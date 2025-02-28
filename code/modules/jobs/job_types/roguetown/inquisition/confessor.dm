/*
This confessor is different to 'confessors', the people who are hit with the confession slip.
Please do not confuse the two.
*/
/datum/job/roguetown/shepherd
	title = "Confessor"
	flag = CONFESSOR
	department_flag = INQUISITION
	selection_color = JCOLOR_INQUISITION
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	allowed_patrons = list(
		/datum/patron/psydon
	)

	tutorial = "Confessors are shady agents of the church hired to spy on the populace and keep them moral. \
	As the most fanatical members of the clergy, their main concern is assisting the local Inquisitor with their work. \
	Whether that be in extracting confessions of sin or hunting night beasts and cultists that hide in plain sight."

	outfit = /datum/outfit/job/roguetown/shepherd
	whitelist_req = TRUE
	display_order = JDO_SHEPHERD
	give_bank_account = 3
	min_pq = 4
	max_pq = null

/datum/outfit/job/roguetown/shepherd
	name = "Confessor"
	jobtype = /datum/job/roguetown/shepherd
	allowed_patrons = list(/datum/patron/psydon)

/datum/outfit/job/roguetown/shepherd/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/armor
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	pants = /obj/item/clothing/under/roguetown/trou/overseer
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	head = /obj/item/clothing/head/roguetown/helmet/overseer
	mask = /obj/item/clothing/mask/rogue/overseer
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/overseer
	cloak = /obj/item/clothing/cloak/cape/inquisitor
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/overseer
	beltl = /obj/item/rogueweapon/mace/cudgel
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/shepherd = 1, /obj/item/lockpick = 1, /obj/item/clothing/head/roguetown/puritan = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.change_stat("intelligence", -1)
		H.change_stat("endurance", 1)
		H.change_stat("strength", 2)
		H.change_stat("speed", 2)
		H.change_stat("perception", 1)

		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
		H.mind.add_antag_datum(new_antag)

	H.verbs |= /mob/living/carbon/human/proc/faith_test
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
