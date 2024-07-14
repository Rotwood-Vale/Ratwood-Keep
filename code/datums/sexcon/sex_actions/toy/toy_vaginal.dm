/datum/sex_action/toy_vagina
	name = "Pleasure cunt with toy"

/datum/sex_action/toy_vagina/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_vagina/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_vagina/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	if(check_dildo_silver(user))
		var/mob/living/carbon/human/H = user
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		if(ishuman(H))
			if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser) || H.mind.has_antag_datum(/datum/antagonist/vampire))
				to_chat(H, span_userdanger("This will HURT."))
			if(V_lord)
				if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
					to_chat(H, span_userdanger("This will sting a little."))
			if(W && W.transformed == TRUE)
				to_chat(H, span_userdanger("This will HURT."))
	user.visible_message(span_warning("[user] shoves \the [dildo] in her cunt..."))

/datum/sex_action/toy_vagina/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks her cunt with \the [dildo]."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	if(check_dildo_silver(user))
		dildoburn(user)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/toy_vagina/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] pulls \the [dildo] from her cunt."))

/datum/sex_action/toy_vagina/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
