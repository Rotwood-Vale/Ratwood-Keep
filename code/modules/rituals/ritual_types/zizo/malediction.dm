// MALEDICTION, marking with people and then messing with them


/proc/get_all_zizotouched()
	var/list/marked = list()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat == DEAD)
			continue
		if(isbrain(H))
			continue
		if(H.has_status_effect(/datum/status_effect/debuff/zizotouch))
			marked += H
	return marked


/proc/select_target_by_name(mob/user, list/mob_list)
	var/list/display = list()
	for(var/mob/M in mob_list)
		display += M.real_name

	var/choice = input(user, "Choose your target", "Target Selection") as null|anything in display
	if(choice)
		var/index = display.Find(choice)
		return mob_list[index]
	return null

/datum/ritual/zizo/touchofzizo
	name = "Touch of Zizo"
	circle = "Malediction"
	difficulty = 1 // We want to encourage this being done.
	favor_cost = 25
	revealchance = 5 //this already has a very high chance to reveal you
	center_requirement = /mob/living/carbon/human

	function = /proc/touchofzizo

proc/touchofzizo(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		H.apply_status_effect(/datum/status_effect/debuff/zizotouch)
		user.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		to_chat(H.mind, span_notice("An uneasy feeling intrudes upon your very soul. Zizo has you within the grasp of Her palm."))
		return TRUE
	return FALSE

/datum/ritual/zizo/voiceofzizo
	name = "Voice of Zizo"
	circle = "Malediction"
	difficulty = 1 // We want to encourage this being done.
	favor_cost = 5 // We already paid for this, and are now cashing in on a risky ritual.
	revealchance = 5 //you already had to deal with abducting somebody who is now in town and screaming about it

	function = /proc/voiceofzizo

proc/voiceofzizo(mob/user, turf/C)
	var/list/zizotouched = get_all_zizotouched()
	var/mob/living/carbon/human/target = select_target_by_name(user, zizotouched)
	if(!target)
		return FALSE
	var/choice = input(user, "What do you want [target.real_name] to do?", "Zizo Command") as null|anything in list("PRAISE", "SPEAK")
	if(!choice)
		return FALSE

	switch(choice)
		if("PRAISE")
			target.say(pick(ZIZO_PRAISES))
			for(var/mob/living/carbon/human/H in view(target))
				if(H.patron?.type != /datum/patron/zizo)
					user.mind.divinefavor += 15
					to_chat(user, span_notice("A soul hears my message of devotion! She is pleased."))
			to_chat(user, span_notice("You compel [target.real_name] to praise Zizo."))
		if("SPEAK")
			var/msg = input(user, "What does Zizo compel [target.real_name] to say?", "Message") as text
			if(msg)
				target.say(msg)
				to_chat(user, span_notice("You forced [target.real_name] to say: \"[msg]\""))
	return TRUE


/datum/ritual/zizo/zizoslullaby
	name = "Zizos lullaby"
	circle = "Malediction"
	difficulty = 1 //
	favor_cost = 25 //not so expensive, used probably to sleep people who have been marked in order to throw them out again
	revealchance = 5
	casttime = 2 //they can still get some words off, 2 seconds cast time and 3 seconds to react


/proc/zizoslullaby(mob/user, turf/C)
	var/list/zizotouched = get_all_zizotouched()
	var/mob/living/carbon/human/target = select_target_by_name(user, zizotouched)
	if(!target)
		return FALSE

	target.eyesclosed = TRUE

	for(var/atom/movable/screen/eye_intent/eyet in target.hud_used.static_inventory)
		eyet.update_icon(target)

	target.become_blind("eyelids")
	to_chat(target.mind, span_notice("Unholy forces tug at your mind, forcing you to sleep..."))
	target.Slowdown(30)
	sleep(20)
	target.Sleeping(300)

	return TRUE
