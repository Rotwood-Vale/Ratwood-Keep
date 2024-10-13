/datum/sex_action/milk_container
	name = "Milk self into container"

/datum/sex_action/milk_container/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/milk_container/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/holding = user.get_active_held_item()
	if(istype(holding, /obj/item/reagent_containers/glass) != TRUE)
		return FALSE
	if(user != target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_CHEST))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/milk_container/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts milking themself into [user.get_active_held_item()]..."))

/datum/sex_action/milk_container/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/chosen_verb = pick(list("milks themself over [user.get_active_held_item()]", "squeezes their breasts over [user.get_active_held_item()]"))
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] [chosen_verb]..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 0, TRUE)

	user.sexcon.handle_container_milk()

/datum/sex_action/milk_container/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops milking themself into the container."))

/datum/sex_action/milk_container/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
// WIP, UNFINISHED, I JUST WANT PEOPLE TO SEE. if you want to help feel free to review and add code or whatever. i am a slopcoder so i need it <3
