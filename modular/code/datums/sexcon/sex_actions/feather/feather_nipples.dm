/datum/sex_action/feather_nipples
	name = "Tickle their nipples with feather"

/datum/sex_action/feather_nipples/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_feather_in_either_hand(user))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/feather_nipples/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_CHEST))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	if(!get_feather_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/feather_nipples/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] begins to tickle [target]'s nipples with a feather..."))

/datum/sex_action/feather_nipples/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] tickles [target]'s nipples with a feather..."))

	user.sexcon.perform_sex_action(target, 1, 3, TRUE)
	target.sexcon.handle_passive_ejaculation()

	var/chosen_emote = pick("giggle", "chuckle", "laugh")
	if(prob(33))
		if(prob(15))
			target.emote("scream", forced = TRUE)
			to_chat(target, span_warning("It's too much!"))
		else
			target.emote(chosen_emote, forced = TRUE)
			to_chat(target, span_warning("It tickles!"))

/datum/sex_action/feather_nipples/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops tickling [target]'s nipples..."))

/datum/sex_action/feather_nipples/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
