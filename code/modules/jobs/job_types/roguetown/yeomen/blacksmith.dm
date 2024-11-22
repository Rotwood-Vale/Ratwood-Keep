/datum/job/roguetown/guildsmith
	title = "Guild Smith"
	flag = GUILDSMITH
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_SHUNNED_UP

	tutorial = "You studied for many decades under your master with a few other apprentices to become an smith, a trade that certainly has seen a boom in revenue in recent times with many a bannerlord seeing the importance in maintaining a well-equipped army."

	outfit = /datum/outfit/job/roguetown/guildsmith
	display_order = JDO_GUILDSMITH
	give_bank_account = 11
	min_pq = 1
	max_pq = null

/datum/outfit/job/roguetown/guildsmith/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)

	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(/obj/item/rogueweapon/hammer = 1, /obj/item/rogueweapon/tongs = 1)
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/key/blacksmith
		cloak = /obj/item/clothing/cloak/apron/blacksmith
	else
		pants = /obj/item/clothing/under/roguetown/trou
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(/obj/item/rogueweapon/hammer = 1, /obj/item/rogueweapon/tongs = 1)
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		cloak = /obj/item/clothing/cloak/apron/blacksmith
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/key/blacksmith
	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
