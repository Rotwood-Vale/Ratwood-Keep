/datum/sex_action/anal_ride_sex
	name = "Ride them anally"
	stamina_cost = 1.0
	aggro_grab_instead_same_tile = FALSE
	check_incapacitated = FALSE

/datum/sex_action/anal_ride_sex/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY))) //Dissabled for Seelie riding non-Seelie
		return FALSE
	return TRUE

/datum/sex_action/anal_ride_sex/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/anal_ride_sex/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(target, TRAIT_TINY) && !(HAS_TRAIT(user, TRAIT_TINY)))
		if(usr?.client?.prefs?.be_russian)
			user.visible_message(span_warning("[user] садится на [target], понимая, что последующие попытки получить удовольствие от крохотного члена бесполезны!"))
		else
			user.visible_message(span_warning("[user] gets on top of [target] trying and failing to ride the tiny cock with their butt!"))
	else
		if(usr?.client?.prefs?.be_russian)
			user.visible_message(span_warning("[user] седлает член [target] своей задницей!"))
		else
			user.visible_message(span_warning("[user] gets on top of [target] and begins riding them with their butt!"))
		playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/anal_ride_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(HAS_TRAIT(target, TRAIT_TINY) && !(HAS_TRAIT(user, TRAIT_TINY)))
			if(usr?.client?.prefs?.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] прыгает на [target], безуспешно пытаясь сесть на член."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] tries to ride [target], unsuccessfully."))
			do_thrust_animate(user, target)
			return	//Return because male seelie cannot succesfully penetrate a large humen target

		if(HAS_TRAIT(user, TRAIT_DEATHBYSNUSNU))
			user.sexcon.try_pelvis_crush(target)
			
		if(usr?.client?.prefs?.be_russian)
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] скачет на члене [target]."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rides [target]."))
	playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)
	if(target.sexcon.considered_limp())
		user.sexcon.perform_sex_action(user, 1.2, 4, TRUE)
	else
		user.sexcon.perform_sex_action(user, 2.4, 9, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 2, 4, FALSE)
	if(target.sexcon.check_active_ejaculation())
		if(usr?.client?.prefs?.be_russian)
			target.visible_message(span_lovebold("[target] кончает в задницу [user]!"))
		else
			target.visible_message(span_lovebold("[target] cums into [user]'s butt!"))
		target.sexcon.cum_into()
		target.virginity = FALSE

/datum/sex_action/anal_ride_sex/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(usr?.client?.prefs?.be_russian)
		user.visible_message(span_warning("[user] встаёт с [target]."))
	else
		user.visible_message(span_warning("[user] gets off [target]."))

/datum/sex_action/anal_ride_sex/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
