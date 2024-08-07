/datum/job/roguetown/shophand
	title = "Shophand"
	flag = SHOPHAND
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_SHUNNED_UP
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "The Merchant has taken you under his wing to learn the arcane arts of mercantilism, numeracy, literacy, and the joy of organizing the shelves. It is mind numbing and repetitive, but at least you have a roof over your head and comfortable surroundings. Given time, perhaps you will run the town's barter."

	outfit = /datum/outfit/job/roguetown/shophand
	display_order = JDO_SHOPHAND
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

	cmode_music = 'sound/music/combat_giza.ogg'

/datum/outfit/job/roguetown/shophand/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, "[type]")
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltl = /obj/item/keyring/shophand
		backr = /obj/item/storage/backpack/rogue/satchel
	if(H.gender == FEMALE)
		pants = /obj/item/clothing/under/roguetown/tights/stockings/random
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/blue
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltl = /obj/item/keyring/shophand
		backr = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		//basically orphan+ skills
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.change_stat("strength", -2)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)
		H.change_stat("fortune", 2)
