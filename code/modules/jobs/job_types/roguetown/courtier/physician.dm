/datum/job/roguetown/physician
	title = "Court Physician"
	flag = PHYSICIAN
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Aasimar"
	)
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_PHYSICIAN
	tutorial = "You were once a noble child like any other, being groomed to take a position of responsibility and authority. Perhaps in another life, you would have turned out to be a wise archivist or a shrewd steward. In this life, however, a wasting disease stole away your youth. Out of desperation, you sought out Pestra and were cured. Now you serve in the King's court ensuring the good health of your betters and their servants."
	outfit = /datum/outfit/job/roguetown/physician
	whitelist_req = TRUE
	give_bank_account = 25
	min_pq = 2
	max_pq = null

/datum/outfit/job/roguetown/physician
	name = "Physician"
	jobtype = /datum/job/roguetown/physician
	allowed_patrons = list(/datum/patron/divine/pestra)

/datum/outfit/job/roguetown/physician/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	cloak = /obj/item/clothing/cloak/black_cloak
	id = /obj/item/clothing/ring/gold
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltl = /obj/item/rogueweapon/huntingknife/idagger
	beltr = /obj/item/keyring/servant
	neck = /obj/item/clothing/neck/roguetown/psicross/pestra
	pants = /obj/item/clothing/under/roguetown/tights/random
	r_hand = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle/pestra = 1, /obj/item/reagent_containers/glass/bottle/rogue/healthpot = 2)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", -1)
		H.change_stat("fortune", 1)
		H.change_stat("endurance", 1)
		if(H.age == AGE_OLD)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.holder_mob = H
	C.update_devotion(50, 50)
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
