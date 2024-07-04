/datum/sex_action/masturbate_penis
	name = "Jerk off"

/datum/sex_action/masturbate_penis/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts jerking off..."))

/datum/sex_action/masturbate_penis/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] jerks his cock..."))
	playsound(owner, 'sound/misc/mat/fap.ogg', 30, TRUE, -2, ignore_walls = FALSE)
	user.sexcon.adjust_arousal(3 * user.sexcon.get_force_pleasure_multiplier())
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_penis/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops jerking off..."))

/datum/sex_action/masturbate_penis/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.just_ejaculated())
		return TRUE
	return FALSE
