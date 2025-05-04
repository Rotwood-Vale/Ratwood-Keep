/datum/surgery/memory_wipe
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/memory_wipe,
		/datum/surgery_step/cauterize,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)

/datum/surgery_step/memory_wipe
	name = "memory wipe"
	implements = list(
		TOOL_SCALPEL = 80,
		TOOL_SAW = 60,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 4 SECONDS
	repeating = FALSE
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED
	skill_min = SKILL_LEVEL_MASTER

/datum/surgery_step/memory_wipe/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target,
		span_notice("You begin the memory excision process on [target]..."),
		"[user] begins carefully slicing near [target]'s hippocampus.",
		"[user] starts operating inside [target]'s skull.")
	return TRUE

/datum/surgery_step/memory_wipe/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/intent/intent)
	// Удаляем трейты — если есть
	REMOVE_TRAIT(target, TRAIT_BANDITCAMP, TRAIT_GENERIC)
	REMOVE_TRAIT(target, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	REMOVE_TRAIT(target, TRAIT_VAMPMANSION, TRAIT_GENERIC)

	target.adjustCloneLoss(20)
	target.emote("groans")
	target.say("Wha... where was I...? It’s all... gone...")

	display_results(user, target,
		span_warning("[target] twitches as fragments of memory vanish into the void."),
		"[user] completes a memory purge on [target].",
		"[user] fiddles with [target]'s head.")
	return TRUE

/datum/surgery_step/memory_wipe/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	target.adjustCloneLoss(20)
	target.emote("groans")

	display_results(user, target,
		span_warning("Your incision goes wide... no memory is lost, but pain floods in."),
		"[user] misses the mark in the brain... only pain results.",
		"[user] misjudges their slice. [target] suffers for nothing.")
	return TRUE
