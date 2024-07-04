/datum/sex_action/masturbate_penis
	name = "Masturbate Penis"

/datum/sex_action/masturbate_penis/can_perform(mob/living/user, mob/living/target)
	var/mob/living/carbon/human/human_user = user
	if(user != target)
		return FALSE
	if(!get_location_accessible(human_user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!human_user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis/on_start(mob/living/user, mob/living/target)
	user.visible_message(span_warning("[user] starts jerking off..."))

/datum/sex_action/masturbate_penis/on_perform(mob/living/user, mob/living/target)
	var/mob/living/carbon/human/human_user = user
	user.visible_message(span_love("[user] jerks his cock..."))
	human_user.sexcon.adjust_arousal(3 * human_user.sexcon.get_force_pleasure_multiplier())
	human_user.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_penis/on_finish(mob/living/user, mob/living/target)
	user.visible_message(span_warning("[user] stops jerking off..."))

/datum/sex_action/masturbate_penis/is_finished(mob/living/user, mob/living/target)
	if(user.sexcon.just_ejaculated())
		return TRUE
	return FALSE
