/datum/job/roguetown/architect
	title = "Architect"
	tutorial = "There are ancient secrets within stone, something your creed has known since man built upon dirt. You've pride in your work, youre the only reason this place doesn't fall apart."
	flag = ARCHITECT
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TOLERATED_UP
	allowed_ages = ALL_AGES_LIST

	outfit = /datum/outfit/job/roguetown/architect
	display_order = JDO_ARCHITECT
	min_pq = 12
	max_pq = null

/datum/outfit/job/roguetown/architect/pre_equip(mob/living/carbon/human/H)         ///////////// fuck being a dumb virgin
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	pants = /obj/item/clothing/under/roguetown/tights/black
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	backr = /obj/item/rogueweapon/pick/drill
	backl = /obj/item/storage/backpack/rogue/backpack
	wrists = /obj/item/storage/keyring/architect
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/lockpickring/mundane
	mask = /obj/item/clothing/mask/rogue/spectacles/golden

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)

		H.change_stat("strength", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.change_stat("endurance", 1)



