/datum/job/roguetown/prince
	title = "Royal Heir"
	f_title = "Royal Heir"
	flag = PRINCE
	department_flag = APPRENTICES
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_ALL_KINDS //Maybe a system to force-pick lineage based on king and queen should be implemented.
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "Born into the royal family or to parents in its good graces, your heritage has bought you a \"free\" ride through life. You’ve never felt the gnawing of the winter, never known the bite of hunger and certainly have never known a honest day's work. You are as free as any bird in the sky, and you may revel in your debauchery for as long as your parents remain in their favourable position: But someday you’ll have to grow up, and that will be the day your carelessness will cost you more than a few mammons."

	outfit = /datum/outfit/job/roguetown/prince
	display_order = JDO_PRINCE
	give_bank_account = TRUE
	min_pq = 1
	max_pq = null

/datum/job/roguetown/prince/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	if(GLOB.lordsurname && H)
		if(input("Take the surname of the current ruler and be a Prince/Princess?"))
			give_lord_surname(H)

/datum/outfit/job/roguetown/prince/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail
		shoes = /obj/item/clothing/shoes/roguetown/nobleboot
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/roguekey/manor
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		backr = /obj/item/storage/backpack/rogue/satchel
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.change_stat("perception", 1)
			H.change_stat("strength", -2)
			H.change_stat("endurance", -1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
	else
		beltl = /obj/item/roguekey/manor
		head = /obj/item/clothing/head/roguetown/hennin
		neck = /obj/item/storage/belt/rogue/pouch/coins/rich
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		armor = /obj/item/clothing/suit/roguetown/armor/silkcoat
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/princess
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random	//Added Silk Stockings for the female nobles
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.change_stat("perception", 2)
			H.change_stat("endurance", -2)
			H.change_stat("strength", -3)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
