/datum/subclass/otavanrefugees
	name = "Otava Refugees"
	tutorial = "Proud Cossacks that live freely, to the elven kingdoms of the frigid colds. You are a Refugee from Otava. Looking now for either safety, or a quick coin."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/human/northern, /datum/species/human/halfelf, /datum/species/elf, /datum/species/elf/wood)
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/otavanrefugees

/datum/outfit/job/roguetown/refugee/otavanrefugees
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/otavanrefugees/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Otavan Cossack", "Otavan Noble", "Otavan Peasant", "Otavan Orthodox Priest")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Otavan Cossack")
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
			pants = /obj/item/clothing/under/roguetown/tights/black
			shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			armor = /obj/item/clothing/suit/roguetown/armor/leather/advanced
			head = /obj/item/clothing/head/roguetown/papakha
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/gun/ballistic/firearm/arquebus_pistol
			l_hand = /obj/item/rogueweapon/sword/sabre
			backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1,/obj/item/powderflask = 1)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", -1)

			if(!H.has_language(/datum/language/elvish))
				H.grant_language(/datum/language/elvish)
				to_chat(H, span_info("I can speak Elvish with ,e before my speech."))

		if("Otavan Noble")
			H.mind.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE) 
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			belt = /obj/item/storage/belt/rogue/leather/black
			beltr = /obj/item/flashlight/flare/torch/lantern
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel)
			neck = /obj/item/storage/belt/rogue/pouch/coins/rich
			id = /obj/item/clothing/ring/silver
			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			cloak = /obj/item/clothing/cloak/half
			head = /obj/item/clothing/head/roguetown/papakha
			r_hand = /obj/item/rogueweapon/woodstaff
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("strength", 1)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

			if(!H.has_language(/datum/language/elvish))
				H.grant_language(/datum/language/elvish)
				to_chat(H, span_info("I can speak Elvish with ,e before my speech."))
		
		if("Otavan Peasant")	
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
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
			
			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)

			if(!H.has_language(/datum/language/elvish))
				H.grant_language(/datum/language/elvish)
				to_chat(H, span_info("I can speak Elvish with ,e before my speech."))
		
		if("Otavan Orthodox Priest")
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
			belt = /obj/item/storage/belt/rogue/leather
			shoes = /obj/item/clothing/shoes/roguetown/armor
			pants = /obj/item/clothing/under/roguetown/tights/black
			beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
			head = /obj/item/clothing/head/roguetown/papakha
			gloves = /obj/item/clothing/gloves/roguetown/leather
			beltl = /obj/item/rogueweapon/sword/rapier
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/silver = 1)
			H.change_stat("intelligence", 1)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 1)
			H.change_stat("constitution", 1)
			H.change_stat("perception", 2)
			H.verbs |= /mob/living/carbon/human/proc/torture_victim
			H.verbs |= /mob/living/carbon/human/proc/faith_test
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

			if(!H.has_language(/datum/language/elvish))
				H.grant_language(/datum/language/elvish)
				to_chat(H, span_info("I can speak Elvish with ,e before my speech."))

	H.set_blindness(0)
