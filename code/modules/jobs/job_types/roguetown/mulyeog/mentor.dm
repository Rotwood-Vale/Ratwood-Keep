/datum/job/roguetown/mentor
	title = "Mentor"
	flag = MENTOR
	department_flag = MULYEOGLINEAGE
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = EAST_GRONN_TYPES
	allowed_sexes = list(MALE) //ruma captain's female
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	tutorial = "A disgraced body guard from foreign lands; \
	After the murder of the State Official underneath your protection, you were hunted down across Gronn. Now, you are a vagabond - travelling with fellow abandoned swordsmen who have the murderous intent to survive. \
	You deeply care for your family, and would do anything to see them survive."
	display_order = JDO_MENTOR
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/mentor
	min_pq = 8
	max_pq = null
	foreign_examine = TRUE

	cmode_music = 'sound/music/combat_mulyeog.ogg'

/datum/outfit/job/roguetown/mentor/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/easthat
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/trou/eastpants1
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich/ //intended use is to pay off the keep
	shirt = /obj/item/clothing/suit/roguetown/shirt/eastshirt1
	armor = /obj/item/clothing/suit/roguetown/armor/eastsuit1
	shoes = /obj/item/clothing/shoes/roguetown/armor
	beltr = /obj/item/rogueweapon/sword/sabre/mulyeog/mentor
	beltl = /obj/item/ammo_holder/quiver/mulyeog
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/storage/keyring/mentor)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)


