/datum/antagonist/zizocultist
	name = "Cultist"
	roundend_category = "cultists"
	antagpanel_category = "Cult"
	job_rank = ROLE_ZIZOIDCULTIST
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "cultist"
	confess_lines = list(
		"DEATH TO THE SUCCESSORS!",
		"PRAISE ZIZO!",
		"THE GODHEAD FAVORS ME!",
	)
	var/islesser = TRUE
	rogue_enabled = TRUE

/datum/antagonist/zizocultist/leader
	name = "Heresiarch"
	islesser = FALSE

/proc/iszizolackey(mob/living/M)
	return istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/zizocultist)

/proc/iszizocultist(mob/living/M)
	return istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/zizocultist/leader)

/datum/antagonist/zizocultist/examine_friendorfoe(datum/antagonist/examined_datum, mob/examiner, mob/examined)
	if(istype(examined_datum, /datum/antagonist/zizocultist/leader))
		return span_boldnotice("OUR LEADER!")
	if(istype(examined_datum, /datum/antagonist/zizocultist))
		return span_boldnotice("An expendable follower.")

/datum/antagonist/zizocultist/on_gain()
	. = ..()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/mob/living/carbon/human/H = owner.current
	C.cultists |= owner
	H.patron = GLOB.patronlist[/datum/patron/zizo]

	owner.special_role = "Cultist"
	H.cmode_music = 'sound/music/combatcult.ogg'
	owner.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/maniac.ogg', 80, FALSE, pressure_affected = FALSE)
	owner.current.verbs |= /mob/living/carbon/human/proc/praise
	owner.current.verbs |= /mob/living/carbon/human/proc/communicate
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	H.change_stat("strength", 2)

	if(islesser)
		add_objective(/datum/objective/zizoserve)
		owner.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.change_stat("intelligence", -2)
		greet()
	else
		add_objective(/datum/objective/zizo)
		owner.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		owner.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("speed", 1)
		greet()
		owner.special_role = ROLE_ZIZOIDCULTIST
		owner.current.verbs |= /mob/living/carbon/human/proc/draw_sigil_zizo
		owner.current.verbs |= /mob/living/carbon/human/proc/release_minion

/datum/antagonist/zizocultist/greet()
	to_chat(owner, span_danger("I'm a Cultist of Zizo, under the orders of the Heresiarch."))
	owner.announce_objectives()

/datum/antagonist/zizocultist/leader/greet()
	to_chat(owner, span_danger("I'm a Heresiarch of Zizo. I must form a great cult and follow her footsteps. My ascension will be glorious."))

	owner.announce_objectives()

/datum/antagonist/zizocultist/can_be_owned(datum/mind/new_owner)
	. = ..()
	if(.)
		if(new_owner.current == SSticker.rulermob)
			return FALSE
		if(new_owner.assigned_role in GLOB.church_positions)
			return FALSE
		if(new_owner.assigned_role in GLOB.inquisition_positions)
			return FALSE
		if(new_owner.unconvertable)
			return FALSE
		if(new_owner.current && HAS_TRAIT(new_owner.current, TRAIT_MINDSHIELD))
			return FALSE

/datum/antagonist/zizocultist/proc/add_cultist(datum/mind/cult_mind)
	cult_mind.add_antag_datum(/datum/antagonist/zizocultist)
	return TRUE

/datum/objective/zizo
	name = "ASCEND"
	explanation_text = "Ensure that I ascend."
	team_explanation_text = "Ensure that I ascend."
	triumph_count = 5

/datum/objective/zizo/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.cultascended)
		return TRUE

/datum/objective/zizoserve
	name = "Serve your Leader"
	explanation_text = "Serve your leader and ensure that they ascend."
	team_explanation_text = "Serve your leader and ensure that they ascend."
	triumph_count = 3

/datum/objective/zizoserve/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.cultascended)
		return TRUE

/datum/antagonist/zizocultist/proc/add_objective(datum/objective/O)
	var/datum/objective/V = new O
	objectives += V

/datum/antagonist/zizocultist/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/zizocultist/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(islesser) // don't need to spam up the chat with all spawn
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] " + span_green("TRIUMPH!"))
				else
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] " + span_red("Failure."))

					traitorwin = FALSE
				count += objective.triumph_count
	else
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] " + span_green("TRIUMPH!"))
				else
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] " + span_red("Failure."))

					traitorwin = FALSE
				count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, span_green("The [special_role_text] has TRIUMPHED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
		else
			to_chat(world, span_red("The [special_role_text] has FAILED!"))

		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

// VERBS

/mob/living/carbon/human/proc/praise()
	set name = "Praise the Godhead!"
	set category = "ZIZO"

	if(stat == DEAD)
		return

	// 3 seconds cooldown
	if(mob_timers["cult_praise_zizo"])
		if(world.time < mob_timers["cult_praise_zizo"] + 3 SECONDS)
			return
	mob_timers["cult_praise_zizo"] = world.time

	audible_message("[src] praises " + span_bold("Zizo") + "!")
	log_game("[src.real_name] praises Zizo!")
	playsound(src.loc, 'sound/vo/cult/praise.ogg', 45, 1)

/mob/living/carbon/human/proc/communicate()
	set name = "Communicate"
	set category = "ZIZO"

	if(stat == DEAD)
		return

	// 5 seconds cooldown
	if(mob_timers["cult_communicate"])
		if(world.time < mob_timers["cult_communicate"] + 5 SECONDS)
			return
	mob_timers["cult_communicate"] = world.time

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/speak = input("What do you speak of?", "RATWOOD") as text|null
	if(!speak)
		return
	whisper("O schlet'a ty'schkotot ty'skvoro...")
	whisper("[speak]")
	log_game("[src.real_name]: [speak]")

	for(var/datum/mind/V in C.cultists)
		to_chat(V, span_boldnotice("A message from [src.real_name]: \"[speak]\""))
		playsound_local(V.current, 'sound/vo/cult/skvor.ogg', 100)


/mob/living/carbon/human/proc/release_minion()
	set name = "Release follower"
	set category = "ZIZO"

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/mob/living/carbon/human/possible = list()
	for(var/datum/mind/V in C.cultists)
		if(V.special_role == "Cultist")
			possible |= V.current

	var/mob/living/carbon/human/choice = input(src, "Whom do you no longer have use for?", "ROGUETOWN") as null|anything in possible
	if(choice)
		var/alert = alert(src, "Are you sure?", "RATWOOD", "Yes", "Cancel")
		if(alert == "Yes")
			visible_message(span_danger("[src] reaches out, ripping up [choice]'s soul!"))
			to_chat(choice, span_userdanger("I HAVE FAILED MY LEADER! I HAVE FAILED ZIZO! NOTHING ELSE BUT DEATH REMAINS FOR ME NOW!"))
			sleep(20)
			choice.gib() // Cooler than dusting.
			C.cultists -= choice.mind
