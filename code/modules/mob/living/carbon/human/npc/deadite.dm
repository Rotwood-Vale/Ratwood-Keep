/mob/living/carbon/human/species/deadite
	race = /datum/species/human/northern
	gender = MALE
	bodyparts = list(/obj/item/bodypart/chest, /obj/item/bodypart/head, /obj/item/bodypart/l_arm,
					 /obj/item/bodypart/r_arm, /obj/item/bodypart/r_leg, /obj/item/bodypart/l_leg)
	faction = list("undead")
	var/outfit = /datum/outfit/job/roguetown/npc/deadite
	ambushable = FALSE
	possible_rmb_intents = list()

/mob/living/carbon/human/species/deadite/npc
	aggressive = 1
	mode = AI_IDLE
	wander = FALSE

/mob/living/carbon/human/species/deadite/npc/ambush
	wander = TRUE

/mob/living/carbon/human/species/deadite/Initialize()
	. = ..()
	var/race = pick(list(ALL_RACES_TYPES))
	set_species(race)
	//randomize_human(src, TRUE) //Fix this shit if you want racially diverse zombies
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 10)

/mob/living/carbon/human/species/deadite/after_creation()
	..()
	make_deadite()
	if(outfit)
		var/datum/outfit/Outfit = new outfit
		if(Outfit)
			equipOutfit(Outfit)
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
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	if(prob(5))
		pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	if(prob(5))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(5))
		gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	if(prob(5))
		neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	if(H.gender == FEMALE)
		H.STASTR = rand(7,11)
	else
		H.STASTR = rand(9,14)
	H.STASPD = 5
	H.STACON = 4
	H.STAEND = 10
	H.STAINT = 1

/// Makes the mob a deadite, called on both npc and player deadites
/mob/living/carbon/human/proc/make_deadite()

	base_intents = GLOB.intents_deadite
	update_a_intents()
	aggressive = TRUE
	mode = AI_IDLE
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
		ADD_TRAIT(src, trait_applied, TRAIT_GENERIC)
	
	STASTR = rand(6,13)
	STASPD = rand(6,13)
	STACON = rand(6,13)
	STAEND = rand(6,13)
	STAINT = 1


/mob/living/carbon/human/species/deadite/handle_ai()
	. = ..()
	try_do_deadite_bite()
	try_do_deadite_idle()

/mob/living/carbon/human/proc/try_do_deadite_bite()

	if(!src || stat >= DEAD)
		return

	if(mob_timers["deadite_bite"])
		if(world.time < mob_timers["deadite_bite"] + rand(2 SECONDS, 5 SECONDS))
			return

	mob_timers["deadite_bite"] = world.time

	var/obj/item/grabbing/bite/bite = get_item_by_slot(SLOT_MOUTH)
	if(!bite || !get_location_accessible(src, BODY_ZONE_PRECISE_MOUTH, grabs = TRUE))
		for(var/mob/living/carbon/human in view(1, src))
			if(human == src) //prevent self biting
				continue
			if((human.mob_biotypes & MOB_UNDEAD) || ("undead" in human.faction) || HAS_TRAIT(human, TRAIT_ZOMBIE_IMMUNE))
				continue
			human.onbite(src)
	else if(istype(bite)) // continue biting if already started
		bite.bitelimb(src)

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
