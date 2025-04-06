/datum/round_event_control/rogue/ascension_baotha
	name = "Ascended Baotha"
	typepath = /datum/round_event/rogue/ascension_baotha
	weight = 1000
	max_occurrences = 2
	min_players = 0
	req_omen = TRUE
	todreq = list("night", "dawn", "day", "dusk")
	earliest_start = 3 MINUTES

/datum/round_event_control/rogue/ascension_baotha/canSpawnEvent()
	if(hasomen(OMEN_CURSE_BAOTHA) == 0)
		return FALSE
	. = ..()

/datum/round_event/rogue/ascension_baotha
	announceWhen = 1
	var/mob/living/carbon/human/target
	var/birthing_time
	var/to_birth = 1

/datum/round_event/rogue/ascension_baotha/start()
	var/list/impregnated_targets = list()

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!H.organHolder || !H.mind)
			continue

		var/obj/item/organ/vagina/V = H.organHolder.get_organ(ORGAN_SLOT_VAGINA)
		if(V && V.pregnant)
			impregnated_targets += H

	if(impregnated_targets.len)
		target = pick(impregnated_targets)
		to_chat(target, span_warning("You feel a sick squirming deep inside your womb..."))
		birthing_time = world.time

// Add this proc to handle progression
/datum/round_event/rogue/ascension_baotha/process()
	if(!target || !birthing_time)
		return

	var/time_passed = world.time - birthing_time

	if(time_passed >= 210 SECONDS)
		birthing_time = null
		to_chat(target, span_danger("Something rips its way out of you in a geyser of blood!"))
		target.emote("agony", forced = TRUE)
		target.Stun(10)
		target.Knockdown(10)
		
		target.spawn_gibs(FALSE)
		var/obj/structure/baotha_globule/G = new /obj/structure/baotha_globule(get_turf(target))
		G.host = target

	else if(time_passed >= 180 SECONDS)
		target.flash_fullscreen("redflash3")
		target.emote("agony", forced = TRUE)
		to_chat(target, span_userdanger("I can't take the pain!"))
		target.Stun(30)
		target.Knockdown(30)

	else if(time_passed >= 90 SECONDS)
		to_chat(target, span_warning("The squirming in your womb grows unbearable..."))

/obj/structure/baotha_globule
	name = "Baothan Globule"
	desc = "A pulsating mass of veiny, glistening flesh. It reeks of submission and rot."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "gland"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	layer = CLOSED_DOOR_LAYER
	max_integrity = 10000
	armor = list("blunt" = 10, "slash" = 5, "stab" = 7, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 50, "acid" = 50)
	var/creation_time
	var/host

/obj/structure/baotha_globule/Initialize()
	. = ..()
	creation_time = world.time
	START_PROCESSING(SSprocessing, src)

/obj/structure/baotha_globule/process()
	if(world.time >= creation_time + 120 SECONDS) // After 10 seconds
		spawn_baothan_flesh()
		return // Stop further processing once it pops

	if(prob(5))
		for(var/mob/living/H in hearers(8, get_turf(src)))
			to_chat(H, span_notice("You hear a soft, wet whisper: 'Feed me...'"))

/obj/structure/baotha_globule/proc/spawn_baothan_flesh()
	var/list/candidates = pollCandidatesForMob("Do you desire to be reborn in Baotha's image?", null, null, null, 100, src, POLL_IGNORE_NECROMANCER_SKELETON)

	if(LAZYLEN(candidates))
		var/mob/C = pick(candidates)
		var/mob/living/simple_animal/hostile/monster/baothan_spawn/M = new /mob/living/simple_animal/hostile/monster/baothan_spawn(get_turf(src))
		M.spawn_gibs(FALSE)
		M.name = "Baothan Succurax"
		M.former_host = host
		M.ckey = C.ckey
		M.mind = C
		C.transfer_to(M)
		visible_message(span_warning("The Baothan Globule quivers... and bursts open with a wet scream!"))
	else
		// No players — spawn a mindless NPC fleshspawn
		var/mob/living/simple_animal/hostile/monster/baothan_spawn/M = new /mob/living/simple_animal/hostile/monster/baothan_spawn(get_turf(src))
		M.name = "Baothan Succurax"
		M.former_host = host
		aggressive = 1
		mode = AI_HUNT
		wander = TRUE
		visible_message(span_warning("The Baothan Globule bursts, releasing a mindless mass of flesh!"))
	
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if (HAS_TRAIT(H, TRAIT_CRACKHEAD)) //message all baothans
			to_chat(H, span_userdanger("You feel the birthing scream of your godling shiver down your spine..."))

	STOP_PROCESSING(SSprocessing, src)
	qdel(src)
