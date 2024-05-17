/datum/job/roguetown/bailiff
	title = "Bailiff"
	flag = BAILIFF
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_races = list(/datum/species/human/northern)
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_BAILIFF
	tutorial = "You judge the common folk and their wrongdoings if necessary. You help plan with the Councillors and maybe the King on any new issues, laws, judgings, and construction that are required to adapt to the world. You serve on a lesser level then the Sheriff,  you are from petty nobility unlike the noble Sheriff. You have two assistant Councillors that may serve as jurors to assist you in your job. You are required to enforce taxes for the King, judge people, make sure the town and manor are not in decay, and to help plan or construct new buildings. You are allowed some limited control over Guards, however it is not the focus of your job unless special circumstances are to change this."
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/bailiff
	give_bank_account = 40
	min_pq = 4

/datum/outfit/job/roguetown/bailiff/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/nobleboot
	head = /obj/item/clothing/head/roguetown/chaperon/bailiff
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	beltl = /obj/item/keyring/sheriff
	beltr = /obj/item/rogueweapon/mace/steel
	cloak = /obj/item/clothing/cloak/stabard/surcoat/bailiff
	gloves = /obj/item/clothing/gloves/roguetown/angle
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	backpack_contents = list(/obj/item/keyring/bailiff = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 1)
	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell
