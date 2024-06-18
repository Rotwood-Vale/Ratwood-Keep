/datum/job/roguetown/adventurer/prisoner
	title = "Prisoner"
	flag = PRISONER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 0
	spawn_positions = -1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = "How does it feel to be the rat in the cage? You're unwanted, unloved and entirely worthless in society. You're kept around for the amusement of the Guards and for the oft chance someone comes to pay your ransom. Might as well start praying to whatever god you find solace in."

	outfit = /datum/outfit/job/roguetown/adventurer/prisoner
	bypass_jobban = TRUE
	display_order = JDO_PRISONER
	give_bank_account = 10
	min_pq = -49
	max_pq = null
	can_random = FALSE
	wanderer_examine = FALSE
	advjob_examine = FALSE
	isprisoner = TRUE

/datum/outfit/job/roguetown/adventurer/prisoner/pre_equip(mob/living/carbon/human/H)
	..()
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
