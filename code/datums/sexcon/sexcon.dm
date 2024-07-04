/datum/sex_controller
	/// The user and the owner of the controller
	var/mob/living/carbon/human/user
	/// Target of our actions, can be ourself
	var/mob/living/carbon/human/target
	/// Whether the user desires to stop his current action
	var/desire_stop = FALSE
	/// What is the current performed action
	var/current_action = null
	/// Enum of desired speed
	var/speed = SEX_SPEED_MID
	/// Enum of desired force
	var/force = SEX_FORCE_MID
	/// Our arousal
	var/arousal = 0
	var/last_arousal_increase_time = 0
	var/last_ejaculation_time = 0
	var/last_moan = 0

/datum/sex_controller/New(mob/living/carbon/human/owner)
	user = owner

/datum/sex_controller/Destroy()
	user = null
	target = null
	. = ..()

/datum/sex_controller/proc/adjust_speed(amt)
	speed = clamp(speed + amt, SEX_SPEED_MIN, SEX_SPEED_MAX)

/datum/sex_controller/proc/adjust_force(amt)
	force = clamp(force + amt, SEX_FORCE_MIN, SEX_FORCE_MAX)

/datum/sex_controller/proc/update_pink_screen()
	var/severity = 0
	switch(arousal)
		if(1 to 10)
			severity = 1
		if(10 to 20)
			severity = 2
		if(20 to 30)
			severity = 3
		if(30 to 40)
			severity = 4
		if(40 to 50)
			severity = 5
		if(50 to 60)
			severity = 6
		if(60 to 70)
			severity = 7
		if(70 to 80)
			severity = 8
		if(80 to 90)
			severity = 9
		if(90 to INFINITY)
			severity = 10
	if(severity > 0)
		user.overlay_fullscreen("horny", /atom/movable/screen/fullscreen/love, severity)
	else
		user.clear_fullscreen("horny")

/datum/sex_controller/proc/start(mob/living/carbon/human/new_target)
	if(!ishuman(new_target))
		return
	set_target(new_target)
	show_ui()

/datum/sex_controller/proc/ejaculate()
	user.visible_message(span_love("[user] makes a mess!"))
	playsound(owner, 'sound/misc/mat/endout.ogg', 30, TRUE, ignore_walls = FALSE)
	add_cum_floor(get_turf(user))
	after_ejaculation()

/datum/sex_controller/proc/after_ejaculation()
	set_arousal(0)
	user.playsound_local(user, 'sound/misc/mat/end.ogg', 100)
	last_ejaculation_time = world.time
	SSticker.cums++

/datum/sex_controller/proc/after_intimate_climax()
	if(HAS_TRAIT(target, TRAIT_GOODLOVER))
		if(!user.mob_timers["cumtri"])
			user.mob_timers["cumtri"] = world.time
			user.adjust_triumphs(1)
			to_chat(user, span_love("Our loving is a true TRIUMPH!"))
	if(HAS_TRAIT(user, TRAIT_GOODLOVER))
		if(!target.mob_timers["cumtri"])
			target.mob_timers["cumtri"] = world.time
			target.adjust_triumphs(1)
			to_chat(target, span_love("Our loving is a true TRIUMPH!"))

/datum/sex_controller/proc/just_ejaculated()
	return (last_ejaculation_time == world.time)

/datum/sex_controller/proc/set_arousal(amount)
	if(amount > arousal)
		last_arousal_increase_time = world.time
	arousal = clamp(amount, 0, MAX_AROUSAL)
	update_pink_screen()
	update_blueballs()

/datum/sex_controller/proc/adjust_arousal(amount)
	set_arousal(arousal + amount)

/datum/sex_controller/proc/add_arousal(amount)
	if(amount <= 0)
		return
	adjust_arousal(amount)
	// Do moans here

