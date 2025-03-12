/datum/subclass/sellsword
	name = "Sellsword"
	tutorial = "You are a common sellsword, regarded as scum by many. You travelled the isle working as a bodyguard, mercenary or a cutthroat. You're loyal to your own well being and the sounds mammons make in your pouch."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = /datum/outfit/job/roguetown/mercenary/sellsword
	maximum_possible_slots = 10
	min_pq = 0
	torch = FALSE
	category_tags = list(CTAG_MERCENARY)


/datum/outfit/job/roguetown/mercenary/sellsword/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Light Armor","Medium Armor", "Heavy Armor")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	backl = /obj/item/storage/backpack/rogue/satchel

	switch(classchoice)
		if("Light Armor")
			H.set_blindness(0)
			to_chat(H, span_warning("'Can't cut what you can't hit' has always been your motto. Favoring the lightest armor you can find, years of avoiding attacks have done wonders for your reflexes."))

			head = /obj/item/clothing/head/roguetown/helmet/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			neck = /obj/item/storage/keyring/mercenary
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			pants = /obj/item/clothing/under/roguetown/trou/leather

			var/list/weapon_types = list(
    "Bastard Sword", "Cutlass", "Rapier", "Sabre", "Battle Axe",
    "Iron Mace", "Spear", "Flail", "Paired Daggers", "Bow", "Crossbow"
)

			var/selected_weapon_type = input(
				"Pick a weapon type",
				"Available types",
			) as anything in weapon_types

			if(selected_weapon_type == "Bastard Sword")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/long
			if(selected_weapon_type == "Cutlass")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/cutlass 
				backpack_contents = list(/obj/item/clothing/head/roguetown/helmet/bandana = 1, /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red = 1)
			if(selected_weapon_type == "Rapier")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/rapier
				backpack_contents = list(/obj/item/clothing/head/roguetown/helmet/tricorn = 1)
			if(selected_weapon_type == "Sabre")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/sabre 
			if(selected_weapon_type == "Battle Axe")
				beltr = /obj/item/rogueweapon/stoneaxe/battle
				H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
			if(selected_weapon_type == "Iron Mace")
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				beltr = /obj/item/rogueweapon/mace/
			if(selected_weapon_type == "Spear")
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
				l_hand = /obj/item/rogueweapon/spear/
			if(selected_weapon_type == "Flail")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
				beltr = /obj/item/rogueweapon/flail/
			if(selected_weapon_type == "Paired Daggers")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
				beltr = /obj/item/rogueweapon/huntingknife/idagger
				beltl = /obj/item/rogueweapon/huntingknife/idagger
			if(selected_weapon_type == "Bow")
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
				beltl = /obj/item/ammo_holder/quiver/arrows
				H.change_stat("perception", 1)
				H.change_stat("strength", -1)
			if(selected_weapon_type == "Crossbow")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.change_stat("perception", 1)
				H.change_stat("strength", -1)
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				beltl = /obj/item/ammo_holder/quiver/bolts


			var/list/goodie_types = list("Extra Dagger", "Smoke Bomb", "Lesser Healing Potion")

			var/selected_goodie_type = input(
				"Pick a goodie!",
				"Available goodies",
			) as anything in goodie_types

			if(selected_goodie_type == "Extra Dagger")
				r_hand = /obj/item/rogueweapon/huntingknife/idagger
			if(selected_goodie_type == "Smoke Bomb")
				r_hand = /obj/item/smokebomb
			if(selected_goodie_type == "Lesser Healing Potion")
				r_hand = /obj/item/reagent_containers/glass/bottle/rogue/lesserhealthpot

			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
				H.change_stat("strength", 2)
				H.change_stat("endurance", 1)
				H.change_stat("constitution", 1)
				H.change_stat("perception", 1)
				H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

		if("Medium Armor")
			H.set_blindness(0)
			to_chat(H, span_warning("Lacking the raw strength for heavier equipment, or the dexterity for lighter armor, you've cut a happy middle ground, opting for affordable maille."))
			head = /obj/item/clothing/head/roguetown/helmet/sallet
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			neck = /obj/item/clothing/neck/roguetown/gorget
			gloves = /obj/item/clothing/gloves/roguetown/chain
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			pants = /obj/item/clothing/under/roguetown/chainlegs
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1, /obj/item/storage/keyring/mercenary = 1)
		
			var/list/weapon_types = list(
    "Bastard Sword", "Cutlass", "Rapier", "Sabre", "Battle Axe",
    "Iron Mace", "Spear", "Flail", "Paired Daggers", "Bow", "Crossbow"
)

			var/selected_weapon_type = input(
				"Pick a weapon type",
				"Available types",
			) as anything in weapon_types

			if(selected_weapon_type == "Bastard Sword")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/long
			if(selected_weapon_type == "Cutlass")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/cutlass 
				backpack_contents = list(/obj/item/clothing/head/roguetown/helmet/bandana = 1, /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red = 1)
			if(selected_weapon_type == "Rapier")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/rapier
				backpack_contents = list(/obj/item/clothing/head/roguetown/helmet/tricorn = 1)
			if(selected_weapon_type == "Sabre")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/sabre 
			if(selected_weapon_type == "Battle Axe")
				beltr = /obj/item/rogueweapon/stoneaxe/battle
				H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
			if(selected_weapon_type == "Iron Mace")
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				beltr = /obj/item/rogueweapon/mace/
			if(selected_weapon_type == "Spear")
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
				l_hand = /obj/item/rogueweapon/spear/
			if(selected_weapon_type == "Flail")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
				beltr = /obj/item/rogueweapon/flail/
			if(selected_weapon_type == "Paired Daggers")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
				beltr = /obj/item/rogueweapon/huntingknife/idagger
				beltl = /obj/item/rogueweapon/huntingknife/idagger
			if(selected_weapon_type == "Bow")
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
				beltl = /obj/item/ammo_holder/quiver/arrows
				H.change_stat("perception", 1)
				H.change_stat("strength", -1)
			if(selected_weapon_type == "Crossbow")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.change_stat("perception", 1)
				H.change_stat("strength", -1)
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				beltl = /obj/item/ammo_holder/quiver/bolts


			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.change_stat("strength", 2)
				H.change_stat("endurance", 1)
				H.change_stat("constitution", 1)
				H.change_stat("perception", 1)
				H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if("Heavy Armor")
			H.set_blindness(0)
			to_chat(H, span_warning("Striding through arrows and bolts like a pleasant summer rain, either through luck in cards, or prudent saving, you wear proper armor and have the training to realize your dream of encasing yourself in metal."))
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			shoes = /obj/item/clothing/shoes/roguetown/armor
			neck = /obj/item/storage/keyring/mercenary
			pants = /obj/item/clothing/under/roguetown/platelegs
			belt = /obj/item/storage/belt/rogue/leather/black
			armor = /obj/item/clothing/suit/roguetown/armor/plate
			gloves = /obj/item/clothing/gloves/roguetown/leather/black
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger)

			var/list/weapon_types = list(
    "Bastard Sword", "Cutlass", "Rapier", "Sabre", "Battle Axe",
    "Iron Mace", "Spear", "Flail", "Paired Daggers", "Bow", "Crossbow"
)
			var/selected_weapon_type = input(
				"Pick a weapon type",
				"Available types",
			) as anything in weapon_types

			if(selected_weapon_type == "Bastard Sword")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/long
			if(selected_weapon_type == "Cutlass")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/cutlass 
				backpack_contents = list(/obj/item/clothing/head/roguetown/helmet/bandana = 1, /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red = 1)
			if(selected_weapon_type == "Rapier")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/rapier
				backpack_contents = list(/obj/item/clothing/head/roguetown/helmet/tricorn = 1)
			if(selected_weapon_type == "Sabre")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
				beltr = /obj/item/rogueweapon/sword/sabre 
			if(selected_weapon_type == "Battle Axe")
				beltr = /obj/item/rogueweapon/stoneaxe/battle
				H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
			if(selected_weapon_type == "Iron Mace")
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				beltr = /obj/item/rogueweapon/mace/
			if(selected_weapon_type == "Spear")
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
				l_hand = /obj/item/rogueweapon/spear/
			if(selected_weapon_type == "Flail")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
				beltr = /obj/item/rogueweapon/flail/
			if(selected_weapon_type == "Paired Daggers")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
				beltr = /obj/item/rogueweapon/huntingknife/idagger
				beltl = /obj/item/rogueweapon/huntingknife/idagger
			if(selected_weapon_type == "Bow")
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
				beltl = /obj/item/ammo_holder/quiver/arrows
				H.change_stat("perception", 1)
				H.change_stat("strength", -1)
			if(selected_weapon_type == "Crossbow")
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.change_stat("perception", 1)
				H.change_stat("strength", -1)
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				beltl = /obj/item/ammo_holder/quiver/bolts


			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.change_stat("strength", 2)
				H.change_stat("endurance", 1)
				H.change_stat("constitution", 1)
				H.change_stat("perception", 1)
				H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)