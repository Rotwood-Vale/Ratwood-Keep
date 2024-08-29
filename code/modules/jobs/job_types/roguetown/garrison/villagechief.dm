/datum/job/roguetown/woodsman
	title = "Village Elder"
	flag = ELDER
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE) //same as bog guard
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_OLD)
	tutorial = "You are as venerable and ancient as the trees themselves, wise even for your years spent in the bog guard. The King may lead officially, but people look to you as Ealdorman to solve lesser issues. Remember the old ways of the law, not everything must end in bloodshed: no matter how much the Bog Guards wish it were the case."
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/woodsman
	display_order = JDO_CHIEF
	min_pq = 5
	max_pq = null
	give_bank_account = 16

	cmode_music = 'sound/music/combat_bog.ogg'

/datum/job/roguetown/woodsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/raincloak/furcloak))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "Village Elder cloak ([index])"

/datum/outfit/job/roguetown/woodsman
	name = "Village Elder"
	jobtype = /datum/job/roguetown/woodsman

/datum/outfit/job/roguetown/woodsman/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace/cudgel
	beltl = /obj/item/flashlight/flare/torch/lantern
	r_hand = /obj/item/rogueweapon/woodstaff
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/keyring/velder  = 1, /obj/item/storage/belt/rogue/pouch/coins/rich = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE) // Inverse Veteran combat skills
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE) // Actually a danger with a ranged weapon. Easy to oneshot, though.
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE) // He knows the basic peasant skills from living in town, watching and helping.
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE) // Skill in axes should translate by default.
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("perception", 5)
		H.change_stat("intelligence", 6)
		H.change_stat("constitution", -5) // The price for high combat skills. Many scars and old wounds make his body frail.
	H.verbs |= /mob/proc/haltyell
	// ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC) It's too heavy for him now.
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
