/datum/sex_action/anal_sex
	name = "Anal Sex"

/datum/sex_action/anal_sex/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	return TRUE
