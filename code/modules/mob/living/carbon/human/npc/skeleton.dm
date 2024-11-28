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
	wander = TRUE

/mob/living/carbon/human/species/skeleton/Initialize()
	. = ..()
	cut_overlays()
	spawn(10)
		after_creation()

//	addtimer(CALLBACK(src, PROC_REF(after_creation)), 10)  fired loadout equip again, leading to duping inhands. Unclear why its here.

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
	for(var/obj/item/bodypart/B in src.bodyparts)
		B.skeletonize()
	var/obj/item/organ/eyes/eyes = src.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(src)
	src.underwear = "Nude"
	if(src.charflaw)
		QDEL_NULL(src.charflaw)
	update_body()
	mob_biotypes = MOB_UNDEAD
	faction = list("undead")
	name = "skeleton"
	real_name = "skeleton"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	if(skel_outfit)
		var/datum/outfit/OU = new skel_outfit
		if(OU)
			equipOutfit(OU)
	QDEL_NULL(sexcon)
//	aggressive=1		should already be handled in the parent
//	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
//	wander = TRUE

/datum/outfit/job/roguetown/npc/skeleton/random/pre_equip(mob/living/carbon/human/H)
	..()

	H.STASTR = 6
	H.STASPD = 10
	H.STACON = 8
	H.STAEND = 8
	H.STAINT = 1


///////////////////////////////////////////////////////////// EVENTMIN SKELETONGS

/mob/living/carbon/human/species/skeleton/npc/peasant/after_creation()
	..()
	QDEL_NULL(sexcon)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/skeleton/npc/peasant)

/datum/outfit/job/roguetown/species/skeleton/npc/peasant/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 6
	H.STASPD = 8
	H.STACON = 8
	H.STAEND = 8
	var/loadout = rand(1,7)
	head = /obj/item/clothing/head/roguetown/roguehood/random
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l

	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
	switch(loadout)
		if(1) //Axe Warrior
			r_hand = /obj/item/rogueweapon/axe/iron
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/knitcap
		if(2) //Long Stick Fighter
			r_hand = /obj/item/rogueweapon/polearm/woodstaff
		if(3) //Club Caveman
			r_hand = /obj/item/rogueweapon/mace/woodclub
		if(4) //Stabbity Stabbity your Knight is now horizontality
			r_hand =/obj/item/rogueweapon/pitchfork
			head = /obj/item/clothing/head/roguetown/strawhat
		if(5) //Bonk Build
			r_hand = /obj/item/rogueweapon/thresher
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		if(6) //Bonk Build
			r_hand = /obj/item/rogueweapon/hoe
			head = /obj/item/clothing/head/roguetown/fisherhat
		if(7) //Ex Wife
			r_hand = /obj/item/cooking/pan
			head = /obj/item/clothing/head/roguetown/armingcap
			shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/brown


///////////////////////////////////////////////////////////// EVENTMIN SKELETONGS
/mob/living/carbon/human/species/skeleton/npc/ambush/after_creation()
	..()
	QDEL_NULL(sexcon)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/skeleton/npc/random)

/datum/outfit/job/roguetown/species/skeleton/npc/random/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l

	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/roguehood/random
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/iron
	else
		r_hand = /obj/item/rogueweapon/mace/woodclub

///////////////////////////////////////////////////////////// EVENTMIN SKELETONGS

/mob/living/carbon/human/species/skeleton/npc/warrior/after_creation()
	..()
	QDEL_NULL(sexcon)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/skeleton/npc/warrior)

/datum/outfit/job/roguetown/species/skeleton/npc/warrior/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 10
	H.STASPD = 7
	H.STACON = 10
	H.STAEND = 10
	var/loadout = rand(1,6)
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l

	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
	switch(loadout)
		if(1) //Skeleton Warrior
			r_hand = /obj/item/rogueweapon/sword/iron
			l_hand = /obj/item/rogueweapon/shield/wood
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(2)//Skeleton Warrior
			r_hand = /obj/item/rogueweapon/mace
			l_hand = /obj/item/rogueweapon/shield/wood
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(3) //Skeleton Warrior
			r_hand = /obj/item/rogueweapon/flail
			l_hand = /obj/item/rogueweapon/shield/wood
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
		if(4) //Skeleton Warrior
			r_hand =/obj/item/rogueweapon/polearm/spear
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(5) //Skeleton Warrior
			r_hand = /obj/item/rogueweapon/sword/sabre
			l_hand = /obj/item/rogueweapon/knife/dagger
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(6) //Skeleton Warrior
			r_hand = /obj/item/rogueweapon/sword/scimitar/messer
			l_hand = /obj/item/rogueweapon/knife/dagger
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/skullcap


// ====================		ANCIENT SKELLY		==========================
/mob/living/carbon/human/species/skeleton/npc/ancient/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/species/skeleton/npc/ancient)

/datum/outfit/job/roguetown/species/skeleton/npc/ancient/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 10
	H.STASPD = 7
	H.STACON = 10
	H.STAEND = 10
	var/loadout = rand(1,3)
	if(prob(20))
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass/copperchest
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron/rust
	if(prob(30))
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/plain

	if(prob(20))
		head = /obj/item/clothing/head/roguetown/helmet/coppercap
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/rust
	if(prob(20))
		neck = /obj/item/clothing/neck/roguetown/gorget/copper

	switch(loadout)
		if(1)
			r_hand = /obj/item/rogueweapon/sword/coppermesser
		if(2)
			r_hand = /obj/item/rogueweapon/mace/cudgel/bludgeon
			l_hand = /obj/item/rogueweapon/shield/wood
		if(3)
			r_hand = /obj/item/rogueweapon/polearm/spear/stone/copper
			l_hand = /obj/item/rogueweapon/shield/tower/hoplite


// ====================		SKILLED SKELLY		==========================
/mob/living/carbon/human/species/skeleton/npc/warrior/skilled/after_creation()
	..()
	QDEL_NULL(sexcon)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/skeleton/npc/warrior)
	d_intent = INTENT_PARRY //these ones will parry instead of dodge, making them much more dangerous
	configure_mind()

/mob/living/carbon/human/species/skeleton/npc/warrior/skilled/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
