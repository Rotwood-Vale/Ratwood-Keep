/mob/living/carbon/human/species/skeleton
	name = "skeleton"
	
	race = /datum/species/human/northern
	gender = MALE
	bodyparts = list(/obj/item/bodypart/chest, /obj/item/bodypart/head, /obj/item/bodypart/l_arm,
					 /obj/item/bodypart/r_arm, /obj/item/bodypart/r_leg, /obj/item/bodypart/l_leg)
	faction = list("undead")
	var/skel_outfit = /datum/outfit/job/roguetown/npc/skeleton
	ambushable = FALSE
	rot_type = null
	possible_rmb_intents = list()

/mob/living/carbon/human/species/skeleton/npc
	aggressive = 1
	mode = AI_IDLE
	wander = FALSE

/mob/living/carbon/human/species/skeleton/npc/ambush

	wander = TRUE

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
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
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
	if(prob(90))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(80))
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	if(prob(30))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(30))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	if(prob(90))
		pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	if(prob(40))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(70))
		gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	if(prob(70))
		neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	if(H.gender == FEMALE)
		H.STASTR = rand(9,12)
	else
		H.STASTR = rand(14,16)
	H.STASPD = 8
	H.STACON = 4
	H.STAEND = 15
	H.STAINT = 1
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/iron
	else
		r_hand = /obj/item/rogueweapon/stoneaxe/woodcut

/mob/living/carbon/human/species/skeleton/npc/no_equipment
    skel_outfit = null

/mob/living/carbon/human/species/skeleton/no_equipment
    skel_outfit = null
