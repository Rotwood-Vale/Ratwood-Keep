
/datum/job/roguetown/vikingfarmer
	title = "Northern Hostage"
	f_title = "Northern Hostage"
	flag = VIKINGFARMER
	department_flag = VIKING
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	show_in_credits = FALSE		//Stops Scom from announcing their arrival.

	tutorial = "You have likely seen the brutality of the Northmen firsthand. Put aside any notion of rescue, and serve the warband well. You know they sacrifice slaves to their twisted god, Graggar, so try and at least appear somewhat useful for the cruel pillagers, tend the farm, and try not to draw too much attention."
	whitelist_req = FALSE

	
	outfit = /datum/outfit/job/roguetown/farmer
	display_order = JDO_VIKINGFARMER
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/vikingfarmer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, pick(4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", 1)

	if(H.gender == MALE)
		head = /obj/item/clothing/head/roguetown/roguehood/random
		if(prob(50))
			head = /obj/item/clothing/head/roguetown/strawhat
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather/rope
	else
		head = /obj/item/clothing/head/roguetown/armingcap
//		pants = /obj/item/clothing/under/roguetown/trou
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather/rope


