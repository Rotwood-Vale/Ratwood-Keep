/obj/effect/proc_holder/spell/invoked/diagnose/secular
	name = "Secular Diagnosis"
	overlay_state = "diagnose"
	range = 1
	associated_skill = /datum/skill/misc/treatment
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/docheal  /////// miricle on 3x cooldown from normal
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Rapid Treatment"
	overlay_state = "doc"
	range = 1
	include_user = TRUE
	sound = 'sound/gore/flesh_eat_03.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/docheallsser  /////// lesser miricle, granted by enchanted rings
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Close Wounds"
	overlay_state = "doc"
	range = 1
	include_user = TRUE
	sound = 'sound/gore/flesh_eat_03.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/stable // sets ox lose to 0 knocks out some toxin, brings blood levels to safe. epi stabalizes ox lose, antihol purges booze, water and iron slowly restores blood.
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Stabilising Syringe"
	overlay_state = "stable"
	range = 1
	sound = 'modular/Smoker/sound/inject.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	include_user = TRUE
	charge_max = 5 MINUTES
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/purge // Purges all reagents and clears all toxin damage while lowering blood levels and hitting with brute
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Purifying Blood Draw"
	overlay_state = "snek"
	range = 1
	include_user = TRUE
	sound = 'sound/combat/newstuck.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 5 MINUTES
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/debride // delays rotting
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Tissue Debridement"
	overlay_state = "unrot"
	range = 1
	include_user = FALSE
	sound = 'sound/combat/newstuck.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 2 MINUTES
	miracle = FALSE
	devotion_cost = 0
	/// Amount of PQ gained for curing zombos
	var/unzombification_pq = PQ_GAIN_UNZOMBIFY


/obj/effect/proc_holder/spell/targeted/debride/cast(list/targets, mob/living/user)

	if(!isliving(targets[1]))
		revert_cast()
		return FALSE

	var/mob/living/target = targets[1]

	if(target == user)
		revert_cast()
		return FALSE

	// If, for whatever reason, someone manages to capture a vampire with (somehow) rot??? This prevents them from losing their undead biotype.
	if(target.mind?.has_antag_datum(/datum/antagonist/vampire) || target.mind?.has_antag_datum(/datum/antagonist/vampire/lesser) || target.mind?.has_antag_datum(/datum/antagonist/vampirelord))
		to_chat(user, span_warning("It's of an incurable evil, I can't."))
		revert_cast()
		return FALSE

	var/datum/antagonist/zombie/was_zombie = target.mind?.has_antag_datum(/datum/antagonist/zombie)

	if(was_zombie)
		revert_cast()
		return FALSE

	var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)

	if(rot)
		rot.amount -= 500


	target.visible_message(span_notice("Some of the rot leaves [target]'s body, yet more will soon fester!"), span_green("I feel some of the rot leave my body, yet more will soon fester!"))

	return TRUE

/obj/effect/proc_holder/spell/targeted/debride/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		revert_cast()
		return FALSE
	var/found = null
	for(var/obj/structure/bed/rogue/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need to lay them on a bed"))
		revert_cast()
		return FALSE
	return TRUE


/obj/effect/proc_holder/spell/targeted/docheal/cast(list/targets, mob/living/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_green("[user] tends to [target]'s wounds."), span_notice("I feel better already."))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(50, 50))
					C.update_damage_overlays()
				if(affecting.heal_wounds(50))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-50)
			target.adjustFireLoss(-50)
		target.adjustToxLoss(-50)
		target.adjustOxyLoss(-50)
		target.blood_volume += BLOOD_VOLUME_SURVIVE
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/targeted/docheallsser/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		target.visible_message(span_green("[user] tends to [target]'s wounds."), span_notice("I feel better already."))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(25, 25))
					C.update_damage_overlays()
				if(affecting.heal_wounds(25))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-25)
			target.adjustFireLoss(-25)
		target.adjustToxLoss(-25)
		target.adjustOxyLoss(-25)
		target.blood_volume += BLOOD_VOLUME_SURVIVE/2
		return TRUE
	return FALSE


/obj/effect/proc_holder/spell/targeted/stable/cast(list/targets, mob/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/ramount = 10
		var/rid = /datum/reagent/medicine/stimu
		target.reagents.add_reagent(rid, ramount)
		target.visible_message(span_green("[user] stabs [target]'s chest with a syringe."), span_notice("My grip on life tightens!"))
		target.setOxyLoss(-100)
		target.adjustToxLoss(-50)
		target.emote("rage")
		target.blood_volume += BLOOD_VOLUME_SURVIVE
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/targeted/purge/cast(list/targets, mob/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/obj/item/bodypart/BPA = target.get_bodypart(user.zone_selected)
		if(!BPA)
			to_chat(user, span_warning("They're missing that part!"))
			revert_cast()
			return FALSE
		BPA.add_wound(/datum/wound/artery/)
		target.visible_message(span_danger("[user] drains the reagents and toxins from [target]."))
		target.adjustToxLoss(-999)
		target.reagents.remove_all_type(/datum/reagent, 9999)
		target.emote("scream")
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/targeted/purge/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		revert_cast()
		return FALSE
	var/found = null
	for(var/obj/structure/bed/rogue/S in oview(2, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need to lay them on a bed."))
		revert_cast()
		return FALSE
	return TRUE

/obj/item/organ/liver/weak
	name = "weakened liver"
	desc = "This seems hardly functional."

/datum/status_effect/debuff/wliver
	id = "wliver"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/wliver
	effectedstats = list("strength" = -3, "constitution" = -3, "endurance" = -3, "speed" = -3)

/atom/movable/screen/alert/status_effect/debuff/wliver
	name = "Weak Liver"
	desc = "I feel drained and sluggish. I'm feeling abdominal pain from my liver."

/obj/item/organ/liver/weak/Insert(mob/living/carbon/M)
	..()
	if(M)
		M.apply_status_effect(/datum/status_effect/debuff/wliver)

/obj/item/organ/liver/weak/Remove(mob/living/carbon/M, special = 0)
	..()
	if(M.has_status_effect(/datum/status_effect/debuff/wliver))
		M.remove_status_effect(/datum/status_effect/debuff/wliver)
