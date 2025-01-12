/datum/subclass/grenzelhoft_kommandant
	name = "Grenzelhoft Kommandant"
	tutorial = "Unbreakable. Resolute. Master of the field. Fearless. \
	These are the first words that come to mind when one mentions the Kommandant, the unparalleled leader of the well reputed, \
	expensive and noble Grenzelhoft mercenaries of the emperiate guild of the Grenzel empire. \
	The mercenaries of Gren rightfully fear and respect their Kommandant, walking to certain death on his one word."
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
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft_kommandant
	maximum_possible_slots = 1
	min_pq = 18
	torch = FALSE
	cmode_music = 'sound/music/combat_grenzelhoft.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/grenzelhoft_kommandant/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/mercenary_boss
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	neck = /obj/item/clothing/neck/roguetown/bervor
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft //Gives them back this so they can color again.
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass/hardened //Buffs this to instead be like a chainmaille and cuirass together
	pants = /obj/item/clothing/under/roguetown/blacksteel/platelegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/blacksteel/plateboots
	gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/long/rider/messer

	// Okay, if you love to duplicate things...
	var/list/weapon_options = list(
		"billhook",
		"halberd",
		"zweihander",
		"estoc",
	)

	var/chosen_weapon = input(
		"Pick a weapon",
		"Available weapons",
	) as anything in weapon_options

	switch(chosen_weapon)
		if("billhook")
			r_hand = /obj/item/rogueweapon/spear/billhook
		if ("halberd")
			r_hand = /obj/item/rogueweapon/halberd
		if ("zweihander")
			r_hand = /obj/item/rogueweapon/greatsword/zwei
		if ("estoc")
			r_hand = /obj/item/rogueweapon/estoc
		else
			r_hand = /obj/item/rogueweapon/halberd

	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE) //Sword Grenz Mercs are 4.
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 3)
		H.change_stat("perception", 2)
		H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
