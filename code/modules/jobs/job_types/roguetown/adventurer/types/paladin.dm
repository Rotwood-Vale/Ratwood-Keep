/datum/subclass/paladin
	name = "Paladin"
	tutorial = "Paladins are holy warriors who have taken sacred vows to uphold justice and righteousness. Often, they were promised redemption for past sins if they crusaded in the name of the gods."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = /datum/outfit/job/roguetown/adventurer/paladin
	category_tags = list(CTAG_ADVENTURER)

	cmode_music = 'sound/music/combat_clergy.ogg'

/datum/outfit/job/roguetown/adventurer/paladin
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/roguetown/adventurer/paladin/pre_equip(mob/living/carbon/human/H)
	..()
	switch(H.patron.name)
		if("Astrata")
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
		if("Noc")
			neck = /obj/item/clothing/neck/roguetown/psicross/noc
		if("Dendor")
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
		if("Necra")
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
		if("Pestra")
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
		if("Malum")
			neck = /obj/item/clothing/neck/roguetown/psicross/malum
		if("Ravox")
			neck = /obj/item/clothing/neck/roguetown/psicross/ravox
		if("Eora")
			neck = /obj/item/clothing/neck/roguetown/psicross/eora


	H.adjust_blindness(-3)
	var/classes = list("Paladin","Battle Master",)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Paladin")
			to_chat(H, span_warning("Paladins are holy warriors who have taken sacred vows to uphold justice and righteousness. Often, they were promised redemption for past sins if they crusaded in the name of the gods."))
			H.set_blindness(0) // No introduction text due to there being no real difference in Paladin archetypes for now.
			to_chat(H, span_warning("You are a Paladin."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2) // Classic paladin is faster then the battle master.
			H.change_stat("endurance", 2)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			belt = /obj/item/storage/belt/rogue/leather/steel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			id = /obj/item/clothing/ring/silver
			backpack_contents = list(/obj/item/rogueweapon/huntingknife)
			cloak = /obj/item/clothing/cloak/tabard/crusader
			switch(H.patron.name)
				if("Astrata")
					cloak = /obj/item/clothing/cloak/templar/astratan
				if("Dendor")
					cloak = /obj/item/clothing/cloak/tabard/crusader/dendor
				if("Necra")
					cloak = /obj/item/clothing/cloak/templar/necran
				if("Pestra")
					cloak = /obj/item/clothing/cloak/tabard/crusader/pestra
				if("Noc")
					cloak = /obj/item/clothing/cloak/tabard/crusader/noc
				if("Malum")
					cloak = /obj/item/clothing/cloak/templar/malummite
				if("Eora")
					cloak = /obj/item/clothing/cloak/tabard/crusader/eora
			if(H.age == AGE_OLD)
				beltr = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
				head = /obj/item/clothing/neck/roguetown/chaincoif
			else if(prob(50))
				head = /obj/item/clothing/neck/roguetown/chaincoif
			else
				head = /obj/item/clothing/head/roguetown/helmet
			backr = /obj/item/rogueweapon/sword/iron
			backl = /obj/item/storage/backpack/rogue/satchel
		if("Battle Master")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a Battle-Master."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 2)
			H.change_stat("speed", -1)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			belt = /obj/item/storage/belt/rogue/leather/steel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			id = /obj/item/clothing/ring/silver
			backpack_contents = list(/obj/item/rogueweapon/huntingknife)
			cloak = /obj/item/clothing/cloak/tabard/crusader
			switch(H.patron.name)
				if("Astrata")
					cloak = /obj/item/clothing/cloak/templar/astratan
				if("Dendor")
					cloak = /obj/item/clothing/cloak/tabard/crusader/dendor
				if("Necra")
					cloak = /obj/item/clothing/cloak/templar/necran
				if("Pestra")
					cloak = /obj/item/clothing/cloak/tabard/crusader/pestra
				if("Noc")
					cloak = /obj/item/clothing/cloak/tabard/crusader/noc
				if("Malum")
					cloak = /obj/item/clothing/cloak/templar/malummite
				if("Eora")
					cloak = /obj/item/clothing/cloak/tabard/crusader/eora
			backr = /obj/item/rogueweapon/flail
			if(prob(50))
				l_hand = /obj/item/rogueweapon/shield/wood
			else
				l_hand = /obj/item/rogueweapon/shield/tower/metal
			if(H.age == AGE_OLD)
				beltr = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
				head = /obj/item/clothing/neck/roguetown/chaincoif
			else if(prob(50))
				head = /obj/item/clothing/neck/roguetown/chaincoif
			else
				head = /obj/item/clothing/head/roguetown/helmet
			backl = /obj/item/storage/backpack/rogue/satchel

	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	if(H.dna.species.type == /datum/species/tieberian)
		cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	//Max devotion limit - Paladins are stronger but cannot pray to gain all abilities beyond t1
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
