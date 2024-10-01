/datum/job/roguetown/tribalguard
	title = "Tribal Guard"
	flag = TRIBALGUARD
	department_flag = TRIBAL
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = "Tribal guards rensposible for the defence of their tribe and their chieftain."
	display_order = JDO_TRIBALGUARD
	outfit = /datum/outfit/job/roguetown/tribalguard
	min_pq = 0
	max_pq = null
	cmode_music = 'sound/music/combat_tribal.ogg'

/datum/outfit/job/roguetown/tribalguard/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/leather/volfhead
	shoes = /obj/item/clothing/shoes/roguetown/boots/bonegreaves
	shirt = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	armor = /obj/item/clothing/suit/roguetown/armor/bone/chestplate
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	neck = /obj/item/clothing/neck/roguetown/psicross/talisman
	belt = /obj/item/storage/belt/rogue/bone/skullbelt
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rope/chain = 1)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_BOG_TREKKING, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE) // Town guards have stronger street skills then castle guards.
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)	
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 5, TRUE) //Hearthstone change.
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("speed", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
