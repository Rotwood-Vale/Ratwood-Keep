/datum/sex_action/suck_nipples
	name = "Suck their nipples"
	check_same_tile = FALSE

/datum/sex_action/suck_nipples/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/suck_nipples/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_CHEST))
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/suck_nipples/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts sucking [target]'s nipples..."))

/datum/sex_action/suck_nipples/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] sucks [target]'s nipples..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(target, 1, 3, TRUE)
	target.sexcon.handle_passive_ejaculation()

	var/milk_to_add = min(max(target.getorganslot(ORGAN_SLOT_BREASTS).breast_size, 1), target.getorganslot(ORGAN_SLOT_BREASTS).milk_stored)
	if(target.getorganslot(ORGAN_SLOT_BREASTS).lactating && milk_to_add > 0 && prob(25))
		user.reagents.add_reagent(/datum/reagent/consumable/breastmilk, milk_to_add)
		target.getorganslot(ORGAN_SLOT_BREASTS).milk_stored -= milk_to_add
		to_chat(user, span_notice("I can taste milk."))
		to_chat(target, span_notice("I can feel milk leak from my buds."))

/datum/sex_action/suck_nipples/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops sucking [target]'s nipples ..."))

/datum/sex_action/suck_nipples/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
