/datum/job/roguetown/orcgrunt
	title = "Orc Grunt"
	flag = ORCGRUNT
	department_flag = ORC
	faction = "Station"
	total_positions = 10
	spawn_positions = 10
	selection_color = JCOLOR_ORC
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "FOR TESTING PURPOSES ONLY"
	display_order = JDO_ORCGRUNT
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/orcgrunt
	give_bank_account = 16
	min_pq = -2
	max_pq = null

	cmode_music = 'sound/music/combat_bog.ogg'

/datum/outfit/job/roguetown/orcgrunt/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/orc_sallet
	backr = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	r_hand = /obj/item/rogueweapon/shield/wood/crafted
	gloves = /obj/item/clothing/gloves/roguetown/plate
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	pants = /obj/item/clothing/under/roguetown/platelegs/orc
	belt = /obj/item/storage/belt/rogue/leather/orc
	beltr = /obj/item/rogueweapon/stoneaxe/battle
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/orc_carapace
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_VIKINGCAMP, TRAIT_GENERIC)
	H.faction = list("orcs")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE) // Chieftess gets nearly same skills as guard.
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)

		H.change_stat("strength", 3)		//Same as captain.
		H.change_stat("intelligence", -2)
		H.change_stat("constitution", 4)
		H.change_stat("endurance", 4)
