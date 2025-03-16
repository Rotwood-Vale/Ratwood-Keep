/datum/surgery/dwarfication
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/dwarfication,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/dwarfication
	name = "dwarfication"
	implements = list(
		TOOL_SCALPEL = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 1 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_JOURNEYMAN

/datum/surgery_step/dwarfication/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE

/datum/surgery_step/dwarfication/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to start to put my tools deeper into [target]'s head.."),
		span_notice("[user] begins to put their tools under  [target]'s eye."),
		span_notice("[user] begins to put their tools under [target]'s eye.."))
	return TRUE

/datum/surgery/dwarfication
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/dwarfication,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/dwarfification
	name = "dwarfication"
	implements = list(
		TOOL_SCALPEL = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 1 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_JOURNEYMAN

/datum/surgery_step/dwarfification/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE

/datum/surgery_step/dwarfification/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to put my tools deeper into [target]'s head..."),
		span_notice("[user] begins to put their tools under [target]'s eye."),
		span_notice("[user] begins to put their tools under [target]'s eye..."))
	return TRUE

/datum/surgery_step/dwarfification/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/gianten))
		display_results(user, target, span_notice("The [target]'s brain is damaged in such a manner already."),
			"[user] puts their tools under [target]'s eye.",
			"[user] puts their tools under [target]'s eye.")
		return FALSE
	else
		display_results(user, target, span_notice("[user] pulls their tool deeper into [target]'s head, causing some damage to their brain."),
			"[user] puts their tools under [target]'s eye.",
			"[user] puts their tools under [target]'s eye.")
		target.apply_status_effect(/datum/status_effect/gianten)
	return TRUE

// Define the status effect
/datum/status_effect/gianten
	id = "gianten"
	duration = -1 // Permanent until removed
	alert_type = null // No HUD alert, if desired

/datum/status_effect/gianten/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.mob_size += 1
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.transform = H.transform.Scale(0.90, 1.25)
		H.transform = H.transform.Translate(0, -(0.25 * 16))
		H.update_transform()
	return TRUE

/datum/status_effect/gianten/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.mob_size -= 1
		H.change_stat("constitution", -1)
		H.change_stat("speed", 1)
		H.transform = H.transform.Scale(1.3333, 1.3333) // Reverse the scaling (1 / 0.75 ≈ 1.3333)
		H.transform = H.transform.Translate(0, (0.25 * 16)) // Reverse the translation
		H.update_transform()
	return TRUE
