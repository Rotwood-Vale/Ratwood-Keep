/mob/living/carbon/human/species/deadite
	// race and gender are overridden in Initialize
	bodyparts = list(/obj/item/bodypart/chest, /obj/item/bodypart/head, /obj/item/bodypart/l_arm,
					 /obj/item/bodypart/r_arm, /obj/item/bodypart/r_leg, /obj/item/bodypart/l_leg)
	faction = list("undead")
	mob_biotypes = MOB_UNDEAD
	var/outfit = /datum/outfit/job/roguetown/npc/deadite
	ambushable = FALSE
	possible_rmb_intents = list()

/mob/living/carbon/human/species/deadite/npc
	aggressive = 1
	mode = NPC_AI_IDLE
	wander = FALSE

/mob/living/carbon/human/species/deadite/npc/ambush
	wander = TRUE

/mob/living/carbon/human/species/deadite/Initialize()
	race = pick(RACES_ALL_KINDS)
	gender = pick(MALE, FEMALE) // needs to be done before DNA setup
	. = ..()
	dna.species.random_character(src)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 10)

/mob/living/carbon/human/species/deadite/after_creation()
	..() // rolls stats
	if(outfit)
		var/datum/outfit/Outfit = new outfit
		if(Outfit)
			equipOutfit(Outfit)
	make_deadite()
	update_body()

/datum/outfit/job/roguetown/npc/deadite/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(5))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(5))
		shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	if(prob(5))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(30))
		if(prob(20))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		else
			shirt = pick(/obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant, /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l)
	else if(!armor && prob(80) && H.gender == FEMALE) // cover those thangs
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	if(prob(5))
		pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	else if(prob(80))
		if(prob(20))
			pants = /obj/item/clothing/under/roguetown/tights
		else
			pants = pick(/obj/item/clothing/under/roguetown/tights/vagrant, /obj/item/clothing/under/roguetown/tights/vagrant/l)
	if(prob(5))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(5))
		gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	if(prob(5))
		neck = /obj/item/clothing/neck/roguetown/chaincoif/iron

/// Makes the mob a deadite, called on both npc and player deadites
/mob/living/carbon/human/proc/make_deadite()

	base_intents = GLOB.intents_deadite
	update_a_intents()
	aggressive = TRUE
	mode = NPC_AI_IDLE
	npc_jump_chance = 0
	rude = FALSE // don't taunt people as a deadite
	tree_climber = FALSE // or climb trees
	handle_ai()
	ambushable = FALSE
	mob_biotypes |= MOB_UNDEAD
	faction += "undead"
	faction -= "station"
	faction -= "neutral"

	dna.species.soundpack_m = new /datum/voicepack/zombie/m()
	dna.species.soundpack_f = new /datum/voicepack/zombie/f()

	for(var/obj/item/bodypart/part as anything in bodyparts)
		if(!part.rotted && !part.skeletonized)
			part.rotted = TRUE
		part.update_disabled()

	for(var/trait_applied in GLOB.traits_deadite)
		ADD_TRAIT(src, trait_applied, DEADITE_TRAIT)

	var/datum/stat_set/stats = new()
	stats.create_from(src)

	// Deadites will still be affected by certain lingering status conditions, but should be immune to
	// the nastiest ones (eg. blood loss) thanks to their traits
	var/strdiff = rand(6, 13) - stats.STASTR
	var/spddiff = rand(6, 13) - stats.STASPD
	var/condiff = rand(6, 13) - stats.STACON
	var/enddiff = rand(6, 13) - stats.STAEND
	var/intdiff = 1 - stats.STAINT

	change_stat("strength", strdiff, "deadite_str")
	change_stat("speed", spddiff, "deadite_spd")
	change_stat("constitution", condiff, "deadite_con")
	change_stat("endurance", enddiff, "deadite_end")
	change_stat("intelligence", intdiff, "deadite_int")

/mob/living/carbon/human/proc/deadite_get_aimheight(victim)
	if(!(mobility_flags & MOBILITY_STAND))
		return rand(1, 2) // Bite their ankles!
	return pick(rand(11, 13), rand(14, 17), rand(5, 8)) // Chest, neck, and mouth; face and ears; arms and hands.

