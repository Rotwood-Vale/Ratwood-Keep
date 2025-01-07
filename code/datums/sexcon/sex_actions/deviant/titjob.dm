/datum/sex_action/titjob
	name = "Use their tits to get off"

/datum/sex_action/titjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return
	return TRUE

/datum/sex_action/titjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_CHEST))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/titjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(target, TRAIT_TINY) && !(HAS_TRAIT(user, TRAIT_TINY)))
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] прижимает головку члена к груди [target]!"))
		else
			user.visible_message(span_warning("[user] grabs [target] and starts rubbing their body against his cock!"))
	else
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] прижимает член к груди [target]!"))
		else
			user.visible_message(span_warning("[user] grabs [target]'s tits and shoves his cock inbetween!"))

/datum/sex_action/titjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(HAS_TRAIT(target, TRAIT_TINY) && !(HAS_TRAIT(user, TRAIT_TINY)))
			if(user.client.prefs.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] трётся головкой члена меж грудей [target]."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs their cock agains [target]'s body."))
		else
			if(user.client.prefs.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] трахает сиськи [target]."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s tits."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	if(user.sexcon.check_active_ejaculation())
		if(user.client.prefs.be_russian)
			user.visible_message(span_lovebold("[user] кончает на сиськи [target]!"))
		else
			user.visible_message(span_lovebold("[user] cums on [target]'s tits!"))

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/titjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(target, TRAIT_TINY) && !(HAS_TRAIT(user, TRAIT_TINY)))
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] убирает головку члена от груди [target]..."))
		else
			user.visible_message(span_warning("[user] pulls his cock away from [target]'s body."))
	else
		if(user.client.prefs.be_russian)
			user.visible_message(span_warning("[user] убирает член от груди [target]..."))
		else
			user.visible_message(span_warning("[user] pulls his cock out from inbetween [target]'s tits."))
