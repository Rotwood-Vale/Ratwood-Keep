/// List of "primordial" wounds so that we don't have to create new wound datums when running checks to see if a wound should be applied
GLOBAL_LIST_INIT(primordial_wounds, init_primordial_wounds())

/proc/init_primordial_wounds()
	var/list/primordial_wounds = list()
	for(var/wound_type in typesof(/datum/wound))
		primordial_wounds[wound_type] = new wound_type()
	return primordial_wounds

/datum/wound
	/// Name of the wound, visible to players when inspecting a limb and such
	var/name = "wound"
	/// Name that appears on check_for_injuries()
	var/check_name

	/// Wounds get sorted from highest severity to lowest severity
	var/severity = WOUND_SEVERITY_LIGHT

	/// Overlay to use when this wound is applied to a carbon mob
	var/mob_overlay = "w1"
	/// Overlay to use when this wound is sewn, and is on a carbon mob
	var/sewn_overlay = ""

	/// Crit message(s) to append when this wound is applied in combat
	var/crit_message
	/// Sound effect(s) to play when this wound is applied
	var/sound_effect

	/// Bodypart that owns this wound, in case it is not a simple one
	var/obj/item/bodypart/bodypart_owner
	/// Mob that owns this wound
	var/mob/living/owner

	/// How many "health points" this wound has, AKA how hard it is to heal
	var/whp = 60
	/// How many "health points" this wound gets after being sewn
	var/sewn_whp = 30
	/// How much this wound bleeds
	var/bleed_rate
	/// Bleed rate when sewn
	var/sewn_bleed_rate = 0.01
	/// Some wounds clot over time, reducing bleeding - This is the rate at which they do so
	var/clotting_rate = 0.01
	/// Clotting rate when sewn
	var/sewn_clotting_rate = 0.02
	/// Clotting will not go below this amount of bleed_rate
	var/clotting_threshold
	/// Clotting will not go below this amount of bleed_rate when sewn
	var/sewn_clotting_threshold = 0
	/// How much pain this wound causes while on a mob
	var/woundpain = 0
	/// Pain this wound causes after being sewn
	var/sewn_woundpain = 0
	/// Sewing progress, because sewing wounds is snowflakey
	var/sew_progress = 0
	/// When sew_progress reaches this, the wound is sewn
	var/sew_threshold = 100

	/// If TRUE, this wound can be sewn
	var/can_sew = FALSE
	/// If TRUE, this wound can be cauterized
	var/can_cauterize = FALSE
	/// If TRUE, this disables limbs
	var/disabling = FALSE
	/// If TRUE, this is a crit wound
	var/critical = FALSE

	/// Amount we heal passively while sleeping
	var/sleep_healing = 1
	/// Amount we heal passively, always
	var/passive_healing = 0
	/// Embed chance if this wound allows embedding
	var/embed_chance = 0

	/// Some wounds make no sense on a dismembered limb and need to go
	var/qdel_on_droplimb = FALSE

	/// If TRUE, this wound can become infected
	var/can_become_infected = FALSE

	/// Cleanliness of the wound
	var/wound_cleanliness = WOUND_CLEANLINESS_DIRTY

	/// Current infection level of the wound
	var/infection_level = 0


/datum/wound/Destroy(force)
	. = ..()
	if(zombie_infection_timer)
		deltimer(zombie_infection_timer)
		zombie_infection_timer = null
	if(werewolf_infection_timer)
		deltimer(werewolf_infection_timer)
		werewolf_infection_timer = null
	if(bodypart_owner)
		remove_from_bodypart()
	else if(owner)
		remove_from_mob()
	bodypart_owner = null
	owner = null

/// Description of this wound returned to the player when a bodypart is examined and such
/datum/wound/proc/get_visible_name(mob/user)
	if(!name)
		return
	var/visible_name = name
	if(is_sewn())
		visible_name += " <span class='green'>(sewn)</span>"
	if(is_clotted())
		visible_name += " <span class='danger'>(clotted)</span>"
	if(has_special_infection())
		visible_name += " <span class='infection'>(INFECTED)</span>"
	return visible_name

