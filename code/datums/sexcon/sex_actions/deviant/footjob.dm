/datum/sex_action/footjob
	name = "Jerk them off with feet"
	check_same_tile = FALSE

/datum/sex_action/footjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/footjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
/// Booted footjob time
//	if(!get_location_accessible(user, BODY_ZONE_PRECISE_L_FOOT))
//		return FALSE
//	if(!get_location_accessible(user, BODY_ZONE_PRECISE_R_FOOT))
//		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/footjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] puts their feet on [target]'s cock..."))

/datum/sex_action/footjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] jerks [target]'s cock with their feet..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/footjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops jerking [target]'s off with their feet..."))

/datum/sex_action/footjob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
