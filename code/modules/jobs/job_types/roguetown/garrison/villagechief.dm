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
	min_pq = 0
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
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("perception", 4)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -3)
		H.change_stat("intelligence", 5)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