/// Description of this wound returned to the player when the bodypart is checked with check_for_injuries()
/datum/wound/proc/get_check_name(mob/user)
	var/visible_name = check_name
	if(visible_name)
		if(has_special_infection())
			visible_name += " <span class='infection'>\[INFECTION\]</span>"
	return visible_name

/// Crit message that should be appended when this wound is applied in combat
/datum/wound/proc/get_crit_message(mob/living/affected, obj/item/bodypart/affected_bodypart)
	if(!length(crit_message))
		return
	var/final_message = pick(crit_message)
	if(affected)
		final_message = replacetext(final_message, "%VICTIM", "[affected.name]")
		final_message = replacetext(final_message, "%P_THEIR", "[affected.p_their()]")
	else
		final_message = replacetext(final_message, "%VICTIM", "victim")
		final_message = replacetext(final_message, "%P_THEIR", "their")
	if(affected_bodypart)
		final_message = replacetext(final_message, "%BODYPART", "[affected_bodypart.name]")
	else
		final_message = replacetext(final_message, "%BODYPART", parse_zone(BODY_ZONE_CHEST))
	if(critical)
		final_message = span_crit("<b>Critical hit!</b> [final_message]")
	return final_message

/// Sound that plays when this wound is applied to a mob
/datum/wound/proc/get_sound_effect(mob/living/affected, obj/item/bodypart/affected_bodypart)
	if(critical && prob(3))
		return 'sound/combat/tf2crit.ogg'
	return pick(sound_effect)

/// Returns whether or not this wound can be applied to a given bodypart
/datum/wound/proc/can_apply_to_bodypart(obj/item/bodypart/affected)
	if(bodypart_owner || owner || QDELETED(affected) || QDELETED(affected.owner))
		return FALSE
	if(affected.status == BODYPART_ROBOTIC)
		return FALSE
	if(!isnull(bleed_rate) && !affected.can_bloody_wound())
		return FALSE
	for(var/datum/wound/other_wound as anything in affected.wounds)
		if(!can_stack_with(other_wound))
			return FALSE
	return TRUE

/// Returns whether or not this wound can be applied while this other wound is present
/datum/wound/proc/can_stack_with(datum/wound/other)
	return TRUE

/// Adds this wound to a given bodypart
/datum/wound/proc/apply_to_bodypart(obj/item/bodypart/affected, silent = FALSE, crit_message = FALSE)
	if(QDELETED(affected) || QDELETED(affected.owner))
		return FALSE
	if(bodypart_owner)
		remove_from_bodypart()
	else if(owner)
		remove_from_mob()
	LAZYADD(affected.wounds, src)
	sortTim(affected.wounds, GLOBAL_PROC_REF(cmp_wound_severity_dsc))
	bodypart_owner = affected
	owner = bodypart_owner.owner
	on_bodypart_gain(affected)
	on_mob_gain(affected.owner)
	if(crit_message)
		var/message = get_crit_message(affected.owner, affected)
		if(message)
			affected.owner.next_attack_msg += " [message]"
	if(!silent)
		var/sounding = get_sound_effect(affected.owner, affected)
		if(sounding)
			playsound(affected.owner, sounding, 100, vary = FALSE)
	RegisterSignal(affected.owner, COMSIG_COMPONENT_CLEAN_ACT, PROC_REF(clean_infection))
	return TRUE

/// Effects when a wound is gained on a bodypart
/datum/wound/proc/on_bodypart_gain(obj/item/bodypart/affected)
	if(bleed_rate && affected.bandage)
		affected.bandage_expire() //new bleeding wounds always expire bandages, fuck you
	if(disabling)
		affected.update_disabled()

/// Removes this wound from a given bodypart
/datum/wound/proc/remove_from_bodypart()
	if(!bodypart_owner)
		return FALSE
	var/obj/item/bodypart/was_bodypart = bodypart_owner
	var/mob/living/was_owner = owner
	LAZYREMOVE(bodypart_owner.wounds, src)
	bodypart_owner = null
	owner = null
	on_bodypart_loss(was_bodypart)
	on_mob_loss(was_owner)
	return TRUE

