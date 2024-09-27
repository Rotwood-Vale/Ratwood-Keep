//		   _   _ Ham-Hole's                                __                      _                    
//		  /_\ | |_ __ ___   __ _ _ __   __ _  ___    ___  / _|   /\/\   __ _ _   _| |__   ___ _ __ ___  
//		 //_\\| | '_ ` _ \ / _` | '_ \ / _` |/ __|  / _ \| |_   /    \ / _` | | | | '_ \ / _ \ '_ ` _ \ 
//		/  _  \ | | | | | | (_| | | | | (_| | (__  | (_) |  _| / /\/\ \ (_| | |_| | | | |  __/ | | | | |
//		\_/ \_/_|_| |_| |_|\__,_|_| |_|\__,_|\___|  \___/|_|   \/    \/\__,_|\__, |_| |_|\___|_| |_| |_|
//		                                                                     |___/                      

// Notes: When I was thinking about an ultimate magic update. I would have non-cantrip spells be refunded on sleep.
// in DND a wizard must prepare his spells each day. I would also attempt to bring a per-day/per-sleep limit to spells that are of higher level.
// With that in mind, since these spells are ones which are permanently attached to your character (in my head-code)
// these are the ones that don't provide you experience as higher level magic should. These are also meant to damage/utility scale with arcane skill later.
// Please enjoy.

//Contributors:

// ways you can contribute:
// balance damage
// balance cooldowns
// balance stamina loss from spell
// improve visuals
// improve dictation
// improve sound
// improve utility eg. maybe acid splash can skeletonize a limb if casted by a high level mage

//==============================================
//	ACID SPLASH
//==============================================
// Notes: You hurl a bubble of acid, a slow moving bubble projectile that deals light burn damage to target and light burn damage over time in an aoe
/obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e
	name = "Acid Splash"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/acidsplash5e
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 3 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/self/acidsplash5e/cast(mob/user = usr)
	var/mob/living/target = user
	target.visible_message(span_warning("[target] hurls a caustic bubble!"), span_notice("You hurl a caustic bubble!"))
	. = ..()

/obj/projectile/magic/acidsplash5e
	name = "acid bubble"
	icon_state = "green_laser"
	damage = 10
	damage_type = BURN
	flag = "magic"
	range = 15
	speed = 30 //higher is slower
	var/aoe_range = 1

/obj/projectile/magic/acidsplash5e/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/turf/T = get_turf(src)
	playsound(src, 'sound/misc/nutriment.ogg', 100)
	
	for(var/mob/living/L in range(aoe_range, get_turf(src))) //apply damage over time to mobs
		if(!L.anti_magic_check())
			var/mob/living/carbon/M = L
			M.apply_status_effect(/datum/status_effect/buff/acidsplash5e)
			new /obj/effect/temp_visual/acidsplash5e(get_turf(M))
	for(var/turf/turfs_in_range in range(aoe_range+1, T)) //make a splash
		new /obj/effect/temp_visual/acidsplash5e(T)

/datum/status_effect/buff/acidsplash5e
	id = "acid splash"
	alert_type = /atom/movable/screen/alert/status_effect/buff/acidsplash5e
	duration = 10 SECONDS

/datum/status_effect/buff/acidsplash5e/on_apply()
	. = ..()
	owner.playsound_local(get_turf(owner), 'sound/health/burning.ogg', 35, FALSE, pressure_affected = FALSE)
	owner.visible_message(span_warning("[owner] is covered in acid!"), span_danger("I am covered in acid!"))
	owner.emote("scream")

/datum/status_effect/buff/acidsplash5e/tick()
	var/mob/living/target = owner
	target.adjustFireLoss(2)

/atom/movable/screen/alert/status_effect/buff/acidsplash5e
	name = "Acid Burn"
	desc = "My skin is burning!"
	icon_state = "debuff"

/obj/effect/temp_visual/acidsplash5e
	icon = 'icons/effects/effects.dmi'
	icon_state = "greenshatter2"
	name = "horrible acrid brine"
	desc = "Best not touch this."
	randomdir = TRUE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER

//==============================================
//	BLADE WARD
//==============================================
// Notes: You extend your hand and trace a sigil of warding in the air. 
/obj/effect/proc_holder/spell/self/bladeward5e
	name = "Blade Ward"
	desc = ""
	clothes_req = FALSE
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 60 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
// Notes: Bard, Sorcerer, Warlock, Wizard

