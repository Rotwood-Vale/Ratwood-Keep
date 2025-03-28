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
	time = 45 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_JOURNEYMAN

/datum/surgery_step/dwarfification/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE
 	if(!HAS_TRAIT(user, TRAIT_ILLEGAL_SURGEON))
        display_results(user, target, span_notice("You are not skilled enough to perform such surgery."),
            "[user] attempts to cut [target]'s body, but fails.",
            "[user] attempts to cut [target]'s body.")
        return FALSE		

/datum/surgery_step/dwarfification/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to put my tools deeper into [target]'s chest..."),
		span_notice("[user] begins to put their tools under [target]'s chest."),
		span_notice("[user] begins to put their tools under [target]'s chest..."))
	return TRUE

/datum/surgery_step/dwarfification/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/dwarfed))
		display_results(user, target, span_notice("The [target]'s body is changed already."),
			"[user] puts their tools under [target]'s chest.",
			"[user] puts their tools under [target]'s chest.")
		return FALSE
	if(target.has_status_effect(/datum/status_effect/gianted))
		display_results(user, target, span_notice("The [target]'s body is changed already."),
			"[user] puts their tools under [target]'s chest.",
			"[user] puts their tools under [target]'s chest.")
		return FALSE
	else
		display_results(user, target, span_notice("[user] pulls their tool deeper into [target]'s head, causing some damage to their brain."),
			"[user] puts their tools under [target]'s chest.",
			"[user] puts their tools under [target]'s chest.")
		target.apply_status_effect(/datum/status_effect/dwarfed)
	return TRUE

/datum/status_effect/dwarfed
	id = "dwarfed"
	duration = -1 // Permanent until removed
	alert_type = null // No HUD alert, if desired

/datum/status_effect/dwarfed/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.mob_size += 1
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.transform = H.transform.Scale(0.90, 1.25)
		H.transform = H.transform.Translate(0, -(0.25 * 16))
		H.update_transform()
	return TRUE

/datum/status_effect/dwarfed/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.mob_size -= 1
		H.change_stat("constitution", -1)
		H.change_stat("speed", 1)
		H.transform = H.transform.Scale(1.3333, 1.3333) // Reverse the scaling (1 / 0.75 ≈ 1.3333)
		H.transform = H.transform.Translate(0, (0.25 * 16)) // Reverse the translation
		H.update_transform()
	return TRUE
