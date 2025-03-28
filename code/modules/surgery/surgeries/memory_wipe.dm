/datum/surgery/cleanhideoutmemory
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/cleanhideoutmemory,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/cleanhideoutmemory
	name = "Clean out hideout memories"
	implements = list(
		TOOL_SCALPEL = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 30 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_JOURNEYMAN
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'

/datum/surgery_step/cleanhideoutmemory/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE
/datum/surgery_step/extractblood/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
 	if(!HAS_TRAIT(user, TRAIT_ILLEGAL_SURGEON))
        display_results(user, target, span_notice("You are not skilled enough to perform such surgery."),
            "[user] attempts to cut [target]'s body, but fails.",
            "[user] attempts to cut [target]'s body.")
        return FALSE			

/datum/surgery_step/cleanhideoutmemory/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to start to put my tools deeper into [target]'s head.."),
		span_notice("[user] begins to put their tools under  [target]'s eye."),
		span_notice("[user] begins to put their tools under [target]'s eye.."))
	return TRUE

/datum/surgery_step/cleanhideoutmemory/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
    target.emote("painscream")

    var/list/traits_to_remove = list(TRAIT_GOBLINCAMP, TRAIT_VAMPIREHIDEOUT, TRAIT_BANDITCAMP)
    var/removed_any = FALSE

    for(var/trait in traits_to_remove)
        if(HAS_TRAIT(target, trait))
            REMOVE_TRAIT(target, trait)
            removed_any = TRUE

    if(removed_any)
        display_results(user, target, span_warning("You cause some braindamage to [target]'s brain..."),
            "[user] pushes their tools deeper into [target]'s head.",
            "[user] pushes their tools deeper into [target]'s head.")
        return TRUE
    else
        display_results(user, target, span_notice("You cause some braindamage to [target]'s brain..."),
            "[user] pushes their tools deeper into [target]'s head.",
            "[user] pushes their tools deeper into [target]'s head.")
        return FALSE
