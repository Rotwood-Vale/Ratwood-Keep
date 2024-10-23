/// doctor "spells"


/obj/effect/proc_holder/spell/invoked/diagnose/secular
	name = "Secular Diagnosis"
	overlay_state = "diagnose"
	range = 1
	associated_skill = /datum/skill/misc/medicine
	miracle = FALSE
	devotion_cost = 0 

/obj/effect/proc_holder/spell/targeted/docheal  /////// miricle on 3x cooldown from normal
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Rapid Treatment"
	overlay_state = "doc"
	range = 1
	sound = 'sound/gore/flesh_eat_03.ogg'
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/stable // sets ox lose to 0 knocks out some toxin, brings blood levels to safe. epi stabalizes ox lose, antihol purges booze, water and iron slowly restores blood.
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Stabalizing Syringe"
	overlay_state = "stable"
	range = 1
	sound = 'modular/Smoker/sound/inject.ogg'
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 5 MINUTES
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/purge // Purges all reagents and clears all toxin damage while lowering blood levels and hitting with brute
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Purifying Blood Draw"
	overlay_state = "snek"
	req_items = list(/obj/item/rogueweapon/huntingknife)
	range = 1
	sound = 'sound/combat/newstuck.ogg'
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 5 MINUTES
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/docheal/cast(list/targets, mob/living/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_info("[user] tends to [target]'s wounds with the focus and purpose."), span_notice("I feel better already."))
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
	return FALSE

/obj/effect/proc_holder/spell/targeted/stable/cast(list/targets, mob/user) 
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/rid = list(/datum/reagent/medicine/epinephrine = 15, /datum/reagent/medicine/antihol = 15, /datum/reagent/water = 45, /datum/reagent/iron = 30)
		target.reagents.add_reagent(rid)
		target.visible_message(span_info("[user] stabs [target]'s chest with a syringe, causing there breathing to return to normal."), span_notice("I feel my breathing steady and grip on life tighten."))
		target.setOxyLoss(0, 0)
		target.adjustToxLoss(-50)
		target.emote("breathgasp")
		target.blood_volume += BLOOD_VOLUME_SURVIVE
		return TRUE
	return FALSE


/obj/effect/proc_holder/spell/targeted/purge/cast(list/targets, mob/user) 
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/obj/item/bodypart/BPA = target.get_bodypart(BODY_ZONE_R_ARM)
		BPA.add_wound(/datum/wound/artery/)
		target.visible_message(span_info("[user] slashes [target]'s artery open letting the toxins and other impurities bleed and drain from them. they might want to stitch that soon."), span_notice("I've been cut by [user] I feel the toxins leaving my body with each heart beat. im getting light headed...."))
		target.adjustToxLoss(-999)
		target.adjustBruteLoss(30, BRUTE, BPA)
		target.reagents.remove_all_type(/datum/reagent, 9999)
		target.emote("scream")
		return TRUE
	return FALSE


