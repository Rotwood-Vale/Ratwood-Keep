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
