/datum/job/roguetown/harbormaster
	title = "Harbormaster"
	flag = HARBORMASTER
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = list(/datum/species/akula)
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	allowed_patrons =  list(/datum/patron/divine/abyssor)
	tutorial = "YARRR."
	display_order = JDO_GUARD_CAPTAIN
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/harbormaster

	give_bank_account = 20
	min_pq = 5
	max_pq = null
	cmode_music = 'sound/music/combat_guard2.ogg'

/datum/outfit/job/roguetown/harbormaster/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/cutlass
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

