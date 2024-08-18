/datum/sex_action/feather_penis
	name = "Tickle their penis with feather"

/datum/sex_action/feather_penis/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_feather_in_either_hand(user))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/feather_penis/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!get_feather_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/feather_penis/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] begins to tickle [target]'s penis with a feather..."))

/datum/sex_action/feather_penis/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] tickles [target]'s penis with a feather..."))

	user.sexcon.perform_sex_action(target, 2, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

	if(prob(5))
		target.emote("scream", forced = TRUE)
		to_chat(target, span_warning("It's too much!"))

/datum/sex_action/feather_penis/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops tickling [target]'s penis..."))

/datum/sex_action/feather_penis/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
