/mob/proc/add_stress(event_type)
	return

/mob/proc/remove_stress(event_type)
	return

/mob/proc/add_stress_list(list/event_list)
	return

/mob/proc/remove_stress_list(list/event_list)
	return

/mob/proc/update_stress()
	return

/mob/proc/get_stress_amount()
	return 0

/mob/proc/get_stress_event(event_type)
	return null

/mob/proc/has_stress_event(event_type)
	return FALSE

/mob/proc/get_positive_stressors()
	return list()

/mob/proc/get_negative_stressors()
	return list()

/mob/living/carbon
	var/oldstress = 0
	var/list/stressors = list()
	var/list/gray_matrix_color = list(0.30,0.30,0.30,0, 0.60,0.60,0.60,0, 0.10,0.10,0.10,0, 0,0,0,1, 0,0,0,0)

/mob/living/carbon/add_stress(event_type)
	var/datum/stressevent/event = get_stress_event(event_type)
	if(!event)
		event = new event_type()
		stressors[event_type] = event
	event.time_added = world.time
	if(event.stacks >= event.max_stacks)
		return
	event.stacks++

/mob/living/carbon/remove_stress(event_type)
	var/datum/stressevent/event = get_stress_event(event_type)
	if(!event)
		return
	stressors -= event_type

/mob/living/carbon/add_stress_list(list/event_list)
	for(var/event_type in event_list)
		add_stress(event_type)

/mob/living/carbon/remove_stress_list(list/event_list)
	for(var/event_type in event_list)
		remove_stress(event_type)

/mob/living/carbon/update_stress()
	// Handle expiration
	for(var/stressor_type in stressors)
		var/datum/stressevent/event = stressors[stressor_type]
		if(event.time_added + event.timer > world.time)
			continue
		remove_stress(stressor_type)
	// Update stress status and prompts
	var/new_stress = get_stress_amount()

	if(new_stress != oldstress)
		if(new_stress > oldstress)
			to_chat(src, span_red("I gain stress."))
		else
			to_chat(src, span_green("I gain peace."))

	if(new_stress > 15)
		change_stat("fortune", -1, "stress")
	else
		change_stat("fortune", 0, "stress")

	oldstress = new_stress
	update_stress_visual(new_stress)

/mob/living/carbon/proc/update_stress_visual(new_stress)
	if(!client)
		return
	/// Update grain alpha
	var/atom/movable/screen/grain_obj = hud_used.grain
	grain_obj.alpha = 55 + (new_stress * 1.5)

	var/fade_progress = 0
	if(new_stress < 5)
		fade_progress = 0
		remove_client_colour(/datum/client_colour/stress_fade)
	else
		fade_progress = clamp(((new_stress - 5) / 50), 0, 0.6)

	/// Update screen black/white
	var/datum/client_colour/stress_fade/fade_color = add_client_colour(/datum/client_colour/stress_fade)
	var/list/matrix = fade_color.colour
	//RED FADE
	// R fade is 0.3
	var/r_fade = 0.3 * fade_progress
	var/red = 1.0 - (0.7 * fade_progress)
	matrix[1] = red // RED
	matrix[2] = r_fade
	matrix[3] = r_fade 
	//GREEN FADE
	// G fade is 0.6
	var/g_fade = 0.6 * fade_progress
	var/green = 1.0 - (0.4 * fade_progress)
	matrix[5] = g_fade
	matrix[6] = green // GREEN
	matrix[7] = g_fade
	//BLUE FADE
	// B fade is 0.1
	var/b_fade = 0.1 * fade_progress
	var/blue = 1.0 - (0.9 * fade_progress)
	matrix[9] = b_fade
	matrix[10] = b_fade
	matrix[11] = blue // BLUE

	update_client_colour()


/mob/living/carbon/get_stress_amount()
	if(HAS_TRAIT(src, TRAIT_NOMOOD))
		return 0
	var/total_stress = 0
	for(var/stressor_type in stressors)
		var/datum/stressevent/event = stressors[stressor_type]
		var/stress_amt = event.get_stress(src)
		total_stress += stress_amt
	return total_stress

/mob/living/carbon/get_stress_event(event_type)
	return stressors[event_type]

/mob/living/carbon/has_stress_event(event_type)
	if(stressors[event_type])
		return TRUE
	return FALSE

/mob/living/carbon/get_positive_stressors()
	. = list()
	for(var/stressor_type in stressors)
		var/datum/stressevent/event = stressors[stressor_type]
		if(event.get_stress(src) <= 0)
			. += event

/mob/living/carbon/get_negative_stressors()
	. = list()
	for(var/stressor_type in stressors)
		var/datum/stressevent/event = stressors[stressor_type]
		if(event.get_stress(src) > 0)
			. += event
