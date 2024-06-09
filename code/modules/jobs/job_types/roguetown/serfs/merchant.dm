/datum/job/roguetown/merchant
	title = "Merchant"
	flag = MERCHANT
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_YEOMAN
	allowed_races = CLOTHED_RACES_TYPES
	tutorial = "You were born into wealth, learning from before you could talk about the basics of mathematics. Counting coins is a simple pleasure for any person, but you've made it an artform. These people are addicted to your wares and you are the literal beating heart of this economy: Dont let these filthy-covered troglodytes ever forget that."

	display_order = JDO_MERCHANT

	outfit = /datum/outfit/job/roguetown/merchant
	give_bank_account = 22
	min_pq = 1
	max_pq = null
	required = TRUE

	cmode_music = 'sound/music/combat_giza.ogg'

/datum/outfit/job/roguetown/merchant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,4,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	//50% chance to be raceswapped to Giza because slop lore
	if(ishumannorthern(H) && prob(50))
		H.skin_tone = SKIN_COLOR_GIZA
		H.update_body()
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltl = /obj/item/keyring/merchant
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		neck = /obj/item/clothing/neck/roguetown/horus
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
		head = /obj/item/clothing/head/roguetown/chaperon
		id = /obj/item/clothing/ring/gold
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 3)
		H.change_stat("strength", -1)
		if(H.dna?.species)
			if(H.dna.species.id == "humen")
				H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	else
		shoes = /obj/item/clothing/shoes/roguetown/gladiator
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltl = /obj/item/roguekey/merchant
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
		neck = /obj/item/clothing/neck/roguetown/horus
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		head = /obj/item/clothing/head/roguetown/chaperon
		id = /obj/item/clothing/ring/gold
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 3)
		H.change_stat("strength", -1)
