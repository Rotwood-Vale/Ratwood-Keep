/datum/game_mode/masquerade
	name = "Masquerade"
	score_value = 100
	required_players = 6
	special_roles = list("Masqbound")
	var/list/masqbound = list()
	var/round_start_time

/datum/game_mode/masquerade/announce()
	..()
	world << span_notice("A masquerade begins. Masks hide faces, but not intent...")

/datum/game_mode/masquerade/pre_setup()
	..()
	masqbound = list()
	return TRUE

/datum/game_mode/masquerade/post_setup()
	..()
	round_start_time = world.time
	var/list/eligible = get_possible_masqbound()
	if(!eligible.len)
		to_chat(world, span_warning("No eligible players for Masquerade mode."))
		return FALSE

	var/leader = pick(eligible)
	leader.add_antag_datum(/datum/antagonist/veilbound/arbiter)
	masqbound += leader
	eligible -= leader

	for(var/i in 1 to min(3, eligible.len))
		var/datum/mind/follower = pick(eligible)
		follower.add_antag_datum(/datum/antagonist/veilbound)
		masqbound += follower
		eligible -= follower

	SPAWN(10 SECONDS)
		sacrifice_check_loop()
	return TRUE

/proc/get_possible_masqbound()
	var/list/eligible = list()
	for(var/datum/mind/M in GLOB.minds)
		if(!M.current || M.assigned_role in GLOB.inquisition_positions || HAS_TRAIT(M.current, TRAIT_MINDSHIELD))
			continue
		eligible += M
	return eligible

/proc/sacrifice_check_loop()
	var/datum/game_mode/masquerade/M = SSticker.mode
	if(!M) return
	var/time_passed = (world.time - M.round_start_time) / (10 MINUTES)
	
	for(var/datum/mind/C in M.masqbound)
		if(!C.current || QDELETED(C.current)) continue
		var/mob/living/carbon/human/H = C.current
		if(!H || !iscarbon(H)) continue
		if(time_passed >= 2)
			to_chat(H, span_danger("You have failed the Rite. Your form begins to twist..."))
			H.mutate_into_unmasked() // Implement this separately
			continue
		if(!H.last_rite_time || (world.time - H.last_rite_time) > 10 MINUTES)
			to_chat(H, span_warning("The Whisper stirs. A Rite must be performed soon..."))

	SPAWN(1 MINUTE)
		sacrifice_check_loop()

/mob/living/carbon/human/var/last_rite_time

/mob/living/carbon/human/proc/register_rite()
	last_rite_time = world.time

/mob/living/carbon/human/proc/mutate_into_unmasked()
	visible_message(span_danger("[src] screams as their mask shatters and horror takes shape!"))
	// TODO: Replace with real transformation logic
