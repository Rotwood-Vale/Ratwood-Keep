/datum/job/roguetown/councillor
	title = "Councillor"
	flag = COUNCILLOR
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_races = RACES_TOLERATED_UP
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_COUNCILLOR
	tutorial = "You may have inherited this role, bought your way into it, or were appointed by the Marshal themselves; \
			Regardless of origin, you now serve as an assistant, planner, and juror for the Marshal. \
			You help him oversee the taxation, construction, and planning of new laws. \
			You only answer to the Duke, Marshal, Duchess, Heir, or Heiress. However, your main focus is to assist the Marshal with their duties."
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/councillor
	
	give_bank_account = 40
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/councillor/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/councillor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/armor
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/keyring/councillor
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 1)
		H.change_stat("fortune", 2)
	
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

