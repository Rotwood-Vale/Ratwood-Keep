/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/Initialize()
	. = ..()
	ADD_TRAIT(src,TRAIT_NOFIRE, "[type]")
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the obelisk
	return

/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "voidstone obelisk"
	desc = "A construct from another age. It is marked by glowing sigils and it's material seems to absorb magic!"
	icon_state = "obelisk-combined"
	icon_living = "obelisk-combined"
	icon_dead = "obelisk-combined"

	faction = list("abberant")
	emote_hear = null
	emote_see = null
	turns_per_move = 6
	speed = 5
	see_in_dark = 9
	move_to_delay = 12
	vision_range = 9
	aggro_vision_range = 9
	movement_type = FLYING
	butcher_results = list()

	health = 750
	maxHealth = 750
	food_type = null

	base_intents = list(/datum/intent/simple/slam)
	attack_sound = list('sound/combat/hits/onstone/wallhit.ogg')
	melee_damage_lower = 30
	melee_damage_upper = 30
	STAEND = 20
	STACON = 20
	STASTR = 12
	STASPD = 8

	simple_detect_bonus = 60
	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 35
	defdrain = 5
	retreat_health = 0.2
	food = 0
	dodgetime = 17
	aggressive = 1
	var/beam_cooldown = 0
	var/beam_range = 10
	/// How long does our beam last?
	var/beam_duration = 5 SECONDS
	/// How long do we wind up before firing?
	var/charge_duration = 1 SECONDS
	/// Overlay we show when we're about to fire
	var/static/image/direction_overlay = image('icons/effects/effects.dmi', "obeliak_telegraph_dir")
	/// A list of all the beam parts.
	var/list/beam_parts = list()
	summon_primer = "You are ancient. A construct built in an age before men, a time of dragons. Your builders don't seem to be around anymore, and time has past with you in standby. How you respond, is up to you."
	tier = 3

/datum/intent/simple/slam
	name = "slam"
	icon_state = "instrike"
	attack_verb = list("slam", "rams")
	animname = "blank22"
	blade_class = BCLASS_BLUNT
	hitsound = 'sound/combat/hits/onstone/wallhit.ogg'
	chargetime = 0
	penfactor = 20
	swingdelay = 0
	candodge = TRUE
	canparry = TRUE
	item_d_type = "blunt"

/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/voidstone(deathspot)
	spill_embedded_objects()
	update_icon()
	sleep(1)
	qdel(src)


/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/MoveToTarget(list/possible_targets)
	stop_automated_movement = 1
	if(!target || !CanAttack(target))
		LoseTarget()
		return 0
	if(binded)
		return 0
	if(target in possible_targets)
		var/target_distance = get_dist(targets_from,target)
		if(world.time >= beam_cooldown)
			Activate(target)
		if(ranged) //We ranged? Shoot at em
			if(!target.Adjacent(targets_from) && ranged_cooldown <= world.time) //But make sure they're not in range for a melee attack and our range attack is off cooldown
				OpenFire(target)
		if(!Process_Spacemove()) //Drifting
			walk(src,0)
			return 1
		if(retreat_distance != null) //If we have a retreat distance, check if we need to run from our target
			if(target_distance <= retreat_distance) //If target's closer than our retreat distance, run
				walk_away(src,target,retreat_distance,move_to_delay)
			else
				Goto(target,move_to_delay,minimum_distance) //Otherwise, get to our minimum distance so we chase them
		else
			Goto(target,move_to_delay,minimum_distance)
		if(target)
			if(targets_from && isturf(targets_from.loc) && target.Adjacent(targets_from)) //If they're next to us, attack
				MeleeAction()
			else
				if(rapid_melee > 1 && target_distance <= melee_queue_distance)
					MeleeAction(FALSE)
				in_melee = FALSE //If we're just preparing to strike do not enter sidestep mode
			return 1
		return 0
	else
		if(ranged_ignores_vision && ranged_cooldown <= world.time) //we can't see our target... but we can fire at them!
			OpenFire(target)
		Goto(target,move_to_delay,minimum_distance)
		FindHidden()
		return 1