/// Effects when a wound is lost on a bodypart
/datum/wound/proc/on_bodypart_loss(obj/item/bodypart/affected)
	if(disabling)
		affected.update_disabled()

/// Returns whether or not this wound can be applied to a given mob
/datum/wound/proc/can_apply_to_mob(mob/living/affected)
	if(bodypart_owner || owner || QDELETED(affected) || !HAS_TRAIT(affected, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	for(var/datum/wound/other_wound as anything in affected.simple_wounds)
		if(!can_stack_with(other_wound))
			return FALSE
	return TRUE

/// Adds this wound to a given mob
/datum/wound/proc/apply_to_mob(mob/living/affected, silent = FALSE, crit_message = FALSE)
	if(QDELETED(affected) || !HAS_TRAIT(affected, TRAIT_SIMPLE_WOUNDS))
		return FALSE
	if(bodypart_owner)
		remove_from_bodypart()
	else if(owner)
		remove_from_mob()
	LAZYADD(affected.simple_wounds, src)
	sortTim(affected.simple_wounds, GLOBAL_PROC_REF(cmp_wound_severity_dsc))
	owner = affected
	on_mob_gain(affected)
	if(crit_message)
		var/message = get_crit_message(affected)
		if(message)
			affected.next_attack_msg += " [message]"
	if(!silent)
		var/sounding = get_sound_effect(affected)
		if(sounding)
			playsound(affected, sounding, 100, vary = FALSE)
	return TRUE

/// Effects when this wound is applied to a given mob
/datum/wound/proc/on_mob_gain(mob/living/affected)
	if(mob_overlay)
		affected.update_damage_overlays()
	if(zombie_infection_timer)
		deltimer(zombie_infection_timer)
		zombie_infection_timer = null
		zombie_infect_attempt()
	if(werewolf_infection_timer)
		deltimer(werewolf_infection_timer)
		werewolf_infection_timer = null
		werewolf_infect_attempt()

/// Removes this wound from a given, simpler than adding to a bodypart - No extra effects
/datum/wound/proc/remove_from_mob()
	if(!owner)
		return FALSE
	var/mob/was_owner = owner
	LAZYREMOVE(owner.simple_wounds, src)
	owner = null
	on_mob_loss(was_owner)
	return TRUE

/// Effects when this wound is removed from a given mob
/datum/wound/proc/on_mob_loss(mob/living/affected)
	UnregisterSignal(affected, COMSIG_COMPONENT_CLEAN_ACT)
	if(mob_overlay)
		affected.update_damage_overlays()
	if(zombie_infection_timer)
		deltimer(zombie_infection_timer)

/// Called on handle_wounds(), on the life() proc
/datum/wound/proc/on_life()
	if(whp <= 0)
		return FALSE
	if(!isnull(clotting_threshold) && clotting_rate && (bleed_rate > clotting_threshold))
		bleed_rate = max(clotting_threshold, bleed_rate - clotting_rate)
	if(can_become_infected && owner.mind) //We don't want to track infection for NPCs
		process_infection()
	if(passive_healing && infection_level <= WOUND_INFECTION_INFECTED)
		heal_wound(passive_healing)
	return TRUE

/// Called on handle_wounds(), on the life() proc
/datum/wound/proc/on_death()
	return
	


/// Heals this wound by the given amount, and deletes it if it's healed completely
/datum/wound/proc/heal_wound(heal_amount, iteration = 0)
	// Wound cannot be healed normally, whp is null
	if(isnull(whp))
		return 0
	var/amount_healed = min(whp, round(heal_amount, DAMAGE_PRECISION))
	if(can_become_infected && infection_level > WOUND_INFECTION_INFECTED) 
		amount_healed *= 0.5 //Infected wounds heal slower from all sources.
	whp -= amount_healed
	if(whp <= 0)
		bleed_rate = 0
		woundpain = 0
		can_sew = FALSE
		can_cauterize = FALSE
		disabling = FALSE
		critical = FALSE
		mob_overlay = ""
		if(!should_persist())
			if(bodypart_owner)
				remove_from_bodypart(src)
			else if(owner)
				remove_from_mob(src)
			else if (iteration < 4)
				addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/wound, heal_wound)), wait = 10 SECONDS, 0, iteration + 1)
			else
				qdel(src)
	return amount_healed

