/datum/migrant_role
	abstract_type = /datum/migrant_role
	/// Name of the role
	var/name = "MIGRANT ROLE"
	/// Restricts species if the list is not null
	var/list/allowed_species
	/// Restricts sexes if list is not null
	var/list/allowed_sexes
	/// Restricts ages if list is not null
	var/list/allowed_ages
	/// Typepath of outfit for the migrant role
	var/outfit
	/// Typepath of the antag datum for the migrant role
	var/antag_datum
	/// If defined they'll get adv class rolls
	var/list/advclass_cat_rolls
	/// Text to greet player of this role in the wave
	var/greet_text

/datum/migrant_role/proc/after_spawn(mob/living/carbon/human/character)
	return

/datum/migrant_role/test
	name = "Tester"
	greet_text = "You are the tester. Don't break anything"
	outfit = /datum/outfit/job/roguetown/mercenary/desert_rider
	antag_datum = /datum/antagonist/bandit

/datum/migrant_role/test/after_spawn(mob/living/carbon/human/character)
	to_chat(character, span_notice("Epic"))

/datum/migrant_role/pilgrim
	name = "Pilgrim"
	greet_text = "tba"
	advclass_cat_rolls = list(CTAG_PILGRIM = 10)
