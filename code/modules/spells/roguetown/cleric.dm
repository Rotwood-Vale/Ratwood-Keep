/obj/effect/proc_holder/spell/invoked/shepherd
	name = "Shepherd"
	range = 7
	overlay_state = "psy"
	releasedrain = 50
	chargedrain = 0
	chargetime = 0
	charge_max = 10 SECONDS
	sound = 'sound/magic/swap.ogg'
	associated_skill = /datum/skill/magic/holy
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokeholy
	miracle = TRUE
	devotion_cost = -30

/obj/effect/proc_holder/spell/invoked/shepherd/cast(list/targets, mob/living/user)
	..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		var/turf/T = get_turf(target)
		var/turf/H = get_turf(user)
		if(T && H)
			playsound(T, 'sound/magic/swap.ogg', 100)
			user.forceMove(T)
			target.forceMove(H)
			return TRUE
	return FALSE

// Cleric Spell Spawner
/datum/devotion/cleric_holder/proc/grant_spells_priest(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron
	var/list/spelllist = list(A.t0, A.t1, A.t2, A.t3)
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		H.mind.AddSpell(new spell_type)
	level = CLERIC_T3
	update_devotion(300, 900)

/datum/devotion/cleric_holder/proc/grant_spells(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron
	var/list/spelllist = list(A.t0, A.t1)
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		H.mind.AddSpell(new spell_type)
	level = CLERIC_T1

/datum/devotion/cleric_holder/proc/grant_spells_templar(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron
	var/list/spelllist = list(/obj/effect/proc_holder/spell/targeted/churn, A.t0)
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		H.mind.AddSpell(new spell_type)
	level = CLERIC_T0

// General
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
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.visible_message("<span class='danger'>[target] is burned by holy light!</span>", "<span class='userdanger'>I'm burned by holy light!</span>")
			target.adjustFireLoss(50)
			target.Paralyze(30)
			target.fire_act(1,5)
			return TRUE
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
			if(/datum/patron/divine/eora) // RATWOOD CHANGE FROM /datum/patron/inhumen/eora
				target.visible_message("<span class='info'>A heady heat flushes the flesh of [target] and potent scents hit you!</span>", "<span class='notice'>My ills drift away in a rush of narcotic pleasure!</span>")
			if(/datum/patron/inhumen/zizo)
				target.visible_message("<span class='info'>Vital energies are sapped towards [target]!</span>", "<span class='notice'>The life around me pales as I am restored!</span>")
			if(/datum/patron/inhumen/graggar)
				target.visible_message("<span class='info'>Foul fumes billow outward as [target] is restored!</span>", "<span class='notice'>A noxious scent burns my nostrils, but I feel better!</span>")
			if(/datum/patron/inhumen/matthios )
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
			target.adjustBruteLoss(-5)
			target.adjustFireLoss(-5)
		target.adjustToxLoss(-5)
		target.adjustOxyLoss(-5)
		target.blood_volume += 25
		return TRUE
	return FALSE

// Light
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
		target.blood_volume += 100
		return TRUE
	return FALSE

// Limb or organ attachment
/obj/effect/proc_holder/spell/invoked/attach_bodypart
	name = "Bodypart Miracle"
	overlay_state = "limb_attach"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/gore/flesh_eat_03.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS //attaching a limb is pretty intense
	miracle = TRUE
	devotion_cost = -45

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_limb(mob/living/target, mob/living/user)
	var/list/missing_limbs = target.get_missing_limbs()
	if(!length(missing_limbs))
		return
	var/obj/item/bodypart/limb
	//try to get from user's hands first
	for(var/obj/item/bodypart/potential_limb in user?.held_items)
		if(potential_limb.owner || !(potential_limb.body_zone in missing_limbs))
			continue
		limb = potential_limb
	//then target's hands
	if(!limb)
		for(var/obj/item/bodypart/dismembered in target.held_items)
			if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
				continue
			limb = dismembered
	//then finally, 1 tile range around target
	if(!limb)
		for(var/obj/item/bodypart/dismembered in range(1, target))
			if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
				continue
			limb = dismembered
	return limb

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_organ(mob/living/target, mob/living/user)
	var/list/missing_organs = list(
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_TONGUE,
	)
	for(var/missing_organ_slot in missing_organs)
		if(!target.getorganslot(missing_organ_slot))
			continue
		missing_organs -= missing_organ_slot
	if(!length(missing_organs))
		return
	var/obj/item/organ/organ
	//try to get from user's hands first
	for(var/obj/item/organ/potential_organ in user?.held_items)
		if(potential_organ.owner || !(potential_organ.slot in missing_organs))
			continue
		organ = potential_organ
	//then target's hands
	if(!organ)
		for(var/obj/item/organ/dismembered in target.held_items)
			if(dismembered.owner || !(dismembered.slot in missing_organs))
				continue
			organ = dismembered
	//then finally, 1 tile range around target
	if(!organ)
		for(var/obj/item/organ/dismembered in range(1, target))
			if(dismembered.owner || !(dismembered.slot in missing_organs))
				continue
			organ = dismembered
	return organ

/obj/effect/proc_holder/spell/invoked/attach_bodypart/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/target = targets[1]
		var/obj/item/bodypart/limb = get_limb(target, user)
		if(!limb?.attach_limb(target))
			var/obj/item/organ/organ = get_organ(target, user)
			if(!organ?.Insert(target))
				return FALSE
			target.visible_message("<span class='info'>\The [organ] attaches itself to [target]!</span>", \
							"<span class='notice'>\The [organ] attaches itself to me!</span>")
			return TRUE
		target.visible_message("<span class='info'>\The [limb] attaches itself to [target]!</span>", \
							"<span class='notice'>\The [limb] attaches itself to me!</span>")
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	name = "Sacred Flame"
	overlay_state = "sacredflame"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	invocation = "Cleansing flames, kindle!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS
	miracle = TRUE
	devotion_cost = -45

/obj/effect/proc_holder/spell/invoked/sacred_flame_rogue/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/L = targets[1]
		user.visible_message("<font color='yellow'>[user] points at [L]!</font>")
		if(L.anti_magic_check(TRUE, TRUE))
			return FALSE
		L.adjust_fire_stacks(5)
		L.IgniteMob()
		addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living, ExtinguishMob)), 5 SECONDS)
		return TRUE

	// Spell interaction with ignitable objects (burn wooden things, light torches up)
	else if(isobj(targets[1]))
		var/obj/O = targets[1]
		if(O.fire_act())
			user.visible_message("<font color='yellow'>[user] points at [O], igniting it with sacred flames!</font>")
			return TRUE
		else
			to_chat(user, "<span class='warning'>You point at [O], but it fails to catch fire.</span>")
			return FALSE
	return FALSE

