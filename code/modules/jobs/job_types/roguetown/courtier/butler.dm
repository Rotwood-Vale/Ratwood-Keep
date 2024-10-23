/datum/job/roguetown/butler
	title = "Head Butler"
	f_title = "Head Maid"
	flag = BUTLER
	department_flag = COURTIERS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	//allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)

	tutorial = "Servitude unto death; That is your motto. Having nurtured royalty for years, you are nothing short of the King's majordomo, commanding over the rest of the house staff."

	outfit = /datum/outfit/job/roguetown/butler
	display_order = JDO_BUTLER
	give_bank_account = 30
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/butler/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("speed", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 1)

	if(H.pronouns == SHE_HER)
	//	switch(H.patron?.type)
	//		if(/datum/patron/divine/eora) //Eoran loadouts
	//			armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy/black
	//			pants = pick(/obj/item/clothing/under/roguetown/tights/stockings/silk/black, /obj/item/clothing/under/roguetown/tights/stockings/fishnet/black)
	//			head  = /obj/item/clothing/head/peaceflower
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen
		pants = pick(/obj/item/clothing/under/roguetown/tights/stockings/black, /obj/item/clothing/under/roguetown/tights/stockings/white) //Added stockings for the maids
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		cloak = /obj/item/clothing/cloak/apron/waist
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/storage/keyring/servant
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	else
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/storage/keyring/servant
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		head = /obj/item/clothing/head/roguetown/fancyhat
