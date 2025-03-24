/datum/sex_action/mating_press
	name = "Plow their cunt"
	require_grab = TRUE
	stamina_cost = 1.0
	check_incapacitated = FALSE

/datum/sex_action/mating_press/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_TINY))//you cannot mating press the fairy
		return FALSE
	return TRUE

/datum/sex_action/mating_press/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!user.sexcon.can_use_penis())
		return
	return TRUE

/datum/sex_action/mating_press/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] plows [target]'s cunt."))
	playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	if(HAS_TRAIT(user, TRAIT_DEATHBYSNUSNU))
		user.sexcon.try_pelvis_crush(target)
	
	user.sexcon.perform_sex_action(user, 2, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_lovebold("[user] impregnates [target]!"))
		user.sexcon.cum_into()
		user.impregnate(target)
		user.virginity = FALSE
		target.virginity = FALSE
	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 3, FALSE)
	if(HAS_TRAIT(user, TRAIT_GOODLOVER))
		user.sexcon.perform_sex_action(target, 7, 15, FALSE)
	else
		user.sexcon.perform_sex_action(target, 4, 7, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/mating_press/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] pulls their cock out of [target]'s cunt."))

/datum/sex_action/mating_press/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
