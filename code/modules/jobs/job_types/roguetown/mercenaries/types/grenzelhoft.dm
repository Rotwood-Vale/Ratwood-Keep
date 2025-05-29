/datum/subclass/grenzelhoft
	name = "Grenzelhoft Mercenary"
	tutorial = "Experts, Professionals, Expensive. Those are the first words that come to mind when the emperiate Grenzelhoft Free Corps is mentioned. While you may work for coin like any common sellsword, maintaining the honor of the Company will be of the utmost priority."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/axian,
		/datum/species/vulpkanin,
		/datum/species/lupian,
		/datum/species/dracon,
		/datum/species/moth, //grenzelmoft?
		/datum/species/dwarf/mountain,
		/datum/species/human/northern,
		/datum/species/demihuman,
		/datum/species/anthromorph,
		/datum/species/tabaxi
	)
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft
	maximum_possible_slots = 9
	min_pq = 15
	torch = FALSE
	cmode_music = 'sound/music/combat_grenzelhoft.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/mercenary
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass
	pants = /obj/item/clothing/under/roguetown/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/armor/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
	backr = /obj/item/storage/backpack/rogue/satchel


	var/weapons = list("billhook", "halberd", "zweihander")
	var/weaponschoice = input("Choose your weapon", "Available weapons") as anything in weapons

	switch(weaponschoice)

		if("billhook")
			r_hand = /obj/item/rogueweapon/spear/billhook
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("halberd")
			r_hand = /obj/item/rogueweapon/halberd
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("zweihander")
			r_hand = /obj/item/rogueweapon/greatsword/zwei
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		else
			r_hand = /obj/item/rogueweapon/halberd
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)

	// Gone are the days of the Grenzelhoft whitewashing forcefields
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 2)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
