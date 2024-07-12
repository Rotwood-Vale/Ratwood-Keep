/datum/sex_action/frotting
	name = "Frot them"

/datum/sex_action/frotting/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return
	return TRUE

/datum/sex_action/frotting/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/frotting/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] shoves their cock against [target]'s own!"))

/datum/sex_action/frotting/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] frots cocks together with [target]'s."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 1, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 1, 4, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/frotting/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] lets go off both their cocks."))
