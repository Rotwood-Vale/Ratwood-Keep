/datum/job/roguetown/hightemplar
	title = "High Templar"
	department_flag = CHURCHMEN
	faction = "Station"
	tutorial = "You are the High Templar, the most experienced of your order. Your strength of arm is second only to your strength of faith, and your loyalty to the Priest(ess) is unquestioning. Your role is to lead the Templar in their guard of the Church and their routing of the Heretical."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	allowed_patrons = ALL_CLERIC_PATRONS
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	outfit = /datum/outfit/job/roguetown/hightemplar
	min_pq = 8
	max_pq = null
	total_positions = 1
	spawn_positions = 1
	display_order = JDO_HIGHTEMPLAR
	give_bank_account = TRUE

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/templar)

/datum/outfit/job/roguetown/hightemplar
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/roguetown/hightemplar/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
	cloak = /obj/item/clothing/cloak/chasuble
	switch(H.patron.name)
		if("Astrata")
			wrists = /obj/item/clothing/neck/roguetown/psicross/astrata
		if("Dendor")
			wrists = /obj/item/clothing/neck/roguetown/psicross/dendor
		if("Necra")
			wrists = /obj/item/clothing/neck/roguetown/psicross/necra
		if("Pestra")
			wrists = /obj/item/clothing/neck/roguetown/psicross/pestra
		if("Noc")
			wrists = /obj/item/clothing/neck/roguetown/psicross/noc
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	backl = /obj/item/rogueweapon/mace/goden/steel
	backr = /obj/item/rogueweapon/shield/tower/metal	
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/keyring/priest
	beltr = /obj/item/rogueweapon/sword/long
	id = /obj/item/clothing/ring/silver
	gloves = /obj/item/clothing/gloves/roguetown/chain
	neck = /obj/item/clothing/neck/roguetown/bervor
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
