/datum/job/roguetown/prisonerr
	title = "Prisoner (Rockhill)"
	flag = PRISONERR
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 4

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = "How does it feel to be the rat in the cage? You're alone and at the mercy of your captors, kept around as a hostage. You spend your days waiting for the oft chance someone comes to pay your ransom. Might as well start praying to whatever god you find solace in."

	outfit = /datum/outfit/job/roguetown/prisonerr
	banned_leprosy = FALSE
	display_order = JDO_PRISONERR
	give_bank_account = 10
	min_pq = -14
	max_pq = null
	can_random = FALSE

	cmode_music = 'sound/music/combat_bum.ogg'

/datum/outfit/job/roguetown/prisonerr/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/gorget/prisoner
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 2)
		var/datum/antagonist/new_antag = new /datum/antagonist/prisoner()
		H.mind.add_antag_datum(new_antag)
	ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
	if(H.gender == FEMALE)
		H.change_stat("strength", -1)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
	if(H.gender == MALE)
		H.change_stat("strength", -1)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/random
		
