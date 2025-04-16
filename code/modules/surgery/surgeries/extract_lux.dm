/datum/surgery/extract_lux
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/extract_lux,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/extract_lux
	name = "extract lux"
	implements = list(
		TOOL_SCALPEL = 80,
		TOOL_SHARP = 60,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 8 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_APPRENTICE

/datum/surgery_step/extract_lux/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE

/datum/surgery_step/extract_lux/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to scrape lux from [target]'s heart..."),
		span_notice("[user] begins to scrape lux from [target]'s heart."),
		span_notice("[user] begins to scrape lux from [target]'s heart."))
	return TRUE

/datum/surgery_step/extract_lux/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/debuff/death_weaken))
		display_results(user, target, span_notice("You cannot draw lux from [target]; they have none left to give."),
		"[user] extracts lux from [target]'s innards.",
		"[user] extracts lux from [target]'s innards.")
		return FALSE
	else
		display_results(user, target, span_notice("You extract a single dose of lux from [target]'s heart."),
			"[user] extracts lux from [target]'s innards.",
			"[user] extracts lux from [target]'s innards.")
		new /obj/item/reagent_containers/lux(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/death_weaken)
	return TRUE