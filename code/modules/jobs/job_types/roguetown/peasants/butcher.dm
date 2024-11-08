/datum/job/roguetown/butcher
	title = "Butcher"
	flag = BUTCHER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_ages = ALL_AGES_LIST
	tutorial = "Some say you're a strange individual, some say you're a cheat, while some claim you're a savant in the art of sausage making. Without your skilled hands and knifework, most of the livestock around the town would be wasted. "

	outfit = /datum/outfit/job/roguetown/beastmaster
	display_order = JDO_BUTCHER
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/beastmaster/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	beltl = /obj/item/key/butcher
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/huntingknife
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random	
	if(H.mind)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", -1)
