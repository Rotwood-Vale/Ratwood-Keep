/datum/subclass/apostate
	name = "Apostate"
	tutorial = "After having devoted the majority of your life to the Inhumen gods, \
				you were cast out of your homelands due to your faith, making you a homeless traveler, no better than the refugees you have been lumped in with"

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	category_tags = list(CTAG_REFUGEE)

	cmode_music = 'sound/music/combat_cult.ogg'

	maximum_possible_slots = 8

	outfit = /datum/outfit/job/roguetown/refugee/apostate

/datum/outfit/job/roguetown/refugee/apostate
	allowed_patrons = NON_DIVINE_PATRONS
/datum/outfit/job/roguetown/refugee/apostate/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Fanatic", "Dualist")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(H.patron?.type)
		
		if(/datum/patron/zizo)
			neck = /obj/item/clothing/neck/roguetown/psicross/wood
			H.change_stat("intelligence", 1)
			H.change_stat("constitution", -1)
			H.faction += "undead"
		if(/datum/patron/inhumen/graggar)
			neck = /obj/item/clothing/neck/roguetown/psicross/wood
			H.change_stat("strength", 1)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", -1)
			ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
		if(/datum/patron/inhumen/matthios)
			neck = /obj/item/clothing/neck/roguetown/psicross/wood
			H.change_stat("fortune", 1)
			H.change_stat("constitution", -1)
			H.change_stat("endurance", -1)
			H.change_stat("perception", 1)
		if(/datum/patron/inhumen/baotha)
			neck = /obj/item/clothing/neck/roguetown/psicross/wood
			H.change_stat("constitution", 1)
			H.change_stat("endurance", 1)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)


	switch(classchoice)

		if("Fanatic")

			switch (H.patron?.type)

				if(/datum/patron/zizo)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
					H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
					H.mind.AddSpell(new SPELL_STRENGTHEN_UNDEAD)
					H.mind.AddSpell(new SPELL_SICKNESS)
					H.mind.AddSpell(new SPELL_EYEBITE)
					H.mind.AddSpell(new SPELL_RAISE_UNDEAD_LESSER)
					H.mind.AddSpell(new SPELL_REVOKE_UNLIFE)
					head = /obj/item/clothing/head/roguetown/necromhood
					pants = /obj/item/clothing/under/roguetown/trou/leather
					shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
					neck = /obj/item/storage/belt/rogue/pouch/coins/poor
					armor = /obj/item/clothing/suit/roguetown/shirt/robe/necromancer
					belt = /obj/item/storage/belt/rogue/leather/rope
					backpack_contents = list(/obj/item/chalk = 1)
					backl = /obj/item/storage/backpack/rogue/satchel
					beltr = /obj/item/reagent_containers/glass/bottle/rogue/lessermanapot
					beltl = /obj/item/rogueweapon/huntingknife
					r_hand = /obj/item/rogueweapon/woodstaff
					H.change_stat("strength", -1)
					H.change_stat("intelligence", 3)
					H.change_stat("constitution", -2)
					H.change_stat("endurance", -1)
					H.change_stat("speed", -1)
					H.mind.adjust_spellpoints(-3) //no starting spellpoints, but they can make a spellbook to get some.
					H.mind.AddSpell(new SPELL_LEARNSPELL)
					H.mind.AddSpell(new SPELL_PRESTIDIGITATION)

					H.set_blindness(0)
				
				if(/datum/patron/inhumen/graggar)
					H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
					pants = /obj/item/clothing/under/roguetown/tights/black
					shoes = /obj/item/clothing/shoes/roguetown/armor
					gloves = /obj/item/clothing/gloves/roguetown/leather
					belt = /obj/item/storage/belt/rogue/leather
					shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
					armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
					wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
					backl = /obj/item/storage/backpack/rogue/satchel
					backr = /obj/item/rogueweapon/shield/wood
					beltr = /obj/item/rogueweapon/stoneaxe/handaxe
					beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
					H.change_stat("strength", 1)
					H.change_stat("endurance", 2)
					H.change_stat("constitution", 2)
					H.change_stat("speed", 1)
					ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
					var/datum/devotion/C = new /datum/devotion(H, H.patron)
					C.grant_spells_churchling(H)
					H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

				if(/datum/patron/inhumen/matthios)
					H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
					pants = /obj/item/clothing/under/roguetown/tights/black
					shoes = /obj/item/clothing/shoes/roguetown/armor
					gloves = /obj/item/clothing/gloves/roguetown/leather
					belt = /obj/item/storage/belt/rogue/leather
					shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
					armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
					wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
					backl = /obj/item/storage/backpack/rogue/satchel
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
					beltr = /obj/item/ammo_holder/quiver/arrows
					beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
					backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1)
					H.change_stat("strength", 1)
					H.change_stat("endurance", 1)
					H.change_stat("perception", 1)
					H.change_stat("constitution", 1)
					H.change_stat("speed", 2)
					ADD_TRAIT(H, TRAIT_COMMIE, TRAIT_GENERIC)
					var/datum/devotion/C = new /datum/devotion(H, H.patron)
					C.grant_spells_churchling(H)
					H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

				if(/datum/patron/inhumen/baotha)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
					shoes = /obj/item/clothing/shoes/roguetown/armor
					gloves = /obj/item/clothing/gloves/roguetown/leather
					belt = /obj/item/storage/belt/rogue/leather
					armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
					pants = /obj/item/clothing/under/roguetown/tights/black
					wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
					backl = /obj/item/storage/backpack/rogue/satchel
					backr = /obj/item/rogueweapon/shield/buckler
					beltr = /obj/item/rogueweapon/whip
					beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
					H.change_stat("strength", 1)
					H.change_stat("endurance", 1)
					H.change_stat("constitution", 1)
					H.change_stat("speed", 2)
					ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
					var/datum/devotion/C = new /datum/devotion(H, H.patron)
					C.grant_spells_churchling(H)
					H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

		if("Dualist")


			if(/datum/patron/inhumen/graggar)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
				head = /obj/item/clothing/head/roguetown/roguehood
				shoes = /obj/item/clothing/shoes/roguetown/shortboots
				armor = /obj/item/clothing/suit/roguetown/shirt/robe
				belt = /obj/item/storage/belt/rogue/leather/rope
				beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
				backl = /obj/item/storage/backpack/rogue/backpack
				r_hand = /obj/item/rogueweapon/woodstaff
				H.change_stat("strength", 3)
				H.change_stat("constitution", 2)
				H.change_stat("intelligence", -1)
				ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			else
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
				head = /obj/item/clothing/head/roguetown/roguehood
				shoes = /obj/item/clothing/shoes/roguetown/shortboots
				armor = /obj/item/clothing/suit/roguetown/shirt/robe
				belt = /obj/item/storage/belt/rogue/leather/rope
				beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
				backl = /obj/item/storage/backpack/rogue/backpack
				r_hand = /obj/item/rogueweapon/woodstaff
				H.change_stat("strength", 3)
				H.change_stat("constitution", 1)
				H.change_stat("speed", 2)
				H.change_stat("intelligence", 1)
				ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	H.set_blindness(0)
