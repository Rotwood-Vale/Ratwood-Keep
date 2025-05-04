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
	time = 100 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_MASTER

/datum/surgery_step/dwarfication/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE

/datum/surgery_step/dwarfication/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to put my tools deeper into [target]'s chest..."),
		span_notice("[user] begins to put their tools under [target]'s chest."),
		span_notice("[user] begins to put their tools under [target]'s chest..."))
	return TRUE

/datum/surgery_step/dwarfication/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/dwarfen))
		display_results(user, target, span_notice("The [target]'s body is damaged in such a manner already."),
			"[user] puts their tools under [target]'s chest.",
			"[user] puts their tools under [target]'s chest.")
		return FALSE
	if(target.has_status_effect(/datum/status_effect/gianted))
		display_results(user, target, span_notice("The [target]'s body has been changed already..."),
			"[user] puts their tools under [target]'s skin.",
			"[user] puts their tools under [target]'s skin.")
		return FALSE
	if(HAS_TRAIT(target, TRAIT_TINY)) //no seelies plz
		display_results(user, target, span_notice("The [target]'s body has been changed already..."),
			"[user] puts their tools under [target]'s skin.",
			"[user] puts their tools under [target]'s skin.")
		return FALSE
	else
		display_results(user, target, span_notice("[user] pulls their tool deeper into [target]'s body, making it to change..."),
			"[user] puts their tools under [target]'s skin.",
			"[user] puts their tools under [target]'s skin.")
		target.apply_status_effect(/datum/status_effect/dwarfen)
	return TRUE

// Define the status effect
/datum/status_effect/dwarfen
	id = "dwarfen"
	duration = -1 // Permanent until removed
	alert_type = null // No HUD alert, if desired

/datum/status_effect/dwarfen/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.mob_size += 1
		H.change_stat("constitution", 2)
		H.change_stat("speed", -2)
		H.transform = H.transform.Scale(1.4, 0.7)
		H.transform = H.transform.Translate(0, -(0.3 * 16))
		H.update_transform()
	return TRUE

/datum/status_effect/dwarfen/on_remove() //WILL NOT MAKE THEM NORMAL!!!
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.mob_size -= 1
		H.change_stat("constitution", -1)
		H.change_stat("speed", 1)
		H.transform = H.transform.Scale(1, 1.1111,)
		H.transform = H.transform.Translate(0, 0.3 * 16)
		H.update_transform()
	return TRUE