/obj/effect/proc_holder/spell/invoked/revive
	name = "Anastasis"
	overlay_state = "revive"
	releasedrain = 90
	chargedrain = 0
	chargetime = 50
	range = 1
	warnie = "sydwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/revive.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 2 MINUTES
	miracle = TRUE
	devotion_cost = -100
	/// Amount of PQ gained for reviving people
	var/revive_pq = 0.25

/obj/effect/proc_holder/spell/invoked/revive/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		testing("revived1")
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		if(target.stat < DEAD)
			to_chat(user, "<span class='warning'>Nothing happens.</span>")
			return FALSE
		if(GLOB.tod == "night")
			to_chat(user, "<span class='warning'>Let there be light.</span>")
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.visible_message("<span class='danger'>[target] is unmade by holy light!</span>", "<span class='userdanger'>I'm unmade by holy light!</span>")
			target.gib()
			return TRUE
		if(!target.revive(full_heal = FALSE))
			to_chat(user, "<span class='warning'>Nothing happens.</span>")
			return FALSE
		testing("revived2")
		var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
		//GET OVER HERE!
		if(underworld_spirit)
			var/mob/dead/observer/ghost = underworld_spirit.ghostize()
			qdel(underworld_spirit)
			ghost.mind.transfer_to(target, TRUE)
		target.grab_ghost(force = TRUE) // even suicides
		target.emote("breathgasp")
		target.Jitter(100)
		target.update_body()
		target.visible_message("<span class='notice'>[target] is revived by holy light!</span>", "<span class='green'>I awake from the void.</span>")
		if(target.mind && revive_pq && !HAS_TRAIT(target, TRAIT_IWASREVIVED) && user?.ckey)
			adjust_playerquality(revive_pq, user.ckey)
			ADD_TRAIT(target, TRAIT_IWASREVIVED, "[type]")
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/revive/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, "<span class='warning'>I need a holy cross.</span>")
		return FALSE
	return TRUE

