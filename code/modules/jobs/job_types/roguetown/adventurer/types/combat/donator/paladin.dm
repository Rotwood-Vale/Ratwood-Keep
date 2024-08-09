//shield flail or longsword, tief can be this with red cross

/datum/advclass/paladin
	name = "Paladin"
	tutorial = "Paladins are holy warriors who have taken sacred vows to uphold justice and righteousness. Often, they were promised redemption for past sins if they crusaded in the name of the gods."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/paladin
	traits_applied = list(TRAIT_HEAVYARMOR)
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/paladin
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/roguetown/adventurer/paladin/pre_equip(mob/living/carbon/human/H)
	..()
	switch(H.patron.name)
		if("Astrata")
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
		if("Dendor")
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
		if("Necra")
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
		if("Pestra")
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
		if("Noc")
			neck = /obj/item/clothing/neck/roguetown/psicross/noc
		if("Eora") //Eora content from Stonekeep
			neck = /obj/item/clothing/neck/roguetown/psicross/eora


	H.adjust_blindness(-3)
	var/classes = list("Paladin","Battle Master",)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Paladin")
			to_chat(src, span_warning("Paladins are holy warriors who have taken sacred vows to uphold justice and righteousness. Often, they were promised redemption for past sins if they crusaded in the name of the gods."))
			H.set_blindness(0) // No introduction text due to there being no real difference in Paladin archetypes for now.
			to_chat(H, span_warning("You are a paladin."))
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.change_stat("perception", 1)
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2) // Classic paladin is faster then the battle master.
			H.change_stat("endurance", 1)
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			belt = /obj/item/storage/belt/rogue/leather/hand
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife
			id = /obj/item/clothing/ring/silver
			cloak = /obj/item/clothing/cloak/tabard/crusader
			switch(H.patron.name)
				if("Astrata")
					cloak = /obj/item/clothing/cloak/tabard/crusader/astrata
				if("Dendor")
					cloak = /obj/item/clothing/cloak/tabard/crusader/dendor
				if("Necra")
					cloak = /obj/item/clothing/cloak/tabard/crusader/necra
				if("Pestra")
					cloak = /obj/item/clothing/cloak/tabard/crusader/pestra
				if("Noc")
					cloak = /obj/item/clothing/cloak/tabard/crusader/noc
			if(prob(70))
				backr = /obj/item/rogueweapon/sword
			else
				backr = /obj/item/rogueweapon/sword/long
			backl = /obj/item/storage/backpack/rogue/satchel
		if("Battle Master")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a battle-master."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.change_stat("perception", 1)
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", -1)
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			belt = /obj/item/storage/belt/rogue/leather/hand
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife
			id = /obj/item/clothing/ring/silver
			cloak = /obj/item/clothing/cloak/tabard/crusader
			switch(H.patron.name)
				if("Astrata")
					cloak = /obj/item/clothing/cloak/tabard/crusader/astrata
				if("Dendor")
					cloak = /obj/item/clothing/cloak/tabard/crusader/dendor
				if("Necra")
					cloak = /obj/item/clothing/cloak/tabard/crusader/necra
				if("Pestra")
					cloak = /obj/item/clothing/cloak/tabard/crusader/pestra
				if("Noc")
					cloak = /obj/item/clothing/cloak/tabard/crusader/noc
				if("Eora") //Eora content from Stonekeep
					cloak = /obj/item/clothing/cloak/tabard/crusader/eora
			backr = /obj/item/rogueweapon/flail
			if(prob(50))
				l_hand = /obj/item/rogueweapon/shield/wood
			else
				l_hand = /obj/item/rogueweapon/shield/tower/metal
			backl = /obj/item/storage/backpack/rogue/satchel

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	if(H.dna.species.type == /datum/species/tieberian)
		cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	//Max devotion limit - Paladins are stronger but cannot pray to gain all abilities beyond t1
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
