/datum/sex_action/toy_other_vagina
	name = "Use toy on their cunt"

/datum/sex_action/toy_other_vagina/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_other_vagina/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_other_vagina/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] shoves \the [dildo] in [target]'s cunt..."))

/datum/sex_action/toy_other_vagina/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures [target]'s cunt..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/toy_other_vagina/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] pulls out \the [dildo] from [target]'s cunt."))

/datum/sex_action/toy_other_vagina/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
