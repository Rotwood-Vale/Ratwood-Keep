
/datum/job/roguetown/highking
	title = "Northmen King"
	f_title = "Northmen Queen"
	flag = HIGHKING
	department_flag = VIKING
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/viking)
	tutorial = "Hailing from the freezing cold Frost Lands, you lead your warband to its newest prize, Rockhill. Graggar's bloodlust must be sated. Topple the statues of the southerner's weak gods, burn their churches, take their valuables and take them as slaves so that they might be sacrificed to Graggar. May the black sun darken the sky for all time!"
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/highking

	display_order = JDO_HIGHKING
	min_pq = 2
	max_pq = null
	cmode_music = 'sound/music/combat_viking.ogg'

/datum/outfit/job/roguetown/highking/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/blacksunhelm
	backr = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/stoneaxe/battle
	r_hand = /obj/item/rogueweapon/sword/cursedsword
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	pants = /obj/item/clothing/under/roguetown/platelegs
	gloves = /obj/item/clothing/gloves/roguetown/graggaritegauntletsleader
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/plate/graggaritearmorleader
	shoes = /obj/item/clothing/shoes/roguetown/boots/graggaritebootsleader
	cloak = /obj/item/clothing/cloak/cape
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE) // Chieftess gets nearly same skills as guard.
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)

		H.change_stat("strength", 4)
		H.change_stat("intelligence", -2)
		H.change_stat("constitution", 4)
		H.change_stat("endurance", 3)
		H.change_stat("speed", -2)

/obj/effect/proc_holder/spell/self/convertrole/viking
	name = "Recruit Thrall"
	new_role = "Graggarite Thrall"
	recruitment_faction = "Viking"
	recruitment_message = "Serve Graggar, %RECRUIT!"
	accept_message = "FOR THE BLACK SUN!"
	refuse_message = "I refuse."

