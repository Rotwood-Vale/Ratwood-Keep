/datum/subclass/desert_rider
	name = "Desert Rider"
	tutorial = "Hooded figures clad in red and easily identifiable by their distinctive emblem, the Desert Riders of Shalvistine are a loosely-governed society of mercenaries and refugees hailing from the fringes of the Zybantian Empire. You were riding saigaback before you could even walk, and you likely feel more at ease on four legs than two. Due to political unrest with neighboring Lalvestine, increasingly deadly sandstorms, or merely a sense of adventure, you find yourself with the Mercenaries’ Guild in Rockhill, selling your skills with the blade to those willing to pay."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/tieberian,
		/datum/species/lizardfolk,
		/datum/species/tabaxi,
		/datum/species/human/northern,
		/datum/species/demihuman,
		/datum/species/anthromorph,
		/datum/species/elf/dark,
	)
	outfit = /datum/outfit/job/roguetown/mercenary/desert_rider
	maximum_possible_slots = 10
	min_pq = 2
	torch = FALSE
	cmode_music = 'sound/music/combat_desertrider.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/desert_rider/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Janissary","Blade Dancer","Blade Caster")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Janissary")
			H.set_blindness(0)
			to_chat(H, span_warning("The Janissaries are the Zybantian Empire's elite infantry units, wielding mace and shield. We do not break."))
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", 2)
			backl = /obj/item/rogueweapon/shield/wood
			r_hand = /obj/item/rogueweapon/mace/steel
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
			armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
			pants = /obj/item/clothing/under/roguetown/chainlegs
			H.grant_language(/datum/language/celestial)

		if("Blade Dancer")
			H.set_blindness(0)
			to_chat(H, span_warning("Zybantian 'Blade Dancers' are famed and feared the world over. Their expertise in blades both long and short is well known..."))
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE) 
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("endurance", 2)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", 3)
			backl = /obj/item/rogueweapon/sword/long/rider
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			armor = /obj/item/clothing/suit/roguetown/armor/leather/advanced
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
			H.grant_language(/datum/language/celestial)
			var/weapons = list("Shamshir","Whips and Knives",)
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Shamshir")
					backl = /obj/item/rogueweapon/sword/long/rider
				if("Whips and Knives")	///They DO enslave people after all
					r_hand = /obj/item/rogueweapon/whip
					l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying

		if("Blade Caster")
			H.set_blindness(0)
			to_chat(H, span_warning("Blade Casters are those skilled in both magyck and swordsmanship, but excelling in nothing."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_spellpoints(1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.change_stat("endurance", 2)
			H.change_stat("intelligence", 3)
			H.change_stat("speed", 3)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/push_spell)
			r_hand = /obj/item/rogueweapon/sword/long/rider
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/magered
			backl = /obj/item/rogueweapon/sword/long/rider

			H.grant_language(/datum/language/celestial)
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord

	shoes = /obj/item/clothing/shoes/roguetown/armor/shalal
	head = /obj/item/clothing/head/roguetown/roguehood/shalal
	gloves = /obj/item/clothing/gloves/roguetown/leather/angle
	belt = /obj/item/storage/belt/rogue/leather/shalal
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/storage/backpack/rogue/satchel/black
	beltl = /obj/item/flashlight/flare/torch
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather


	backpack_contents = list(/obj/item/storage/keyring/mercenary, /obj/item/rogueweapon/huntingknife/idagger/navaja, /obj/item/clothing/neck/roguetown/shalal)

