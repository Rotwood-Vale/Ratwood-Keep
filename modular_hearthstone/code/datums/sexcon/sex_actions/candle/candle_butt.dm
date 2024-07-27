/datum/sex_action/candle_butt
	name = "Use candle wax on their bossom"

/datum/sex_action/candle_butt/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_candle_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/candle_butt/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_candle_in_either_hand(user))
		return FALSE
	var/obj/item/candle/C = get_candle_in_either_hand(user)
	if(!C.lit)
		to_chat(usr, span_warning("Lit it first!"))
		return FALSE

	return TRUE

/datum/sex_action/candle_butt/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] begins to drop wax [target]'s bossom..."))

/datum/sex_action/candle_butt/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] drops wax on [target]'s bossom..."))

	user.sexcon.perform_sex_action(target, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

	if(prob(33))
		to_chat(target, span_warning("It's hot!"))
		playsound(src, 'sound/items/firesnuff.ogg', 20)

/datum/sex_action/candle_butt/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops dropping wax on [target]'s bossom..."))

/datum/sex_action/candle_butt/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
