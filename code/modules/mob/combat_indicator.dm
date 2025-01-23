/mob/living
	/// An overlay image that displays the mob's intent, doesn't apply to NPCs.
	var/static/mutable_appearance/combat_indicator

/mob/living/proc/toggle_combat_indicator()
	if(!combat_indicator)
		combat_indicator = mutable_appearance('icons/mob/roguehud.dmi', "combat_indicator", FLY_LAYER)
		combat_indicator.alpha = 175
	if(!cmode)
		cut_overlay(combat_indicator)
		update_vision_cone()
	else
		add_overlay(combat_indicator)
		update_vision_cone()
	return cmode

/mob/living/toggle_cmode()
	..()
	log_message("[src] has " + (cmode ? "enabled" : "disabled") + " combat mode.", LOG_ATTACK)
	toggle_combat_indicator()

/datum/mob_descriptor/combat_mode
	name = "Combat Mode"
	slot = MOB_DESCRIPTOR_SLOT_NOTHING
	verbage = "looks"
	describe = span_artery("ready for combat!")
	show_obscured = TRUE

/datum/mob_descriptor/combat_mode/can_describe(mob/living/described)
	return described.cmode

/datum/mob_descriptor/combat_mode/can_user_see(mob/living/described, mob/user)
	return TRUE
