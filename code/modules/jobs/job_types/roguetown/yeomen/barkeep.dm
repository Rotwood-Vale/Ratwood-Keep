/datum/job/roguetown/barkeep
	title = "Barkeep"
	flag = BARKEEP
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_TOLERATED_UP

	tutorial = "Liquor Lodging and Lavish Baths, youre the life of the party and a rich bastard because of it. Well before that pesky merchant came around and convinced people to take up the bottle instead of the tankred, you were the reason the hardworking men and women of this town could rest."

	outfit = /datum/outfit/job/roguetown/barkeep
	display_order = JDO_BARKEEP
	give_bank_account = 43
	min_pq = -4
	max_pq = null

/datum/outfit/job/roguetown/barkeep/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	cloak = /obj/item/clothing/cloak/apron/waist
	if(H.gender == MALE)
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
		neck = /obj/item/keyring/innkeep
		cloak = /obj/item/clothing/cloak/apron/waist
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress
		neck = /obj/item/storage/belt/rogue/pouch/coins/mid
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltl = /obj/item/keyring/innkeep
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