/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/vobelisk/construct.ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/Destroy()
	extinguish_laser()
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/proc/Activate(atom/target)

	src.face_atom(target)
	src.move_resist = MOVE_FORCE_VERY_STRONG
	src.add_overlay(direction_overlay)
	src.visible_message(span_notice("The air chills as [src] takes in energy..."))

	var/fully_charged = do_after(src, delay = charge_duration, target = src)
	src.cut_overlay(direction_overlay)
	if (!fully_charged)
		return TRUE

	if (!fire_laser())
		var/static/list/fail_emotes = list("tremors.", "creaks.", "emits green steam as it fails to fire.")
		src.manual_emote(pick(fail_emotes))
		return TRUE

	do_after(src, delay = beam_duration, target = src)
	extinguish_laser()
	beam_cooldown = world.time + 200
	return TRUE

/// Create a laser in the direction we are facing
/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/proc/fire_laser()
	src.visible_message(span_danger("[src] fires a aberrant beam!"))
	playsound(src, 'sound/magic/obeliskbeam.ogg', 150, FALSE, 0, 3)
	var/turf/target_turf = get_ranged_target_turf(src, src.dir, beam_range)
	var/turf/origin_turf = get_turf(src)
	var/list/affected_turfs = get_line(origin_turf, target_turf) - origin_turf
	for(var/turf/affected_turf in affected_turfs)
		if(affected_turf.opacity)
			break
		var/blocked = FALSE
		for(var/obj/potential_block in affected_turf.contents)
			if(potential_block.opacity)
				blocked = TRUE
				break
		if(blocked)
			break
		var/obj/effect/obeliskbeam/new_obeliskbeam = new(affected_turf)
		new_obeliskbeam.dir = src.dir
		beam_parts += new_obeliskbeam
		new_obeliskbeam.assign_creator(src)
		for(var/mob/living/hit_mob in affected_turf.contents)
			hit_mob.apply_damage(damage = 25, damagetype = BURN)
			to_chat(hit_mob, span_userdanger("You're blasted by [src]'s aberrant beam!"))
//		RegisterSignal(new_obeliskbeam, COMSIG_QDELETING, PROC_REF(extinguish_laser)) // In case idk a singularity eats it or something
	if(!length(beam_parts))
		return FALSE
	var/atom/last_obeliskbeam = beam_parts[length(beam_parts)]
	last_obeliskbeam.icon_state = "obeliskbeam_end"
	var/atom/first_obeliskbeam = beam_parts[1]
	first_obeliskbeam.icon_state = "obeliskbeam_start"
	return TRUE

/// Get rid of our laser when we are done with it
/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk/proc/extinguish_laser()
	if(!length(beam_parts))
		return FALSE
	src.move_resist = initial(src.move_resist)
	for(var/obj/effect/obeliskbeam/beam in beam_parts)
		beam.disperse()
	beam_parts = list()

/// Segments of the actual beam, these hurt if you stand in them
/obj/effect/obeliskbeam
	name = "abberant beam"
	icon = 'icons/effects/effects.dmi'
	icon_state = "obeliskbeam_mid"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	light_color = "#008080"
	light_power = 4
	light_range = 3
	/// Who made us?
	var/datum/weakref/creator

/obj/effect/obeliskbeam/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSfastprocess, src)

/obj/effect/obeliskbeam/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/obj/effect/obeliskbeam/process()
	var/atom/ignore = creator?.resolve()
	for(var/mob/living/hit_mob in get_turf(src))
		if(hit_mob == ignore)
			continue
		damage(hit_mob)

/// Hurt the passed mob
/obj/effect/obeliskbeam/proc/damage(mob/living/hit_mob)
	hit_mob.apply_damage(damage = 15, damagetype = BURN)
	to_chat(hit_mob, span_danger("You're damaged by [src]!"))

