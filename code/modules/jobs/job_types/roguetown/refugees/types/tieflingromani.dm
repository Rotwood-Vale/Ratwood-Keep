/datum/subclass/tieflingromani
	name = "Tiefling Erghun"
	tutorial = "You and your families had been always those of wanderlust, tossed out from every town or city. Yet still one must find way to make a living, and so to the next place you go."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/tieberian)
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/tieflingromani

/datum/outfit/job/roguetown/refugee/tieflingromani
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/tieflingromani/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Vaquero", "Erghuni Fortune Teller", "Erghuni Prostitute", "Erghuni")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Vaquero")
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/ridingboots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/tights
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves =/obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/advanced
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogue/instrument/guitar
			beltl = /obj/item/flashlight/flare/torch/lantern
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 2)
			H.change_stat("fortune", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)

		if("Erghuni Fortune Teller")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
			shirt = /obj/item/clothing/suit/roguetown/shirt/robe/magered
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/tights
			belt = /obj/item/storage/belt/rogue/leather/rope
			id = /obj/item/clothing/ring/gold
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/reagent_containers/powder/ozium = 1, /obj/item/lovepotion, /obj/item/scrying)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 1)
			H.change_stat("strength", -2)
			H.change_stat("endurance", -1)
			H.change_stat("constitution", -2)
			H.change_stat("speed", 1)
			H.change_stat("fortune", 5)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/message)
		
		if("Erghuni Prostitute")	
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/rogueweapon/huntingknife
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			backl = /obj/item/storage/backpack/rogue/satchel
			H.change_stat("speed", 2)
			H.change_stat("perception", 1)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
		
		if("Erghuni")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
			belt = /obj/item/storage/belt/rogue/leather/rope
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	H.set_blindness(0)
