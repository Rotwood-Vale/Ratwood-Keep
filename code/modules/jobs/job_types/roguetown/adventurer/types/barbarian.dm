/datum/subclass/barbarian
	name = "Barbarian"
	tutorial = "A jack-of-all-trades warrior sort. Is skilled in all weapons, but master of none."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/barbarian
	cmode_music = 'sound/music/combat_gronn.ogg'
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/barbarian
	allowed_patrons = list(/datum/patron/divine/ravox, /datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/adventurer/barbarian/pre_equip(mob/living/carbon/human/H)
	..() // Compared to the Warrior the barbarian is more suited to the wilds. But they are able to make use of almost any weapon by talent and killer instinct.
	H.adjust_blindness(-3)
	var/classes = list("Warrior","Hunter Killer",)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Warrior")
			H.set_blindness(0)
			to_chat(H, span_warning("Barbarians are great warriors of the outlands, often regarded as the strongest of their tribes -- should they have any that live. These incredible titans of strength and brutality are motivated most often by a single... all consuming instinct. SURVIVE."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			beltr = /obj/item/rogueweapon/sword/iron
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			if(prob(55))
				head = /obj/item/clothing/head/roguetown/helmet/horned
			if(prob(23))
				armor = /obj/item/clothing/suit/roguetown/armor/leather
			else
				armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			if(prob(40))
				cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			H.change_stat("intelligence", -2)
			H.change_stat("strength", 3) // Barbs are traditionally a mix of strength/resilience.
			H.change_stat("constitution", 3)
			H.change_stat("endurance", 2)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
		if("Hunter Killer")
			H.set_blindness(0)
			to_chat(H, span_warning("Barbarians are great warriors of the outlands, often regarded as the strongest of their tribes -- should they have any that live. These incredible titans of strength and brutality are motivated most often by a single... all consuming instinct. SURVIVE."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			l_hand = /obj/item/ammo_holder/quiver/arrows
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			backr = /obj/item/storage/backpack/rogue/satchel
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			if(prob(33))
				armor = /obj/item/clothing/suit/roguetown/armor/leather
			else
				armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			H.change_stat("intelligence", -1) // The hunter is smarter, more skilled -- but not as tough.
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 3)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	if(ishumannorthern(H) && prob(70)) //gronn lore
		H.skin_tone = SKIN_COLOR_GRONN
		H.update_body()
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
