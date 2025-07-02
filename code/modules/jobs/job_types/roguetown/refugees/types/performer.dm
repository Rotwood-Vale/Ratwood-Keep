/datum/subclass/performer
	name = "Performer"
	tutorial = "Your whole life has been a degrading spectacle. Whether as part of a traveling circus or lone performer, \
				you've learned how to sell your talents or your body. The depressing state of the world has driven you to \
				seek refuge in a place where entertainment is still valued, even if it's just a distraction from the catastrophe."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 15

	outfit = /datum/outfit/job/roguetown/refugee/performer

/datum/outfit/job/roguetown/refugee/performer
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/performer/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Whore", "Minstrel", "Harlequin")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Whore")
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			neck = neck = /obj/item/clothing/neck/roguetown/coif
			r_hand = /obj/item/soap/bath
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
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
			H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
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
			neck = /obj/item/clothing/neck/roguetown/coif
			shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/white
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1)
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
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
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
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			head = /obj/item/clothing/head/roguetown/jester
			neck = /obj/item/clothing/neck/roguetown/coif
			H.change_stat("intelligence", 2)
			H.change_stat("perception", -1)
			H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	H.set_blindness(0)
