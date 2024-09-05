/datum/job/roguetown/shepherd
	title = "Mook"
	flag = CONFESSOR
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 3
	spawn_positions = 3

	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_sexes = list(MALE, FEMALE)
	allowed_patrons = list(
		/datum/patron/old_god,
		ALL_DIVINE_PATRONS,
	)
	tutorial = "Mooks are the eyes, ears, and nose of the Inquisitor. Where-ever he goes, they go, and whatever he does, they do. Using their rather dubious skills to do the things that the Inquisitor would not be seen publicly doing, whether it be stealing, sneaking around, or other morally grey acts. But everything for the faith, no?"

	outfit = /datum/outfit/job/roguetown/shepherd
	display_order = JDO_SHEPHERD
	give_bank_account = 10
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/shepherd
	name = "Mook"
	jobtype = /datum/job/roguetown/shepherd

/datum/outfit/job/roguetown/shepherd/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	gloves = /obj/item/clothing/gloves/roguetown/angle
	shoes = /obj/item/clothing/shoes/roguetown/boots
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/tights/black
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	head = /obj/item/clothing/head/roguetown/menacing/bandit
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	beltl = /obj/item/rogueweapon/mace/cudgel
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	backr = /obj/item/storage/backpack/rogue/satchel/black 
	backpack_contents = list(/obj/item/keyring/puritan = 1, /obj/item/rogueweapon/huntingknife/idagger/steel = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 1)
		H.change_stat("strength", 1)
		H.change_stat("speed", 3)
		H.change_stat("perception", 2)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
		H.mind.add_antag_datum(new_antag)
	H.verbs |= /mob/living/carbon/human/proc/faith_test
