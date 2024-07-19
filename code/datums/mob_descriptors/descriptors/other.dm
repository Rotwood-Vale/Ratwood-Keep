/datum/mob_descriptor/defiant
	name = "Defiant"
	slot = MOB_DESCRIPTOR_SLOT_NOTHING
	verbage = "looks"
	describe = "defiant!"
	show_obscured = TRUE

/datum/mob_descriptor/defiant/can_describe(mob/living/described)
	if(!described.defiant)
		return FALSE
	return TRUE

/datum/mob_descriptor/age
	name = "Age"
	slot = MOB_DESCRIPTOR_SLOT_AGE

/datum/mob_descriptor/age/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	return TRUE

/datum/mob_descriptor/age/get_description(mob/living/described)
	var/mob/living/carbon/human/human = described
	if(human.age == AGE_OLD)
		return "an old"
	else if (human.age == AGE_MIDDLEAGED)
		return "a middle-aged"
	else
		return "an adult"
