/datum/surgery/giantication
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/giantication,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/giantication
	name = "Giantication"
	implements = list(
		TOOL_SCALPEL = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 1 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_JOURNEYMAN

/datum/surgery_step/giantication/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		to_chat(user, "They're dead!")
		return FALSE

/datum/surgery_step/giantication/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to start to put my tools deeper into [target]'s chest.."),
		span_notice("[user] begins to put their tools under  [target]'s eye."),
		span_notice("[user] begins to put their tools under [target]'s eye.."))
	return TRUE

/datum/surgery/giantication
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/giantication,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/dwarfification
	name = "giantication"
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
	display_results(user, target, span_notice("I begin to put my tools deeper into [target]'s chest..."),
		span_notice("[user] begins to put their tools under [target]'s chest."),
		span_notice("[user] begins to put their tools under [target]'s chest..."))
	return TRUE

/datum/surgery_step/dwarfification/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	target.emote("painscream")
	if(target.has_status_effect(/datum/status_effect/gianted))
		display_results(user, target, span_notice("The [target]'s body has been changed already..."),
			"[user] puts their tools under [target]'s skin.",
			"[user] puts their tools under [target]'s skin.")
		return FALSE
	else
		display_results(user, target, span_notice("[user] pulls their tool deeper into [target]'s body, making it to change..."),
			"[user] puts their tools under [target]'s skin.",
			"[user] puts their tools under [target]'s skin.")
		target.apply_status_effect(/datum/status_effect/gianted)
	return TRUE

/datum/status_effect/gianted
	id = "gianted"
	duration = -1 // perma perma 
	alert_type = null // no alerts or huds or another debuff on your screen 

/datum/status_effect/gianted/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.mob_size += 1
		H.change_stat("constitution", -1)
		H.change_stat("speed", 1)
		H.transform = H.transform.Scale(1.33, 1.33)
		H.transform = H.transform.Translate(0, -(0.25 * 16))
		H.update_transform()
	return TRUE

/datum/status_effect/gianted/on_remove() //that will not work to return dwarf or kobold or seelie back god forgive us for our sins
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.mob_size -= 1
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.transform = H.transform.Scale(0.7519, 0.7519) // dude 1 / 1.33 ≈ 0.7519 
		H.transform = H.transform.Translate(0, (0.25 * 16)) // reverse their position backkk 
		H.update_transform()
	return TRUE
