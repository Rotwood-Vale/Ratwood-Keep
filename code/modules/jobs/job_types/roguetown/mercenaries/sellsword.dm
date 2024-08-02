/datum/job/roguetown/mercenary/sellsword
	title = "Sellsword"
	flag = SELLSWORD
	department_flag = MERCENARIES
	tutorial = "You are a common sellsword, albeit with some experience under your belt. You travelled the isle working as a bodyguard, mercenary or a cutthroat. You're loyal only to your own well being and the sounds mammons make in your pouch."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = /datum/outfit/job/roguetown/mercenary/sellsword
	display_order = JDO_SELLSWORD
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/mercenary/sellsword/pre_equip(mob/living/carbon/human/H)
	..()
	switch(rand(1,3))
		if(1)
			head = /obj/item/clothing/head/roguetown/helmet/leather
		if(2)
			head = /obj/item/clothing/head/roguetown/helmet/tricorn
		if(3)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	switch(rand(1,3))
		if(1)
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
		if(2)
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
		if(3)
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	switch(rand(1,3))
		if(1)
			beltr = /obj/item/rogueweapon/sword/cutlass
		if(2)
			beltr = /obj/item/rogueweapon/sword/long
		if(3)
			beltr = /obj/item/rogueweapon/sword/rapier
	beltl = /obj/item/rogueweapon/mace

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
