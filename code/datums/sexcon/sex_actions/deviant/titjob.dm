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
	user.visible_message(span_warning("[user] grabs [target]'s tits and shoves their cock inbetween!"))

/datum/sex_action/titjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s tits."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/titjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] pulls their cock out from inbetween [target]'s tits."))