/obj/effect/proc_holder/spell/self/bladeward5e/cast(mob/user = usr)
	var/mob/living/target = user
	target.apply_status_effect(/datum/status_effect/buff/bladeward5e)
	ADD_TRAIT(target, TRAIT_BREADY, TRAIT_GENERIC)
	user.visible_message("<span class='info'>[user] traces a warding sigil in the air.</span>", "<span class='notice'>I trace a a sigil of warding in the air.</span>")

/datum/status_effect/buff/bladeward5e
	id = "blade ward"
	alert_type = /atom/movable/screen/alert/status_effect/buff/bladeward5e
	effectedstats = list("constitution" = 2)
	duration = 20 SECONDS
	var/static/mutable_appearance/ward = mutable_appearance('icons/effects/beam.dmi', "purple_lightning", -MUTATIONS_LAYER)

/atom/movable/screen/alert/status_effect/buff/bladeward5e
	name = "Blade Ward"
	desc = "I am resistant to damage."
	icon_state = "buff"

/datum/status_effect/buff/bladeward5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(ward)
	target.update_vision_cone()

/datum/status_effect/buff/bladeward5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(ward)
	target.update_vision_cone()
	REMOVE_TRAIT(target, TRAIT_BREADY, TRAIT_GENERIC)
	. = ..()

//==============================================
//	BOOMING BLADE
//==============================================
/obj/effect/proc_holder/spell/invoked/boomingblade5e
	name = "Booming Blade"
	overlay_state = "blade_burst"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	
/obj/effect/proc_holder/spell/invoked/boomingblade5e/cast(list/targets, mob/living/user)
	var/mob/living/carbon/target = targets[1]
	var/mob/living/L = target
	var/mob/U = user
	var/obj/item/held_item = user.get_active_held_item() //get held item
	if(held_item)
		held_item.melee_attack_chain(U, L)
		target.apply_status_effect(/datum/status_effect/buff/boomingblade5e/) //apply buff

/datum/status_effect/buff/boomingblade5e
	id = "booming blade"
	alert_type = /atom/movable/screen/alert/status_effect/buff/boomingblade5e
	duration = 10 SECONDS
	var/turf/start_pos
	var/static/mutable_appearance/glow = mutable_appearance('icons/effects/effects.dmi', "empdisable", -MUTATIONS_LAYER)

/datum/status_effect/buff/boomingblade5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(glow)
	target.update_vision_cone()
	start_pos = get_turf(target) //set buff starting position

/datum/status_effect/buff/boomingblade5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(glow)
	target.update_vision_cone()
	. = ..()

/datum/status_effect/buff/boomingblade5e/tick()
	var/turf/new_pos = get_turf(owner)
	var/startX = start_pos.x
	var/startY = start_pos.y
	var/newX = new_pos.x
	var/newY = new_pos.y
	if(startX != newX || startY != newY)//if target moved
		//explosion
		if(!owner.anti_magic_check())
			boom()
		Destroy(src)

/datum/status_effect/buff/boomingblade5e/proc/boom()
	var/exp_heavy = 0
	var/exp_light = 0
	var/exp_flash = 2
	var/exp_fire = 0
	var/damage = 30
	explosion(owner, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire)
	owner.adjustBruteLoss(damage)
	owner.visible_message(span_warning("A thunderous boom eminates from [owner]!"), span_danger("A thunderous boom eminates from you!"))

/atom/movable/screen/alert/status_effect/buff/boomingblade5e
	name = "Booming Blade"
	desc = "I feel if I move I am in serious trouble."
	icon_state = "debuff"

//==============================================
//	CHILL TOUCH
//==============================================
// Notes: I have taken creative liberties because I don't want to fuck with people's ability to be healed.
// This now attaches a ghost hand to a targeted body part and does different things depending on the part
/obj/effect/proc_holder/spell/invoked/chilltouch5e
	name = "Chill Touch"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

// Notes: sorcerer, warlock, wizard
/obj/effect/proc_holder/spell/invoked/chilltouch5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/obj/item/bodypart/bodypart = target.get_bodypart(user.zone_selected)
		if(!bodypart)
			return FALSE
		var/obj/item/chilltouch5e/hand = new(target)
		hand.host = target
		hand.bodypart = bodypart
		hand.forceMove(target)
		bodypart.add_embedded_object(hand, silent = TRUE, crit_message = FALSE)
		if(user.zone_selected == BODY_ZONE_CHEST)
			var/choice = alert(target, "A skeletal hand attempts to grapple your private parts!", "", "Accept it!", "Fight it!")
			switch(choice)
			//IF YOU CHOOSE Accept it! - YOU RECIEVE PLEASURE
				if("Accept it!")
					hand.pleasureaccepted = TRUE
				if("Fight it!")
					hand.pleasureaccepted = FALSE
	return FALSE