/// Ignore damage dealt to this mob
/obj/effect/obeliskbeam/proc/assign_creator(mob/living/maker)
	creator = WEAKREF(maker)

/// Disappear
/obj/effect/obeliskbeam/proc/disperse()
	animate(src, time = 0.5 SECONDS, alpha = 0)
	QDEL_IN(src, 0.5 SECONDS)






/////////////////////////VOID DRAGON////////////////////////////
/*
Void dragons are creatures of a bygone age. It is a melee creature, that will chase down and cut most people to shreds if they are by themself.
Whenever possible, the void dragon will use it's chain lightning attack to shock anyone within range.
It will also call down lightning strikes from the sky, and fling people with it's tail, as well as fly up into the sky.*/

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/Initialize()
	. = ..()
	ADD_TRAIT(src,TRAIT_NOFIRE, "[type]")
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
	for(var/action_type in attack_action_types)
		var/datum/action/innate/megafauna_attack/attack_action = new action_type()
		attack_action.Grant(src)
	var/obj/effect/proc_holder/spell/aoe_turf/repulse/voiddragon/repulse_action = new /obj/effect/proc_holder/spell/aoe_turf/repulse/voiddragon(src)
	var/obj/effect/proc_holder/spell/invoked/sundering_lightning/lightning_action = new /obj/effect/proc_holder/spell/invoked/sundering_lightning
//	repulse_action.action.Grant(src)
//	lightning_action.action.Grant(src)
	mob_spell_list += repulse_action
	mob_spell_list += lightning_action

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the void dragon
	return

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)
		TailSwipe(pulledby)



#define DRAKE_SWOOP_HEIGHT 270 //how high up drakes go, in pixels
#define DRAKE_SWOOP_DIRECTION_CHANGE_RANGE 5 //the range our x has to be within to not change the direction we slam from

#define SWOOP_DAMAGEABLE 1
#define SWOOP_INVULNERABLE 2


/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/SetRecoveryTime(buffer_time)
	recovery_time = world.time + buffer_time
	ranged_cooldown = world.time + buffer_time

/// This proc is called by the HRD-MDE grenade to enrage the megafauna. This should increase the megafaunas attack speed if possible, give it new moves, or disable weak moves. This should be reverseable, and reverses on zlvl change.
/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/enrage()
	if(enraged || ((health / maxHealth) * 100 <= 80))
		return
	enraged = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/unrage()
	enraged = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon
	name = "void dragon"
	desc = "An ancient creature from a bygone age. Now would be a good time to run."
	health = 2500
	maxHealth = 2500
	attack_verb_continuous = "gouges"
	attack_verb_simple = "gouge"
	attack_sound = 'sound/misc/demon_attack1.ogg'
	icon = 'modular/icons/mob/96x96/ratwood_dragon.dmi'
	icon_state = "dragon"
	icon_living = "dragon"
	icon_dead = "dragon_dead"
	speak_emote = list("roars")
	emote_hear = null
	emote_see = null
	base_intents = list(/datum/intent/unarmed/dragonclaw)
	faction = list("abberant")
	melee_damage_lower = 40
	melee_damage_upper = 40
	retreat_distance = 0
	minimum_distance = 0
	aggressive = 1
	speed = 5
	move_to_delay = 5
	ranged = TRUE
	pixel_x = -32
	var/swooping = NONE
	var/player_cooldown = 0
	deathmessage = "collapses to the floor with a final roar, the impact rocking the ground."
	footstep_type = FOOTSTEP_MOB_HEAVY
	var/list/attack_action_types = list(/datum/action/innate/megafauna_attack/sundering_lightning,
							/datum/action/innate/megafauna_attack/dragon_slam,
							/datum/action/innate/megafauna_attack/summon_obelisk,
							/datum/action/innate/megafauna_attack/lava_swoop,
							/datum/action/innate/megafauna_attack/lightning_breath)
	var/anger_modifier = 0
	var/recovery_time = 0
	var/chosen_attack = 1 // chosen attack num
	/// Has someone enabled hard mode?
	var/enraged = FALSE
	var/sound/Snd // so far only way i can think of to stop a sound, thank MSO for the idea.
	var/cl_cd
	var/lightning_cd
	var/summon_cd
	var/slam_cd
	summon_primer = "You are ancient. A creature long since banished to the void ages past, you were trapped in a seemingly timeless abyss. Now you've been freed, returned to the world- and everything has changed. It seems some of your constructs remain buried beneath the ground. How you react to these events, only time can tell."
	tier = 5

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/vdragon/drgn.ogg')

