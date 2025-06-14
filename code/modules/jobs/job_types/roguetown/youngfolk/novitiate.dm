/datum/job/roguetown/novitiate
	title = "Novitiate"
	flag = NOVITIATE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_SHUNNED_UP
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "It doesnt matter if you are an orphan, your family were zealots so they sent you here, or you just decided to follow the path of the Gods yourself. \
	You ended up in the Rockhillian Church, given a shelter and food, submitting to the will of Their eminence. You have faith, and the rest is meaningless."

	outfit = /datum/outfit/job/roguetown/novitiate
	display_order = JDO_NOVITIATE
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/novitiate/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/robe
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else
		head = /obj/item/clothing/head/roguetown/armingcap
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/key/church
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/satchel

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat("perception", 1)
		H.change_stat("speed", 2)
		H.change_stat("endurance", 1)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_churchling(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
