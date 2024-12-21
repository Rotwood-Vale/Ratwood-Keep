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
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/adventurer/paladin/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/tabard/crusader
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			wrists = /obj/item/clothing/neck/roguetown/psicross/astrata
			head = /obj/item/clothing/head/roguetown/helmet/heavy/astratan
			cloak = /obj/item/clothing/cloak/templar/astratan
		if(/datum/patron/divine/abyssor)
			wrists = /obj/item/clothing/neck/roguetown/psicross/abyssor
			head = /obj/item/clothing/head/roguetown/helmet/heavy/abyssorgreathelm
			cloak = /obj/item/clothing/cloak/abyssortabard
		if(/datum/patron/divine/dendor)
			wrists = /obj/item/clothing/neck/roguetown/psicross/dendor
			head = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
			cloak = /obj/item/clothing/cloak/tabard/crusader/dendor
		if(/datum/patron/divine/necra)
			wrists = /obj/item/clothing/neck/roguetown/psicross/necra
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necran
			cloak = /obj/item/clothing/cloak/templar/necran
		if(/datum/patron/divine/pestra)
			wrists = /obj/item/clothing/neck/roguetown/psicross/pestra
			cloak = /obj/item/clothing/cloak/tabard/crusader/pestra
		if(/datum/patron/divine/eora) //Eora content from stonekeep
			wrists = /obj/item/clothing/neck/roguetown/psicross/eora
			head = /obj/item/clothing/head/roguetown/helmet/sallet
			cloak = /obj/item/clothing/cloak/tabard/crusader/eora
		if(/datum/patron/divine/noc)
			wrists = /obj/item/clothing/neck/roguetown/psicross/noc
			head = /obj/item/clothing/head/roguetown/helmet/heavy/nochelm
			cloak = /obj/item/clothing/cloak/tabard/crusader/noc
		if(/datum/patron/divine/ravox)
			wrists = /obj/item/clothing/neck/roguetown/psicross/ravox
			cloak = /obj/item/clothing/cloak/tabard/crusader/ravox
		if(/datum/patron/divine/malum)
			wrists = /obj/item/clothing/neck/roguetown/psicross/malum
			cloak = /obj/item/clothing/cloak/templar/malumite
			head = /obj/item/clothing/head/roguetown/helmet/heavy/malum
		if(/datum/patron/old_god)
			wrists = /obj/item/clothing/neck/roguetown/psicross
			cloak = /obj/item/clothing/cloak/tabard/crusader/psydon
		if(/datum/patron/inhumen/zizo) 
			H.cmode_music = 'sound/music/combat_cult.ogg'
			neck = /obj/item/roguekey/inhumen

	H.adjust_blindness(-3)
	var/classes = list("Paladin","Battle Master",)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Paladin")
			to_chat(src, span_warning("Paladins are holy warriors who have taken sacred vows to uphold justice and righteousness. Often, they were promised redemption for past sins if they crusaded in the name of the gods."))
			H.set_blindness(0) // No introduction text due to there being no real difference in Paladin archetypes for now.
			to_chat(H, span_warning("You are a paladin."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.change_stat("perception", 1)
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2) // Classic paladin is faster then the battle master.
			H.change_stat("endurance", 1)
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			belt = /obj/item/storage/belt/rogue/leather/steel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife
			id = /obj/item/clothing/ring/silver
			backr = /obj/item/rogueweapon/sword
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(
								/obj/item/flashlight/flare/torch = 1,
								)
		if("Battle Master")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a battle-master."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.change_stat("perception", 1)
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", -1)
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			belt = /obj/item/storage/belt/rogue/leather/steel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife
			id = /obj/item/clothing/ring/silver
			backr = /obj/item/rogueweapon/flail
			l_hand = /obj/item/rogueweapon/shield/tower/metal
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(
								/obj/item/flashlight/flare/torch = 1,
								)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	//Max devotion limit - Paladins are stronger but cannot pray to gain all abilities beyond t1
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