// Cure rot
/obj/effect/proc_holder/spell/invoked/cure_rot
	name = "Cure Rot"
	overlay_state = "cure_rot"
	releasedrain = 90
	chargedrain = 0
	chargetime = 50
	range = 1
	warnie = "sydwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/revive.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 2 MINUTES
	miracle = TRUE
	devotion_cost = -100
	/// Amount of PQ gained for curing zombos
	var/unzombification_pq = 0.4

/obj/effect/proc_holder/spell/invoked/cure_rot/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		testing("curerot1")
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		var/datum/antagonist/zombie/was_zombie = target.mind?.has_antag_datum(/datum/antagonist/zombie)
		var/has_rot = was_zombie
		if(!has_rot && iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/bodypart as anything in stinky.bodyparts)
				if(bodypart.rotted || bodypart.skeletonized)
					has_rot = TRUE
					break
		if(!has_rot)
			to_chat(user, "<span class='warning'>Nothing happens.</span>")
			return FALSE
		if(GLOB.tod == "night")
			to_chat(user, "<span class='warning'>Let there be light.</span>")
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)
		testing("curerot2")
		if(was_zombie)
			if(was_zombie.become_rotman && prob(5)) //5% chance to NOT become a rotman
				was_zombie.become_rotman = FALSE
			target.mind.remove_antag_datum(/datum/antagonist/zombie)
			target.Unconscious(20 SECONDS)
			target.emote("breathgasp")
			target.Jitter(100)
			if(unzombification_pq && !HAS_TRAIT(target, TRAIT_IWASUNZOMBIFIED) && user?.ckey)
				adjust_playerquality(unzombification_pq, user.ckey)
				ADD_TRAIT(target, TRAIT_IWASUNZOMBIFIED, "[type]")
		var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
		if(rot)
			rot.amount = 0
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/rotty in stinky.bodyparts)
				rotty.rotted = FALSE
				rotty.skeletonized = FALSE
				rotty.update_limb()
				rotty.update_disabled()
		target.update_body()
		if(!HAS_TRAIT(target, TRAIT_ROTMAN))
			target.visible_message("<span class='notice'>The rot leaves [target]'s body!</span>", "<span class='green'>I feel the rot leave my body!</span>")
		else
			target.visible_message("<span class='warning'>The rot fails to leave [target]'s body!</span>", "<span class='warning'>I feel no different...</span>")
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/cure_rot/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, "<span class='warning'>I need a holy cross.</span>")
		return FALSE
	return TRUE

// Necrite
/obj/effect/proc_holder/spell/targeted/burialrite
	name = "Burial Rites"
	range = 5
	overlay_state = "consecrateburial"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Undermaiden grant thee passage forth and spare the trials of the forgotten."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = -15

/obj/effect/proc_holder/spell/targeted/burialrite/cast(list/targets, mob/user = usr)
	. = ..()
	var/success = FALSE
	for(var/obj/structure/closet/crate/coffin/coffin in view(1))
		success = pacify_coffin(coffin, user)
		if(success)
			user.visible_message("My funeral rites have been performed on [coffin]!", "[user] consecrates [coffin]!")
			return
	for(var/obj/structure/closet/dirthole/hole in view(1))
		success = pacify_coffin(hole, user)
		if(success)
			user.visible_message("My funeral rites have been performed on [hole]!", "[user] consecrates [hole]!")
			return
	to_chat(user, "<span class='red'>I failed to perform the rites.</span>")

