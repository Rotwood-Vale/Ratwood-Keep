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
	tutorial = "Вы могли унаследовать эту должность, купить ее или быть назначены самим маршалом;\
			Независимо от происхождения, теперь вы служите помощником, планировщиком и присяжным маршала. \
			Вы помогаете ему следить за налогообложением, строительством и планированием новых законов. \
			Вы подчиняетесь только герцогу, маршалу, герцогине, наследнику или наследнице. Однако ваша основная задача - помогать маршалу в выполнении его обязанностей."

	outfit = /datum/outfit/job/roguetown/councillor
	
	give_bank_account = 40
	min_pq = 2
	max_pq = null

/datum/outfit/job/roguetown/councillor/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/councillor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/armor
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/keyring/councillor
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 1)
		H.change_stat("fortune", 1)
	
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

