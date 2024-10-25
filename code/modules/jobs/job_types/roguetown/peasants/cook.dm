/datum/job/roguetown/cook
	title = "Cook"
	flag = COOK
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	tutorial = "There are many mouths to feed in town, and most look to you for it. You work under the care of the innkeeper, and craft such culinary delights that even the crown stops by, from time to time. All the while, you try to get the rest of the staff up to speed, too, before you get too many burn marks on you."

	outfit = /datum/outfit/job/roguetown/cook
	display_order = JDO_COOK
	give_bank_account = 25
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/cook/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		if(H.age == AGE_MIDDLEAGED)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/roguekey/tavern
	backr = /obj/item/storage/backpack/rogue/satchel
	cloak = /obj/item/clothing/cloak/apron/cook
	head = /obj/item/clothing/head/roguetown/cookhat
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	if(H.gender == MALE || THEY_THEM)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
	H.change_stat("constitution", 2)