/obj/effect/proc_holder/spell/targeted/churn
	name = "Churn Undead"
	range = 8
	overlay_state = "necra"
	releasedrain = 30
	charge_max = 30 SECONDS
	max_targets = 0
	cast_without_targets = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Undermaiden rebukes!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = -60

/obj/effect/proc_holder/spell/targeted/churn/cast(list/targets,mob/living/user = usr)
	var/prob2explode = 100
	if(user && user.mind)
		prob2explode = 0
		for(var/i in 1 to user.mind.get_skill_level(/datum/skill/magic/holy))
			prob2explode += 30
	for(var/mob/living/L in targets)
		var/isvampire = FALSE
		var/iszombie = FALSE
		if(L.stat == DEAD)
			continue
		if(L.mind)
			var/datum/antagonist/vampirelord/lesser/V = L.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
			if(V)
				if(!V.disguised)
					isvampire = TRUE
			if(L.mind.has_antag_datum(/datum/antagonist/zombie))
				iszombie = TRUE
			if(L.mind.special_role == "Vampire Lord")
				user.visible_message("<span class='warning'>[L] overpowers being churned!</span>", "<span class='userdanger'>[L] is too strong, I am churned!</span>")
				user.Stun(50)
				user.throw_at(get_ranged_target_turf(user, get_dir(user,L), 7), 7, 1, L, spin = FALSE)
				return
		if((L.mob_biotypes & MOB_UNDEAD) || isvampire || iszombie)
//			L.visible_message("<span class='warning'>[L] is unmade by PSYDON!</span>", "<span class='danger'>I'm unmade by PSYDON!</span>")
			var/vamp_prob = prob2explode
			if(isvampire)
				vamp_prob -= 59
			if(prob(vamp_prob))
				explosion(get_turf(L), light_impact_range = 1, flame_range = 1, smoke = FALSE)
				L.Stun(50)
//				L.throw_at(get_ranged_target_turf(L, get_dir(user,L), 7), 7, 1, L, spin = FALSE)
			else
				L.visible_message("<span class='warning'>[L] resists being churned!</span>", "<span class='userdanger'>I resist being churned!</span>")
	..()
	return TRUE

/obj/effect/proc_holder/spell/targeted/soulspeak
	name = "Speak with Soul"
	range = 5
	overlay_state = "speakwithdead"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "She-Below brooks thee respite, be heard, wanderer."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = -100

/obj/effect/proc_holder/spell/targeted/soulspeak/cast(list/targets,mob/user = usr)
	var/mob/living/carbon/spirit/capturedsoul = null
	var/list/souloptions = list()
	var/list/itemstorestore = list()
	for(var/mob/living/carbon/spirit/S in GLOB.mob_list)
		souloptions += S.livingname
	var/pickedsoul = input(user, "Which soul should I commune with?", "Available Souls") as null|anything in souloptions
	if(!pickedsoul)
		return
	for(var/mob/living/carbon/spirit/P in GLOB.carbon_list)
		if(P.livingname == pickedsoul)
			to_chat(P, "You feel yourself being pulled out of the underworld.")
			sleep(2 SECONDS)
			P.loc = user.loc
			capturedsoul = P
			P.invisibility = INVISIBILITY_OBSERVER
			user.grant_language(/datum/language_holder/abyssal)
			for(var/obj/item/I in P.held_items) // this is big ass, will revisit later
				. |= P.dropItemToGround(I)
				if(istype(I, /obj/item/underworld/coin))
					itemstorestore |= "token"
				if(istype(I, /obj/item/flashlight/lantern/shrunken))
					itemstorestore |= "lamp"
				qdel(I)
			break
		to_chat(P, "[itemstorestore]")
	if(capturedsoul)
		spawn(2 MINUTES)
			to_chat(user, "The soul returns to the underworld.")
			to_chat(capturedsoul, "You feel yourself being pulled back to the underworld.")
			for(var/obj/effect/landmark/underworld/A in GLOB.landmarks_list)
				capturedsoul.loc = A.loc
				capturedsoul.invisibility = initial(capturedsoul.invisibility)
				for(var/I in itemstorestore)
					if(I == "token")
						var/obj/item/underworld/coin/C = new
						capturedsoul.put_in_hands(C)
					if(I == "lamp")
						var/obj/item/flashlight/lantern/shrunken/L = new
						capturedsoul.put_in_hands(L)
			user.remove_language(/datum/language_holder/abyssal)
		to_chat(user, "<font color='blue'>I feel a cold chill run down my spine, a presence has arrived.</font>")
		capturedsoul.Paralyze(1200)

