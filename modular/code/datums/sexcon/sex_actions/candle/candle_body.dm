/datum/sex_action/candle_body
	name = "Use candle wax on their body"

/datum/sex_action/candle_body/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_candle_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/candle_body/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_candle_in_either_hand(user))
		return FALSE
	var/obj/item/candle/C = get_candle_in_either_hand(user)
	if(!C.lit)
		to_chat(usr, span_warning("Light it first!"))
		return FALSE

	return TRUE

/datum/sex_action/candle_body/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] begins to drop wax on [target]'s body..."))

/datum/sex_action/candle_body/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] drops wax on [target]'s body..."))

	user.sexcon.perform_sex_action(target, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

	if(prob(33))
		to_chat(target, span_warning("It's hot!"))
		playsound(src, 'sound/items/firesnuff.ogg', 20)

/datum/sex_action/candle_body/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops dropping wax on [target]'s body..."))

/datum/sex_action/candle_body/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
