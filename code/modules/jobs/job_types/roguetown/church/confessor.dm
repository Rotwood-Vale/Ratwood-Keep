/datum/job/roguetown/shepherd
	title = "Confessor"
	flag = CONFESSOR
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_patrons = list(
		/datum/patron/old_god,
		/datum/patron/divine/astrata,
		/datum/patron/divine/noc,
		/datum/patron/divine/dendor,
		/datum/patron/divine/abyssor,
		/datum/patron/divine/ravox,
		/datum/patron/divine/necra,
		/datum/patron/divine/xylix,
		/datum/patron/divine/pestra,
		/datum/patron/divine/malum,
	)

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "Confessors are shady agents of the church hired to spy on the populace and keep them moral. As the most fanatical members of the clergy, their main concern is assisting the local Inquisitor with their work in extracting confessions of sin as well as hunting night beasts and cultists that hide in plain sight."

	outfit = /datum/outfit/job/roguetown/shepherd
	//cant use the spells anyway due no devotion.
	//spells = list(/obj/effect/proc_holder/spell/invoked/heal, /obj/effect/proc_holder/spell/invoked/shepherd)
	whitelist_req = TRUE
	display_order = JDO_SHEPHERD
	give_bank_account = 3
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/shepherd
	name = "Confessor"
	jobtype = /datum/job/roguetown/shepherd

/datum/outfit/job/roguetown/shepherd/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/black
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	mask = /obj/item/clothing/mask/rogue/shepherd
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	beltl = /obj/item/rogueweapon/mace/cudgel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backpack_contents = list(/obj/item/keyring/shepherd = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.change_stat("intelligence", -1)
		H.change_stat("endurance", 1)
		H.change_stat("strength", 2)
		H.change_stat("speed", 2)
		H.change_stat("perception", 1)
		H.cmode_music = 'sound/music/combat_clergy.ogg'
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
		H.mind.add_antag_datum(new_antag)
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
