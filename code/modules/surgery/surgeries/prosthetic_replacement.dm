/datum/surgery/prosthetic_replacement
	name = "Prosthetic replacement"
	steps = list(
		/datum/surgery_step/add_prosthetic,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	requires_bodypart = FALSE //need a missing limb
	requires_missing_bodypart = TRUE
	requires_bodypart_type = NONE

/datum/surgery_step/add_prosthetic
	name = "Implant limb"
	implements = list(
		/obj/item/bodypart = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	time = 3 SECONDS
	requires_bodypart = FALSE //need a missing limb
	requires_missing_bodypart = TRUE
	requires_bodypart_type = NONE
	skill_min = SKILL_LEVEL_EXPERT
	skill_median = SKILL_LEVEL_MASTER

/datum/surgery_step/add_prosthetic/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/obj/item/bodypart/bodypart = tool
	if(ismonkey(target) && bodypart.animal_origin != MONKEY_BODYPART)
		to_chat(user, span_warning("[bodypart] doesn't match the patient's morphology."))
		return FALSE
	else if(bodypart.animal_origin)
		to_chat(user, span_warning("[bodypart] doesn't match the patient's morphology."))
		return FALSE

	if(target_zone != bodypart.body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
		to_chat(user, span_warning("[tool] isn't the right type for [parse_zone(target_zone)]."))
		return FALSE

	display_results(user, target, span_notice("I begin to replace [target]'s [parse_zone(target_zone)] with [tool]..."),
		span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)] with [tool]."),
		span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)]."))
	return TRUE

/datum/surgery_step/add_prosthetic/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/obj/item/bodypart/bodypart = tool
	if(bodypart.attach_limb(target) && bodypart.attach_wound)
		bodypart.add_wound(bodypart.attach_wound)
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/target_head = human_target.get_bodypart(BODY_ZONE_HEAD)
		if(target_head && human_target.stat < DEAD) // If the head is reattached and the body is rotten, it'll kickstart the rot timer again and revive them as a deadite immediately.
			var/found_rotten = FALSE
			for(var/obj/item/bodypart/limb in human_target.bodyparts)
				if(!found_rotten && limb.rotted)
					found_rotten = TRUE
			
			if(found_rotten) // Body is already rotted.
				var/datum/antagonist/zombie/zomble = human_target.mind?.has_antag_datum(/datum/antagonist/zombie)
				if(zomble)
					addtimer(CALLBACK(zomble, TYPE_PROC_REF(/datum/antagonist/zombie, wake_zombie)), 5 SECONDS)
				else if(can_death_zombify(src))
					var/datum/component/rot/rot = human_target.GetComponent(/datum/component/rot)
					if(!rot) // In the case the rot component deleted itself because there was no head. Then add a new one that will automatically raise them as a deadite.
						LoadComponent(human_target.rot_type)
						rot = human_target.GetComponent(/datum/component/rot)
						rot.amount = 20 MINUTES
			else
				LoadComponent(target.rot_type)
	display_results(user, target, span_notice("I succeed transplanting [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] successfully transplants [target]'s [parse_zone(target_zone)] with [tool]!"),
		span_notice("[user] successfully transplants [target]'s [parse_zone(target_zone)]!"))
	return TRUE
