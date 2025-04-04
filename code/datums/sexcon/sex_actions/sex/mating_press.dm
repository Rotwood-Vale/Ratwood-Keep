/datum/sex_action/mating_press
	name = "Mating press"
	require_grab = TRUE
	stamina_cost = 1.0
	check_incapacitated = FALSE

/datum/sex_action/mating_press/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_TINY) && !HAS_TRAIT(target, TRAIT_TINY)) //Seelie cannot mating press large targets
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_TINY) && HAS_TRAIT(target, TRAIT_TINY)) //Large target cannot mating press Seelie
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

/datum/sex_action/mating_press/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] pins [target] to the ground, folding their legs over their shoulders and pounding their pussy!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

	//Send target to the ground to be PRESSED
	target.Knockdown(10)

	//Move the user over the target
	if(user.loc != target.loc)
		user.forceMove(target)


/datum/sex_action/mating_press/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] ploughs [target]'s cunt."))
	playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	//Check for bed breaker trait and try pelvis crush
	if(HAS_TRAIT(user, TRAIT_DEATHBYSNUSNU))
		user.sexcon.try_pelvis_crush(target)

	//Cause reciever to lose a LITTLE stamina based on users force level
	target.stamina_add(0.2 * user.sexcon.get_stamina_cost_multiplier())
	
	user.sexcon.perform_sex_action(user, 2, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		//No more guaranteed preggers....
		user.visible_message(span_lovebold("[user] cums deep into [target]'s womb!"))
		user.sexcon.cum_into()
		user.try_impregnate(target)
		user.virginity = FALSE
		target.virginity = FALSE
	//Limp dick sex...
	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 3, FALSE)
	//Goodlover gives more arousal
	if(HAS_TRAIT(user, TRAIT_GOODLOVER))
		user.sexcon.perform_sex_action(target, 7, 10, FALSE)
	//Normal pressing, fully erect!
	else
		user.sexcon.perform_sex_action(target, 4, 10, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/mating_press/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	//Just the default message that vaginal sex has. Not sure how to make it better
	user.visible_message(span_warning("[user] pulls their cock out of [target]'s cunt."))

/datum/sex_action/mating_press/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
