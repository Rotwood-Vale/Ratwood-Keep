/datum/job/roguetown/longshoreman
	title = "Longshoreman"
	flag = LONGSHOREMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	selection_color = JCOLOR_SOLDIER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "You answered Abyssor's call when you were young, though in troublesome ways, \
	pilaging for treasury from anyone who'd cross your path. Now your captain retires from a life of crime, \
	settling down as do you, serving them with undying loyalty along with their supervisors, the steward and merchant. Protect your employer's best interests as best you can and keep the rabble out."
	display_order = JDO_LONGSHOREMAN
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/longshoreman
	give_bank_account = 12
	min_pq = 2
	max_pq = null
	cmode_music = 'sound/music/combat_pirate.ogg'

/datum/outfit/job/roguetown/longshoreman
	allowed_patrons = list(/datum/patron/divine/abyssor)

/datum/outfit/job/roguetown/longshoreman/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/bandana
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather/advanced
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/cutlass
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	backpack_contents = list(/obj/item/storage/keyring/harbormaster = 1, /obj/item/reagent_containers/glass/bottle/rogue/wine = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 1) 
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
