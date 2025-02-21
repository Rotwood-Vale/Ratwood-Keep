/datum/job/roguetown/kyodai
	title = "Kyodai"
	flag = KYODAI
	department_flag = MULYEOGLINEAGE
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = EAST_GRONN_TYPES
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	tutorial = "An enforcer of the local Ruma Clan; \
	Through bloodshed, murder, and obedience to your superiors - you rose to replace them. You are now an officer of the Ruma Clan. \
	Direct your underlings & ensure the satisfaction of your Captain."
	display_order = JDO_KYODAI
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/kyodai
	min_pq = 0 //turn into 5 after testing
	max_pq = null

	cmode_music = 'sound/music/combat_rumaclan.ogg'

/datum/outfit/job/roguetown/kyodai/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
	pants = /obj/item/clothing/under/roguetown/trou/eastpants2
	shirt = /obj/item/clothing/suit/roguetown/shirt/easttats
	armor = /obj/item/clothing/suit/roguetown/shirt/eastshirt2
	cloak = /obj/item/clothing/cloak/eastcloak1
	shoes = /obj/item/clothing/shoes/roguetown/armor
	beltr = /obj/item/rogueweapon/sword/sabre/mulyeog/rumahench
	beltl = /obj/item/ammo_holder/mulyeog/rumahench
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/storage/keyring/nightman)

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

	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
