/datum/job/roguetown/mulyeogenforcer
	title = "Bunsu"
	flag = BUNSU
	department_flag = MULYEOGLINEAGE
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = EAST_GRONN_TYPES
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	tutorial = "A vagabond swordsman; \
	Outcast from your previous clan, or merely a thug with a sword, it doesn't matter. Now, you are a vagabond - travelling with fellow abandoned swordsmen who have the murderous intent to survive. \
	You deeply care for your family, and your skills with the sword. You would would gladly sacrifice yourself for either."
	display_order = JDO_BUNYU
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/bunsu
	min_pq = 5
	max_pq = null
	foreign_examine = TRUE

	cmode_music = 'sound/music/combat_mulyeog.ogg'

/datum/outfit/job/roguetown/bunsu/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/trou/eastpants1
	shirt = /obj/item/clothing/suit/roguetown/shirt/eastshirt1
	armor = /obj/item/clothing/suit/roguetown/armor/eastsuit/foreignsuit
	shoes = /obj/item/clothing/shoes/roguetown/armor
	beltr = /obj/item/rogueweapon/sword/sabre/mulyeog
	beltl = /obj/item/ammo_holder/quiver/mulyeog
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/storage/keyring/mulyeog)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 1)