/obj/item/chilltouch5e
	name = "Skeletal Hand"
	desc = "A ghostly, skeletal hand which moves of it's own accord."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bounty"
	
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	max_integrity = 10

	var/oxy_drain = 2
	var/pleasure = 1
	var/curprocs = 0
	var/procsmax = 360
	var/pleasureaccepted = FALSE
	var/mob/living/host //who are we stuck to?
	var/obj/item/bodypart/bodypart //where are we stuck to?

	embedding = list(
		"embedded_unsafe_removal_time" = 50,
		"embedded_pain_chance" = 0,
		"embedded_pain_multiplier" = 0,
		"embed_chance" = 100,
		"embedded_fall_chance" = 0)
	item_flags = DROPDEL
	destroy_sound = 'sound/magic/vlightning.ogg'

/obj/item/chilltouch5e/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/chilltouch5e/on_embed(obj/item/bodypart/bodypart)
	to_chat(bodypart.owner, "<span class='warning'>hand attached to [bodypart.owner]'s [bodypart]!</span>")
	if(bodypart.owner)
		host = bodypart.owner
		START_PROCESSING(SSobj, src)

/obj/item/chilltouch5e/process()
	var/hand_proc = pick(1,2,3,4,5)
	var/mult = pick(1,2)
	var/mob/living/target = host
	if(!is_embedded)
		host = null
		return PROCESS_KILL
	if(curprocs >= procsmax)
		host = null
		return PROCESS_KILL
	if(!host)
		qdel(src)
		return FALSE
	curprocs++
	if(hand_proc == 1)
		switch(bodypart.name)
			if(BODY_ZONE_HEAD) //choke
				to_chat(host, "<span class='warning'>[host] chokes!</span>")
				playsound(get_turf(host), pick('sound/combat/shove.ogg'), 100, FALSE, -1)
				host.emote("choke")

				target.adjustOxyLoss(oxy_drain*mult*2)
			if(BODY_ZONE_CHEST) //pleasure if erp, hurt if not
				//if erp allowed & said yes to prompt pleasure them & combat mode OFF
				if(target.client.prefs.sexable == TRUE && pleasureaccepted && !target.cmode)
					to_chat(host, "<span class='warning'>[host] is rubbed by a skeletal hand!</span>")
					playsound(get_turf(host), pick('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 100, FALSE, -1)
					target.sexcon.perform_sex_action(host, pleasure*mult*3, 0, TRUE)
				else //damage
					to_chat(host, "<span class='danger'>[host] is pummeled!</span>")
					playsound(get_turf(host), pick('sound/combat/hits/punch/punch_hard (1).ogg','sound/combat/hits/punch/punch_hard (2).ogg','sound/combat/hits/punch/punch_hard (3).ogg'), 100, FALSE, -1)
					target.adjustBruteLoss(oxy_drain*mult*3)
			else
				to_chat(host, "<span class='danger'>[host]'s [bodypart] is twisted!</span>")
				playsound(get_turf(host), pick('sound/combat/hits/punch/punch (1).ogg','sound/combat/hits/punch/punch (2).ogg','sound/combat/hits/punch/punch (3).ogg'), 100, FALSE, -1)
				target.apply_damage(oxy_drain*mult*3, BRUTE, bodypart)
				bodypart.update_disabled()
	return FALSE

//==============================================
//	CONTROL FLAMES
//==============================================
//lame. skip. merge it with on/off

//==============================================
//	CREATE BONFIRE
//==============================================
//Conjure temporary campfire, why not?
/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e
	name = "Create Bonfire"
	desc = ""
	clothes_req = FALSE
	range = 0
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 3 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

	summon_type = list(
		/obj/machinery/light/rogue/createbonfire5e
	)
	summon_lifespan = 600
	summon_amt = 1

	action_icon_state = "the_traps"

/obj/effect/proc_holder/spell/aoe_turf/conjure/the_traps/post_summon(obj/structure/trap/T, mob/user)
	T.immune_minds += user.mind
	T.charges = 1

/obj/machinery/light/rogue/createbonfire5e
	name = "magical bonfire"
	icon_state = "churchfire1"
	base_state = "churchfire"
	density = FALSE
	layer = 2.8
	brightness = 7
	fueluse = 10 MINUTES
	color = "#6ab2ee"
	bulb_colour = "#6ab2ee"
	cookonme = TRUE
	can_damage = TRUE
	max_integrity = 30

/obj/machinery/light/rogue/createbonfire5e/process()
	..()
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()

/obj/machinery/light/rogue/createbonfire5e/onkick(mob/user)
	if(isliving(user) && on)
		var/mob/living/L = user
		L.visible_message(span_info("[L] snuffs [src]."))
		burn_out()

/obj/machinery/light/rogue/createbonfire5e/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(on)
		var/mob/living/carbon/human/H = user

		if(istype(H))
			H.visible_message(span_info("[H] warms \his hand near the fire."))

			if(do_after(H, 100, target = src))
				var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
				to_chat(H, span_warning("HOT!"))
				if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
					H.update_damage_overlays()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch

//==============================================
//	DANCING LIGHTS
//==============================================
//lame. skip maybe add later for a dance party or something

//==============================================
//	DECOMPOSE
//==============================================
// Notes: turn a freshly dead body into a rotman
/obj/effect/proc_holder/spell/invoked/decompose5e
	name = "Decompose"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = TRUE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/decompose5e/cast(list/targets, mob/living/user)
	if(!isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		var/has_rot = FALSE
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/bodypart as anything in stinky.bodyparts)
				if(bodypart.rotted || bodypart.skeletonized)
					has_rot = TRUE
					break
		if(has_rot)
			to_chat(user, span_warning("Already rotted."))
			return FALSE
		//do some sounds and effects or something (flies?)
		if(target.mind)
			target.mind.add_antag_datum(/datum/antagonist/zombie)
		target.Unconscious(20 SECONDS)
		target.emote("breathgasp")
		target.Jitter(100)
		var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
		if(rot)
			rot.amount = 100
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/rotty in stinky.bodyparts)
				rotty.rotted = TRUE
				rotty.update_limb()
				rotty.update_disabled()
		target.update_body()
		if(HAS_TRAIT(target, TRAIT_ROTMAN))
			target.visible_message(span_notice("[target]'s body rots!"), span_green("I feel rotten!"))
		else
			target.visible_message(span_warning("[target]'s body fails to rot!"), span_warning("I feel no different..."))
		return TRUE
	return FALSE

//==============================================
//	DRUIDCRAFT
//==============================================
//lame. skip

//==============================================
//	ELDRITCH BLAST
//==============================================
// Notes: 
/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e
	name = "Eldritch Blast"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/eldritchblast5e
	overlay_state = "force_dart"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 3 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout


/obj/projectile/magic/eldritchblast5e
	name = "eldritch blast"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "arcane_barrage"
	damage = 20
	damage_type = BRUTE
	flag = "magic"
	range = 15

/obj/projectile/magic/eldritchblast5e/on_hit(atom/target, blocked = FALSE)
	. = ..()
	playsound(src, 'sound/magic/swap.ogg', 100)

//==============================================
//	ENCODE THOUGHTS
//==============================================
//Fine. I'll add it.
/obj/effect/proc_holder/spell/invoked/encodethoughts5e
	name = "Encode Thoughts"
	desc = "Latch onto the mind of one who is nearby, weaving a particular thought into their mind."
	name = "Encode Thoughts"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/encodethoughts5e/cast(list/targets, mob/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(!target)
			return
		var/message = stripped_input(user, "What thought do you wish to weave into [target]'s mind?")
		if(!message)
			return
		to_chat(target, "Your mind thinks to itself: </span><font color=#7246ff>\"[message]\"</font>")
		to_chat(user, "I pluck the strings of [target]'s mind")
		log_game("[key_name(user)] sent a message to [key_name(target)] with contents [message]")
		return TRUE
	to_chat(user, span_warning("I wasn't able to find a mind to weave here."))
	revert_cast()

//==============================================
//	FIRE BOLT
//==============================================
// Notes: 

/obj/effect/proc_holder/spell/invoked/projectile/firebolt5e
	name = "Fire Bolt"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/firebolt5e
	overlay_state = "fireball_multi"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 3 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	xp_gain = TRUE

/obj/projectile/magic/aoe/fireball/firebolt5e
	name = "fireball"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 1
	exp_fire = -1
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0

//==============================================
//	FRIENDS
//==============================================
//lame. skip. You aren't going to get a player to become friendly.

//==============================================
//	FROSTBITE
//==============================================
/obj/effect/proc_holder/spell/invoked/frostbite5e
	name = "Frostbite"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	
/obj/effect/proc_holder/spell/invoked/frostbite5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.apply_status_effect(/datum/status_effect/buff/frostbite5e/) //apply debuff
		target.adjustFireLoss(12) //damage
		target.adjustBruteLoss(12)

/datum/status_effect/buff/frostbite5e
	id = "frostbite"
	alert_type = /atom/movable/screen/alert/status_effect/buff/frostbite5e
	duration = 20 SECONDS
	var/static/mutable_appearance/frost = mutable_appearance('icons/roguetown/mob/coldbreath.dmi', "breath_m", ABOVE_ALL_MOB_LAYER)
	effectedstats = list("speed" = -2)

/atom/movable/screen/alert/status_effect/buff/frostbite5e
	name = "Frostbite"
	desc = "I can feel myself slowing down."
	icon_state = "debuff"

/datum/status_effect/buff/frostbite5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(frost)
	target.update_vision_cone()
	var/newcolor = rgb(136, 191, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), 20 SECONDS)

/datum/status_effect/buff/frostbite5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(frost)
	target.update_vision_cone()
	. = ..()

//==============================================
//	GREEN-FLAME BLADE
//==============================================
/obj/effect/proc_holder/spell/invoked/greenflameblade5e
	name = "Green-Flame Blade"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	
/obj/effect/proc_holder/spell/invoked/greenflameblade5e/cast(list/targets, mob/living/user)
	var/mob/living/carbon/target = targets[1]
	var/mob/living/L = target
	var/mob/U = user
	var/obj/item/held_item = user.get_active_held_item() //get held item
	var/aoe_range = 1
	if(held_item)
		held_item.melee_attack_chain(U, L)
		L.adjustFireLoss(15) //burn target
		playsound(target, 'sound/items/firesnuff.ogg', 100)
		//burn effect and sound
		for(var/mob/living/M in range(aoe_range, get_turf(target))) //burn non-user mobs in an aoe
			if(!M.anti_magic_check())
				if(M != user)
					M.adjustFireLoss(15) //burn target
					//burn effect and sound
					new /obj/effect/temp_visual/acidsplash5e(get_turf(M))
					playsound(M, 'sound/items/firelight.ogg', 100)

/obj/effect/temp_visual/greenflameblade5e
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	name = "green-flame"
	desc = "Magical fire. Interesting."
	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER

//==============================================
//	GUIDANCE
//==============================================
/obj/effect/proc_holder/spell/invoked/guidance5e
	name = "Guidance"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	
/obj/effect/proc_holder/spell/invoked/guidance5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		if(target != user)
			var/datum/status_effect/buff/guidance5e/G = new /datum/status_effect/buff/guidance5e/
			G.giver = user
			target.apply_status_effect(G) //apply buff
			to_chat(target, span_info("You are illuminated by [user]'s guiding light."))
			target.visible_message(span_info("[target] is illuminated by a guiding presence!"), span_info("You begin to guide [target]."))
		else
			to_chat(target, span_warning("You can't guide yourself!"))

/datum/status_effect/buff/guidance5e
	id = "guidance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guidance5e
	duration = 30 SECONDS
	effectedstats = list("intelligence" = 2)
	var/static/mutable_appearance/guided = mutable_appearance('icons/effects/effects.dmi', "blessed")
	var/mob/living/carbon/giver

/datum/status_effect/buff/guidance5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(guided)
	target.update_vision_cone()

/datum/status_effect/buff/guidance5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(guided)
	target.update_vision_cone()
	. = ..()

/atom/movable/screen/alert/status_effect/buff/guidance5e
	name = "Guidance"
	desc = "Someone is guiding me."
	icon_state = "buff"

//==============================================
//	GUST
//==============================================
//lame. skip. Kinda boring tbh. Might add later

//==============================================
//	HAND OF RADIANCE
//==============================================
//lame. skip. Without the ability to choose enemies real time not really viable an aoe like this. Maybe would be good as an aoe flash. Might add later

//==============================================
//	INFESTATION
//==============================================
/obj/effect/proc_holder/spell/invoked/infestation5e
	name = "Infestation"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 8
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	
/obj/effect/proc_holder/spell/invoked/infestation5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_warning("[target] is surrounded by a cloud of pestilent vermin!"), span_notice("You surround [target] in a cloud of pestilent vermin!"))
		target.apply_status_effect(/datum/status_effect/buff/infestation5e/) //apply debuff

