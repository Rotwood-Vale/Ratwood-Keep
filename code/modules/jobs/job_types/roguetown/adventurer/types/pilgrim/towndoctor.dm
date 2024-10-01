/datum/advclass/towndoctor
	name = "Barber Surgeon"
	tutorial = "You are the closest thing to a doctor that the townsfolk here will ever meet. Wielding crude tools and accumulated knowledge, you have probably cut into as many people as the average Knight."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/doctor
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	traits_applied = list(TRAIT_EMPATH, TRAIT_NOSTINK)
	cmode_music = 'sound/music/combat_physician.ogg'

/datum/outfit/job/roguetown/adventurer/doctor
	allowed_patrons = list(/datum/patron/divine/pestra, /datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/adventurer/doctor/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/mask/rogue/spectacles
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltr = /obj/item/rogueweapon/huntingknife/idagger
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
		/obj/item/rogueweapon/surgery/scalpel = 1,
		/obj/item/rogueweapon/surgery/saw = 1,
		/obj/item/rogueweapon/surgery/hemostat = 2,
		/obj/item/rogueweapon/surgery/retractor = 1,
		/obj/item/rogueweapon/surgery/bonesetter = 1,
		/obj/item/rogueweapon/surgery/cautery = 1,
		/obj/item/natural/worms/leech/cheele = 1,
		/obj/item/needle/pestra = 1,
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/pestle = 1,
	)
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
		pants = /obj/item/clothing/under/roguetown/trou
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
		head = /obj/item/clothing/head/roguetown/nightman
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		head = /obj/item/clothing/head/roguetown/armingcap

	ADD_TRAIT(H, TRAIT_STEELHEARTED, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		switch(H.patron?.type)
			if(/datum/patron/divine/pestra) 
				H.change_stat("strength", -1)
				H.change_stat("intelligence", 4)
				H.change_stat("speed", 2)  
				H.change_stat("perception", 2)
				if(H.age == AGE_OLD)
					H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
					H.change_stat("strength", -1)
					H.change_stat("constitution", -2)
					H.change_stat("intelligence", 2)
					H.change_stat("perception", 2)
			if(/datum/patron/divine/graggar) // Butcher-surgeon.
				H.change_stat("strength", 3) // Their only weapon skill is apprentice knives.
				H.change_stat("intelligence", -2)
				H.change_stat("speed", 2)  
				H.change_stat("perception", -2)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, -2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
				if(H.age == AGE_OLD)
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
					H.change_stat("strength", 1) // Negates the old age strength debuff.
					H.change_stat("constitution", -2) // This in combination of the nerfed stats of being old.
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)