/mob/living/carbon/human/species/deadite/npc_choose_attack_zone(mob/living/victim)
	aimheight_change(deadite_get_aimheight(victim))

/mob/living/carbon/human/species/deadite/do_best_melee_attack(mob/living/victim)
	if(do_deadite_attack(victim))
		return TRUE
	return ..() // use grabs and such

/mob/living/carbon/human/species/deadite/handle_ai()
	. = ..()
	try_do_deadite_idle() // sort of a misnomer, just handles zombie noises

// This proc exists because non-converted deadites don't have minds and can't have the antag datum
// So we need two separate entry points for this logic
/mob/living/carbon/human/proc/do_deadite_attack(mob/living/victim)
	// first, we try to bite
	if(try_do_deadite_bite(victim))
		return TRUE // spent our turn
	return FALSE

/mob/living/carbon/human/proc/try_do_deadite_bite(mob/living/victim)
	if(!src || stat >= DEAD)
		return FALSE

	var/obj/item/grabbing/bite/bite = get_item_by_slot(SLOT_MOUTH)
	if(istype(bite))
		// 50% chance to continue biting if already started
		if(prob(50))
			bite.bitelimb(src)
			return TRUE
		return FALSE // try something else like grappling
	
	if(!victim) // if we aren't passed a target, find one at random from nearby. this is currently unused
		for(var/mob/living/carbon/human in view(1, src))
			if(human == src) //prevent self biting
				continue
			if((human.mob_biotypes & MOB_UNDEAD) || ("undead" in human.faction) || HAS_TRAIT(human, TRAIT_ZOMBIE_IMMUNE))
				continue
			victim = human

	if(!victim) // still no one to bite
		return FALSE

	if(!get_location_accessible(src, BODY_ZONE_PRECISE_MOUTH, grabs = TRUE)) // can't bite, mouth is covered!
		return FALSE

	victim.onbite(src)
	// onbite doesn't directly apply the attack delay so we do it here
	changeNext_move(/datum/intent/bite::clickcd)
	return TRUE // use up our turn regardless of if the bite succeeded or not

/mob/living/carbon/human/proc/try_do_deadite_idle()

	if(mob_timers["deadite_idle"])
		if(world.time < mob_timers["deadite_idle"] + rand(5 SECONDS, 10 SECONDS))
			return

	mob_timers["deadite_idle"] = world.time
	emote("idle")

/// Use this to attempt to add the zombie antag datum to a human
/mob/living/carbon/human/proc/zombie_check()
	if(!mind)
		return
	var/already_zombie = mind.has_antag_datum(/datum/antagonist/zombie)
	if(already_zombie)
		return already_zombie
	if(mind.has_antag_datum(/datum/antagonist/vampirelord))
		return
	if(mind.has_antag_datum(/datum/antagonist/werewolf))
		return
	if(mind.has_antag_datum(/datum/antagonist/skeleton))
		return
	if(HAS_TRAIT(src, TRAIT_ZOMBIE_IMMUNE))
		return
	return mind.add_antag_datum(/datum/antagonist/zombie)

/**
 * This occurs when one zombie infects a living human, going into instadeath from here is kind of shit and confusing
 * We instead just transform at the end
 */
/mob/living/carbon/human/proc/zombie_infect_attempt()
	var/datum/antagonist/zombie/zombie_antag = zombie_check()
	if(!zombie_antag)
		return
	if(stat >= DEAD) //do shit the natural way i guess
		return
	to_chat(src, span_danger("I feel horrible... REALLY horrible..."))
	mob_timers["puke"] = world.time
	vomit(1, blood = TRUE, stun = FALSE)
	addtimer(CALLBACK(src, PROC_REF(wake_zombie)), 1 MINUTES)
	return zombie_antag

/mob/living/carbon/human/proc/wake_zombie()
	var/datum/antagonist/zombie/zombie_antag = mind?.has_antag_datum(/datum/antagonist/zombie)
	if(!zombie_antag || zombie_antag.has_turned)
		return FALSE
	flash_fullscreen("redflash3")
	to_chat(src, span_danger("It hurts... Is this really the end for me?"))
	emote("scream") // heres your warning to others bro
	Knockdown(1)
	zombie_antag.wake_zombie(TRUE)
	return TRUE
