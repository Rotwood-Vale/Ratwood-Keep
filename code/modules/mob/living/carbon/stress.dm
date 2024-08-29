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
		if(!event.can_apply(src))
			return
		stressors[event_type] = event
	event.time_added = world.time
	if(event.stacks >= event.max_stacks)
		return event
	event.stacks++
	return event

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

	var/ascending = (new_stress > oldstress)

	if(new_stress != oldstress)
		var/diff_abs = abs(new_stress - oldstress)
		if(diff_abs > 1)
			if(ascending)
				to_chat(src, span_smallred("I gain stress."))
			else
				to_chat(src, span_smallgreen("I gain peace."))

	var/old_threshold = get_stress_threshold(oldstress)
	var/new_threshold = get_stress_threshold(new_stress)
	if(old_threshold != new_threshold)
		switch(new_threshold)
			if(STRESS_THRESHOLD_NICE)
				to_chat(src, span_green("I feel good"))
			if(STRESS_THRESHOLD_NEUTRAL)
				if(ascending)
					to_chat(src, span_info("I no longer feel good"))
				else
					to_chat(src, span_info("I no longer feel stressed"))
			if(STRESS_THRESHOLD_STRESSED)
				if(ascending)
					to_chat(src, span_red("I'm getting stressed..."))
				else
					to_chat(src, span_red("I'm stressed a little less, now"))
			if(STRESS_THRESHOLD_STRESSED_BAD)
				if(ascending)
					to_chat(src, span_boldred("I'm getting at my limit.."))
				else
					to_chat(src, span_boldred("I'm not freaking out that badly anymore..."))
			if(STRESS_THRESHOLD_FREAKING_OUT)
				to_chat(src, span_boldred("I'M FREAKING OUT!!!"))

	if(new_stress >= 15)
		change_stat("fortune", -1, "stress")
	else
		change_stat("fortune", 0, "stress")

	if(new_stress >= 20)
		roll_streak_freakout()

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

/mob/living/carbon/proc/roll_streak_freakout()
	if(stat != CONSCIOUS)
		return
	if(mob_timers["next_stress_freakout"])
		if(world.time < mob_timers["next_stress_freakout"])
			return
	if(!prob(20)) // 20% per update to make it less consistent
		return
	// Randomized cooldown
	mob_timers["next_stress_freakout"] = world.time + rand(60 SECONDS, 120 SECONDS)
	stress_freakout()

/mob/living/carbon/proc/stress_freakout()
	to_chat(src, span_boldred("I PANIC!!!"))
	Stun(2 SECONDS)
	blur_eyes(2)
	freakout_hud_skew()
	add_stress(/datum/stressevent/freakout)
	if(get_stress_amount() >= 30)
		heart_attack()
	else
		emote("fatigue", forced = TRUE)
		addtimer(CALLBACK(src, PROC_REF(do_stress_freakout_scream)), rand(1 SECONDS, 2 SECONDS))

/mob/living/carbon/proc/do_stress_freakout_scream()
	if(stat != CONSCIOUS)
		return
	emote("scream", forced = TRUE)

/mob/living/carbon/proc/freakout_hud_skew()
	if(!hud_used)
		return
	var/matrix/skew = matrix()
	skew.Scale(1.5)
	var/matrix/newmatrix = skew
	for(var/C in hud_used.plane_masters)
		var/atom/movable/screen/plane_master/whole_screen = hud_used.plane_masters[C]
		if(whole_screen.plane == HUD_PLANE)
			continue
		animate(whole_screen, transform = newmatrix, time = 1, easing = QUAD_EASING)
		animate(transform = -newmatrix, time = 30, easing = QUAD_EASING)

/mob/living/carbon/get_stress_amount()
	if(HAS_TRAIT(src, TRAIT_NOMOOD))
		return 0
	var/total_stress = 0
	for(var/stressor_type in stressors)
		var/datum/stressevent/event = stressors[stressor_type]
		var/stress_amt = event.get_stress(src)
		if(stress_amt > 0 && HAS_TRAIT(src, TRAIT_BAD_MOOD))
			stress_amt *= 2
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

/proc/get_stress_threshold(stress_amt)
	switch(stress_amt)
		if(-INFINITY to -4)
			return STRESS_THRESHOLD_NICE
		if(-4 to 4)
			return STRESS_THRESHOLD_NEUTRAL
		if(4 to 11)
			return STRESS_THRESHOLD_STRESSED
		if(11 to 19)
			return STRESS_THRESHOLD_STRESSED_BAD
		if(19 to INFINITY)
			return STRESS_THRESHOLD_FREAKING_OUT

