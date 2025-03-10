/datum/surgery/graggar_ritual
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/saw,
		/datum/surgery_step/graggar,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/graggar_ritual
	name = "Graggar's ritual"
	implements = list(
		TOOL_CUT= 10,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 30 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_NOVICE
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'

/datum/surgery_step/graggar_ritual/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to look [target]'s body for a proper slice.."),
		span_notice("[user] chops [target]'s body."),
		span_notice("[user] chops [target]'s body."))
	return TRUE

/datum/surgery_step/graggar_ritual/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(target.has_status_effect(/datum/status_effect/debuff/alreadygraggared))
		display_results(user, target, span_notice("The [target]'s most delicious parts are already taken!!!"),
		"[user] chops [target]'s body.",
		"[user] chops  [target]'s body.")
		return FALSE
	else
	if(target.HAS_TRAIT(TRAIT_MAA))
		display_results(user, target, span_notice(" [user] starts to cut some meat from [target]'s spine!."),
			"[user] cuts a slice from [target]'s body.",
			"[user] cuts a slice from  [target]'s body.")
		new /obj/item/meat/maa(target.loc)	
		target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
	return 
	else
	if(target.HAS_TRAIT(TRAIT_TEMPLAR))
		display_results(user, target, span_notice(" [user] starts to cut some meat from [target]'s spine!."),
			"[user] cuts a slice from [target]'s body.",
			"[user] cuts a slice from  [target]'s body.")
		new /obj/item/meat/templar(target.loc)	
		target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
	return 
	else
	if(target.HAS_TRAIT(TRAIT_WATCHMAN))
		display_results(user, target, span_notice(" [user] starts to cut some meat from [target]'s spine!."),
			"[user] cuts a slice from [target]'s body.",
			"[user] cuts a slice from  [target]'s body.")
		new /obj/item/meat/watchman(target.loc)	
		target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
	return 
	if(target.HAS_TRAIT(TRAIT_VANGUARD))
		display_results(user, target, span_notice(" [user] starts to cut some meat from [target]'s spine!."),
			"[user] cuts a slice from [target]'s body.",
			"[user] cuts a slice from  [target]'s body.")
		new /obj/item/meat/vanguard(target.loc)	
		target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
	return 
	if(target.HAS_TRAIT(TRAIT_KNIGHT))
		display_results(user, target, span_notice(" [user] starts to cut some meat from [target]'s spine!."),
			"[user] cuts a slice from [target]'s body.",
			"[user] cuts a slice from  [target]'s body.")
		new /obj/item/meat/knight(target.loc)	
		target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
	return 
	if(target.HAS_TRAIT(TRAIT_PREIST))
		display_results(user, target, span_notice(" [user] starts to cut some meat from [target]'s spine!."),
			"[user] cuts a slice from [target]'s body.",
			"[user] cuts a slice from  [target]'s body.")
		new /obj/item/meat/preist(target.loc)	
		target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
	return 
	if(target.HAS_TRAIT(TRAIT_ROYAL_FAMILY))
		display_results(user, target, span_notice(" [user] starts to cut some meat from [target]'s spine!."),
			"[user] cuts a slice from [target]'s body.",
			"[user] cuts a slice from  [target]'s body.")
		new /obj/item/meat/royal(target.loc)	
		target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
	return 
