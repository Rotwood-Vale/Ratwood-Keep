/datum/advclass/knighterrant
	name = "Knight-errant"
	tutorial = "Once part of a noble family, you were cast away. A path closes, yet a thousand open up, brimming with the opportunity of new victories. When a warrior is gone, that will be his best and only bulwark."
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	outfit = /datum/outfit/job/roguetown/adventurer/knighterrant
	maximum_possible_slots = 3		//For testing!
	pickprob = 50
	category_tags = list(CTAG_ADVENTURER)


/datum/outfit/job/roguetown/adventurer/knighterrant/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/brigandinegauntlets
	pants = /obj/item/clothing/under/roguetown/chainlegs
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	cloak = /obj/item/clothing/cloak/tabard
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	armor = /obj/item/clothing/suit/roguetown/armor/plate/noblecuirass
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/rogueweapon/mace
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	backl = /obj/item/rogueweapon/shield/tower
	backr = /obj/item/rogueweapon/sword/iron/short
		
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	if(H.age == AGE_OLD)   // something about being careful of old ppl in a line of work where ppl die young. Old age cavalry would be suicide but go on
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE) // up to Journeyman. If you go old, might as well give you a bone.
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE) // up to Journeyman
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)
	H.change_stat("speed", -2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_NOBLE)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
