/datum/sex_action/pitjob
	name = "Jerk them off with armpit"
	check_same_tile = FALSE
	check_incapacitated = FALSE

/datum/sex_action/pitjob/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		name = "Рука. Подрочить подмышкой."

/datum/sex_action/pitjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!(HAS_TRAIT(user, TRAIT_TINY)) && HAS_TRAIT(target, TRAIT_TINY))	//Normal size trying to pitjob male Seelie, pp too small
		return FALSE
	return TRUE

/datum/sex_action/pitjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_L_ARM) && !get_location_accessible(user, BODY_ZONE_R_ARM))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/pitjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(user, TRAIT_TINY) && !HAS_TRAIT(target, TRAIT_TINY))
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] обжимает крупный член своей подмышкой [target]..."))
		else
			user.visible_message(span_warning("[user] presses their tiny underarm against [target]'s cock..."))
	else
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] обжимает член своей подмышкой [target]..."))
		else
			user.visible_message(span_warning("[user] puts [target]'s cock under their arm..."))

/datum/sex_action/pitjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(HAS_TRAIT(user, TRAIT_TINY) && !HAS_TRAIT(target, TRAIT_TINY))
			if(user.client.prefs.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] ласкает крупный член [target] своей подмышкой..."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs their armpit along [target]'s cock..."))
		else
			if(user.client.prefs.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] ласкает член [target] своей подмышкой..."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] squeezes [target]'s cock with their armpit..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/pitjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(user, TRAIT_TINY) && !HAS_TRAIT(target, TRAIT_TINY))
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] убирает конечности от крупного члена [target]."))
		else
			user.visible_message(span_warning("[user] stops rubbing their armpit along [target]'s cock."))
	else
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] убирает конечности от члена [target]."))
		else
			user.visible_message(span_warning("[user] stops jerking [target] off with their armpit."))

/datum/sex_action/pitjob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
