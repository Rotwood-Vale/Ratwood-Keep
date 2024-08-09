//terrify mobs scream
/datum/advclass/barbarian
	name = "Barbarian"
	tutorial = "A jack-of-all-trades warrior sort. Is skilled in all weapons, but master of none"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/barbarian
	traits_applied = list(TRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN, TRAIT_STEELHEARTED)
	cmode_music = 'sound/music/combat_gronn.ogg'
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/barbarian
	allowed_patrons = list(/datum/patron/divine/ravox, /datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/adventurer/barbarian/pre_equip(mob/living/carbon/human/H)
	..() // Compared to the Warrior the barbarian is more suited to the wilds. But they are able to make use of almost any weapon by talent and killer instinct.
	H.adjust_blindness(-3)
	var/classes = list("Warrior","Hunter Killer", "Ravager")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Warrior")
			H.set_blindness(0)
			to_chat(H, span_warning("Barbarians are great warriors of the outlands, often regarded as the strongest of their tribes -- should they have any that live. These incredible titans of strength and brutality are motivated most often by a single... all consuming instinct. SURVIVE."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(3,4), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
			beltr = /obj/item/rogueweapon/sword/iron
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
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
		if("Hunter Killer")
			H.set_blindness(0)
			to_chat(H, span_warning("Barbarians are great warriors of the outlands, often regarded as the strongest of their tribes -- should they have any that live. These incredible titans of strength and brutality are motivated most often by a single... all consuming instinct. SURVIVE."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			l_hand = /obj/item/quiver/arrows
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
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
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
		if("Ravager") //Lower constitution/weaponskills, but they're better at unarmed combat than barbs are with a weapon. Good skills, not much gear. Gets extra bite damage.
			H.set_blindness(0)
			to_chat(H, span_warning("Some barbarians eschew the axe in favour of the most faithful weapons anyone could hope for: fist, claw, and fang."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			backr = /obj/item/storage/backpack/rogue/satchel
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			if(prob(33))
				armor = /obj/item/clothing/suit/roguetown/armor/leather
			else
				armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			H.change_stat("intelligence", -2) 
			H.change_stat("strength", 3) 
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 2)
			ADD_TRAIT(H, TRAIT_STRONGBITE, TRAIT_GENERIC) //doubles bite damage, which is 50% of STR. 
/*
			if("ROLL THE DICE!")
				if(prob(49)) // Warrior
					H.set_blindness(0)
					to_chat(src, span_warning("Barbarians are great warriors of the outlands, often regarded as the strongest of their tribes -- should they have any that live. These incredible titans of strength and brutality are motivated most often by a single... all consuming instinct. SURVIVE."))
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1), TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(3,4), TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(0,1), TRUE)
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
					shoes = /obj/item/clothing/shoes/roguetown/boots/leather
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
				else if(prob(45)) // Hunter Killer
					H.set_blindness(0)
					to_chat(src, span_warning("You are a barbarian of the outlands, having fought many monstrous beasts and men in your time -- you now find yourself in the lands of nobles and beggars."))
					
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2), TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,2), TRUE)
					H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
					
					H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
					beltr = /obj/item/rogueweapon/stoneaxe/woodcut
					r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
					l_hand = /obj/item/quiver/arrows
					belt = /obj/item/storage/belt/rogue/leather
					neck = /obj/item/storage/belt/rogue/pouch/coins/poor
					beltl = /obj/item/rogueweapon/huntingknife
					backl = /obj/item/storage/backpack/rogue/satchel
					shoes = /obj/item/clothing/shoes/roguetown/boots/leather
					wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
					cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
					if(prob(33))
						armor = /obj/item/clothing/suit/roguetown/armor/leather
					else
						armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
					H.change_stat("intelligence", -1) // The hunter is smarter, more skilled -- but not as tough.
					H.change_stat("strength", 2) 
					H.change_stat("constitution", 2)
					H.change_stat("endurance", 3)
				else // Bear Wolf. Barbarian Unique. They don't get armor.
					H.set_blindness(0)
					to_chat(src, span_warning("You are a barbarian of the outlands, having fought many monstrous beasts and men in your time -- you now find yourself in the lands of nobles and beggars."))
					H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2), TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
					H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1), TRUE)
					H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
					H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE) 
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE) 
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
					beltr = /obj/item/rogueweapon/stoneaxe/woodcut
					belt = /obj/item/storage/belt/rogue/leather
					neck = /obj/item/storage/belt/rogue/pouch/coins/poor
					beltl = /obj/item/rogueweapon/huntingknife
					backl = /obj/item/storage/backpack/rogue/satchel
					shoes = /obj/item/clothing/shoes/roguetown/boots/leather
					wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
					H.change_stat("intelligence", -1)
					H.change_stat("strength", pick(3,4)) // The bear wolf is an endurance fighter. Never tiring. Unrelenting.
					H.change_stat("constitution", 3)
					H.change_stat("endurance", 4)
*/
/* 
	var/randy = rand(1,5)
	switch(randy) // Pick wep. Choose skill.
		if(1 to 2)
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		if(3 to 4)
			
		if(5)
			beltr = /obj/item/rogueweapon/mace/steel
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
*/
	//70% chance to be raceswapped to Gronn because slop lore