/datum/intent/unarmed/dragonclaw
	name = "gouge"
	icon_state = "inchop"
	attack_verb = list("slashes", "gouges", "eviscerates")
	animname = "cut"
	blade_class = BCLASS_CHOP
	hitsound = "genslash"
	penfactor = 60
	damfactor = 40
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"
	miss_sound = "bluntwooshlarge"

/datum/action/innate/megafauna_attack
	name = "Megafauna Attack"
	icon_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = ""
	var/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/M
	var/chosen_message
	var/chosen_attack_num = 0

/datum/action/innate/megafauna_attack/Grant(mob/living/L)
	M = L
	return ..()
/datum/action/innate/megafauna_attack/Activate()
	M.chosen_attack = chosen_attack_num
	to_chat(M, chosen_message)

/datum/action/innate/megafauna_attack/sundering_lightning
	name = "Summon Sundering Lightning"
	button_icon_state = "lightning"
	chosen_message = "<span class='colossus'>You are now summoning lightning from the sky.</span>"
	chosen_attack_num = 1

/datum/action/innate/megafauna_attack/dragon_slam
	name = "Ground Slam shockwave"
	icon_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "projectile"
	chosen_message = "<span class='colossus'>You are now slamming the ground to make shockwaves.</span>"
	chosen_attack_num = 2

/datum/action/innate/megafauna_attack/summon_obelisk
	name = "summon obelisk"
	icon_icon = 'icons/effects/fire.dmi'
	button_icon_state = "1"
	chosen_message = "<span class='colossus'>You are now summoning obelisks to help.</span>"
	chosen_attack_num = 3

/datum/action/innate/megafauna_attack/lava_swoop
	name = "Lava Swoop"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "lavastaff_warn"
	chosen_message = "<span class='colossus'>You are now swooping and striking lightning at your target.</span>"
	chosen_attack_num = 4

