/datum/sex_action/toy_other_anal
	name = "Use toy on their butt"

/datum/sex_action/toy_other_anal/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_other_anal/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_other_anal/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] shoves \the [dildo] in [target]'s butt..."))

/datum/sex_action/toy_other_anal/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures [target]'s butt..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 6, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/toy_other_anal/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] pulls \the [dildo] from [target]'s butt."))

/datum/sex_action/toy_other_anal/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