/datum/status_effect/buff/infestation5e
	id = "infestation"
	alert_type = /atom/movable/screen/alert/status_effect/buff/infestation5e
	duration = 15 SECONDS
	effectedstats = list("constitution" = -2)
	var/static/mutable_appearance/rotten = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")

/datum/status_effect/buff/infestation5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	to_chat(owner, span_danger("I am suddenly surrounded by a cloud of bugs!"))
	target.Jitter(20)
	target.add_overlay(rotten)
	target.update_vision_cone()

/datum/status_effect/buff/infestation5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(rotten)
	target.update_vision_cone()
	. = ..() 

/datum/status_effect/buff/infestation5e/tick()
	var/mob/living/target = owner
	var/mob/living/carbon/M = target
	target.adjustToxLoss(2)
	target.adjustBruteLoss(1)
	var/prompt = pick(1,2,3)
	var/message = pick(
		"Ticks on my skin start to engorge with blood!",
		"Flies are laying eggs in my open wounds!",
		"Something crawled in my ear!",
		"There are too many bugs to count!",
		"They're trying to get under my skin!",
		"Make it stop!",
		"Millipede legs tickle the back of my ear!",
		"Fire ants bite at my feet!",
		"A wasp sting right on the nose!",
		"Cockroaches scurry across my neck!",
		"Maggots slimily wriggle along my body!",
		"Beetles crawl over my mouth!",
		"Fleas bite my ankles!",
		"Gnats buzz around my face!",
		"Lice suck my blood!",
		"Crickets chirp in my ears!",
		"Earwigs crawl into my ears!")
	if(prompt == 1)
		M.add_nausea(pick(10,20))
		to_chat(target, span_warning(message))
		owner.playsound_local(get_turf(owner), 'sound/surgery/organ2.ogg', 35, FALSE, pressure_affected = FALSE)

