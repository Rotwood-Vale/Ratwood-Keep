/datum/subclass/scavenger
	name = "Scavenger"
	tutorial = "Your life has been one of simple hardship and labor, whether out of necessity or choice. As you fled from the rot, \
				you learned how to best use and gather the natural resources around you.\ "

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/scavenger

/datum/outfit/job/roguetown/refugee/scavenger
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/scavenger/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Prospector", "Harvester", "Tracker")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Prospector")
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE) //pickaxe
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) 
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE) 
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			r_hand = /obj/item/rogueweapon/pick
			head = /obj/item/clothing/head/roguetown/hatfur
			armor = /obj/item/clothing/suit/roguetown/armor/workervest
			pants = /obj/item/clothing/under/roguetown/trou
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
			beltl = /obj/item/rogueweapon/hammer/claw
			backl = /obj/item/storage/backpack/rogue/backpack
			backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/huntingknife = 1)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", -1)

		if("Harvester")
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			head = /obj/item/clothing/head/roguetown/strawhat
			pants = /obj/item/clothing/under/roguetown/tights/random
			armor = /obj/item/clothing/suit/roguetown/armor/workervest
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)

		if("Tracker")
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			pants = /obj/item/clothing/under/roguetown/tights/random
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			backr = /obj/item/storage/backpack/rogue/satchel
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/ammo_holder/quiver/arrows
			beltl = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/flint = 1, /obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1)
			gloves = /obj/item/clothing/gloves/roguetown/leather
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)

	H.set_blindness(0)
