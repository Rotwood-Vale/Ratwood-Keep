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
		/obj/item/organ_storage = 80,
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
	if(istype(tool, /obj/item/organ_storage))
		if(!length(tool.contents))
			to_chat(user, span_warning("There is nothing inside [tool]!"))
			return FALSE
		tool = tool.contents[1]
		if(!isbodypart(tool))
			to_chat(user, span_warning("[tool] cannot be attached!"))
			return FALSE

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
	if(istype(tool, /obj/item/organ_storage))
		tool.icon_state = initial(tool.icon_state)
		tool.desc = initial(tool.desc)
		tool.cut_overlays()
		tool = tool.contents[1]
		if(!isbodypart(tool))
			return FALSE

	var/obj/item/bodypart/bodypart = tool
	if(bodypart.attach_limb(target) && bodypart.attach_wound)
		bodypart.add_wound(bodypart.attach_wound)
	display_results(user, target, span_notice("I succeed transplanting [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] successfully transplants [target]'s [parse_zone(target_zone)] with [tool]!"),
		span_notice("[user] successfully transplants [target]'s [parse_zone(target_zone)]!"))
	return TRUE