/atom/movable/screen/alert/status_effect/buff/infestation5e
	name = "Infestation"
	desc = "Pestilent vermin bite and chew at my skin."
	icon_state = "debuff"

//==============================================
//	LIGHT
//==============================================
/obj/effect/proc_holder/spell/self/light5e
	name = "Light"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 8
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

	var/obj/item/item
	var/item_type = /obj/item/flashlight/flare/light5e
	var/delete_old = TRUE //TRUE to delete the last summoned object if it's still there, FALSE for infinite item stream weeeee

/obj/effect/proc_holder/spell/self/light5e/cast(list/targets, mob/user = usr)
	if (delete_old && item && !QDELETED(item))
		QDEL_NULL(item)
		if(user.dropItemToGround(user.get_active_held_item()))
			user.put_in_hands(make_item(), TRUE)
			user.visible_message(span_info("An orb of light condenses in [user]'s hand!"), span_info("You condense an orb of pure light!"))

/obj/effect/proc_holder/spell/self/light5e/Destroy()
	if(item)
		qdel(item)
	return ..()

/obj/effect/proc_holder/spell/self/light5e/proc/make_item()
	item = new item_type
	return item

/obj/item/flashlight/flare/light5e
	name = "condensed light"
	desc = "An orb of condensed light."
	w_class = WEIGHT_CLASS_NORMAL
	light_range = 10
	light_color = LIGHT_COLOR_WHITE
	force = 10
	icon = 'icons/roguetown/rav/obj/cult.dmi'
	icon_state = "sphere0"
	item_state = "sphere0"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	light_color = "#ffffff"
	on_damage = 10
	flags_1 = null
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP
	var/datum/looping_sound/torchloop/soundloop
	max_integrity = 200
	fuel = 10 MINUTES
	light_depth = 0
	light_height = 0

