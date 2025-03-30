/datum/surgery/undofication
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/undofication,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/undofication
	name = "Undofication"
	implements = list(
		TOOL_SCALPEL = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 30 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_JOURNEYMAN
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'

/datum/surgery_step/undofication/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_RITUALIST)) //not to bloat traits you are a good guy
        display_results(user, target, span_notice("You are not skilled enough to perform such surgery."),
            "[user] attempts to cut [target]'s body, but fails.",
            "[user] attempts to cut [target]'s body.")
        return FALSE		

/datum/surgery_step/undofication/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to start to put my tools deeper into [target]'s chest.."),
		span_notice("[user] begins to put their tools under  [target]'s chest."),
		span_notice("[user] begins to put their tools under [target]'s chest.."))
	return TRUE

/datum/surgery_step/undofication/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/debuff/dwarfed))
		display_results(user, target, span_notice("The [target]'s body changes..."),
		"[user] puts their tools into [target]'s chest.",
		"[user] puts their tools into  [target]'s chest.")
		target.apply_status_effect(/datum/status_effect/debuff/dwarfed)
	if(target.has_status_effect(/datum/status_effect/debuff/gianted))
		display_results(user, target, span_notice("The [target]'s body changes..."),
		"[user] puts their tools into [target]'s chest.",
		"[user] puts their tools into  [target]'s chest.")
		target.apply_status_effect(/datum/status_effect/debuff/gianted)
	else
		display_results(user, target, span_notice(" [user] pulls their tool deeper into [target]'s chest. But for whats purpose?"),
			"[user] puts their tools into  [target]'s eye.",
			"[user] puts their tools into  [target]'s eye.")
	return TRUE
