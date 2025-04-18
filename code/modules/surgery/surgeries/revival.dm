/datum/surgery/rogue_revival
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/infuse_lux,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/infuse_lux
	name = "infuse lux"
	implements = list(
		/obj/item/reagent_containers/lux = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 10 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_JOURNEYMAN

/datum/surgery_step/infuse_lux/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat < DEAD)
		to_chat(user, "They're not dead!")
		return FALSE

/datum/surgery_step/infuse_lux/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to revive [target]..."),
		span_notice("[user] begins to work lux into [target]'s heart."),
		span_notice("[user] begins to work lux into [target]'s heart."))
	return TRUE

/datum/surgery_step/infuse_lux/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/revive_pq = PQ_GAIN_REVIVE
	if(target.mob_biotypes & MOB_UNDEAD)
		display_results(user, target, span_notice("You cannot infuse life into the undead! The rot must be cured first."),
		"[user] works the lux into [target]'s innards.",
		"[user] works the lux into [target]'s innards.")
		return FALSE
	if(target.has_status_effect(/datum/status_effect/debuff/death_embrace))
		display_results(user, target, span_notice("[target]'s soul is barely intact! They can not be brought back a third time."),
		"[user] works the lux into [target]'s innards.",
		"[user] works the lux into [target]'s innards.")
		return FALSE
	display_results(user, target, span_notice("You succeed in restarting [target]'s hearth with the infusion of lux."),
		"[user] works the lux into [target]'s innards.",
		"[user] works the lux into [target]'s innards.")
	target.adjustOxyLoss(-100)
	if(!target.revive(full_heal = FALSE))
		to_chat(user, span_warning("Nothing happens."))
		return FALSE
	var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
	if(underworld_spirit)
		var/mob/dead/observer/ghost = underworld_spirit.ghostize()
		qdel(underworld_spirit)
		ghost.mind.transfer_to(target, TRUE)
	target.grab_ghost(force = TRUE) // even suicides
	target.emote("breathgasp")
	target.Jitter(100)
	if(target.has_status_effect(/datum/status_effect/debuff/death_weaken))
		target.remove_status_effect(/datum/status_effect/debuff/death_weaken)
		target.apply_status_effect(/datum/status_effect/debuff/death_embrace)	//revived twice by a physician without divine help? Soul nearly torn apart.
	else
		target.apply_status_effect(/datum/status_effect/debuff/death_weaken)	//revived once by a physician without divine help? Soul damaged.
	target.update_body()
	target.visible_message(span_notice("[target] is dragged back from Necra's hold!"), span_green("I awake from the void."))
	qdel(tool)
	if(target.mind)
		target.mind.remove_antag_datum(/datum/antagonist/zombie)
		if(revive_pq && !HAS_TRAIT(target, TRAIT_IWASREVIVED) && user?.ckey)
			adjust_playerquality(revive_pq, user.ckey)
			ADD_TRAIT(target, TRAIT_IWASREVIVED, "[type]")
	return TRUE

/datum/surgery_step/infuse_lux/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	display_results(user, target, span_warning("I screwed up!"),
		span_warning("[user] screws up!"),
		span_notice("[user] works the lux into [target]'s innards."), TRUE)
	return TRUE