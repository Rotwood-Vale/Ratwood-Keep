/datum/job/roguetown/knavewench // The most aggressively rude name yet.
	title = "Tavern Knave"
	f_title = "Tavern Wench"
	flag = KNAVEWENCH
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 4
	spawn_positions = 4

	allowed_races = RACES_ALL_KINDS
	tutorial = "You have a simple role at the Azurian Pint; please. You wait tables and help guests, clean the rooms, grow and brew more drink, and assist in the kitchens as need be. Bring a smile to the masses--and those cheapsake townsfolk and adventures might just give you an extra coin...assuming you've not already pilfered their pouch while they're in a drunken stupor off your latest brew."

	outfit = /datum/outfit/job/roguetown/knavewench
	display_order = JDO_KNAVEWENCH
	give_bank_account = 10
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/knavewench/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		if(H.age == AGE_MIDDLEAGED)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/roguekey/tavern
	cloak = /obj/item/clothing/cloak/apron/waist
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	if(H.pronouns == HE_HIM || H.pronouns == THEY_THEM || H.pronouns == IT_ITS)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
	H.change_stat("constitution", 2)
