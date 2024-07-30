/datum/job/roguetown/nightman
	title = "Nightmaster"
	f_title = "Nightmistress"
	flag = NIGHTMASTER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS

	tutorial = "You are renting out the bath-house in a joint operation with the barkeep. Providing security for the bathwenches and helping them find work, or a troublemaking rake that the others hate to tolerate. \
		\
		This role allows for full customization."

	allowed_ages = ALL_AGES_LIST
	outfit = /datum/outfit/job/roguetown/nightman
	display_order = JDO_NIGHTMASTER
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/nightman/pre_equip(mob/living/carbon/human/H)
	..()
	beltr = /obj/item/keyring/nightman
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", -1)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou/leather
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/nightman
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		if(H.dna?.species)
			if(iself(H) || ishalfelf(H))
				armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
			else if(ishumannorthern(H))
				H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()
			else if(isdwarf(H))
				armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	else
		switch(H.patron?.type)
			if(/datum/patron/divine/eora) //Eoran loadouts
				shoes = /obj/item/clothing/shoes/roguetown/sandals
				armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/random
				wrists = /obj/item/clothing/neck/roguetown/psicross/eora
				head  = /obj/item/clothing/head/peaceflower
			else
				armor = /obj/item/clothing/suit/roguetown/armor/armordress/alt
				shoes = /obj/item/clothing/shoes/roguetown/shortboots

		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random
