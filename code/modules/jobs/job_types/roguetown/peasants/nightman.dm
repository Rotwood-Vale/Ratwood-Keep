/datum/job/roguetown/nightman
	title = "Nightmaster"
	flag = NIGHTMASTER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 0 
	spawn_positions = 0 // Disabled until he gets his own place on the map

	allowed_sexes = list(MALE)
	allowed_races = CLOTHED_RACES_TYPES

	tutorial = "The Nightmaster is technically a noble. Owner of the Whitevein Lounge, a decaying bathhouse converted into a den of low-lifes. A troublemaking rake that the others hate to tolerate."

	allowed_ages = ADULT_AGES_LIST
	outfit = /datum/outfit/job/roguetown/nightman
	display_order = JDO_NIGHTMASTER
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/nightman/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/nightman
	beltr = /obj/item/keyring/nightman
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", -1)
	if(H.dna?.species)
		if(iself(H) || ishalfelf(H))
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
		else if(ishumannorthern(H))
			H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()
		else if(isdwarf(H))
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
