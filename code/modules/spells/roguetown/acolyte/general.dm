// Lesser miracle
/obj/effect/proc_holder/spell/invoked/lesser_heal
	name = "Lesser Miracle"
	overlay_state = "lesserheal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	devotion_cost = -25

/obj/effect/proc_holder/spell/invoked/lesser_heal/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(user.patron.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) //positive energy harms the undead
			target.visible_message("<span class='danger'>[target] is burned by holy light!</span>", "<span class='userdanger'>I'm burned by holy light!</span>")
			target.adjustFireLoss(50)
			target.Paralyze(30)
			target.fire_act(1,5)
			return TRUE
		//this if chain is stupid, replace with variables on /datum/patron when possible?
		switch(user.patron.type)
			if(/datum/patron/old_god)
				target.visible_message("<span class='info'>A strange stirring feeling pours from [target]!</span>", "<span class='notice'>Sentimental thoughts drive away my pains!</span>")
			if(/datum/patron/divine/astrata)
				target.visible_message("<span class='info'>A wreath of gentle light passes over [target]!</span>", "<span class='notice'>I'm bathed in holy light!</span>")
			if(/datum/patron/divine/noc)
				target.visible_message("<span class='info'>A shroud of soft moonlight falls upon [target]!</span>", "<span class='notice'>I'm shrouded in gentle moonlight!</span>")
			if(/datum/patron/divine/dendor)
				target.visible_message("<span class='info'>A rush of primal energy spirals about [target]!</span>", "<span class='notice'>I'm infused with primal energies!</span>")
			if(/datum/patron/divine/abyssor)
				target.visible_message("<span class='info'>A mist of salt-scented vapour settles on [target]!</span>", "<span class='notice'>I'm invigorated by healing vapours!</span>")
			if(/datum/patron/divine/ravox)
				target.visible_message("<span class='info'>An air of righteous defiance rises near [target]!</span>", "<span class='notice'>I'm filled with an urge to fight on!</span>")
			if(/datum/patron/divine/necra)
				target.visible_message("<span class='info'>A sense of quiet respite radiates from [target]!</span>", "<span class='notice'>I feel the Undermaiden's gaze turn from me for now!</span>")
			if(/datum/patron/divine/xylix)
				target.visible_message("<span class='info'>A fugue seems to manifest briefly across [target]!</span>", "<span class='notice'>My wounds vanish as if they had never been there! </span>")
			if(/datum/patron/divine/pestra)
				target.visible_message("<span class='info'>A aura of clinical care encompasses [target]!</span>", "<span class='notice'>I'm sewn back together by sacred medicine!</span>")
			if(/datum/patron/divine/malum)
				target.visible_message("<span class='info'>A tempering heat is discharged out of [target]!</span>", "<span class='notice'>I feel the heat of a forge soothing my pains!</span>")
			if(/datum/patron/inhumen/eora)
				target.visible_message("<span class='info'>A heady heat flushes the flesh of [target] and potent scents hit you!</span>", "<span class='notice'>My ills drift away in a rush of narcotic pleasure!</span>")
			if(/datum/patron/inhumen/zizo)
				target.visible_message("<span class='info'>Vital energies are sapped towards [target]!</span>", "<span class='notice'>The life around me pales as I am restored!</span>")
			if(/datum/patron/inhumen/graggar)
				target.visible_message("<span class='info'>Foul fumes billow outward as [target] is restored!</span>", "<span class='notice'>A noxious scent burns my nostrils, but I feel better!</span>")
			if(/datum/patron/inhumen/matthios)
				target.visible_message("<span class='info'>A wreath of strange light passes over [target]!</span>", "<span class='notice'>I'm bathed in strange holy light?</span>")
			if(/datum/patron/godless)
				target.visible_message("<span class='info'>Without any particular cause or reason, [target] is healed!</span>", "<span class='notice'>My wounds close without cause.</span>")
			else
				target.visible_message("<span class='info'>A choral sound comes from above and [target] is healed!</span>", "<span class='notice'>I am bathed in healing choral hymns!</span>")
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(20, 20))
					C.update_damage_overlays()
				if(affecting.heal_wounds(20))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-20)
			target.adjustFireLoss(-20)
		target.adjustToxLoss(-20)
		target.adjustOxyLoss(-20)
		target.blood_volume += BLOOD_VOLUME_SURVIVE/4
		return TRUE
	return FALSE

// Miracle
/obj/effect/proc_holder/spell/invoked/heal
	name = "Miracle"
	overlay_state = "astrata"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
//	chargedloop = /datum/looping_sound/invokeholy
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 20 SECONDS
	miracle = TRUE
	devotion_cost = -45

/obj/effect/proc_holder/spell/invoked/heal/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.visible_message("<span class='danger'>[target] is burned by holy light!</span>", "<span class='userdanger'>I'm burned by holy light!</span>")
			target.adjustFireLoss(100)
			target.Paralyze(50)
			target.fire_act(1,5)
			return TRUE
		target.visible_message("<span class='info'>A wreath of gentle light passes over [target]!</span>", "<span class='notice'>I'm bathed in holy light!</span>")
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
