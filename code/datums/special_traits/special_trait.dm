/datum/special_trait
	abstract_type = /datum/special_trait
	var/name
	var/greet_text
	var/req_text
	var/weight = 100
	var/list/allowed_sexes
	var/list/allowed_races
	var/list/allowed_ages
	var/list/allowed_patrons
	var/list/allowed_jobs
	var/list/allowed_migrants
	var/list/restricted_migrants
	var/list/restricted_traits
	var/list/restricted_races
	var/list/restricted_jobs

/datum/special_trait/proc/can_apply(mob/living/carbon/human/character)
	return TRUE

/datum/special_trait/proc/on_apply(mob/living/carbon/human/character, silent)
	return
