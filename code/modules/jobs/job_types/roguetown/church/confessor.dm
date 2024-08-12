/datum/job/roguetown/confessor
	title = "Confessor"
	flag = CONFESSOR
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	allowed_patrons = list(
		/datum/patron/old_god,
		ALL_DIVINE_PATRONS,
	)	//gets set to old god.

	allowed_races = RACES_TOLERATED_UP
	allowed_sexes = list(MALE)
	tutorial = "Confessors are shady agents of the Inquisition hired to spy on the populace and keep them moral. As fanatics of their faith, their main concern is assisting the local Inquisitor with their work in extracting confessions of sin and heresy."

	outfit = /datum/outfit/job/roguetown/confessor
	display_order = JDO_CONFESSOR
	give_bank_account = TRUE
	min_pq = null
	max_pq = null

/datum/outfit/job/roguetown/confessor
	name = "Confessor"
	jobtype = /datum/job/roguetown/confessor
	allowed_patrons = list(/datum/patron/old_god)

/datum/outfit/job/roguetown/confessor/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/black
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	mask = /obj/item/clothing/mask/rogue/shepherd
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1,
		/obj/item/needle = 1,
		/obj/item/rogueweapon/surgery/scalpel = 1,
		/obj/item/rogueweapon/surgery/saw = 1,
		/obj/item/rogueweapon/surgery/hemostat = 2, //2 forceps so you can clamp bleeders AND manipulate organs
		/obj/item/rogueweapon/surgery/retractor = 1,
		/obj/item/rogueweapon/surgery/bonesetter = 1,
		/obj/item/rogueweapon/surgery/cautery = 1,
		/obj/item/natural/worms/leech/cheele = 1, //little buddy
		/obj/item/keyring/confessor = 1
	)
	beltl = /obj/item/rogueweapon/mace/cudgel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.change_stat("intelligence", -2)
		H.change_stat("endurance", 1)
		H.change_stat("strength", 2)
		H.change_stat("speed", 2)
		H.change_stat("perception", 1)
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
