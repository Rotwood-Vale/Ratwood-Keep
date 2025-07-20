/datum/job/roguetown/captian_db
	title = "Drunkard Bastards Captain"
	flag = CAPTAIN_DB
	department_flag = DB
	selection_color = JCOLOR_DB
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Having managed to discover uncharted lands (coincidentally at the same time your dreaded rivals, the Black Spot crew) you set sail to Ferentia to strike an accord with a local Duchy to prosper on this new island hand-in-hand with the displaced nobility. Your task won't be easy, as the Black Spots have their eyes on the same lord you intend to petition. Sabotage their aims without causing an uproar and be the crew Rockhill chooses - the Black Spots have only ill intentions for the poor Duchy."

	display_order = JDO_CAPTAIN_DB
	whitelist_req = TRUE
	allowed_maps = list("Rockhill (Pirate Event)")

	outfit = /datum/outfit/job/roguetown/captian_db

	give_bank_account = 50
	min_pq = 5
	max_pq = null
	cmode_music = 'sound/music/combat_pirate.ogg'

/datum/outfit/job/roguetown/captian_db
	allowed_patrons = list(/datum/patron/divine/abyssor)

/datum/outfit/job/roguetown/captian_db/pre_equip(mob/living/carbon/human/H)
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