// Druid

/obj/effect/proc_holder/spell/targeted/blesscrop
	name = "Bless Crops"
	range = 5
	overlay_state = "blesscrop"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Treefather commands thee, be fruitful!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = -15

/obj/effect/proc_holder/spell/targeted/blesscrop/cast(list/targets,mob/user = usr)
	visible_message("<FONT COLOR='green'>[usr] blesses the crop with Dendor's Favour!</FONT><BR>")
	for(var/obj/machinery/crop/C in view(5))
		C.growth += 40
		C.update_seed_icon()

//At some point, this spell should Awaken beasts, allowing a ghost to possess them. Not for this PR though.
/obj/effect/proc_holder/spell/targeted/beasttame
	name = "Tame Beast"
	range = 5
	overlay_state = "tamebeast"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Be still and calm, brotherbeast."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = -60

/obj/effect/proc_holder/spell/targeted/beasttame/cast(list/targets,mob/user = usr)
	visible_message("<FONT COLOR='green'>[usr] soothes the beastblood with Dendor's whisper.</FONT><BR>")
	for(var/mob/living/simple_animal/hostile/retaliate/B in oview(2))
		B.aggressive = 0

/obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	name = "Fungal Illumination"
	range = 1
	overlay_state = "blesscrop"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/items/dig_shovel.ogg'
	associated_skill = /datum/skill/magic/holy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	invocation = "Treefather light the way."
	invocation_type = "whisper" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/targeted/conjure_glowshroom/cast(list/targets,mob/user = usr)
	var/turf/T = user.loc
	for(var/X in GLOB.cardinals)
		var/turf/TT = get_step(T, X)
		if(!isclosedturf(TT) && !locate(/obj/structure/glowshroom) in TT)
			new /obj/structure/glowshroom(TT)
	return TRUE

// Noc Spells

/obj/effect/proc_holder/spell/invoked/blindness
    name = "Blindness"
    overlay_state = "blindness"
    req_items = list(/obj/item/clothing/neck/roguetown/psicross)
    releasedrain = 30
    chargedrain = 0
    chargetime = 0
    range = 7
    warnie = "sydwarning"
    movement_interrupt = FALSE
    sound = 'sound/magic/churn.ogg'
    invocation = "Noc blinds thee of thy sins!"
    invocation_type = "shout" //can be none, whisper, emote and shout
    associated_skill = /datum/skill/magic/holy
    antimagic_allowed = TRUE
    charge_max = 15 SECONDS
    devotion_cost = -30

/obj/effect/proc_holder/spell/invoked/blindness/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message("<span class='warning'>[user] points at [target]'s eyes!</span>","<span class='warning'>My eyes are covered in darkness!</span>")		
		target.blind_eyes(2)
	return TRUE

/obj/effect/proc_holder/spell/invoked/invisibility
	name = "Invisibility"
	overlay_state = "invisibility"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	charge_max = 30 SECONDS
	range = 3
	warnie = "sydwarning"
	movement_interrupt = FALSE
	invocation_type = "none"
	sound = 'sound/misc/area.ogg' //This sound doesnt play for some reason. Fix me.
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	devotion_cost = -45

/obj/effect/proc_holder/spell/invoked/invisibility/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message("<span class='warning'>[target] starts to fade into thin air!</span>", "<span class='notice'>You start to become invisible!</span>")
		animate(target, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
		target.mob_timers[MT_INVISIBILITY] = world.time + 15 SECONDS
		addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 15 SECONDS)
		addtimer(CALLBACK(target, TYPE_PROC_REF(/atom/movable, visible_message), "<span class='warning'>[target] fades back into view.</span>", "<span class='notice'>You become visible again.</span>"), 15 SECONDS)
	return FALSE