/datum/sex_controller/proc/update_blueballs()
	if(arousal >= BLUEBALLS_GAIN_THRESHOLD)
		owner.add_stress(/datum/stressevent/blueb)
	else if (arousal <= BLUEBALLS_LOOSE_THRESHOLD)
		owner.remove_stress(/datum/stressevent/blueb)

/datum/sex_controller/proc/check_active_ejaculation()
	if(arousal < ACTIVE_EJAC_THRESHOLD)
		return FALSE
	return TRUE

/datum/sex_controller/proc/handle_passive_ejaculation()
	if(arousal < PASSIVE_EJAC_THRESHOLD)
		return
	ejaculate()

/datum/sex_controller/proc/process_sexcon(dt)
	handle_arousal_unhorny(dt)
	handle_passive_ejaculation()

/datum/sex_controller/proc/handle_arousal_unhorny(dt)
	if(last_arousal_increase_time + AROUSAL_TIME_TO_UNHORNY < world.time)
		return
	adjust_arousal(-dt * AROUSAL_UNHORNY_RATE)

/datum/sex_controller/proc/show_ui()
	var/list/dat = list()
	var/force_name = get_force_string()
	var/speed_name = get_speed_string()
	dat += "<a href='?src=[REF(src)];task=speed_down'>\<</a> [speed_name] <a href='?src=[REF(src)];task=speed_up'>\></a> ~|~ <a href='?src=[REF(src)];task=force_down'>\<</a> [force_name] <a href='?src=[REF(src)];task=force_up'>\></a>"
	if(target == user)
		dat += "<br><center>Doing unto yourself</center>"
	else
		dat += "<br><center>Doing unto [target]'s</center>"
	dat += "<br>"
	if(current_action)
		dat += "<center><a href='?src=[REF(src)];task=stop'>Stop</a></center>"
	for(var/action_type in GLOB.sex_actions)
		var/datum/sex_action/action = SEX_ACTION(action_type)
		if(!action.shows_on_menu(user, target))
			continue
		var/link = ""
		if(!can_perform_action(action_type))
			link = "linkOff"
		if(current_action == action_type)
			link = "linkOn"
		dat += "<br><a class='[link]' href='?src=[REF(src)];task=action;action_type=[action_type]'>[action.name]</a>"

	var/datum/browser/popup = new(user, "sexcon", "Sate Desire", 350, 550)
	popup.set_content(dat.Join())
	popup.open()
	return

/datum/sex_controller/Topic(href, href_list)
	if(usr != user)
		return
	switch(href_list["task"])
		if("action")
			var/action_path = text2path(href_list["action_type"])
			var/datum/sex_action/action = SEX_ACTION(action_path)
			if(!action)
				return
			try_start_action(action_path)
		if("stop")
			try_stop_current_action()
		if("speed_up")
			adjust_speed(1)
		if("speed_down")
			adjust_speed(-1)
		if("force_up")
			adjust_force(1)
		if("force_down")
			adjust_force(-1)
	show_ui()

/datum/sex_controller/proc/try_stop_current_action()
	if(!current_action)
		return
	desire_stop = TRUE

/datum/sex_controller/proc/stop_current_action()
	if(!current_action)
		return
	var/datum/sex_action/action = SEX_ACTION(current_action)
	action.on_finish(user, target)
	desire_stop = FALSE
	current_action = null

/datum/sex_controller/proc/try_start_action(action_type)
	if(action_type == current_action)
		stop_current_action()
		return
	stop_current_action()
	if(!action_type)
		return
	if(!can_perform_action(action_type))
		return FALSE
	// Set vars
	desire_stop = FALSE
	current_action = action_type
	INVOKE_ASYNC(src, PROC_REF(sex_action_loop))

/datum/sex_controller/proc/sex_action_loop()
	// Do action loop
	var/datum/sex_action/action = SEX_ACTION(current_action)
	action.on_start(user, target)
	while(TRUE)
		if(!user.rogfat_add(action.stamina_cost * get_stamina_cost_multiplier()))
			break
		if(!do_after(user, (action.do_time / get_speed_multiplier()), target = target))
			break
		if(!can_perform_action(current_action))
			break
		if(action.is_finished(user, target))
			break
		if(desire_stop)
			break
		action.on_perform(user, target)
		// It could want to finish afterwards the performed action
		if(action.is_finished(user, target))
			break
		if(!action.continous)
			break
	stop_current_action()

