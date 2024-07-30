/datum/job/roguetown/butler
	title = "Butler"
	flag = BUTLER
	department_flag = COURTIERS
	faction = "Station"
	total_positions = 2
	spawn_positions = 3

	f_title = "Maid"
	allowed_races = RACES_ALL_KINDS
	allowed_ages = ALL_AGES_LIST

	tutorial = "Servitude unto death; your blade a charcuterie of artisanal cheeses and meat, your armor wit and classical training. \
			You don't consider yourself a servant anymore, if anything, you're a part of the family now. \
			You alone have raised Kings, Queens, Princesses and Princes; without you, the royals would have all starved to death."

	outfit = /datum/outfit/job/roguetown/butler
	display_order = JDO_BUTLER
	give_bank_account = 5
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/butler/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)

	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/keyring/servant
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)
	else
		switch(H.patron?.type)
			if(/datum/patron/divine/eora) //Eoran loadouts
				armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy/black
				pants = pick(/obj/item/clothing/under/roguetown/tights/stockings/silk/black, /obj/item/clothing/under/roguetown/tights/stockings/fishnet/black)
				head  = /obj/item/clothing/head/peaceflower
			else
				armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen
				pants = pick(/obj/item/clothing/under/roguetown/tights/stockings/black, /obj/item/clothing/under/roguetown/tights/stockings/white) //Added stockings for the maids

		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		cloak = /obj/item/clothing/cloak/apron/waist
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/keyring/servant
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)

