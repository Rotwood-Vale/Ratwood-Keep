/datum/job/roguetown/architect
	title = "Architect"
	tutorial = " The Archivist meticulously preserves and organizes ancient scrolls and tomes, safeguarding the collective knowledge of the realm for generations to come. Nobles and Peasants alike often seek the Archivists expertise on matters of history and fact."
	flag = ARCHITECT
	department_flag = COURTIERS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TOLERATED_UP
	allowed_ages = ALL_AGES_LIST

	outfit = /datum/outfit/job/roguetown/architect
	display_order = JDO_ARCHITECT
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/architect/pre_equip(mob/living/carbon/human/H)         ///////////// fuck being a dumb virgin
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	pants = /obj/item/clothing/under/roguetown/tights/black
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	backr = /obj/item/gun/ballistic/blunderbuss
	backl = /obj/item/rogueweapon/pick/drill
	wrists = /obj/item/keyring/architect
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/ammo_holder/bullet/grapeshot
	mask = /obj/item/clothing/mask/rogue/spectacles/golden
	neck = /obj/item/powderflask

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("intelligence", 4)
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.change_stat("endurance", 2)



