/datum/subclass/scavenger
	name = "Scavenger"
	tutorial = "Your life has been one of simple hardship and labor, whether out of necessity or choice. As you fled from the rot, \
				you learned how to best use and gather the natural resources around you.\ "

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	outfit = /datum/outfit/job/roguetown/refugee/scavenger

/datum/outfit/job/roguetown/refugee/scavenger
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/scavenger/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Prospector", "Harvester", "Tracker", "Thief", "Smuggler", "Stalker", "Whore", "Minstrel", "Harlequin", "Charlatan", "Drunkard", "Gravedigger","Peddler", "Spicer")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Prospector")
			r_hand = /obj/item/rogueweapon/pick
			head = /obj/item/clothing/head/roguetown/hatfur
			neck = /obj/item/storage/belt/rogue/pouch/coins/mid
			armor = /obj/item/clothing/suit/roguetown/armor/workervest
			pants = /obj/item/clothing/under/roguetown/trou
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/tongs
			beltl = /obj/item/rogueweapon/hammer/wood
			backl = /obj/item/storage/backpack/rogue/backpack
			backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/rogueweapon/chisel = 1)

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
			H.mind.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)

			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", -1)

		if("Harvester")
			head = /obj/item/clothing/head/roguetown/strawhat
			armor = /obj/item/clothing/suit/roguetown/armor/workervest
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			r_hand = /obj/item/rogueweapon/thresher
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltl = /obj/item/rogueweapon/sickle
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			backl = /obj/item/storage/backpack/rogue/backpack
			backpack_contents = list(/obj/item/seeds/wheat = 2, /obj/item/seeds/apple = 1, /obj/item/ash = 3, /obj/item/rogueweapon/handsaw = 1)
			pants = /obj/item/clothing/under/roguetown/tights/random
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes

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
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)

			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)

		if("Tracker")
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
			gloves = /obj/item/clothing/gloves/roguetown/leather
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/ammo_holder/quiver/arrows
			beltl = /obj/item/flashlight/flare/torch/lantern
			backr = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/flint = 1, /obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1)
			pants = /obj/item/clothing/under/roguetown/tights/random
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather

			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)

			H.change_stat("intelligence", 1)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)

		if("Thief")
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
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
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife/idagger
			beltr = /obj/item/ammo_holder/bomb/smokebombs
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
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE) // let's them recognize reagents
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
			beltl = /obj/item/ammo_holder/quiver/bolts
			backpack_contents = list(/obj/item/reagent_containers/powder/ozium = 2, /obj/item/reagent_containers/glass/bottle/mercury = 2, /obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 1)
			H.change_stat("fortune", 1)
			H.cmode_music = 'sound/music/combat_pirate.ogg'
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

		if("Stalker") //thief but ranger
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
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
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			beltl = /obj/item/ammo_holder/quiver/arrows
			H.change_stat("perception", 2)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

		if("Whore")
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			r_hand = /obj/item/soap/bath
			if(H.gender == MALE)
				pants =	/obj/item/clothing/under/roguetown/loincloth
				belt =	/obj/item/storage/belt/rogue/leather/cloth
			else
				shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
				armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy
				pants =	/obj/item/clothing/under/roguetown/tights/stockings/fishnet/random
				belt =	/obj/item/storage/belt/rogue/leather/cloth
			H.change_stat("constitution", 1)
			H.change_stat("endurance", 2)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)

		if("Minstrel")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/bardhat
			pants = /obj/item/clothing/under/roguetown/tights/random
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			cloak = /obj/item/clothing/cloak/raincloak/red
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/ammo_holder/bomb/smokebombs
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			head = /obj/item/clothing/head/roguetown/bardhat //with this hat, they will get all the pussy(or dick depending on preference(or both ig))
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/white
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			var/instrument = pick(0,1,2,3,4,5)
			switch(instrument)
				if(0)
					backr = /obj/item/rogue/instrument/harp
				if(1)
					backr = /obj/item/rogue/instrument/lute
				if(2)
					backr = /obj/item/rogue/instrument/accord
				if(3)
					backr = /obj/item/rogue/instrument/guitar
				if(4)
					backr = /obj/item/rogue/instrument/flute
				if(5)
					backr = /obj/item/rogue/instrument/drum
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 2)
			H.change_stat("speed", 2)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)

		if("Harlequin")
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
			H.cmode_music = 'sound/music/combat_jester.ogg'
			H.verbs |= /mob/living/carbon/human/proc/ventriloquate
			H.verbs |= /mob/living/carbon/human/proc/ear_trick
			// TODO: Make alternative colored versions of the jester outfit
			shoes = /obj/item/clothing/shoes/roguetown/jester
			pants = /obj/item/clothing/under/roguetown/tights
			armor = /obj/item/clothing/suit/roguetown/shirt/jester
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/ammo_holder/bomb/smokebombs
			beltl = /obj/item/storage/belt/rogue/pouch
			head = /obj/item/clothing/head/roguetown/jester
			neck = /obj/item/clothing/neck/roguetown/coif
			H.change_stat("intelligence", 2)
			H.change_stat("perception", -1)
			H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)

		if("Charlatan")
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/fancyhat
			shoes = /obj/item/clothing/shoes/roguetown/armor
			pants = /obj/item/clothing/under/roguetown/tights/random
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			backpack_contents = list(/obj/item/lockpick = 1)
			H.change_stat("strength", 1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 1)
			H.change_stat("fortune", -1)

		if("Drunkard")
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			armor = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/clothing/mask/cigarette/rollie/cannabis
			beltl = /obj/item/flint
			backpack_contents = list(/obj/item/storage/pill_bottle/dice = 1, /obj/item/toy/cards/deck = 1, /obj/item/reagent_containers/glass/bottle/rogue/wine = 1)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE) //Climbing into windows to steal drugs or booze.
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
			H.change_stat("intelligence", -2)
			H.change_stat("constitution", 1)
			H.change_stat("strength", 1)
			H.change_stat("fortune", 2)

		if("Gravedigger")
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/leather/vest
			backr = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			backpack_contents = list(/obj/item/lockpick = 1)
			gloves = /obj/item/clothing/gloves/roguetown/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail
			shoes = /obj/item/clothing/shoes/roguetown/armor
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/sword/iron/short
			backl = /obj/item/rogueweapon/shovel
			head = /obj/item/clothing/head/roguetown/puritan
			H.change_stat("strength", 2)
			H.change_stat("perception", 1)
			H.change_stat("speed", 2)
			H.change_stat("endurance", 1)
			H.change_stat("fortune", 1)

		if("Peddler")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/chaperon
			cloak = /obj/item/clothing/cloak/raincloak/blue
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
			pants = /obj/item/clothing/under/roguetown/tights/sailor
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
			id = /obj/item/clothing/ring/gold
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			// TODO: randomized content table
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/clothing/ring/silver = 2, /obj/item/reagent_containers/glass/bottle/rogue/healthpot = 2, /obj/item/reagent_containers/glass/bottle/rogue/manapot = 2)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 3)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

		if("Spicer")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			head = /obj/item/clothing/head/roguetown/puritan
			backpack_contents = list(/obj/item/reagent_containers/powder/spice = 2, /obj/item/reagent_containers/powder/ozium = 1, /obj/item/reagent_containers/powder/moondust = 2)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

		// TODO: add useless trinkets before this class makes sense
		// if("Hoaxer")
		// 	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

	H.set_blindness(0)
