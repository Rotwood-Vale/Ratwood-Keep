/datum/sex_action/thighjob
	name = "Jerk them off with thighs"

/datum/sex_action/thighjob/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)	
		name = "Член. Подрочить бёдрами."

/datum/sex_action/thighjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/thighjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/thighjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY))) //thighjob giver is Seelie, recipient is normal
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] хватается за талию [target] и начинает дрочить член своим животом!"))
		else
			user.visible_message(span_warning("[user] grabs [target]'s thighs and shoves their cock inbetween!"))
	else if(!(HAS_TRAIT(user, TRAIT_TINY)) && HAS_TRAIT(target, TRAIT_TINY))	//recipient is Seelie, thighjob giver is normal
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] хватается за плечи [target] и начинает дрочить маленький член бёдрами!"))
		else
			user.visible_message(span_warning("[user] holds [target] against their thigh, pressing their cock against it..."))
	else	//Normal, obviously
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] хватается за талию [target] и начинает дрочить член своими бёдрами!"))
		else
			user.visible_message(span_warning("[user] moves their thighs between [target]'s cock..."))

/datum/sex_action/thighjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY))) //thighjob giver is Seelie, recipient is normal
			if(user.client.prefs.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] дрочит член своим животом [target]!"))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs their legs and groin along [target]'s cock..."))
		else if(!(HAS_TRAIT(user, TRAIT_TINY)) && HAS_TRAIT(target, TRAIT_TINY))	//recipient is Seelie, thighjob giver is normal
			if(user.client.prefs.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] дрочит крохотный член своими бёдрами [target]!"))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] moves [target] up and down their thigh, rubbing their cock..."))
		else	//Normal, obviously
			if(user.client.prefs.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] дрочит член [target] своими бёдрами!"))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] jerks [target]'s cock with their thighs..."))
		
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(target, user)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/thighjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(user.client.prefs.be_russian)
		user.visible_message(span_warning("[user] встаёт с [target]..."))
	else
		user.visible_message(span_warning("[user] stops jerking [target] off with their thighs..."))

/datum/sex_action/thighjob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
