/datum/job/roguetown/citywatch
	title = "Watchman"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 11
	spawn_positions = 11
	selection_color = JCOLOR_SOLDIER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Responsible for the safety of the city and the enforcement of the law, \
	you walk among the downtrodden, delivering justice and pain. \
	Bound to the commands of many lords, both the Church and the Sheriff hold great sway over your life."
	display_order = JDO_TOWNGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/citywatch
	give_bank_account = 16
	min_pq = 1
	max_pq = null

	cmode_music = 'sound/music/combat_guard.ogg'
			
/datum/outfit/job/roguetown/citywatch/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/citywatch
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/citywatch
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/armor/citywatch
	gloves = /obj/item/clothing/gloves/roguetown/chain
	shoes = /obj/item/clothing/shoes/roguetown/armor
	beltl = /obj/item/keyring/town_watch
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/rogueweapon/mace/stunmace
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /obj/item/rope/chain = 1)
	backl = null
	if(H.mind)
		assign_skills(H)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/outfit/job/roguetown/citywatch/proc/assign_skills(mob/living/carbon/human/guard)
	guard.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
   	guard.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/bows, pick(3), TRUE)
  	guard.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE) 
	guard.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
    guard.change_stat("strength", 1)
    guard.change_stat("perception", 3)
    guard.change_stat("constitution", -1)
    guard.change_stat("speed", 1)

/mob/proc/haltyell()
	set name = "HALT!"
	set category = "Noises"
	emote("haltyell")
