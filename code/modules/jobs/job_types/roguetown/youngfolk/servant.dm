/datum/job/roguetown/servant
	title = "Servant"
	flag = SERVANT
	department_flag = ALL_AGES_LIST
	faction = "Station"
	total_positions = 6
	spawn_positions = 6

	allowed_races = RACES_SHUNNED_UP
	allowed_ages = list(AGE_ADULT)

	tutorial = "Granted a life of comfortable servitute in the King's manor, you follow the Butler/Maid's commands and spend your day performing necessary but menial tasks."

	outfit = /datum/outfit/job/roguetown/servant
	display_order = JDO_SERVANT
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("perception", 1)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather/rope
		neck = /obj/item/storage/belt/rogue/pouch
		beltr = /obj/item/keyring/servant
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		neck = /obj/item/storage/belt/rogue/pouch
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/keyring/servant