/datum/action/innate/megafauna_attack/lightning_breath
	name = "Breath chain lightning"
	button_icon_state = "lightning"
	chosen_message = "<span class='colossus'>You are now breathing lightning.</span>"
	chosen_attack_num = 5

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/TailSwipe(mob/victim)
	var/mob/living/target = victim
	src.visible_message(span_notice("[src] slams [target] with it's tail, knocking them to the floor!"))
	target.Paralyze(5)
	target.apply_damage(20, BRUTE)
	shake_camera(target, 2, 1)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/OpenFire()
	if(swooping)
		return

	anger_modifier = clamp(max((maxHealth - health) / 50, enraged ? 15 : 0), 0, 20)
	ranged_cooldown = world.time + ranged_cooldown_time

	if(client)
		switch(chosen_attack)
			if(1)
				create_lightning(target)
			if(2)
				dragon_slam(src,2,10,8)
			if(3)
				if(world.time >= summon_cd)
					summon_obelisk()
			if(4)
				lava_swoop()
			if(5)
				src.visible_message(span_colossus("[src] opens his maw, and lightning crackles beyond it's teeth."))
				chain_lightning(target, src)
		return
	if(prob(15 + anger_modifier))
		lava_swoop()
	if(world.time >= cl_cd)
		src.visible_message(span_colossus("[src] opens his maw, and lightning crackles beyond it's teeth."))
		chain_lightning(target, src)
		return
	if(health <= 0.75 * maxHealth && world.time >= summon_cd)
		summon_obelisk()
		return
	if(world.time >= lightning_cd)
		create_lightning(target)
		return

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/summon_obelisk()
	var/list/spawnLists = list(/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk,/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk)
	var/reinforcement_count = 2
	src.visible_message(span_cultbigbold("[src] summons abberant obelisks from beneath the ground."))
	summon_cd = world.time + 2000
	while(reinforcement_count > 0)
		var/list/turflist = list()
		for(var/turf/t in RANGE_TURFS(1, src))
			turflist += t

		var/turf/picked = pick(turflist)


		var/spawnTypes = pick_n_take(spawnLists)
		new spawnTypes(picked)
		reinforcement_count--
		continue

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/MeleeAction(patience = TRUE)
	if(rapid_melee > 1)
		var/datum/callback/cb = CALLBACK(src, PROC_REF(CheckAndAttack))
		var/delay = SSnpcpool.wait / rapid_melee
		for(var/i in 1 to rapid_melee)
			addtimer(cb, (i - 1)*delay)
	else
		if(world.time >= slam_cd)
			src.visible_message(span_colossus("[src] slams the ground, creating a shockwave!"))
			dragon_slam(src,2,10,8)
		AttackingTarget()
	if(patience)
		GainPatience()

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/dragon_slam(mob/owner, range, delay, throw_range)
	var/turf/origin = get_turf(owner)
	if(!origin)
		return
	slam_cd = world.time + 150
	var/list/all_turfs = RANGE_TURFS(range, origin)
	for(var/sound_range = 0 to range)
		playsound(origin,'sound/misc/bamf.ogg', 600, TRUE, 10)
		for(var/turf/stomp_turf in all_turfs)
			if(get_dist(origin, stomp_turf) > sound_range)
				continue
			new /obj/effect/temp_visual/small_smoke/halfsecond(stomp_turf)
			for(var/mob/living/hit_mob in stomp_turf)
				if(hit_mob == owner || hit_mob.throwing)
					continue
				to_chat(hit_mob, span_userdanger("[owner]'s ground slam shockwave sends you flying!"))
				var/turf/thrownat = get_ranged_target_turf_direct(owner, hit_mob, throw_range, rand(-10, 10))
				hit_mob.throw_at(thrownat, 8, 2, null, TRUE, force = MOVE_FORCE_OVERPOWERING)
				hit_mob.apply_damage(20, BRUTE)
				shake_camera(hit_mob, 2, 1)
			all_turfs -= stomp_turf
		SLEEP_CHECK_DEATH(delay)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/create_lightning(atom/target)
	if(!target)
		return
	var/turf/targetturf = get_turf(target)
	var/last_dist = 0
	lightning_cd = world.time + 250
	for(var/t in spiral_range_turfs(4, targetturf))
		var/turf/T = t
		if(!T)
			continue
		var/dist = get_dist(targetturf, T)
		if(dist > last_dist)
			last_dist = dist
			sleep(2 + min(4 - last_dist, 12) * 0.5) //gets faster
		new /obj/effect/temp_visual/targetlightning(T)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/lightning_strikes(amount, delay = 0.8)
	if(!target)
		return
	target.visible_message(span_colossus("Lightning starts to strike down from the sky!"))
	while(amount > 0)
		if(QDELETED(target))
			break
		var/turf/T = pick(RANGE_TURFS(enraged ? 2 : 1, target))
		new /obj/effect/temp_visual/targetlightning(T)
		amount--
		SLEEP_CHECK_DEATH(delay)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/lava_swoop(amount = 30)
	if(health < maxHealth * 0.5)
		return swoop_attack(lava_arena = TRUE, swoop_cooldown = enraged ? 2 SECONDS : 6 SECONDS)
	INVOKE_ASYNC(src, PROC_REF(lightning_strikes), enraged ? 60 : amount)
	swoop_attack(FALSE, target, 1000) // longer cooldown until it gets reset below
	SLEEP_CHECK_DEATH(0)
	if(health < maxHealth*0.5)
		SetRecoveryTime(40)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/swoop_attack(lava_arena = FALSE, atom/movable/manual_target, swoop_cooldown = 30)
	if(stat || swooping)
		return
	if(manual_target)
		target = manual_target
	if(!target)
		return
	playsound(loc, 'sound/vo/mobs/vdragon/drgnroar.ogg', 50, TRUE, -1)
	stop_automated_movement = TRUE
	swooping |= SWOOP_DAMAGEABLE
	movement_type = FLYING
	density = FALSE
	icon_state = "shadow"
	visible_message("<span class='boldwarning'>[src] swoops up high!</span>")

	var/negative
	var/initial_x = x
	if(target.x < initial_x) //if the target's x is lower than ours, swoop to the left
		negative = TRUE
	else if(target.x > initial_x)
		negative = FALSE
	else if(target.x == initial_x) //if their x is the same, pick a direction
		negative = prob(50)
	var/obj/effect/temp_visual/dragon_flight/F = new /obj/effect/temp_visual/dragon_flight(loc, negative)

	negative = !negative //invert it for the swoop down later

	var/oldtransform = transform
	alpha = 255
	animate(src, alpha = 204, transform = matrix()*0.9, time = 3, easing = BOUNCE_EASING)
	for(var/i in 1 to 3)
		sleep(1)
		if(QDELETED(src) || stat == DEAD) //we got hit and died, rip us
			qdel(F)
			if(stat == DEAD)
				swooping &= ~SWOOP_DAMAGEABLE
				animate(src, alpha = 255, transform = oldtransform, time = 0, flags = ANIMATION_END_NOW) //reset immediately
			return
	animate(src, alpha = 100, transform = matrix()*0.7, time = 7)
	swooping |= SWOOP_INVULNERABLE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	SLEEP_CHECK_DEATH(7)

	while(target && loc != get_turf(target))
		forceMove(get_step(src, get_dir(src, target)))
		SLEEP_CHECK_DEATH(0.5)

	// Ash drake flies onto its target and rains fire down upon them
	var/descentTime = 10

	//ensure swoop direction continuity.
	if(negative)
		if(ISINRANGE(x, initial_x + 1, initial_x + DRAKE_SWOOP_DIRECTION_CHANGE_RANGE))
			negative = FALSE
	else
		if(ISINRANGE(x, initial_x - DRAKE_SWOOP_DIRECTION_CHANGE_RANGE, initial_x - 1))
			negative = TRUE
	new /obj/effect/temp_visual/dragon_flight/end(loc, negative)
	new /obj/effect/temp_visual/dragon_swoop(loc)
	animate(src, alpha = 255, transform = oldtransform, descentTime)
	SLEEP_CHECK_DEATH(descentTime)
	swooping &= ~SWOOP_INVULNERABLE
	mouse_opacity = initial(mouse_opacity)
	icon_state = "[initial(icon_state)]"
	playsound(loc, 'sound/misc/meteorimpact.ogg', 200, TRUE)
	for(var/mob/living/L in orange(1, src))
		if(L.stat)
			visible_message(span_warning("[src] slams down on [L], crushing [L.p_them()]!"))
			L.gib()
		else
			L.adjustBruteLoss(75)
			if(L && !QDELETED(L)) // Some mobs are deleted on death
				var/throw_dir = get_dir(src, L)
				if(L.loc == loc)
					throw_dir = pick(GLOB.alldirs)
				var/throwtarget = get_edge_target_turf(src, throw_dir)
				L.throw_at(throwtarget, 3)
				visible_message(span_warning("[L] is thrown clear of [src]!</span>"))
	for(var/mob/M in range(7, src))
		shake_camera(M, 15, 1)
	movement_type = GROUND
	density = TRUE
	SLEEP_CHECK_DEATH(1)
	swooping &= ~SWOOP_DAMAGEABLE
	SetRecoveryTime(swoop_cooldown)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/ex_act(severity, target)
	if(severity == EXPLODE_LIGHT)
		return
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/adjustHealth(amount, updating_health = TRUE)
	if(swooping & SWOOP_INVULNERABLE)
		return FALSE
	return ..()