/obj/item/flashlight/flare/light5e/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -9,"sy" = 3,"nx" = 12,"ny" = 4,"wx" = -6,"wy" = 5,"ex" = 3,"ey" = 6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 2,"sturn" = 2,"wturn" = -2,"eturn" = -2,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/flashlight/flare/light5e/Initialize()
	. = ..()
	soundloop = new(list(src), FALSE)

/obj/item/flashlight/flare/light5e/process()
	on = TRUE
	update_brightness()
	open_flame(heat)
	if(!fuel || !on)
		//turn_off()
		STOP_PROCESSING(SSobj, src)
		if(!fuel)
			icon_state = "sphere0"
		return
	if(!istype(loc,/obj/machinery/light/rogue/torchholder))
		if(!ismob(loc))
			if(prob(23))
				//turn_off()
				STOP_PROCESSING(SSobj, src)
				return

/obj/item/flashlight/flare/light5e/turn_off()
	playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
	soundloop.stop()
	STOP_PROCESSING(SSobj, src)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
		M.update_inv_belt()
	damtype = BRUTE
	Destroy(src)

/obj/item/flashlight/flare/light5e/fire_act(added, maxstacks)
	if(fuel)
		if(!on)
			playsound(src.loc, 'sound/items/firelight.ogg', 100)
			on = TRUE
			damtype = BURN
			update_brightness()
			force = on_damage
			soundloop.start()
			if(ismob(loc))
				var/mob/M = loc
				M.update_inv_hands()
			START_PROCESSING(SSobj, src)
			return TRUE
	..()

