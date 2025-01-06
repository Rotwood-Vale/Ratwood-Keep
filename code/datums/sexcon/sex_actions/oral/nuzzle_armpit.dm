/datum/sex_action/armpit_nuzzle
	name = "Nuzzle their armpit"
	check_same_tile = FALSE
	check_incapacitated = FALSE

/datum/sex_action/armpit_nuzzle/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		name = "Лицо. Прижаться к подмышке."

/datum/sex_action/armpit_nuzzle/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/armpit_nuzzle/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_L_ARM) && !get_location_accessible(target, BODY_ZONE_R_ARM))
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/armpit_nuzzle/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(user.client.prefs.be_russian)
		user.visible_message(span_warning("[user] приближает свою голову к подмышке [target]..."))
	else
		user.visible_message(span_warning("[user] moves their head against [target]'s armpit..."))


/datum/sex_action/armpit_nuzzle/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(user.client.prefs.be_russian)
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] тыкается в подмышку [target]..."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] nuzzles [target]'s armpit..."))

/datum/sex_action/armpit_nuzzle/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(user.client.prefs.be_russian)
		user.visible_message(span_warning("[user] отводит свою голову от подмышки [target]..."))
	else
		user.visible_message(span_warning("[user] stops nuzzling [target]'s armpit..."))
