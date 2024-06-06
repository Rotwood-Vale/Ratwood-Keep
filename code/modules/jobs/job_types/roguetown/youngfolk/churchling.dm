/datum/job/roguetown/churchling
	title = "Churchling"
	flag = CHURCHLING
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	spells = list(/obj/effect/proc_holder/spell/invoked/lesser_heal)

	allowed_races = CLOTHED_RACES_TYPES
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = YOUNG_AGES_LIST

	tutorial = "Your family were zealots, they scolded you with a studded belt and prayed like sinners every waking hour of the day they weren’t toiling in the fields. You escaped them by becoming a churchling, and a guaranteed education isnt so bad"

	outfit = /datum/outfit/job/roguetown/churchling
	display_order = JDO_CHURCHLING
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/churchling/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/weaving, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, round(rand(3,5)), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, round(rand(3,5)), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather/rope
		pants = /obj/item/clothing/under/roguetown/tights
		backr = /obj/item/storage/backpack/rogue/satchel
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		armor = /obj/item/clothing/suit/roguetown/shirt/robe
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		belt = /obj/item/storage/belt/rogue/leather/rope
		pants = /obj/item/clothing/under/roguetown/tights
		backr = /obj/item/storage/backpack/rogue/satchel
		head = /obj/item/clothing/head/roguetown/armingcap

	H.change_stat("perception", 1)
	H.change_stat("speed", 2)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	//Max devotion limit - Churchlings can only call upon lesser miracles until their education is complete.
	C.max_devotion = 100
	C.max_progression = CLERIC_REQ_0
	C.update_devotion(50, 50)
	C.holder_mob = H
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
