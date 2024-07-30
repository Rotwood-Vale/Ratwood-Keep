/*
	It'd prob be a good idea to fill out a entire roster of bandits
	For now tho you got this cause I don't feel like reworking the shit ass gamemode yet
	The antag would also have to be touched as it loads out all the gear attached to the datum lol
*/
/datum/advclass/bandit
	name = "Bandit"
	tutorial = "A Free Man of the wilderness, you draw nigh to the flaming lure Matthios laid to gather prey within walls, fearful of the darkness beyond. Win back what the Giver's flame created; what these slaves of gold greedily hoard!"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
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
	
