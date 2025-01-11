/datum/sex_action/toy_anal
	name = "Pleasure butt with toy"

/datum/sex_action/toy_anal/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_anal/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_anal/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	if(usr?.client?.prefs?.be_russian)
		user.visible_message(span_warning("[user] прижимает \the [dildo] к своему заду..."))
	else
		user.visible_message(span_warning("[user] starts shoving \the [dildo] in their butt..."))

/datum/sex_action/toy_anal/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	if(user.sexcon.do_message_signature("[type]"))
		if(usr?.client?.prefs?.be_russian)
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] играется со своей задницей при помощи \the [dildo]."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures their butt with \the [dildo]."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 6, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/toy_anal/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	if(usr?.client?.prefs?.be_russian)
		user.visible_message(span_warning("[user] вынимает \the [dildo] из своей задницы."))
	else
		user.visible_message(span_warning("[user] pulls \the [dildo] from their butt."))

/datum/sex_action/toy_anal/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
