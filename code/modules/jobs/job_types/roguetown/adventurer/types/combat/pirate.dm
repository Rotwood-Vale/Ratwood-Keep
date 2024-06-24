/datum/advclass/pirate
	name = "Pirate"
	tutorial = "YARRR"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/akula)
	allowed_patrons =  list(/datum/patron/divine/abyssor, /datum/patron/inhumen/matthios)
	outfit = /datum/outfit/job/roguetown/adventurer/pirate
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_DODGEEXPERT)
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/pirate/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.change_stat("strength", -1)
	H.change_stat("perception", 2)
	H.change_stat("speed", pick(3,4))
	H.change_stat("intelligence", 2)