/obj/item/flashlight/flare/light5e/afterattack(atom/movable/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(on)
		if(prob(50) || (user.used_intent.type == /datum/intent/use))
			if(ismob(A))
				A.spark_act()
			else
				A.fire_act(3,3)

/obj/item/flashlight/flare/light5e/spark_act()
	fire_act()

/obj/item/flashlight/flare/light5e/get_temperature()
	if(on)
		return FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	return ..()

/obj/item/flashlight/flare/light5e/update_brightness(mob/user = null)
	..()
	if(on)
		item_state = "[initial(item_state)]"
	else
		item_state = "[initial(item_state)]"

//==============================================
//	LIGHTNING LURE
//==============================================

/obj/effect/proc_holder/spell/targeted/lightninglure5e
	name = "Lightning Lure"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 3
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	include_user = FALSE

	var/delay = 3 SECONDS
	var/sprite_changes = 10
	var/datum/beam/current_beam = null

obj/effect/proc_holder/spell/targeted/lightninglure5e/cast(list/targets, mob/user = usr)
	for(var/mob/living/carbon/C in targets)
		user.visible_message(span_warning("[C] is connected to [user] with a lightning lure!"), span_warning("You create a static link with [C]."))
		playsound(user, 'sound/items/stunmace_gen (2).ogg', 100)

		var/x 
		for(x=1; x < sprite_changes; x++)
			current_beam = new(user,C,time=30/sprite_changes,beam_icon_state="lightning[rand(1,12)]",btype=/obj/effect/ebeam, maxdistance=10)
			INVOKE_ASYNC(current_beam, TYPE_PROC_REF(/datum/beam, Start))
			sleep(delay/sprite_changes)

		var/dist = get_dist(user, C)
		if (dist <= range)
			C.electrocute_act(1, user) //just shock	
			//var/atom/throw_target = get_step(user, get_dir(user, C))
			//C.throw_at(throw_target, 100, 2) //from source material but kinda op.
		else
			playsound(user, 'sound/items/stunmace_toggle (3).ogg', 100)
			user.visible_message(span_warning("The lightning lure fizzles out!"), span_warning("[C] is too far away!"))
			
//==============================================
//	MAGE HAND
//==============================================
//lame. skip. Same functionality as on/off which I intend to add later.

//==============================================
//	MAGIC STONE
//==============================================
/obj/effect/proc_holder/spell/invoked/magicstone5e
	name = "Magic Stone"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	var/magic_color = "#c8daff"

/obj/effect/proc_holder/spell/invoked/magicstone5e/cast(list/targets, mob/living/user)
	if(istype(targets[1], /obj/item/natural/stone))
		var/obj/item/natural/stone/S = targets[1]
		to_chat(user, "<span class='info'>[S] is infused with magical energy!</span>")
		S.name = "magic "+S.name
		S.force *= 1.5 //ouchy
		S.throwforce *= 1.5 //ouchy
		S.color = magic_color
		var/mutable_appearance/magic_overlay = mutable_appearance('icons/effects/effects.dmi', "electricity")
		S.add_overlay(magic_overlay)
	else
		to_chat(user, span_warning("There is no stone here!"))
		revert_cast()
//==============================================
//	MENDING
//==============================================

/obj/effect/proc_holder/spell/invoked/mending5e
	name = "Mending"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 1 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/magicstone5e/cast(list/targets, mob/living/user)
	if(istype(targets[1], /obj/item))
		var/obj/item/I = targets[1]
		if(I.obj_integrity >= I.max_integrity)
			var/repair_percent = 0.25
			repair_percent *= I.max_integrity
			I.obj_integrity = min(I.obj_integrity + repair_percent, I.max_integrity)
			user.visible_message(span_info("[I] glows in a faint mending light."))
			if(I.obj_broken == TRUE)
				I.obj_broken = FALSE
		else
			user.visible_message(span_info("[I] appears to be in pefect condition."))
			revert_cast()
	else
		to_chat(user, span_warning("There is no item here!"))
		revert_cast()

//==============================================
//	MESSAGE
//==============================================
//lame. skip. Already in the game.

/*
XX	added
X	added, needs work
S	skipped, might add later
SS	skipped

XX	Acid Splash			Conjuration		1 Action		60 Feet				Instantaneous	V, S
XX 	Blade Ward			Abjuration		1 Action		Self				1 round			V, S
X 	Booming Blade		Evocation		1 Action		Self (5-foot radius)1 round			S, M
XX 	Chill Touch			Necromancy		1 Action		120 feet			1 round			V, S
SS 	Control Flames		Transmutation	1 Action		60 Feet				Instantaneous	S
XX 	Create Bonfire		Conjuration		1 Action		60 Feet				1 minute		V, S
S 	Dancing Lights		Evocation		1 Action		120 feet			1 minute		V, S, M
X 	Decompose (HB)		Necromancy		1 Action		Touch				1 minute		V, S
SS 	Druidcraft			Transmutation	1 Action		30 Feet				Instantaneous	V, S
XX 	Eldritch Blast		Evocation		1 Action		120 Feet			Instantaneous	V, S
XX 	Encode Thoughts		Enchantment		1 Action		Self				8 hours			S
XX 	Fire Bolt			Evocation		1 Action		120 feet			Instantaneous	V, S
SS 	Friends				Enchantment		1 Action		Self				1 minute		S, M
XX 	Frostbite			Evocation		1 Action		60 feet				Instantaneous	V, S
X	Green-Flame Blade	Evocation		1 Action		Self (5-foot radius)Instantaneous	S, M
XX 	Guidance			Divination		1 Action		Touch				1 minute		V, S
S 	Gust				Transmutation	1 Action		30 feet				Instantaneous	V, S
S 	Hand of Radiance	Evocation		1 Action		5 feet				Instantaneous	V, S
XX 	Infestation			Conjuration		1 Action		30 feet				Instantaneous	V, S, M
XX 	Light				Evocation		1 Action		Touch				1 hour			V, M
XX	Lightning Lure		Evocation		1 Action		Self(15-foot radius)Instantaneous	V
S	Mage Hand			Conjuration		1 Action		30 feet				1 minute		V, S
XX	Magic Stone			Transmutation	1 Bonus Action	Touch				1 minute		V, S
XX	Mending				Transmutation	1 Minute		Touch				Instantaneous	V, S, M
SS 	Message				Transmutation	1 Action		120 feet			1 round			V, S, M

//we are here

	Mind Sliver	Enchantment	1 Action	60 feet	1 round	V
	Minor Illusion	Illusion	1 Action	30 feet	1 minute	S, M
	Mold Earth	Transmutation	1 Action	30 feet	Instantaneous or 1 hour	S
	On/Off (UA)	Transmutation T	1 Action	60 feet	Instantaneous	V, S
	Poison Spray	Conjuration	1 Action	10 feet	Instantaneous	V, S
SS	Prestidigitation	Transmutation	1 Action	10 feet	Up to 1 hour	V, S
S	Primal Savagery	Transmutation	1 Action	Self	Self	S
	Produce Flame	Conjuration	1 Action	Self	10 minutes	V, S
	Ray of Frost	Evocation	1 Action	60 feet	Instantaneous	V, S
	Resistance	Abjuration	1 Action	Touch	Concentration up to 1 minute	V, S, M
	Sacred Flame	Evocation	1 Action	60 feet	Instantaneous	V, S
	Sapping Sting	Necromancy D	1 Action	30 feet	Instantaneous	V, S
	Shape Water	Transmutation	1 Action	30 feet	Instantaneous or 1 hour	S
	Shillelagh	Transmutation	1 Bonus Action	Touch	1 minute	V, S, M
	Shocking Grasp	Evocation	1 Action	Touch	Instantaneous	V, S
S	Spare the Dying	Necromancy	1 Action	Touch	Instantaneous	V, S
	Sword Burst	Conjuration	1 Action	Self (5-foot radius)	Instantaneous	V
SS	Thaumaturgy	Transmutation	1 Action	30 feet	Up to 1 minute	V
	Thorn Whip	Transmutation	1 Action	30 feet	Instantaneous	V, S, M
	Thunderclap	Evocation	1 Action	Self (5-foot radius)	Instantaneous	S
	Toll the Dead	Necromancy	1 Action	60 feet	Instantaneous	V, S
	True Strike	Divination	1 Action	30 feet	Concentration up to 1 round	S
XX	Vicious Mockery	Enchantment	1 Action	60 feet	Instantaneous	V
	Virtue (UA)	Abjuration	1 Action	Touch	1 round	V, S
S	Word of Radiance	Evocation	1 Action	5 feet	Instantaneous	V, M
*/
