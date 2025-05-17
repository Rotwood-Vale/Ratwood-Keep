/mob/living/proc/update_stamina() //update hud and regen after last_fatigued delay on taking
	var/athletics_skill = 0
	if(mind)
		athletics_skill = mind.get_skill_level(/datum/skill/misc/athletics)
	max_stamina = (STAEND + athletics_skill) * 10 //This here is the calculation for max STAMINA / GREEN
	if(world.time > last_fatigued + 50) //regen fatigue
		var/added = energy / max_energy // Add an amount of stamina from our energy pool. Blue -> Green
		added = round(-10+ (added*-40))
		if(HAS_TRAIT(src, TRAIT_MISSING_NOSE))
			added = round(added * 0.5, 1)
		if(stamina >= 1)
			stamina_add(added)
		else
			stamina = 0

	update_health_hud()

/mob/living/proc/update_energy()
	var/athletics_skill = 0
	if(mind)
		athletics_skill = mind.get_skill_level(/datum/skill/misc/athletics)
	max_energy = (STAEND + athletics_skill) * 100 // ENERGY / BLUE (Average of 1000)
	if(cmode)
		if(!HAS_TRAIT(src, TRAIT_BREADY))
			energy_add(-2)

/mob/proc/energy_add(added as num)
	return

/mob/living/energy_add(added as num)
	if(HAS_TRAIT(src, TRAIT_NOSTAMINA))
		return TRUE
	if(m_intent == MOVE_INTENT_RUN)
		mind?.add_sleep_experience(/datum/skill/misc/athletics, (STAINT*0.02))
	energy += added
	if(energy > max_energy)
		energy = max_energy
		update_health_hud()
		return FALSE
	else
		if(energy <= 0)
			energy = 0
			if(m_intent == MOVE_INTENT_RUN) //can't sprint at zero stamina
				toggle_rogmove_intent(MOVE_INTENT_WALK)
		update_health_hud()
		return TRUE

/mob/proc/stamina_add(added as num)
	return TRUE

/mob/living/stamina_add(added as num, emote_override, force_emote = TRUE) //call update_stamina here and set last_fatigued, return false when not enough fatigue left
	if(HAS_TRAIT(src, TRAIT_NOSTAMINA))
		return TRUE
	stamina = CLAMP(stamina+added, 0, max_stamina)
	if(added > 0)
		energy_add(added * -1)
	if(added >= 5)
		if(energy <= 0)
			if(iscarbon(src))
				var/mob/living/carbon/C = src
				if(!HAS_TRAIT(C, TRAIT_NOHUNGER))
					if(C.nutrition <= 0)
						if(C.hydration <= 0)
							C.heart_attack()
							return FALSE
	if(stamina >= max_stamina)
		stamina = max_stamina
		update_health_hud()
		if(m_intent == MOVE_INTENT_RUN) //can't sprint at full fatigue
			toggle_rogmove_intent(MOVE_INTENT_WALK, TRUE)
		if(!emote_override)
			emote("fatigue", forced = force_emote)
		else
			emote(emote_override, forced = force_emote)
		blur_eyes(2)
		last_fatigued = world.time + 3 SECONDS //extra time before fatigue regen sets in
		stop_attack()
		changeNext_move(CLICK_CD_EXHAUSTED)
		flash_fullscreen("blackflash")
		if(energy <= 0)
			addtimer(CALLBACK(src, PROC_REF(Knockdown), 30), 1 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(Immobilize), 30), 1 SECONDS)
		if(iscarbon(src))
			var/mob/living/carbon/C = src
			if(isseelie(C))  //Add wingcheck here
				C.visible_message(span_warning("[C] falls from the air!"), span_warning("I fall down in exhaustion!"))
				addtimer(CALLBACK(C, TYPE_PROC_REF(/mob/living/carbon/human, Knockdown), 10), 1 SECONDS)
			if(C.get_stress_amount() >= 30)
				C.heart_attack()
			if(!HAS_TRAIT(C, TRAIT_NOHUNGER))
				if(C.nutrition <= 0)
					if(C.hydration <= 0)
						C.heart_attack()
		return FALSE
	else
		last_fatigued = world.time
		update_health_hud()
		return TRUE

/mob/living/carbon
	var/heart_attacking = FALSE

/mob/living/carbon/proc/heart_attack()
	if(HAS_TRAIT(src, TRAIT_NOSTAMINA))
		return
	if(!heart_attacking)
		heart_attacking = TRUE
		shake_camera(src, 1, 3)
		blur_eyes(10)
		var/stuffy = list("ZIZO GRABS MY WEARY HEART!","ARGH! MY HEART BEATS NO MORE!","NO... MY HEART HAS BEAT IT'S LAST!","MY HEART HAS GIVEN UP!","MY HEART BETRAYS ME!","THE METRONOME OF MY LIFE STILLS!")
		to_chat(src, span_userdanger("[pick(stuffy)]"))
		emote("breathgasp", forced = TRUE)
		addtimer(CALLBACK(src, PROC_REF(adjustOxyLoss), 110), 30)

/mob/living/proc/freak_out() // currently solely used for vampire snowflake stuff
	return

/mob/proc/do_freakout_scream() // currently solely used for vampire snowflake stuff
	emote("scream", forced=TRUE)

/mob/living/carbon/freak_out() // currently solely used for vampire snowflake stuff
	if(mob_timers["freakout"])
		if(world.time < mob_timers["freakout"] + 10 SECONDS)
			flash_fullscreen("stressflash")
			return
	mob_timers["freakout"] = world.time
	shake_camera(src, 1, 3)
	flash_fullscreen("stressflash")
	changeNext_move(CLICK_CD_EXHAUSTED)
	add_stress(/datum/stressevent/freakout)
	emote("fatigue", forced = TRUE)
	if(hud_used)
		var/matrix/skew = matrix()
		skew.Scale(2)
		var/matrix/newmatrix = skew
		for(var/C in hud_used.plane_masters)
			var/atom/movable/screen/plane_master/whole_screen = hud_used.plane_masters[C]
			if(whole_screen.plane == HUD_PLANE)
				continue
			animate(whole_screen, transform = newmatrix, time = 1, easing = QUAD_EASING)
			animate(transform = -newmatrix, time = 30, easing = QUAD_EASING)

/mob/living/proc/stamina_reset()
	stamina = 0
	last_fatigued = 0
	return
