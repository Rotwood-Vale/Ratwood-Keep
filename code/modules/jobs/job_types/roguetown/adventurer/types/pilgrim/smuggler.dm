/datum/advclass/smuggler
	name = "Smuggler"
	tutorial = "YARRR"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/akula, /datum/species/human/northern, /datum/species/lizardfolk)
	outfit = /datum/outfit/job/roguetown/adventurer/smuggler
	category_tags = list(CTAG_PILGRIM)
	cmode_music = 'sound/music/combat_pirate.ogg'

/datum/outfit/job/roguetown/adventurer/smuggler
	allowed_patrons =  list(/datum/patron/divine/abyssor, /datum/patron/inhumen/matthios)

/datum/outfit/job/roguetown/adventurer/smuggler/pre_equip(mob/living/carbon/human/H)
	..()
	head =/obj/item/clothing/head/roguetown/helmet/bandana
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/backpack
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltl = /obj/item/ammo_holder/quiver
	backpack_contents = list(/obj/item/reagent_containers/powder = 2, /obj/item/reagent_containers/glass/bottle/mercury = 2, /obj/item/reagent_containers/glass/bottle/rogue/poison = 1, /obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
	H.change_stat("perception", 1) 
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 1)
