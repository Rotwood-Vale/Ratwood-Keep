/datum/surgery/soul_extract
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/soul_extract,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/soul_extract
	name = "soul_extract"
	implements = list(
		TOOL_CURSED = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 30 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_JOURNEYMAN
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'

/datum/surgery_step/soul_extract/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE

/datum/surgery_step/soul_extract/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to start to put my tools deeper into [target]'s head.."),
		span_notice("[user] begins to put their tools under  [target]'s eye."),
		span_notice("[user] begins to put their tools under [target]'s eye.."))
	return TRUE

/datum/surgery_step/soul_extract/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/debuff/soul_stolen))
		display_results(user, target, span_notice("The [target]'s light is already taken..."),
		"[user] puts their tools under [target]'s eye.",
		"[user] puts their tools under  [target]'s eye.")
		return FALSE
	if(target.HAS_TRAIT(TRAIT_KOBOLD))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/kobold(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_DRAKIAN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/drakian(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_HALFKIN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/halfkin(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_WILDKIN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/wildkin(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_VERMINVOLK))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/verminvolk(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_AXIAN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/axian(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_HUMAN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/human(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_TIEFLING))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/tiefling(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_SEELIE))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/seelie(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_HALFORC))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/halforc(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_HUMAN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/human(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_HALFELF))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/halfelf(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_AASIMAR))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/aasimar(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_ELF))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/elf(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_DROW))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/drow(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_GOBLIN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/goblin(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_SISSEAN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/sissean(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_HALFORC))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/halforc(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_LUPIAN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/lupian(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_FLUVIAN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/fluvian(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_TABAXI))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/tabaxi(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
	return TRUE
		if(target.HAS_TRAIT(TRAIT_VULPKANIN))
		display_results(user, target, span_notice(" [user] pulls part of [target]'s soul out..."),
			"[user] puts their tools under  [target]'s eye.",
			"[user] puts their tools under  [target]'s eye.")
		new /obj/item/soul/vulpkanin(target.loc)
		target.apply_status_effect(/datum/status_effect/debuff/soul_stolen)
