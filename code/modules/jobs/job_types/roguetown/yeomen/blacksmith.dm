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
	gloves = /obj/item/clothing/gloves/roguetown/leather
	head = /obj/item/clothing/head/roguetown/hatfur
	cloak = /obj/item/clothing/cloak/apron/blacksmith
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/key/blacksmith = 1)
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/tongs
	beltr = /obj/item/rogueweapon/hammer/iron
	pants = /obj/item/clothing/under/roguetown/trou
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		if(H.age == AGE_MIDDLEAGED)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)

	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
