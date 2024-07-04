/datum/sex_action/masturbate_vagina
	name = "Masturbate Vagina"

/datum/sex_action/masturbate_vagina/can_perform(mob/living/user, mob/living/target)
	var/mob/living/carbon/human/human_user = user
	if(user != target)
		return FALSE
	if(!human_user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	return TRUE
