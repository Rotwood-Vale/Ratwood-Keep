/datum/job/roguetown/farmer
	title = "Soilson"
	flag = FARMER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 3
	spawn_positions = 5
	display_order = JDO_SOILSON
	selection_color = JCOLOR_PEASANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_SHUNNED_UP

	tutorial = "It is a simple life you live, your basic understanding of life is something many would be envious of if they knew how perfect it was. You know a good day's work, the sweat on your brow is yours: Famines and plague may take its toll, but you know how to celebrate life well. Till the soil and produce fresh food for those around you, and maybe youll be more than an unsung hero someday."


	f_title = "Soilbride"
	outfit = /datum/outfit/job/roguetown/farmer
	display_order = 24
	give_bank_account = 17
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/farmer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, pick(4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 1)
		H.change_stat("speed", 1)

	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/key/farm
	if(H.gender == MALE)
		head = /obj/item/clothing/head/roguetown/roguehood/random
		if(prob(50))
			head = /obj/item/clothing/head/roguetown/strawhat
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	else
		head = /obj/item/clothing/head/roguetown/armingcap
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
