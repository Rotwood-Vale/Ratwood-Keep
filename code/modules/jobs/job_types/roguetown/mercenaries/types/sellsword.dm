/datum/advclass/sellsword
	name = "Sellsword"
	tutorial = "You are a common sellsword, regarded as scum by many. You travelled the isle working as a bodyguard, mercenary or a cutthroat. You're loyal to your own well being and the sounds mammons make in your pouch."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = /datum/outfit/job/roguetown/mercenary/sellsword
	maximum_possible_slots = 10
	min_pq = 0
	torch = FALSE
	category_tags = list(CTAG_MERCENARY)


/datum/outfit/job/roguetown/mercenary/sellsword/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Swordsman","Fencer", "Cutthroat")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/mace

	switch(classchoice)
		if("Swordsman")
			H.set_blindness(0)
			to_chat(H, span_warning("You are well versed in the ways of the longsword. You have a steel sword and a leather helmet."))
			head = /obj/item/clothing/head/roguetown/helmet/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			beltr = /obj/item/rogueweapon/sword
			if(prob(40))
				beltr = /obj/item/rogueweapon/sword/long
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			neck = /obj/item/keyring/mercenary
			pants = /obj/item/clothing/under/roguetown/trou/leather
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/satchel
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
		if("Fencer")
			H.set_blindness(0)
			to_chat(H, span_warning("You are well versed in the ways of the rapier. You have a rapier and a tricorn."))
			head = /obj/item/clothing/head/roguetown/helmet/tricorn
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			beltr = /obj/item/rogueweapon/sword/rapier
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			neck = /obj/item/keyring/mercenary
			pants = /obj/item/clothing/under/roguetown/trou/leather
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/satchel
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
		if("Cutthroat")
			H.set_blindness(0)
			to_chat(H, span_warning("You are well versed in the ways of the Cutlass. You have a cutlass and a maritime outfit."))
			head = /obj/item/clothing/head/roguetown/helmet/bandana
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
			beltr = /obj/item/rogueweapon/sword/cutlass
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			neck = /obj/item/keyring/mercenary
			pants = /obj/item/clothing/under/roguetown/trou/leather
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/satchel
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
