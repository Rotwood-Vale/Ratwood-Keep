/datum/job/roguetown/harbormaster
	title = "Harbormaster"
	flag = HARBORMASTER
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "A long retired captain, \
	you have seen everything the many ports of the known world have to offer. \
	During the dae, you comfortably sit back and manage the flow of goods of the local harbor, \
	but at night your mind looks to the south, to the great maritime cities and exotic markets of Grenzelhoft and Zybantium, now fallen to the Rot. \
	You work closely with the merchant and steward, ensuring the safety of them, the harbor and the goods that pass through it. Command your mates while listening to your supervisors in order to protect their business."

	display_order = JDO_HARBORMASTER
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/harbormaster

	give_bank_account = 20
	min_pq = 5
	max_pq = null
	cmode_music = 'sound/music/combat_pirate.ogg'

/datum/outfit/job/roguetown/harbormaster
	allowed_patrons = list(/datum/patron/divine/abyssor)

/datum/outfit/job/roguetown/harbormaster/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/tricorn/lucky
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather/advanced
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/cutlass
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	backpack_contents = list(/obj/item/storage/keyring/harbormaster = 1, /obj/item/rope = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1) 
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
