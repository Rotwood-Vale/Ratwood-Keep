/datum/job/roguetown/butler
	title = "Butler"
	flag = BUTLER
	department_flag = COURTIERS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	f_title = "Maid"
	allowed_races = RACES_TOLERATED_UP
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)

	tutorial = "Servitude unto death; That is your motto. Having nurtured royalty for years, you are nothing short of the King's majordomo, commanding over the rest of the house staff."

	outfit = /datum/outfit/job/roguetown/butler
	display_order = JDO_BUTLER
	give_bank_account = 15
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/butler/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)

	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/keyring/servant
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		cloak = /obj/item/clothing/cloak/apron/waist
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/keyring/servant
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)

