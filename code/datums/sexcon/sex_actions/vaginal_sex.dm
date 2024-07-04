/datum/sex_action/vaginal_sex
	name = "Vaginal Sex"

/datum/sex_action/vaginal_sex/can_perform(mob/living/user, mob/living/target)
	var/mob/living/carbon/human/human_target = target
	if(user == target)
		return FALSE
	if(!human_target.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	return TRUE