/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/AttackingTarget()
	if(!swooping)
		return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/DestroySurroundings()
	if(!swooping)
		..()

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/Move()
	if(!swooping)
		..()

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/Goto(target, delay, minimum_distance)
	if(!swooping)
		..()

/obj/effect/temp_visual/lava_warning
	icon_state = "lavastaff_warn"
	layer = BELOW_MOB_LAYER
	light_range = 2
	duration = 13

/obj/effect/temp_visual/lava_warning/ex_act()
	return

/obj/effect/temp_visual/lava_warning/Initialize(mapload, reset_time = 10)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fall), reset_time)
	src.alpha = 63.75
	animate(src, alpha = 255, time = duration)

/obj/effect/temp_visual/lava_warning/proc/fall(reset_time)
	var/turf/T = get_turf(src)
	playsound(T,'sound/magic/fleshtostone.ogg', 80, TRUE)
	sleep(duration)
	playsound(T,'sound/magic/fireball.ogg', 200, TRUE)

	for(var/mob/living/L in T.contents)
		if(istype(L, /mob/living/simple_animal/hostile/retaliate/rogue/voiddragon))
			continue
		L.adjustFireLoss(10)
		to_chat(L, "<span class='userdanger'>You fall directly into the pool of lava!</span>")

	// changes turf to lava temporarily
	if(!T.density && !islava(T))
		var/lava_turf = /turf/open/lava
		var/reset_turf = T.type
		T.ChangeTurf(lava_turf)
		sleep(reset_time)
		T.ChangeTurf(reset_turf)

