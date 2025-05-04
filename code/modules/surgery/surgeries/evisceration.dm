/datum/surgery/evisceration
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/evisceration,
		/datum/surgery_step/cauterize,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/evisceration
	name = "evisceration"
	implements = list(
		TOOL_SCALPEL = 80,
		TOOL_SAW = 60,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 60 SECONDS
	repeating = TRUE
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED
	skill_min = SKILL_LEVEL_MASTER

/datum/surgery_step/clone_damage_step/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream") 
	target.adjustCloneLoss(5)
	display_results(user, target,
		span_warning("You drive the blade deeper, tearing flesh and spirit alike."),
		"[user] carves into [target] with grim determination, leaving behind a trail of ruin.",
		"[user] twists the tool cruelly inside [target]'s body, invoking screams of agony.")
	return TRUE

/datum/surgery_step/clone_damage_step/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	display_results(user, target,
		span_notice("Your hand falters; the wound is shallow and meaningless."),
		"[user] slips, barely scratching [target]'s flesh.",
		"[user] hesitates, the pain inflicted too minor to matter.")
	return TRUE
