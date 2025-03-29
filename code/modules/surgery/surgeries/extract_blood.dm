/datum/surgery/extractblood
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/extractblood,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)

/datum/surgery_step/extractblood
	name = "Extract blood"
	implements = list(
		TOOL_SCALPEL = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 30 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED |
	skill_min = SKILL_LEVEL_JOURNEYMAN
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'

/datum/surgery_step/extractblood/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
 	if(!HAS_TRAIT(user, TRAIT_ILLEGAL_SURGEON))
        display_results(user, target, span_notice("You are not skilled enough to perform such surgery."),
            "[user] attempts to cut [target]'s body, but fails.",
            "[user] attempts to cut [target]'s body.")
        return FALSE	

/datum/surgery_step/extractblood/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to start to put my tools deeper into [target]'s chest.."),
		span_notice("[user] begins to put their tools into [target]'s chest."),
		span_notice("[user] begins to put their tools into [target]'s chest.."))
	return TRUE

/datum/surgery_step/extractblood/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/debuff/bloodtaken))
		display_results(user, target, span_notice("The [target]'s blood is already taken. Let them rest to gather some magic inside them."),
		"[user] puts their tools under [target]'s skin.",
		"[user] puts their tools under  [target]'s skin.")
		return FALSE
	else
		display_results(user, target, span_notice(" [user] pulls their tool deeper into [target]'s body, extracting some blood."),
			"[user] puts their tools under  [target]'s skin.",
			"[user] puts their tools under  [target]'s skin.")
		target.apply_status_effect(/datum/status_effect/debuff/bloodtaken)
		new /obj/item/reagent_containers/shunned_blood(target.loc)
	return TRUE
