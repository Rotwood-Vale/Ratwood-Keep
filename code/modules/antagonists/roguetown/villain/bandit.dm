/datum/antagonist/bandit
	name = "Bandit"
	roundend_category = "bandits"
	antagpanel_category = "Bandit"
	job_rank = ROLE_BANDIT
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "bandit"
	rogue_enabled = TRUE
	confess_lines = list(
		"FREEDOM!!!",
		"I WILL NOT LIVE IN YOUR WALLS!",
		"I WILL NOT FOLLOW YOUR RULES!",
	)
	var/favor = 50
	var/totaldonated = 0

/datum/antagonist/bandit/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/bandit))
		return span_boldnotice("Another free man. My ally.")

/datum/antagonist/bandit/on_gain()
	owner.special_role = "Bandit"
	//owner.assigned_role = "Bandit"
	forge_objectives()
	. = ..()
	equip_bandit()
	move_to_spawnpoint()
	finalize_bandit()

/datum/antagonist/bandit/proc/finalize_bandit()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 80, FALSE, pressure_affected = FALSE)
	var/mob/living/carbon/human/H = owner.current
	ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
	for(var/obj/structure/fluff/traveltile/bandit/tile in GLOB.traveltiles)
		tile.show_travel_tile(H)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_COMMIE, TRAIT_GENERIC)
	H.set_patron(/datum/patron/inhumen/matthios)
	to_chat(H, span_alertsyndie("I am a BANDIT!"))
	to_chat(H, span_boldwarning("Long ago I did a crime worthy of my bounty being hung on the wall outside of the local inn. I live now with fellow free men in reverence to MATTHIOS whose idol grants us boons and wishes when fed the money, treasures, and metals of the civilized wretches. I must feed the idol to satisfy my greed!"))

/* /datum/antagonist/bandit/greet()
	to_chat(owner.current, span_alertsyndie("I am a BANDIT!"))
	to_chat(owner.current, span_info("Long ago I did a crime worthy of my bounty being hung on the wall outside of the local inn. I must feed the idol money and valuable metals to satisfy my greed!"))
	owner.announce_objectives()
	..() */ //commenting out until they get a proper objective implementation or whatever.

/datum/antagonist/bandit/proc/forge_objectives()
	return
/*
	if(!(locate(/datum/objective/bandit) in objectives))
		var/datum/objective/bandit/bandit_objective = new
		bandit_objective.owner = owner
		objectives += bandit_objective
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/escape/boat/escape_objective = new
		escape_objective.owner = owner
		objectives += escape_objective*/

/datum/antagonist/bandit/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.bandit_starts))

/datum/antagonist/bandit/proc/equip_bandit()

	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Bandit"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	return TRUE

/datum/antagonist/bandit/roundend_report()
	if(owner?.current)
		var/the_name = owner.name
		if(ishuman(owner.current))
			var/mob/living/carbon/human/H = owner.current
			the_name = H.real_name
		if(!totaldonated)
			to_chat(world, "[the_name] was a bandit.")
		else
			to_chat(world, "[the_name] was a bandit. Their band stole [totaldonated] mammons worth of loot!")
	return

	var/traitorwin = TRUE

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(!objective.check_completion())
				traitorwin = FALSE
			count += objective.triumph_count

	if(!count)
		count = 1

	if(traitorwin)
		owner.adjust_triumphs(count)
		to_chat(owner.current, span_greentext("I've TRIUMPHED!"))
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(owner.current, span_redtext("I've failed to satisfy my greed."))
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
