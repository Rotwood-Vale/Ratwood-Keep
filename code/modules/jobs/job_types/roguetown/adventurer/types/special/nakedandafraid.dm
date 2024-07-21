//challenge class, spawns with no items at all
/datum/advclass/nudist
	name = "Nudist"
	tutorial = "You have come to this land wholly unprepared!\nSurvival will be a true TRIUMPH."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/nudist
	traits_applied = list(TRAIT_NUDIST)
	category_tags = list(CTAG_CHALLENGE)

/datum/outfit/job/roguetown/adventurer/nudist
	allowed_patrons = list(/datum/patron/divine/dendor)

/datum/outfit/job/roguetown/adventurer/nudist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 4)
	H.change_stat("constitution", 1)
