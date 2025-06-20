/datum/subclass/cleric
	name = "Cleric"
	tutorial = "Clerics are wandering warriors of the Gods, an asset to any party."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/cleric
	category_tags = list(CTAG_ADVENTURER)

	cmode_music = 'sound/music/combat_clergy.ogg'

/datum/outfit/job/roguetown/adventurer/cleric
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
			cloak = /obj/item/clothing/cloak/templar/astratan
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/roguetown/psicross/noc
			cloak = /obj/item/clothing/cloak/tabard/crusader/noc
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
			cloak = /obj/item/clothing/cloak/tabard/crusader/dendor
			H.mind.adjust_skillrank(/datum/skill/magic/druidic, 2, TRUE) // enough to craft druid mask, at least
		if(/datum/patron/divine/necra)
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
			cloak = /obj/item/clothing/cloak/templar/necran
		if(/datum/patron/divine/pestra)
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
			cloak = /obj/item/clothing/cloak/tabard/crusader/pestra
		if(/datum/patron/divine/malum)
			neck = /obj/item/clothing/neck/roguetown/psicross/malum
			cloak = /obj/item/clothing/cloak/templar/malummite
		if(/datum/patron/divine/ravox)
			neck = /obj/item/clothing/neck/roguetown/psicross/ravox
		if(/datum/patron/divine/eora)
			neck = /obj/item/clothing/neck/roguetown/psicross/eora
			cloak = /obj/item/clothing/cloak/tabard/crusader/eora

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Life Cleric")
	if (H.patron.type == /datum/patron/divine/malum)
		classes += ("Forge Cleric")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Life Cleric")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a cleric of the life domain. Well versed in the arts of healing and magic."))
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/white
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/mace
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/shield/wood
			backpack_contents = list(/obj/item/rogueweapon/huntingknife)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 1) // More intelligence and no speed penalty for Life Clerics.
			H.change_stat("constitution", -1)
			H.change_stat("endurance", 2)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if("Forge Cleric")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a cleric of the Forge domain. You are adept at making arms and armors as well as using them."))
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			cloak = /obj/item/clothing/cloak/apron/blacksmith
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			backr = /obj/item/rogueweapon/shield/wood
			backl = /obj/item/storage/backpack/rogue/backpack
			backpack_contents = list(/obj/item/rogueweapon/huntingknife =1, /obj/item/clothing/neck/roguetown/chaincoif/iron = 1, /obj/item/rogueore/coal = 1, /obj/item/rogueweapon/tongs=1, /obj/item/rogueore/iron=1, /obj/item/rogueweapon/hammer/iron = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE) //Traded a few weapon proficiencies from war cleric for smithing.
			H.AddSpell(new /obj/effect/proc_holder/spell/invoked/malum_flame_rogue) // weaker astra fire spell. mostly for lighting things.
			H.change_stat("intelligence", 2) // Changed to follow balance people's advice.
			H.change_stat("constitution", 1)
			H.change_stat("strength", 2)
			H.change_stat("speed", -2)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/outfit/job/roguetown/adventurer/cleric/post_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE
