//shield
/datum/advclass/cleric
	name = "Cleric"
	tutorial = "Disciples of the divine - clerics are blessed with the power of miracles from the gods themselves."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	traits_applied = list(TRAIT_OUTLANDER)
	vampcompat = FALSE
	outfit = /datum/outfit/job/roguetown/adventurer/cleric
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list("Monk" = "You are a wandering acolyte, versed in both miracles and martial arts.",
					"Paladin" = "A holy warrior. Where others of the clergy may have spent their free time studying scriptures, you have instead honed your skills with a blade.",
					"Hymnist" = "You are a devout worshipper of the divine. You've spent your youth studying scriptures and serving in church choirs - and now you wander spreading the good word of your faith.")

/datum/outfit/job/roguetown/adventurer/cleric
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Monk","Paladin","Hymnist")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Monk")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a wandering acolyte, versed in both miracles and martial arts."))
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			gloves = /obj/item/clothing/gloves/roguetown/plate
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shoes = /obj/item/clothing/shoes/roguetown/boots
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/flashlight/flare/torch = 1)
			var/datum/devotion/C = new /datum/devotion(H, H.patron)
			C.grant_spells_templar(H)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 1)

		if("Paladin")
			to_chat(H, span_warning("A holy warrior. Where others of the clergy may have spent their free time studying scriptures, you have instead honed your skills with a blade."))
			belt = /obj/item/storage/belt/rogue/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/shield/tower
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/chain
			backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/flashlight/flare/torch = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
			var/datum/devotion/C = new /datum/devotion(H, H.patron)
			C.grant_spells_templar(H)
			var/weapons = list("Bastard Sword","Mace","Flail")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Bastard Sword")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/long
				if("Mace")
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
					beltr = /obj/item/rogueweapon/mace
				if("Flail")
					H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
					beltr = /obj/item/rogueweapon/flail
			H.set_blindness(0)
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 1)

		if("Hymnist")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a devout worshipper of the divine. You've spent your youth studying scriptures and serving in church choirs - and now you wander spreading the good word of your faith."))
			backl = /obj/item/storage/backpack/rogue/satchel
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shoes = /obj/item/clothing/shoes/roguetown/boots
			backr = /obj/item/rogueweapon/woodstaff
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogue/instrument/vocals
			backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/flashlight/flare/torch = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 1)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)
			var/datum/devotion/C = new /datum/devotion(H, H.patron)
			C.passive_devotion_gain += 0.25
			C.grant_spells(H)
			START_PROCESSING(SSobj, C)

	switch(H.patron?.type)
		if(/datum/patron/old_god)
			neck = /obj/item/clothing/neck/roguetown/psicross
			cloak = /obj/item/clothing/cloak/psydontabard
			head = /obj/item/clothing/head/roguetown/roguehood/psydon
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
			head = /obj/item/clothing/head/roguetown/roguehood/astrata
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/astrata
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/roguetown/psicross/noc
			head =  /obj/item/clothing/head/roguetown/nochood
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/noc
		if(/datum/patron/divine/abyssor)
			neck = /obj/item/clothing/neck/roguetown/psicross/abyssor
			head = /obj/item/clothing/head/roguetown/roguehood/abyssor
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/abyssor
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
			head = /obj/item/clothing/head/roguetown/dendormask
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/dendor
		if(/datum/patron/divine/necra)
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
			head = /obj/item/clothing/head/roguetown/necrahood
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/necra
		if(/datum/patron/divine/pestra)
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
			cloak = /obj/item/clothing/cloak/templar/pestra //placeholder
			head = /obj/item/clothing/head/roguetown/roguehood/black //placeholder
		if(/datum/patron/divine/ravox)
			neck = /obj/item/clothing/neck/roguetown/psicross/ravox
			cloak = /obj/item/clothing/cloak/templar/ravox //placeholder
			head = /obj/item/clothing/head/roguetown/roguehood/red //placeholder
		if(/datum/patron/divine/malum)
			neck = /obj/item/clothing/neck/roguetown/psicross/malum
			head = /obj/item/clothing/head/roguetown/roguehood //placeholder
			cloak = /obj/item/clothing/cloak/templar/malumite
		if(/datum/patron/divine/eora)
			neck = /obj/item/clothing/neck/roguetown/psicross/eora
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/eora
			head = /obj/item/clothing/head/roguetown/eoramask
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_cult.ogg'
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/black //placeholder
			head = /obj/item/clothing/head/roguetown/roguehood/black //placeholder
			beltl = /obj/item/roguekey/inhumen
		if (/datum/patron/inhumen/matthios)
			H.cmode_music = 'sound/music/combat_cult.ogg'
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/black //placeholder
			head = /obj/item/clothing/head/roguetown/roguehood/black //placeholder

	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
