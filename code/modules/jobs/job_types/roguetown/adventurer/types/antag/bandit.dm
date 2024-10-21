/*
	It'd prob be a good idea to fill out a entire roster of bandits
	For now tho you got this cause I don't feel like reworking the shit ass gamemode yet
	The antag would also have to be touched as it loads out all the gear attached to the datum lol
*//* Commented out for bandit jobbening
/datum/advclass/bandit
	name = "Bandit"
	tutorial = "A person living in service of the god Matthios, through theft and social woes can ones suffering be alleviated."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	outfit = /datum/outfit/job/roguetown/adventurer/bandit
	category_tags = list(CTAG_ANTAG, CTAG_BANDIT)

/datum/outfit/job/roguetown/adventurer/bandit
	allowed_patrons = list(/datum/patron/inhumen/matthios)

/datum/outfit/job/roguetown/adventurer/bandit/pre_equip(mob/living/carbon/human/H)
	..()

/datum/outfit/job/roguetown/adventurer/bandit/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/datum/antagonist/new_antag = new /datum/antagonist/bandit()
	H.mind.add_antag_datum(new_antag)

*/