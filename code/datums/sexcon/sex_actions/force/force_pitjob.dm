/datum/sex_action/force_pitjob
	name = "Use their armpit to get off"
	check_same_tile = FALSE
	require_grab = TRUE
	stamina_cost = 1.0

/datum/sex_action/force_pitjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_TINY)) //Fairy is too small and weak to force this
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return
	return TRUE

/datum/sex_action/force_pitjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_L_ARM) && !get_location_accessible(target, BODY_ZONE_R_ARM))
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return
	return TRUE

/datum/sex_action/force_pitjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] grabs [target]'s arm and shoves their cock under it!"))

/datum/sex_action/force_pitjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s armpit."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/force_pitjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] pulls their cock out from [target]'s armpit."))
