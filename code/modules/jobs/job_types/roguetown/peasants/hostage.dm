/datum/job/roguetown/hostage
	title = "Hostage"
	flag = HOSTAGE
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 0
	spawn_positions = -1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = "You're too valuable to outright kill yet not a free person. You either messed up really bad or got very unlucky. Either way, the crown has held you hostage until you home country pays your ransom, as if that would ever happen. Might as well start praying to whatever god you find solace in."

	outfit = /datum/outfit/job/roguetown/adventurer/hostage
	bypass_jobban = TRUE
	display_order = JDO_HOSTAGE
	give_bank_account = 10
	min_pq = -49
	max_pq = null
	can_random = FALSE

/datum/outfit/job/roguetown/adventurer/hostage/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.wear_mask)
		var/obj/I = H.wear_mask
		H.dropItemToGround(H.wear_mask, TRUE)
		qdel(I)
	mask = /obj/item/clothing/mask/rogue/facemask/prisoner
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.change_stat("strength", -4)
		H.change_stat("intelligence", -3)
		H.change_stat("speed", -2)
		H.change_stat("constitution", -3)
		H.change_stat("endurance", -2)
		var/datum/antagonist/new_antag = new /datum/antagonist/prisoner()
		H.mind.add_antag_datum(new_antag)
		ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
