/datum/job/roguetown/prince
	title = "Heir"
	f_title = "Heiress"
	flag = PRINCE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_TOLERATED_UP 
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "You’ve never felt the gnawing of the winter, never known the bite of hunger and certainly have never known what the peasantry call a honest day's work. In your youth you were as free as any bird in the sky, but that is of the past. Your noble duties are fast approaching and you will soon have to choose: Continue to spend life leisurely, or stalwartly shoulder the duties you've been handed."

	outfit = /datum/outfit/job/roguetown/prince
	display_order = JDO_PRINCE
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/job/roguetown/prince/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	if(GLOB.lordsurname && H)
		give_lord_surname(H)

/datum/outfit/job/roguetown/prince/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
		armor = /obj/item/clothing/suit/roguetown/armor/leather/heir
		shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/keyring/royal
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		backr = /obj/item/storage/backpack/rogue/satchel
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.change_stat("perception", 1)
			H.change_stat("strength", 1)
			H.change_stat("constitution", 1)
			H.change_stat("endurance", -2) //a life free from hard labor
			H.change_stat("speed", 1)
			H.change_stat("intelligence", 2)

	else
		beltl = /obj/item/storage/keyring/royal
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		armor = /obj/item/clothing/suit/roguetown/armor/leather/heiress
		shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.change_stat("perception", 2)
			H.change_stat("endurance", -2)
			H.change_stat("strength", -1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
