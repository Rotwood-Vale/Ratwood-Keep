/mob/living/carbon/human/species/skeleton
	name = "skeleton"
	
	race = /datum/species/human/northern
	gender = MALE
	domhand = 2
	simpmob_attack = 30
	simpmob_defend = 0
	bodyparts = list(/obj/item/bodypart/chest, /obj/item/bodypart/head, /obj/item/bodypart/l_arm,
					 /obj/item/bodypart/r_arm, /obj/item/bodypart/r_leg, /obj/item/bodypart/l_leg)
	faction = list("undead")
	var/skel_outfit = /datum/outfit/job/roguetown/npc/skeleton
	ambushable = FALSE
	rot_type = null
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw)
	a_intent = INTENT_HELP
	possible_mmb_intents = list(INTENT_STEAL, INTENT_JUMP, INTENT_KICK, INTENT_BITE)
	possible_rmb_intents = list(/datum/rmb_intent/feint, /datum/rmb_intent/aimed, /datum/rmb_intent/strong, /datum/rmb_intent/weak)

/mob/living/carbon/human/species/skeleton/npc
	aggressive = 1
	mode = AI_IDLE
	wander = FALSE
	candodge = FALSE

/mob/living/carbon/human/species/skeleton/npc/ambush

	wander = TRUE

/obj/item/bodypart/chest/skeleton
	max_damage = 450
/obj/item/bodypart/head/skeleton
	max_damage = 400
/obj/item/bodypart/l_arm/skeleton
	max_damage = 300
/obj/item/bodypart/r_arm/skeleton
	max_damage = 300
/obj/item/bodypart/r_leg/skeleton
	max_damage = 360
/obj/item/bodypart/l_leg/skeleton
	max_damage = 360

/mob/living/carbon/human/species/skeleton/Initialize()
	. = ..()
	cut_overlays()
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 10)

/mob/living/carbon/human/species/skeleton/after_creation()
	..()
	if(src.dna && src.dna.species)
		src.dna.species.species_traits |= NOBLOOD
		src.dna.species.soundpack_m = new /datum/voicepack/skeleton()
		src.dna.species.soundpack_f = new /datum/voicepack/skeleton()
	var/obj/item/bodypart/O = src.get_bodypart(BODY_ZONE_R_ARM)
	if(O)
		O.drop_limb()
		qdel(O)
	O = src.get_bodypart(BODY_ZONE_L_ARM)
	if(O)
		O.drop_limb()
		qdel(O)
	src.regenerate_limb(BODY_ZONE_R_ARM)
	src.regenerate_limb(BODY_ZONE_L_ARM)
	// src.remove_all_languages()
	// uncomment this to prohibit skeletons from knowing or speaking any languages. This is commented to allow skeletons to be the main subject of admin events. (eg: skeleton traders, skeletons concealing their bones and blending in with the kingdom society, the underworld bar skeletons, skeletons telling skeleton jokes)
	src.underwear = "Nude"
	if(src.charflaw)
		QDEL_NULL(src.charflaw)
	mob_biotypes |= MOB_UNDEAD
	faction = list("undead")
	name = "skelelon"
	real_name = "skelelon"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LIMBATTACHMENT, TRAIT_GENERIC)
	for(var/obj/item/bodypart/B in src.bodyparts)
		B.skeletonize(FALSE)
	update_body()
	if(skel_outfit)
		var/datum/outfit/OU = new skel_outfit
		if(OU)
			equipOutfit(OU)

/datum/outfit/job/roguetown/npc/skeleton/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = rand(6, 12)
	H.STAPER = rand(1, 6)
	H.STAINT = 1
	H.STACON = rand(12, 18)
	H.STAEND = rand(8, 10)
	H.STASPD = rand(1, 6)
	if(prob(99))
		if(prob(25))
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		if(prob(40))
			shoes = pickweight(list(/obj/item/clothing/shoes/roguetown/armor/leather = 2, /obj/item/clothing/shoes/roguetown/sandals = 3, /obj/item/clothing/shoes/roguetown/armor = 1))
		if(prob(5))
			cloak = /obj/item/clothing/cloak/tabard/crusader
		if(prob(30))
			armor = pickweight(list(/obj/item/clothing/suit/roguetown/armor/chainmail/iron = 1, /obj/item/clothing/suit/roguetown/armor/gambeson = 3, /obj/item/clothing/suit/roguetown/armor/leather = 5))
		if(prob(70))
			shirt = pickweight(list(/obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant = 4, /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l = 4, /obj/item/clothing/suit/roguetown/shirt/rags = 4))
		if(prob(50))
			pants = pickweight(list(/obj/item/clothing/under/roguetown/chainlegs/iron = 1, /obj/item/clothing/under/roguetown/trou/leather = 6))
		if(prob(60))
			head = pickweight(list(/obj/item/clothing/head/roguetown/helmet/leather = 2, /obj/item/clothing/head/roguetown/headband/red = 4, /obj/item/clothing/head/roguetown/helmet/horned = 1, /obj/item/clothing/head/roguetown/helmet/winged = 1, /obj/item/clothing/head/roguetown/menacing/bandit = 2))
		if(prob(25))
			gloves = pickweight(list(/obj/item/clothing/gloves/roguetown/chain/iron = 1, /obj/item/clothing/gloves/roguetown/leather = 6, /obj/item/clothing/gloves/roguetown/fingerless = 3))
		if(prob(45))
			neck = pickweight(list(/obj/item/clothing/neck/roguetown/chaincoif/iron = 1, /obj/item/clothing/neck/roguetown/coif = 6))
	else
		shoes = /obj/item/clothing/shoes/roguetown/jester
		pants = /obj/item/clothing/under/roguetown/tights/jester
		armor = /obj/item/clothing/suit/roguetown/shirt/jester
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/keyring/servant
		beltl = /obj/item/storage/belt/rogue/pouch
		head = /obj/item/clothing/head/roguetown/jester
		neck = /obj/item/clothing/neck/roguetown/coif

	var/skeleweapon = rand(1, 5)
	switch(skeleweapon)
		if(1)
			r_hand = /obj/item/rogueweapon/sword/iron
		if(2)
			r_hand = /obj/item/rogueweapon/stoneaxe/woodcut
		if(3)
			r_hand = /obj/item/rogueweapon/spear/stone
		if(4)
			r_hand = /obj/item/rogueweapon/huntingknife/stoneknife
			l_hand = /obj/item/rogueweapon/huntingknife/stoneknife
		if(5)
			r_hand = /obj/item/rogueweapon/sword/iron/messer

/mob/living/carbon/human/species/skeleton/npc/no_equipment
    skel_outfit = null

/mob/living/carbon/human/species/skeleton/no_equipment
    skel_outfit = null
