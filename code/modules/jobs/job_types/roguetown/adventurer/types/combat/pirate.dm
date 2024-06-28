/datum/advclass/pirate
	name = "Pirate"
	tutorial = "YARRR"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/akula)
	allowed_patrons =  list(/datum/patron/divine/abyssor, /datum/patron/inhumen/matthios)
	outfit = /datum/outfit/job/roguetown/adventurer/pirate
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/combat_pirate.ogg'

/datum/outfit/job/roguetown/adventurer/pirate
	allowed_patrons =  list(/datum/patron/divine/abyssor, /datum/patron/inhumen/matthios)

/datum/outfit/job/roguetown/adventurer/pirate/pre_equip(mob/living/carbon/human/H)
	..()
	switch(rand(1,3))
		if(1)
			head = /obj/item/clothing/head/roguetown/helmet/tricorn/skull
		if(2)
			head = /obj/item/clothing/head/roguetown/helmet/tricorn
		if(3)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/cutlass
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("perception", 1) 
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 1)

