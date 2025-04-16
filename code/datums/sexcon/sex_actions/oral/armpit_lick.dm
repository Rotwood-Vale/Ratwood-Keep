/datum/sex_action/armpit_lick
	name = "Lick their armpit"
	check_same_tile = FALSE
	check_incapacitated = FALSE

/datum/sex_action/armpit_lick/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/armpit_lick/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_L_ARM) && !get_location_accessible(target, BODY_ZONE_R_ARM))
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/armpit_lick/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] starts licking [target]'s armpit..."))

/datum/sex_action/armpit_lick/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] licks [target]'s armpit..."))
	user.make_sucking_noise()

/datum/sex_action/armpit_lick/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] stops licking [target]'s armpit ..."))
