//challenge class, spawns with no items at all
/datum/advclass/nudist
	name = "Nudist"
	tutorial = "You have come to this land wholly unprepared!\nSurvival will be a true TRIUMPH."
	allowed_sexes = list("male", "female")
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/nudist
	isvillager = FALSE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/nudist
	allowed_patrons = list(/datum/patron/divine/dendor)

/datum/outfit/job/roguetown/adventurer/nudist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	H.change_stat("strength", 4)
	H.change_stat("endurance", 4)
	H.change_stat("constitution", 3)
	H.change_stat("intelligence", -3)

	ADD_TRAIT(H, TRAIT_NUDIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
