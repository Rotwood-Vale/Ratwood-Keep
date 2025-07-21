/datum/job/roguetown/captain_bs
	title = "Black Spots Captain"
	flag = CAPTAIN_BS
	department_flag = BS
	selection_color = JCOLOR_BS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Those prancing lubbers of the Drunkard Bastards claim they were the ones to discover that ripe and untamed island far off to the western seas. Hah! Clearly it was your crew who found the land, ergo it's your right to profit greatly off the discovery. You simply need to trick some rich fools into bringing their wealth and their serfs aboard your vessels to reach the island... then take it all for yourself. The pirate kingdom will be forged in blood and rum! Make sure the Bastards don't get chosen, just try to hold back. A massacre won't endear you well."

	display_order = JDO_CAPTAIN_BS
	whitelist_req = FALSE
	allowed_maps = list("Rockhill (Pirate Event)")

	outfit = /datum/outfit/job/roguetown/captain_bs

	give_bank_account = 50
	min_pq = 5
	max_pq = null
	cmode_music = 'sound/music/combat_pirate.ogg'

/datum/outfit/job/roguetown/captain_bs
	allowed_patrons = list(/datum/patron/divine/abyssor)

/datum/outfit/job/roguetown/captain_bs/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/tricorn/lucky
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather/advanced
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/long/marlin
	beltr = /obj/item/gun/ballistic/firearm/arquebus_pistol
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /obj/item/powderflask = 1, /obj/item/storage/keyring/harbormaster = 1, /obj/item/ammo_holder/bullet/lead = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 1) 
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 3)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
