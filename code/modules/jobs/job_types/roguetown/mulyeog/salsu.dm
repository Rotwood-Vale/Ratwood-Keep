/datum/job/roguetown/mulyeogenhenchman
	title = "Salsu"
	flag = SALSU
	department_flag = MULYEOGLINEAGE
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	allowed_races = EAST_GRONN_TYPES
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	tutorial = "A vagabond swordsman; \
	Recently picked up by the Lineage, you were once a common thug with scars. You travel with fellow abandoned swordsmen who have the murderous intent to survive. \
	You are not as well versed in the sword as your superiors, but you are many. You are apart of a family, now."
	display_order = JDO_SALSU
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/salsu
	min_pq = 3
	max_pq = null
	foreign_examine = TRUE

	cmode_music = 'sound/music/combat_mulyeog.ogg'

/datum/outfit/job/roguetown/salsu/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/trou/eastpants1
	shirt = /obj/item/clothing/suit/roguetown/shirt/eastshirt1
	armor = /obj/item/clothing/suit/roguetown/armor/eastsuit3
	shoes = /obj/item/clothing/shoes/roguetown/armor
	beltr = /obj/item/rogueweapon/sword/sabre/mulyeog
	beltl = /obj/item/ammo_holder/quiver/mulyeog
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/storage/keyring/mulyeog)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)