/// Sews the wound up, changing its properties to the sewn ones
/datum/wound/proc/sew_wound()
	if(!can_sew)
		return FALSE
	var/old_overlay = mob_overlay
	mob_overlay = sewn_overlay
	bleed_rate = sewn_bleed_rate
	clotting_rate = sewn_clotting_rate
	clotting_threshold = sewn_clotting_threshold
	woundpain = sewn_woundpain
	whp = min(whp, sewn_whp)
	disabling = FALSE
	can_sew = FALSE
	sleep_healing = max(sleep_healing, 1)
	passive_healing = max(passive_healing, 1)
	if(mob_overlay != old_overlay)
		owner?.update_damage_overlays()
	return TRUE

/// Cauterizes the wound
/datum/wound/proc/cauterize_wound()
	if(!can_cauterize)
		return FALSE
	if(!isnull(clotting_threshold) && bleed_rate > clotting_threshold)
		bleed_rate = clotting_threshold
	heal_wound(40)
	return TRUE

/// Checks if this wound is sewn
/datum/wound/proc/is_sewn()
	return (sew_progress >= sew_threshold)

/// Checks if this wound is clotted
/datum/wound/proc/is_clotted()
	return !isnull(clotting_threshold) && (bleed_rate <= clotting_threshold)

/// Checks if this wound has a special infection (zombie or werewolf)
/datum/wound/proc/has_special_infection()
	return (zombie_infection_timer || werewolf_infection_timer)

/// Some wounds cannot go away naturally
/datum/wound/proc/should_persist()
	if(has_special_infection())
		return TRUE
	return FALSE

/// Returns whether or not this wound should embed a weapon
/proc/should_embed_weapon(datum/wound/wound_or_boolean, obj/item/weapon)
	if(!istype(wound_or_boolean))
		return FALSE
	if(weapon && !can_embed(weapon))
		return FALSE
	return prob(wound_or_boolean.embed_chance)


/////////////////////////////////////////////////////////////////////////////////

///////////////////INFECTION HANDLING LOGIC//////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////


///Called from the life() proc and responsible for handling non-werewolf, non-deadite wound infections
/datum/wound/proc/process_infection()
	if(infection_level > WOUND_INFECTION_INFECTED && owner != null)
		owner.adjustToxLoss(0.1)
		if(infection_level > WOUND_INFECTION_GANGRENOUS && !bodypart_owner.rotted)
			bodypart_owner.rotted = TRUE
	infection_level =  clamp((infection_level + wound_cleanliness*0.1), 0, 300)
	return

/datum/wound/proc/treat_infection(var/treatment_effectiveness = 25)
	var/amount_treated = min(infection_level, round(treatment_effectiveness, DAMAGE_PRECISION))
	infection_level = clamp((infection_level - treatment_effectiveness), 0, 300)
	return amount_treated

///Do cleaning behavior for the wound. An argument of TRUE will set it to sterile.
/datum/wound/proc/clean_infection(var/sterilize = FALSE)
	wound_cleanliness = sterilize ? WOUND_CLEANLINESS_STERILE : WOUND_CLEANLINESS_CLEAN

///Do filthifying behavior for the wound
/datum/wound/proc/filthify_wound()
	if(!can_become_infected)
		return
	if(wound_cleanliness != WOUND_CLEANLINESS_FILTHY)
		wound_cleanliness = WOUND_CLEANLINESS_FILTHY
		if(owner)
			owner.adjustToxLoss(0.2) //It's possible to have a LOT of wounds, so we want to be careful how much of this we deal
