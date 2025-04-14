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
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/sacred_flame_rogue/cast(list/targets, mob/user = usr)
	. = ..()
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
			to_chat(user, span_warning("You point at [O], but it fails to catch fire."))
			return FALSE
	revert_cast()
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
	devotion_cost = 80
	/// Amount of PQ gained for reviving people
	var/revive_pq = PQ_GAIN_REVIVE

/obj/effect/proc_holder/spell/invoked/revive/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		testing("revived1")
		var/mob/living/target = targets[1]
		if(target == user)
			revert_cast()
			return FALSE
		if(GLOB.tod == "night")
			to_chat(user, span_warning("Let there be light."))
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.visible_message(span_danger("[target] is unmade by holy light!"), span_userdanger("I'm unmade by holy light!"))
			target.gib()
			return TRUE
		if(target.stat < DEAD || target.has_status_effect(/datum/status_effect/debuff/death_weaken))
			to_chat(user, span_warning("Nothing happens."))
			revert_cast()
			return FALSE
		if(HAS_TRAIT(target, TRAIT_EXCOMMUNICATED))
			to_chat(user, span_warning("Necra will not allow them to return back."))
			revert_cast()
			return FALSE
		if(HAS_TRAIT(target, TRAIT_ASTRATARISEN))
			to_chat(user, span_warning("This mortal form can not take more of Astrata's light."))
			revert_cast()
			return FALSE
		testing("revived2")
		var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
		//GET OVER HERE!
		if(underworld_spirit)
			var/mob/dead/observer/ghost = underworld_spirit.ghostize()
			qdel(underworld_spirit)
			ghost.mind.transfer_to(target, TRUE)
		target.grab_ghost(force = TRUE) // even suicides
		target.revive(admin_revive = TRUE)
		target.adjustOxyLoss(-100)
		target.emote("breathgasp")
		target.Jitter(100)
		if(isseelie(target))
			var/mob/living/carbon/human/fairy_target = target
			fairy_target.set_heartattack(FALSE)
			var/obj/item/organ/wings/Wing = fairy_target.getorganslot(ORGAN_SLOT_WINGS)
			if(Wing == null)
				var/wing_type = fairy_target.dna.species.organs[ORGAN_SLOT_WINGS]
				var/obj/item/organ/wings/seelie/new_wings = new wing_type()
				new_wings.Insert(fairy_target)
		target.update_body()
		target.visible_message(span_notice("[target] is revived by holy light!"), span_green("I awake from the void."))
		ADD_TRAIT(target, TRAIT_ASTRATARISEN, "[type]")	//A mortal frame can only take so much of astrata's light.
		if(target.mind)
			if(revive_pq && !HAS_TRAIT(target, TRAIT_IWASREVIVED) && user?.ckey)
				adjust_playerquality(revive_pq, user.ckey)
				ADD_TRAIT(target, TRAIT_IWASREVIVED, "[type]")
		target.mind.remove_antag_datum(/datum/antagonist/zombie)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/revive/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need a holy cross."))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/targeted/smite	//Smite targets all excommunicated and apostates in view, providing a chance to stun based on holy level, and sets them on fire w/ a debuff effect applied.
	name = "Smite Unfaithful"				//Smite is twice as strong during the dae, and will even target undead/vampires during the day.
	range = 8
	overlay_state = "astrata"
	releasedrain = 30
	charge_max = 30 SECONDS
	max_targets = 0
	cast_without_targets = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/ahh2.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Firstborn smites thee!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 30
	var/smitelevel = 1
	var/prob2smite = 0

/obj/effect/proc_holder/spell/targeted/smite/cast(list/targets, mob/living/user = usr)
	prob2smite = 0

	if (GLOB.tod == "dawn"|| GLOB.tod == "day"||GLOB.tod == "dusk")
		smitelevel = 2
	else
		smitelevel = 1
	if(user && user.mind)
		for(var/i in 1 to user.mind.get_skill_level(/datum/skill/magic/holy))
			prob2smite += 20
	for(var/mob/living/L in targets)
		if(L.stat == DEAD)
			continue
		if(HAS_TRAIT(L, TRAIT_EXCOMMUNICATED) || L.has_status_effect(/datum/status_effect/debuff/apostasy))
			user.visible_message(span_warning("[usr] brings forth the Firstborn's power and smites [L]!"))
			smite_effect(L)
			..()
			return TRUE
		if(L.mind)
			var/datum/antagonist/vampirelord/lesser/V = L.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
			if(V)
				if(V.disguised || smitelevel != 2) // Being disguised makes you immune to being smited. If you can hide from astrata's rays in dae, you can hide from the smite.
					continue
				user.visible_message(span_warning("[user] brings forth the Firstborn's power and smites [L]!"))
				smite_effect(V)
				return

			if(L.mind.special_role == "Vampire Lord" && smitelevel == 2)
				var/datum/antagonist/vampirelord/V_lord = L.mind.has_antag_datum(/datum/antagonist/vampirelord/)
				if(V_lord.vamplevel < 4)
					user.visible_message(span_warning("[usr] brings forth the Firstborn's power and smites [L]!"))
					smite_effect(L)
					return
				else
					user.visible_message(span_warning("[L] rebukes [usr]'s smite!"))
					user.throw_at(get_ranged_target_turf(user, get_dir(user,L), 7), 7, 1, L, spin = FALSE)
			var/datum/antagonist/zombie/Z =L.mind.has_antag_datum(/datum/antagonist/zombie)
			if(Z)
				user.visible_message(span_warning("[usr] brings forth the Firstborn's power and smites [L]!"))
				smite_effect(L)
				return
		if(L.mob_biotypes & MOB_UNDEAD && smitelevel == 2)
			user.visible_message(span_warning("[usr] brings forth the Firstborn's power and smites [L]!"))
			smite_effect(L)
			return
		..()
	return TRUE

/obj/effect/proc_holder/spell/targeted/smite/proc/smite_effect(var/mob/living/carbon/L)
	var/stuntime = 25 * smitelevel
	var/fireamount = 5 * smitelevel
	if(prob(prob2smite))
		L.Stun(stuntime)
	L.adjust_fire_stacks(fireamount)
	L.IgniteMob()
	L.apply_status_effect (/datum/status_effect/debuff/smited)
	to_chat(L, span_warning("Astrata's divine light smites me!"))
