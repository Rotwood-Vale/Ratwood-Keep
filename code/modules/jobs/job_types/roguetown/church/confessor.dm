/datum/job/roguetown/shepherd
	title = "Confessor"
	flag = CONFESSOR
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TOLERATED_UP
	allowed_sexes = list(MALE)
	allowed_patrons = list(
		/datum/patron/old_god,
		ALL_DIVINE_PATRONS,
	)
	tutorial = "You're the Inquisitor's muscle and you've been sent along him to this decrepit settlement. Obey the Inquisitor as always. It's also been a while since you last saw your comrade... May the one guide us."
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/shepherd
	display_order = JDO_SHEPHERD
	give_bank_account = 3
	min_pq = 1
	max_pq = null

/datum/outfit/job/roguetown/shepherd
	name = "Confessor"
	jobtype = /datum/job/roguetown/shepherd
	allowed_patrons = list(/datum/patron/old_god)

/datum/outfit/job/roguetown/shepherd/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/black
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	mask = /obj/item/clothing/mask/rogue/shepherd
	backl = /obj/item/storage/backpack/rogue/satchel
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
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
		H.change_stat("strength", 3)
		H.change_stat("speed", 2)
		H.change_stat("perception", 1)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
