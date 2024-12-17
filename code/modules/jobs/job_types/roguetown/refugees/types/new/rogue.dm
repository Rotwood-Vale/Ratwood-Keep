/datum/subclass/rogue
	name = "Rogue"
	tutorial = "A life of crime has led you to wander from city to city, always looking for an opportunity to \
				make a quick buck at someone else's expense. The ever spreading rot has pushed you towards a new haven, \
				where illicit profit is sure to be made."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	cmode_music = 'sound/music/combat_duelist.ogg'

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/rogue

/datum/outfit/job/roguetown/refugee/rogue
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Thief", "Smuggler", "Cutthroat")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Thief")
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			backpack_contents = list(/obj/item/lockpickring/mundane = 1)
			H.change_stat("strength", -1)
			H.change_stat("perception", 1)
			H.change_stat("speed", 3)
			H.change_stat("intelligence", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

		if("Smuggler")
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE) 
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE) 
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			head =/obj/item/clothing/head/roguetown/helmet/bandana
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/mid
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/backpack
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltl = /obj/item/ammo_holder/quiver
			backpack_contents = list(/obj/item/reagent_containers/powder = 2, /obj/item/reagent_containers/glass/bottle/mercury = 2, /obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1)
			H.change_stat("perception", 1) 
			H.change_stat("endurance", 1)
			H.change_stat("speed", 1)
			H.change_stat("fortune", 1)
			H.cmode_music = 'sound/music/combat_pirate.ogg'
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

		if("Cutthroat") //thief but less sneak and more stab
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			beltl = /obj/item/rogueweapon/huntingknife/idagger
			H.change_stat("strength", 1)
			H.change_stat("perception", 1)
			H.change_stat("speed", 1)
			H.change_stat("intelligence", -1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	H.set_blindness(0)