/obj/effect/temp_visual/drakewall
	desc = "An ash drakes true flame."
	name = "Fire Barrier"
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	anchored = TRUE
	opacity = FALSE
	density = TRUE
	duration = 82
	color = COLOR_DARK_ORANGE

/obj/effect/temp_visual/drakewall/CanAtmosPass(direction)
	return !density


/obj/effect/temp_visual/dragon_swoop
	name = "certain death"
	desc = "Don't just stand there, move!"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "void_blink_in"
	layer = BELOW_MOB_LAYER
	pixel_x = -32
	pixel_y = -32
	color = "#FF0000"
	duration = 10

/obj/effect/temp_visual/dragon_flight
	icon = 'modular/icons/mob/96x96/ratwood_dragon.dmi'
	icon_state = "dragon"
	layer = ABOVE_ALL_MOB_LAYER
	pixel_x = -32
	duration = 10
	randomdir = FALSE

/obj/effect/temp_visual/dragon_flight/Initialize(mapload, negative)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(flight), negative)

/obj/effect/temp_visual/dragon_flight/proc/flight(negative)
	if(negative)
		animate(src, pixel_x = -DRAKE_SWOOP_HEIGHT*0.1, pixel_z = DRAKE_SWOOP_HEIGHT*0.15, time = 3, easing = BOUNCE_EASING)
	else
		animate(src, pixel_x = DRAKE_SWOOP_HEIGHT*0.1, pixel_z = DRAKE_SWOOP_HEIGHT*0.15, time = 3, easing = BOUNCE_EASING)
	sleep(3)
	icon_state = "dragon_swoop"
	if(negative)
		animate(src, pixel_x = -DRAKE_SWOOP_HEIGHT, pixel_z = DRAKE_SWOOP_HEIGHT, time = 7)
	else
		animate(src, pixel_x = DRAKE_SWOOP_HEIGHT, pixel_z = DRAKE_SWOOP_HEIGHT, time = 7)

/obj/effect/temp_visual/dragon_flight/end
	pixel_x = DRAKE_SWOOP_HEIGHT
	pixel_z = DRAKE_SWOOP_HEIGHT
	duration = 10

