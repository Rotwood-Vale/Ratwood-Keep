/datum/subclass/forlorn
	name = "Forlorn Hope Mercenary"
	tutorial = "The Order of the Forlorn Hope, a holy order founded in the name of Noc and the banishment of the rot. Now it is riddled with the wounded, the veterans and the landless of the Vakran civil war. Take up the banner and fight again in the name of the Ten, or use the pretense of faith and zealotry to make ends meet by any means necessary."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/lupian, /datum/species/vulpkanin)
	outfit = /datum/outfit/job/roguetown/mercenary/forlorn
	maximum_possible_slots = 5
	min_pq = 15
	torch = FALSE
	cmode_music = 'sound/music/combat_forlorn.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/forlorn/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor
	neck = /obj/item/clothing/neck/roguetown/gorget/alt
	head = /obj/item/clothing/head/roguetown/helmet/volfplate
	pants = /obj/item/clothing/under/roguetown/tights/black
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	beltr = /obj/item/storage/keyring/mercenary
	backr = /obj/item/storage/backpack/rogue/satchel

	var/weapons = list("warhammer", "axe", "crossbow")
	var/weaponschoice = input("Choose your weapon", "Available weapons") as anything in weapons

	switch(weaponschoice)

		if("warhammer")
			beltl = /obj/item/rogueweapon/mace/warhammer/steel
			backl = /obj/item/rogueweapon/shield/heater
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			backpack_contents = list(/obj/item/rogueweapon/huntingknife) // They need something to take heads with
		if("axe")
			beltl = /obj/item/rogueweapon/stoneaxe/battle
			backl = /obj/item/rogueweapon/shield/heater
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE) // This brings the axe class in line-
			H.mind.adjust_skillrank(/datum/skill/combat/maces, -1, TRUE) //
			H.mind.adjust_skillrank(/datum/skill/combat/swords, -2, TRUE) // -for the same total skill points overall
		if("crossbow")
			beltl = /obj/item/ammo_holder/quiver/bolts
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE) // Takes the crossbow merc to expert crossbows-
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE) // -and competent bows overall, as all mercs are-
			H.mind.adjust_skillrank(/datum/skill/combat/maces, -2, TRUE) // -experts with their respective weapons.
			H.mind.adjust_skillrank(/datum/skill/combat/swords, -1, TRUE) // Apprentice swordsmen. 
			backpack_contents = list(/obj/item/rogueweapon/huntingknife) // They need something to take heads with
		else
			beltl = /obj/item/rogueweapon/mace/warhammer/steel
			backl = /obj/item/rogueweapon/shield/heater
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			backpack_contents = list(/obj/item/rogueweapon/huntingknife)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
