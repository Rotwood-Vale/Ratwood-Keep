/datum/subclass/ecclesiast
	name = "Ecclesiast"
	tutorial = "After having devoted the majority of your life to the Church of the Successors, \
				you find yourself in a foreign land, fleeing from the encroaching rot, a catastrophe \
				that is putting your unwavering faith to test."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	category_tags = list(CTAG_REFUGEE)

	cmode_music = 'sound/music/combat_clergy.ogg'

	maximum_possible_slots = 8

	outfit = /datum/outfit/job/roguetown/refugee/ecclesiast

/datum/outfit/job/roguetown/refugee/ecclesiast
	allowed_patrons = ALL_NON_INHUMEN_PATRONS

/datum/outfit/job/roguetown/refugee/ecclesiast/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Preacher", "Returning Crusader", "Monk")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

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
			H.mind.adjust_skillrank(/datum/skill/magic/druidic, 2, TRUE)
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
		if(/datum/patron/psydon)
			neck = /obj/item/clothing/neck/roguetown/psicross/silver
			cloak = /obj/item/clothing/cloak/cape/puritan


	switch(classchoice)

		if("Preacher")

			switch (H.patron?.type)

				if(/datum/patron/psydon)
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
					shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/overseer
					pants = /obj/item/clothing/under/roguetown/trou/overseer
					armor = /obj/item/clothing/suit/roguetown/armor/gambeson/overseer
					shoes = /obj/item/clothing/shoes/roguetown/armor/inqboots
					belt = /obj/item/storage/belt/rogue/leather
					cloak = /obj/item/clothing/cloak/cape/inquisitor
					beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
					head = /obj/item/clothing/head/roguetown/inqhat
					gloves = /obj/item/clothing/gloves/roguetown/inqgloves
					beltl = /obj/item/rogueweapon/sword/rapier
					backl = /obj/item/storage/backpack/rogue/satchel
					backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/silver = 1, /obj/item/lockpick = 1, /obj/item/clothing/head/roguetown/puritan = 1)
					H.change_stat("intelligence", 2)
					H.change_stat("strength", 1)
					H.change_stat("endurance", 1)
					H.change_stat("speed", 1)
					H.change_stat("constitution", 1)
					H.change_stat("perception", 2)
					H.verbs |= /mob/living/carbon/human/proc/torture_victim
					H.verbs |= /mob/living/carbon/human/proc/faith_test
					ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
				else
					H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
					pants = /obj/item/clothing/under/roguetown/tights/black
					shoes = /obj/item/clothing/shoes/roguetown/armor
					gloves = /obj/item/clothing/gloves/roguetown/leather
					belt = /obj/item/storage/belt/rogue/leather
					shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
					armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
					wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
					backl = /obj/item/storage/backpack/rogue/satchel
					backr = /obj/item/rogueweapon/shield/wood
					beltr = /obj/item/rogueweapon/mace
					beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
					H.change_stat("strength", 2)
					H.change_stat("endurance", 2)
					H.change_stat("constitution", 1)
					H.change_stat("speed", 1)
					ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
					var/datum/devotion/C = new /datum/devotion(H, H.patron)
					C.grant_spells(H)
					H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

		if("Returning Crusader")

			switch (H.patron?.type)

				if(/datum/patron/psydon)
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
					belt = /obj/item/storage/belt/rogue/leather/plaquesilver
					pants = /obj/item/clothing/under/roguetown/chainlegs
					shoes = /obj/item/clothing/shoes/roguetown/armor/steel
					shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
					armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
					cloak = /obj/item/clothing/cloak/stabard/crusader/t
					gloves = /obj/item/clothing/gloves/roguetown/chain
					backr = /obj/item/rogueweapon/shield/tower/metal
					backl = /obj/item/storage/backpack/rogue/satchel
					beltr = /obj/item/rogueweapon/mace/steel
					beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
					head = /obj/item/clothing/head/roguetown/helmet/heavy/crusader/t
					H.change_stat("endurance", 2)
					H.change_stat("constitution", 2)
					H.change_stat("intelligence", 1)
					H.change_stat("perception", 1)
					H.change_stat("strength", 2)
					ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
					ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
					H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
				else
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
					belt = /obj/item/storage/belt/rogue/leather/plaquegold
					pants = /obj/item/clothing/under/roguetown/chainlegs
					shoes = /obj/item/clothing/shoes/roguetown/armor/steel
					shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
					armor = /obj/item/clothing/cloak/stabard/crusader
					cloak = /obj/item/clothing/cloak/cape/crusader
					gloves = /obj/item/clothing/gloves/roguetown/chain
					backr = /obj/item/rogueweapon/shield/tower/metal
					backl = /obj/item/storage/backpack/rogue/satchel
					beltr = /obj/item/rogueweapon/sword/decorated
					beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
					head = /obj/item/clothing/head/roguetown/helmet/heavy/crusader
					H.change_stat("endurance", 2)
					H.change_stat("constitution", 2)
					H.change_stat("intelligence", 1)
					H.change_stat("perception", 1)
					H.change_stat("strength", 2)
					ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
					ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
					H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
					var/datum/devotion/C = new /datum/devotion(H, H.patron)
					C.grant_spells_templar(H)
					H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

		if("Monk")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/roguehood
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			armor = /obj/item/clothing/suit/roguetown/shirt/robe
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			backl = /obj/item/storage/backpack/rogue/backpack
			r_hand = /obj/item/rogueweapon/woodstaff
			H.change_stat("strength", 3)
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 2)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	H.set_blindness(0)
