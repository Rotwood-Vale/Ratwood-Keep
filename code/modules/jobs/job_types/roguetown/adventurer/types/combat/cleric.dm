//shield
/datum/advclass/cleric
	name = "Cleric"
	tutorial = "Clerics are wandering warriors of the Gods, an asset to any party."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDSPLUS
	vampcompat = FALSE
	outfit = /datum/outfit/job/roguetown/adventurer/cleric
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/cleric
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/roguetown/psicross/noc
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
		if(/datum/patron/divine/necra)
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
		if(/datum/patron/divine/pestra)
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
		if(/datum/patron/divine/eora) //Eora content from Stonekeep
			neck = /obj/item/clothing/neck/roguetown/psicross/eora

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Life Cleric","War Cleric","Nature Cleric", "Cloistered Devout")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Life Cleric")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a cleric of the life domain. Well versed in the arts of healing and magic."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 1) // More intelligence and no speed penalty for Life Clerics.
			H.change_stat("strength", 1)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 2)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if("War Cleric")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a cleric of the war domain. Experienced in both the granting of life and the taking of it. Unfortunately your study of warcraft has weakened your divine abilities..."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.change_stat("intelligence", 1)
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 2) // Stronger but less intelligent/quick compared to life clerics.
			H.change_stat("speed", -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		if("Nature Cleric")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a cleric of the nature domain."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/druidic, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.change_stat("intelligence", 2)
			H.change_stat("strength", 1)
			H.change_stat("constitution", 1)
			H.change_stat("endurance", 2)
			H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		// HEARTHSTONE ADD: cloistered cleric subclass (lighter armored and equipped)
		if("Cloistered Devout")
			// Devout start without the typical cleric medium/heavy armor shtick and without much in the way of weapons or skills to use them.
			// They're better with miracles and regenerate devotion passively like the Priest does, however.
			H.set_blindness(0)
			to_chat(H, span_warning("You are a cloistered cleric, a devout traveller whom has engressed into distant lands to spread the word of your chosen Patron. Having secluded yourself for many years, your body has suffered... But you have gained great insight as a result!"))
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.change_stat("intelligence", 4)
			H.change_stat("strength", -2)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		// HEARTHSTONE ADDITION END

	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/wood
	backpack_contents = list(/obj/item/rogueweapon/huntingknife)
	// everything about this sucks - we should really make a subclass datum or something
	if(classchoice == "Nature Cleric")
		beltr = /obj/item/rogueweapon/sword
		armor = /obj/item/clothing/suit/roguetown/armor/leather
		pants = /obj/item/clothing/under/roguetown/trou
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		shoes = /obj/item/clothing/shoes/roguetown/boots
	// HEARTHSTONE ADD: cloistered devout custom outfits
	else if (classchoice == "Cloistered Devout")
		// do the generic stuff first then replace it w/ patron specific things... if it exists
		// for reference, cloistered devouts are lightly armored/unarmored but get patron-specific stuff (if applicable) and a devo regen
		head = /obj/item/clothing/head/roguetown/roguehood/black
		armor = /obj/item/clothing/suit/roguetown/shirt/robe
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
		wrists = null
		beltr = null
		backr = /obj/item/rogueweapon/woodstaff
		pants = /obj/item/clothing/under/roguetown/tights
		shoes = /obj/item/clothing/shoes/roguetown/boots
		// apply patron-specific outfit alterations
		switch(H.patron?.type)
			if(/datum/patron/divine/astrata)
				head = /obj/item/clothing/head/roguetown/roguehood/astrata
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/astrata
				beltr = /obj/item/flashlight/flare/torch/lantern // you are the lightbringer
			if(/datum/patron/divine/noc)
				head =  /obj/item/clothing/head/roguetown/roguehood/nochood
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/noc
				pants = /obj/item/clothing/under/roguetown/tights/black
				belt = /obj/item/storage/belt/rogue/leather/black
			if(/datum/patron/divine/necra)
				head = /obj/item/clothing/head/roguetown/necrahood
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/necra
				pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
			if(/datum/patron/divine/dendor)
				head = /obj/item/clothing/head/roguetown/dendormask
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/dendor
				pants = /obj/item/clothing/under/roguetown/loincloth
				belt = /obj/item/storage/belt/rogue/leather/rope
				shoes = /obj/item/clothing/shoes/roguetown/sandals
			if(/datum/patron/divine/xylix)
				head = /obj/item/clothing/head/roguetown/roguehood/tricksterhood
			if(/datum/patron/old_god)
				head = /obj/item/clothing/head/roguetown/psydonhood
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/psydonrobe
			if(/datum/patron/divine/eora)
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/eora
	// HEARTHSTONE ADDITION END
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	// HEARTHSTONE ADDITION: cloistered devout devo regen & tier buff
	if (classchoice == "Cloistered Devout")
		C.grant_spells_devout(H)
	else
		C.grant_spells_cleric(H)
	// HEARTHSTONE ADDITION END
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