/obj/effect/temp_visual/dragon_flight/end/flight(negative)
	if(negative)
		pixel_x = -DRAKE_SWOOP_HEIGHT
		animate(src, pixel_x = -32, pixel_z = 0, time = 5)
	else
		animate(src, pixel_x = -32, pixel_z = 0, time = 5)

/obj/effect/temp_visual/target/ex_act()
	return

/obj/effect/temp_visual/target/Initialize(mapload, list/flame_hit)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fall), flame_hit)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/chain_lightning(var/list/targets, mob/user = usr)
	targets = list()
	cl_cd = world.time + 500

	for(var/mob/living/target in view(7, src))
		if(target == src)
			continue
		if(istype(target,/mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk))
			continue
		targets += target
	src.move_resist = MOVE_FORCE_VERY_STRONG
	var/mob/living/carbon/target = targets[1]
	var/distance = get_dist(user.loc,target.loc)
	if(distance>3)
		to_chat(user, span_colossus("[target.p_theyre(TRUE)] too far away!"))

		return
	if(do_after(user, 2 SECONDS, target = src))
		user.Beam(target,icon_state="lightning[rand(1,12)]",time=5)
		src.visible_message(span_colossus("[src] unleashes a storm of lightning from it's maw."))
		Bolt(user,target,30,5,user)
		src.move_resist = initial(src.move_resist)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/Bolt(mob/origin,mob/target,bolt_energy,bounces,mob/user = usr)
	origin.Beam(target,icon_state="lightning[rand(1,12)]",time=5)
	var/mob/living/carbon/current = target
	if(current.anti_magic_check())
		current.visible_message(span_warning("[current] absorbs the spell, remaining unharmed!"), span_danger("I absorb the spell, remaining unharmed!"))
	else if(bounces < 1)
		current.electrocute_act(bolt_energy,"Lightning Bolt",flags = SHOCK_NOGLOVES)
	else
		current.electrocute_act(bolt_energy,"Lightning Bolt",flags = SHOCK_NOGLOVES)
		var/list/possible_targets = new
		for(var/mob/living/M in view(7,target))
			if(user == M || target == M && los_check(current,M)) // || origin == M ? Not sure double shockings is good or not
				continue
			possible_targets += M
		if(!possible_targets.len)
			return
		var/mob/living/next = pick(possible_targets)
		if(next)
			Bolt(current,next,max((bolt_energy-5),5),bounces-1,user)

/mob/living/simple_animal/hostile/retaliate/rogue/voiddragon/proc/los_check(mob/A,mob/B)
	//Checks for obstacles from A to B
	var/obj/dummy = new(A.loc)
	dummy.pass_flags |= PASSTABLE
	for(var/turf/turf in getline(A,B))
		for(var/atom/movable/AM in turf)
			if(!AM.CanPass(dummy,turf,1))
				qdel(dummy)
				return 0
	qdel(dummy)
	return 1

/obj/effect/proc_holder/spell/aoe_turf/repulse/voiddragon
	name = "Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail."
	sound = 'sound/misc/tail_swing.ogg'
	charge_max = 150
	clothes_req = FALSE
	cooldown_min = 150
	invocation_type = "none"
	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep
	action_icon_state = "tailsweep"
	action_background_icon_state = "bg_alien"
	anti_magic_check = FALSE
	range = 2

/obj/effect/proc_holder/spell/aoe_turf/repulse/voiddragon/cast(list/targets, mob/user = usr)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		playsound(C.loc, 'sound/combat/hits/punch/punch_hard (3).ogg', 80, TRUE, TRUE)
		C.spin(6, 1)
	..(targets, user, 3)

#undef DRAKE_SWOOP_HEIGHT
#undef DRAKE_SWOOP_DIRECTION_CHANGE_RANGE
#undef SWOOP_DAMAGEABLE
#undef SWOOP_INVULNERABLE