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
	tutorial = "'Break his leg', 'Knock out a tooth', 'shave her head'... All things you've been ordered to do by the Inquisitor countless times, and you listen to his every word like the good little idiot you are. Being the runt of society has its benefits, you get to serve the 2 most important men, the Inquisitor, and the God of all reality, Psydon."

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
	if(prob(60))
		head = /obj/item/clothing/head/roguetown/menacing/bandit
	else if(prob(40))
		head = /obj/item/clothing/head/roguetown/menacing
	else if(prob(20))
		cloak = /obj/item/clothing/cloak/raincloak/mortus
	else
		head = /obj/item/clothing/head/roguetown/necrahood
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	beltl = /obj/item/rogueweapon/mace/cudgel
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	backr = /obj/item/storage/backpack/rogue/satchel/black 
	backpack_contents = list(/obj/item/keyring/shepherd = 1, /obj/item/rogueweapon/huntingknife/idagger = 1, /obj/item/rope = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 2)
		H.change_stat("strength", 2)
		H.change_stat("speed", 1)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", -2)
	H.verbs |= /mob/living/carbon/human/proc/faith_test
