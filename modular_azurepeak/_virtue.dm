GLOBAL_LIST_EMPTY(virtues)

/datum/virtue
	/// What the virtue's called.
	var/name
	/// A brief, in-character description of what the virtue does.
	var/desc
	/// A list containing any traits we need to add to the mob.
	var/list/added_traits = list()
	/// An associative list containing any skills we want to adjust.
	var/list/added_skills = list()

/datum/virtue/proc/apply_to_human(mob/living/carbon/human/recipient)
	return

/datum/virtue/proc/handle_traits(mob/living/carbon/human/recipient)
	if (!LAZYLEN(added_traits))
		return
	for(var/trait in added_traits)
		ADD_TRAIT(recipient, trait, "[type]")

/datum/virtue/proc/handle_skills(mob/living/carbon/human/recipient)
	if (!recipient.mind || !LAZYLEN(added_skills))
		return
	for(var/skill in added_skills)
		recipient.mind?.adjust_skillrank(skill, added_skills[skill], TRUE)

/proc/apply_virtue(mob/living/carbon/human/recipient, datum/virtue/virtue_type)
	virtue_type.apply_to_human(recipient)
	virtue_type.handle_traits(recipient)
	virtue_type.handle_skills(recipient)

/datum/virtue/none
	name = "None"
	desc = "Without virtue."