/datum/sex_controller/proc/can_perform_action(action_type)
	if(!action_type)
		return FALSE
	var/datum/sex_action/action = SEX_ACTION(action_type)
	if(!inherent_perform_check())
		return FALSE
	if(!action.can_perform(user, target))
		return FALSE
	return TRUE

/datum/sex_controller/proc/inherent_perform_check()
	if(!target)
		return FALSE
	if(user.stat != CONSCIOUS)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	return TRUE

/datum/sex_controller/proc/set_target(mob/living/carbon/human/new_target)
	target = new_target

/datum/sex_controller/proc/get_speed_multiplier()
	switch(speed)
		if(SEX_SPEED_LOW)
			return 1.0
		if(SEX_SPEED_MID)
			return 1.5
		if(SEX_SPEED_HIGH)
			return 2.0
		if(SEX_SPEED_EXTREME)
			return 2.5

/datum/sex_controller/proc/get_stamina_cost_multiplier()
	switch(force)
		if(SEX_FORCE_LOW)
			return 1.0
		if(SEX_FORCE_MID)
			return 1.5
		if(SEX_FORCE_HIGH)
			return 2.0
		if(SEX_SPEED_EXTREME)
			return 2.5

/datum/sex_controller/proc/get_force_pleasure_multiplier()
	switch(force)
		if(SEX_FORCE_LOW)
			return 1.0
		if(SEX_FORCE_MID)
			return 1.5
		if(SEX_FORCE_HIGH)
			return 2.0
		if(SEX_FORCE_EXTREME)
			return 2.5

/datum/sex_controller/proc/get_force_string()
	switch(force)
		if(SEX_FORCE_LOW)
			return "<font color='#eac8de'>GENTLE</font>"
		if(SEX_FORCE_MID)
			return "<font color='#e9a8d1'>FIRM</font>"
		if(SEX_FORCE_HIGH)
			return "<font color='#f05ee1'>ROUGH</font>"
		if(SEX_FORCE_EXTREME)
			return "<font color='#d146f5'>BRUTAL</font>"

/datum/sex_controller/proc/get_speed_string()
	switch(speed)
		if(SEX_SPEED_LOW)
			return "<font color='#eac8de'>SLOW</font>"
		if(SEX_SPEED_MID)
			return "<font color='#e9a8d1'>STEADY</font>"
		if(SEX_SPEED_HIGH)
			return "<font color='#f05ee1'>QUICK</font>"
		if(SEX_SPEED_EXTREME)
			return "<font color='#d146f5'>UNRELENTING</font>"

/datum/sex_controller/proc/get_generic_force_adjective()
	switch(force)
		if(SEX_FORCE_LOW)
			return pick(list("gently", "carefully", "tenderly", "gingerly", "delicately", "lazingly"))
		if(SEX_FORCE_MID)
			return pick(list("firmly", "vigorously", "eagerly", "steadily", "willingly", "intently"))
		if(SEX_FORCE_HIGH)
			return pick(list("roughly", "carelessly", "forcefully", "fervently", "fiercely"))
		if(SEX_FORCE_EXTREME)
			return pick(list("brutally", "violently", "relentlessly", "savagely", "mercilessly"))

/datum/sex_controller/proc/spanify_force(string)
	switch(force)
		if(SEX_FORCE_LOW)
			return "<span class='love_low'>[string]</font>"
		if(SEX_FORCE_MID)
			return "<span class='love_mid'>[string]</font>"
		if(SEX_FORCE_HIGH)
			return "<span class='love_high'>[string]</font>"
		if(SEX_FORCE_EXTREME)
			return "<span class='love_extreme'>[string]</font>"
