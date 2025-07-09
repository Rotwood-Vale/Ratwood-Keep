/datum/job/roguetown/butler
	title = "Butler"
	flag = BUTLER
	department_flag = COURTIERS
	selection_color = JCOLOR_COURTIER
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_SHUNNED_UP
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)

	tutorial = "Servitude unto death; That is your motto. Having nurtured royalty for years, you are nothing short of the Duke's majordomo, commanding over the rest of the house staff."

	outfit = /datum/outfit/job/roguetown/butler
	display_order = JDO_BUTLER
	give_bank_account = 30
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/butler/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/storage/keyring/butler
	beltl = /obj/item/storage/belt/rogue/pouch/coins/rich
	cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
	backl = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/clothing/ring/silver

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.change_stat("constitution", -1)
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 2)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1)