/datum/surgery/lobotomy
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/lobotomy,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)

/datum/surgery_step/lobotomy
	name = "Lobotomy"
	implements = list(
		TOOL_SCALPEL = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 100 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED
	skill_min = SKILL_LEVEL_MASTER

/datum/surgery_step/lobotomy/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE

/datum/surgery_step/lobotomy/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to start to put my tools deeper into [target]'s head.."),
		span_notice("[user] begins to put their tools under  [target]'s eye."),
		span_notice("[user] begins to put their tools under [target]'s eye.."))
	return TRUE

/datum/surgery_step/lobotomy/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/debuff/lobotomized))
		display_results(user, target, span_notice("The [target]'s brain is damaged in such a manner already."),
			"[user] puts their tools under [target]'s eye.",
			"[user] puts their tools under [target]'s eye.")
		return FALSE
	else
		display_results(user, target, span_notice("[user] pulls their tool deeper into [target]'s head, causing some damage to their brain."),
			"[user] puts their tools under [target]'s eye.",
			"[user] puts their tools under [target]'s eye.")
		target.apply_status_effect(/datum/status_effect/debuff/lobotomized)
		return TRUE

