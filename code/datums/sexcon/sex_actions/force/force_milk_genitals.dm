/datum/sex_action/force_milk_genitals
	name = "Forcibly milk cock"
	check_same_tile = FALSE

/datum/sex_action/force_milk_genitals/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/force_milk_genitals/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/holding = user.get_active_held_item()
	if(istype(holding, /obj/item/reagent_containers/glass) != TRUE)
		return FALSE
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/force_milk_genitals/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(usr?.client?.prefs?.be_russian)
		user.visible_message(span_warning("[user] начинает дрочить член [target] над [user.get_active_held_item()]!"))
	else
		user.visible_message(span_warning("[user] starts masturbating [target] into [user.get_active_held_item()]..."))
	

/datum/sex_action/force_milk_genitals/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		var/chosen_verb
		if(usr?.client?.prefs?.be_russian)
			chosen_verb = pick(list("активно мастурбирует член [target] над [user.get_active_held_item()]", "массирует член [target] над [user.get_active_held_item()]", "дрочит член [target] над [user.get_active_held_item()]"))
		else
			chosen_verb = pick(list("pleasures cock [target] over [user.get_active_held_item()]", "sensually massages cock [target] over [user.get_active_held_item()]", "masturbates [target] cock over [user.get_active_held_item()]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] [chosen_verb]..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_cock_milking(user)

/datum/sex_action/force_milk_genitals/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(usr?.client?.prefs?.be_russian)
		user.visible_message(span_warning("[user] прекращает дрочить член [target] над контейнером."))
	else
		user.visible_message(span_warning("[user] stops jerking [target] into the container."))

/datum/sex_action/force_milk_genitals/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
