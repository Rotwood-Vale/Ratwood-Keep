/datum/sex_action/masturbate_anus
	name = "Finger butt"

/datum/sex_action/masturbate_anus/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_anus/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_anus/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts fingering his butt..."))

/datum/sex_action/masturbate_anus/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fingers his butt..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)
	user.sexcon.adjust_arousal(3 * user.sexcon.get_force_pleasure_multiplier())
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_anus/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops fingering his butt..."))

/datum/sex_action/masturbate_anus/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.just_ejaculated())
		return TRUE
	return FALSE
