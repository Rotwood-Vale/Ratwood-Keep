/datum/job/roguetown/bapprentice
	title = "Smithy Apprentice"
	flag = APPRENTICE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_ages = list(AGE_ADULT)

	tutorial = "Long hours and back-breaking work wouldnt even describe a quarter of what you do in a day for your Master. Its exhausting, filthy and you dont get much freetime: but someday youll get your own smithy, and youll have TWICE as many apprentices as your master does."

	outfit = /datum/outfit/job/roguetown/bapprentice
	display_order = JDO_APPRENTICE
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/bapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		shirt = null
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/key/blacksmith
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(/obj/item/rogueweapon/hammer = 1, /obj/item/rogueweapon/tongs = 1)
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/key/blacksmith
		cloak = /obj/item/clothing/cloak/apron/brown
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(/obj/item/rogueweapon/hammer = 1, /obj/item/rogueweapon/tongs = 1)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
