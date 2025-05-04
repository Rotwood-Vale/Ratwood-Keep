// Uncomment this for NPCs to display their 'thoughts' above their heads.
// #define NPC_THINK_DEBUG
#ifdef NPC_THINK_DEBUG
#define NPC_THINK(message) visible_message(message, runechat_message = message)
#else
#define NPC_THINK(message)
#endif

/mob/living/carbon/human
	var/aggressive=0 //0= retaliate only
	var/frustration=0
	var/pathing_frustration=0
	var/pickupTimer=0
	var/list/enemies = list()
	var/list/friends = list()
	var/mob/living/target
	var/obj/item/pickupTarget
	var/mode = NPC_AI_OFF
	var/list/myPath = list()
	var/is_currently_pathing = FALSE
	var/list/blacklistItems = list()
	var/maxStepsTick = 6
	var/resisting = FALSE
	var/pickpocketing = FALSE
	var/del_on_deaggro = null
	var/last_aggro_loss = null
	var/wander = TRUE
	var/ai_when_client = FALSE
	var/next_idle = 0
	var/next_seek = 0
	var/next_stand = 0
	var/next_passive_detect = 0
	var/flee_in_pain = FALSE
	/// When is the next time we'll attempt to stand up?
	var/next_stand_attempt = 0
	var/ai_currently_active = FALSE

	var/returning_home = FALSE

/mob/living/carbon/human/proc/IsStandingStill()
	return doing || resisting || pickpocketing

/mob/living/carbon/human/proc/handle_ai()
	if(client)
		if(!ai_when_client)
			return
	START_PROCESSING(SShumannpc,src)

/mob/living/carbon/human/proc/process_ai()
	if(IsDeadOrIncap())
		walk_to(src,0)
		return stat == DEAD // only stop processing if we're dead-dead
	// we assume we're conscious after this point since we aren't dead or incapacitated
	if(client)
		if(!ai_when_client)
			walk_to(src,0)
			return TRUE //remove us from processing
	cmode = 1
	update_cone_show()
	if(resisting) // already busy from a prior turn! stop!
		walk_to(src, 0)
		NPC_THINK("Still resisting, passing turn!")
		return // Your turn is already being used to continue a resist.
	if(on_fire || buckled || restrained() || pulledby)
		resisting = TRUE
		walk_to(src,0)
		NPC_THINK("Starting to resist!")
		resist()
		resisting = FALSE
		return // Resisting passes your turn, you can't attack.
	if(!(mobility_flags & MOBILITY_STAND) && (world.time >= next_stand_attempt))
		resisting = TRUE
		npc_stand()
		resisting = FALSE
		return // Standing passes your turn, you can't attack.
	if(!handle_combat())
		if(mode == NPC_AI_IDLE && !pickupTarget)
			npc_idle()
			if(del_on_deaggro && last_aggro_loss && (world.time >= last_aggro_loss + del_on_deaggro))
				if(deaggrodel())
					return TRUE

/mob/living/carbon/human/proc/npc_stand()
	if(next_move > world.time)
		return
	walk_to(src, 0) // no walking while you stand up
	NPC_THINK("Trying to stand!")
	if(stand_up())
		next_stand_attempt = world.time
	else
		// Wait 1-3 seconds between attempts.
		next_stand_attempt = world.time + rand(1 SECONDS, 3 SECONDS)

/mob/living/carbon/human/proc/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle + rand(3 SECONDS, 5 SECONDS))
		return
	NPC_THINK("Idle...")
	next_idle = world.time + rand(3 SECONDS, 5 SECONDS)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc))
		if(wander)
			if(prob(50))
				var/turf/T = get_step(loc,pick(GLOB.cardinals))
				if(T.can_traverse_safely(src)) // Don't wander into lava or open space unless we're immune to it/can't fall.
					step_towards(src, T, update_movespeed())
			else
				setDir(turn(dir, pick(90,-90)))
		else
			setDir(turn(dir, pick(90,-90)))
	if(prob(3))
		emote("idle")

/mob/living/carbon/human/proc/deaggrodel()
	if(aggressive)
		for(var/mob/living/L in view(7)) // scan for enemies
			if( should_target(L) && (L != src))
				if(L.stat != DEAD)
					retaliate(L)
					return FALSE
	if(!target)
//		var/escape_path
//		for(var/obj/structure/flora/RT in view(6, src))
//			if(istype(RT,/obj/structure/flora/roguetree/stump))
//				continue
//			if(istype(RT,/obj/structure/flora/roguetree))
//				escape_path = RT
//				break
//			if(istype(RT,/obj/structure/flora/rogueshroom))
//				escape_path = RT
//				break
	//	if(escape_path)
		qdel(src)
		return TRUE

/// unsets my_path if it's not valid. that's it that's the proc
/mob/living/carbon/human/proc/validate_path()
	var/give_up = FALSE
	if(pathing_frustration > 8)
		NPC_THINK("Giving up on this path because of frustration!")
		give_up = TRUE
	if(length(myPath) && get_dist(src, myPath[1]) > 5)
		NPC_THINK("Giving up on this path because of distance!")
		give_up = TRUE
	if(give_up)
		myPath = list()
		pathing_frustration = 0
	return !give_up // returns TRUE if the path is valid, FALSE otherwise

/// progress along an existing path or cancel it
/// returns # of steps taken
/mob/living/carbon/human/proc/move_along_path()
	if(!length(myPath))
		// no path, quit early
		NPC_THINK("Tried to move along a nonexistent path?!")
		return 0
	if(get_dist(src, myPath[1]) > 3) // too far away from our current path to continue
		pathing_frustration++
		NPC_THINK("TOO FAR! Strike [pathing_frustration]!")
		return 0
	// var/move_started = world.time
	for(var/i = 0; i < maxStepsTick; i++)
		if(!length(myPath))
			NPC_THINK("MOVEMENT TURN [i]: Path complete!")
			return
		else if(!validate_path())
			NPC_THINK("MOVEMENT TURN [i]: Path invalidated!")
			return
		// We have a valid path, but our target might be next to us due to movement. Check and bail if so.
		// This logic will have to change if we ever use A* to pathfind to something that isn't our target var.
		else if(target && z == target.z && Adjacent(target))
			myPath = list()
			pathing_frustration = 0
			return
		var/movespeed = update_movespeed()
		if(!(mobility_flags & MOBILITY_MOVE) || IsDeadOrIncap() || IsStandingStill() || is_move_blocked_by_grab())
			NPC_THINK("MOVEMENT TURN [i]: Waiting to move!")
			sleep(1) // wait 1ds to see if we're finished/recovered
			continue
		// this is unnecessary, we don't re-call handle_ai until this is done
/* 		if(world.time > (move_started + /datum/controller/subsystem/humannpc::wait))
			// we ran out of time and started the next tick!
			NPC_THINK("MOVEMENT TURN [i]: Out of time to move!")
			return */
		var/turf/next_path_turf = myPath[1]
		var/move_dir = get_dir(src, myPath[1])
		var/turf/next_step = get_step(src, move_dir)
		if(next_path_turf.z != z) // if moving up or down z-levels, need specific checks
			var/obj/structure/stairs/the_stairs = locate() in get_turf(src)
			// if moving up, go in the direction of the stairs, else go the opposite direction
			move_dir = next_path_turf.z > z ? the_stairs.dir : GLOB.reverse_dir[the_stairs.dir]
			next_step = the_stairs.get_target_loc(move_dir)
		if(!next_step)
			pathing_frustration++
			NPC_THINK("MOVEMENT TURN [i]: Unable to find turf to move to! Strike [pathing_frustration]!")
			myPath -= myPath[1]
			continue
		if(!step(src, move_dir)) // try to move onto or along our path
			for(var/obj/structure/O in next_step)
				if(O.density && O.climbable)
					NPC_THINK("MOVEMENT TURN [i]: Trying to climb over [O]!")
					O.climb_structure(src)
					break
		if(loc != next_step) // movement failed and so did climb_structure
			pathing_frustration++
			NPC_THINK("MOVEMENT TURN [i]: Move failed! Strike [pathing_frustration]!")
			sleep(1)
		else if(loc == myPath[1]) // if we made it to the right part of our path
			.++
			pathing_frustration = 0
			myPath -= myPath[1]
			NPC_THINK("MOVEMENT TURN [i]: Movement on cooldown for [movespeed/10] seconds!")
			sleep(movespeed) // wait until next move

// blocks, but only while path is being calculated
/mob/living/carbon/human/proc/start_pathing_to(new_target)
	if(!new_target)
		back_to_idle()
		return FALSE

	var/turf/turf_of_target = get_turf(new_target)
	if(!turf_of_target)
		back_to_idle()
		return FALSE
	if(is_currently_pathing)
		NPC_THINK("Already pathing!")
		return FALSE
	if(!length(myPath)) // need a new path
		var/const/MAX_RANGE_FIND = 32
		NPC_THINK("Pathfinding...")
		is_currently_pathing = TRUE
		myPath = get_path_to(src, turf_of_target, TYPE_PROC_REF(/turf, Heuristic_cardinal_3d), MAX_RANGE_FIND + 1, 250,1, adjacent = TYPE_PROC_REF(/turf, reachableTurftest3d))
		is_currently_pathing = FALSE
		if(length(myPath))
			myPath -= get_turf(src) // remove the turf we start on
			pathing_frustration = 0
			NPC_THINK("Found a path with length [length(myPath)]!")
			return TRUE
	NPC_THINK("Failed to find a path!")
	//too far away or pathing failed
	back_to_idle()
	return FALSE

// taken from /mob/living/carbon/human/interactive/
/mob/living/carbon/human/proc/IsDeadOrIncap(checkDead = TRUE)
	if(!(mobility_flags & MOBILITY_FLAGS_INTERACTION))
		return TRUE
	if(health <= 0 && checkDead)
		return TRUE
	if(incapacitated(ignore_restraints = TRUE))
		return TRUE
	return FALSE


/mob/living/carbon/human/proc/equip_item(obj/item/I)
	if(I.loc == src)
		return TRUE

	if(I.anchored)
		blacklistItems[I] ++
		return FALSE

	// WEAPONS
	if(istype(I, /obj/item))
		if(put_in_hands(I))
			return TRUE

	blacklistItems[I] ++
	return FALSE

/mob/living/carbon/human/proc/pickup_and_wear(obj/item/clothing/C)
	if(!equip_to_appropriate_slot(C))
		monkeyDrop(get_item_by_slot(C)) // remove the existing item if worn
		addtimer(CALLBACK(src, PROC_REF(equip_to_appropriate_slot), C), 5)

/mob/living/carbon/human/proc/monkeyDrop(obj/item/A)
	if(A)
		dropItemToGround(A, TRUE)

/mob/living/carbon/human/resist_restraints()
	var/obj/item/I = null
	if(handcuffed)
		I = handcuffed
	else if(legcuffed)
		I = legcuffed
	if(I)
		changeNext_move(CLICK_CD_BREAKOUT)
		last_special = world.time + CLICK_CD_BREAKOUT
		cuff_resist(I)

/mob/living/carbon/human/proc/should_target(mob/living/L)
	if(HAS_TRAIT(src, TRAIT_PACIFISM))
		return FALSE

	if(L == src)
		return FALSE
	
	// hugbox spawn protection
	if(L.status_flags & GODMODE)
		return FALSE

	if (L.alpha == 0 && L.rogue_sneaking)
		return FALSE

	if(!is_in_zweb(src.z,L.z))
		return FALSE

	if(L.stat == DEAD)
		return FALSE

	if(L.InFullCritical())
		return FALSE

	if(L.name in friends)
		return FALSE

	if(enemies[L])
		return TRUE

	if(aggressive && !faction_check_mob(L))
		return TRUE

	return FALSE

/mob/living/carbon/human/proc/handle_combat()
	switch(mode)
		if(NPC_AI_IDLE)		// idle
			if(world.time >= next_seek)
				NPC_THINK("Seeking for targets...")
				next_seek = world.time + 3 SECONDS
				for(var/mob/living/L in view(7, src)) // scan for enemies
					if(should_target(L))
						retaliate(L)
					if (world.time >= next_passive_detect && L.alpha == 0 && L.rogue_sneaking && prob(STAPER / 2))
						if (!npc_detect_sneak(L, -20)) // attempt a passive detect with 20% increased difficulty
							next_passive_detect = world.time + STAPER SECONDS

		if(NPC_AI_HUNT)		// hunting for attacker
			// basic behavior chain: targeting > fleeing > picking up a weapon > attacking
			if(target)
				if(!should_target(target))
					if (target.alpha == 0 && target.rogue_sneaking) // attempt one detect since we were just fighting them and have lost them
						if (npc_detect_sneak(target))
							retaliate(target)
					else
						back_to_idle()
						return TRUE
				m_intent = MOVE_INTENT_WALK
				validate_path()
				if(!length(myPath)) // create a new path to the target
					start_pathing_to(target)
				// move along the existing path if we have one
				if(length(myPath) && move_along_path()) // If we successfully moved, finish our turn
					return TRUE

			// Flee before trying to pick up a weapon.
			if(flee_in_pain && target && (target.stat == CONSCIOUS))
				var/paine = get_complex_pain()
				if(paine >= ((STAEND * 10)*0.75)) // pain threshold decreased from END*10*0.9 due to all NPCs having insane END for some reason
					NPC_THINK("Ouch! Entering flee mode!")
					mode = NPC_AI_FLEE
					m_intent = MOVE_INTENT_RUN
					myPath = list() // cancel chasing our target
					return TRUE

			if(!get_active_held_item() && !get_inactive_held_item() && !mind?.has_antag_datum(/datum/antagonist/zombie))
				// pickup any nearby weapon
				for(var/obj/item/I in view(1,src))
					if(!isturf(I.loc))
						continue
					if(blacklistItems[I])
						continue
					if(I.force > 7)
						equip_item(I)

			// if can't reach target for long enough, go idle
			if(frustration >= 15)
				back_to_idle()
				return TRUE

			if(Adjacent(target) && isturf(target.loc))	// if right next to perp
				frustration = 0
				face_atom(target)
				monkey_attack(target)
				return TRUE
			else								// not next to perp
				frustration++

		if(NPC_AI_FLEE)
			var/const/NPC_FLEE_DISTANCE = 8
			var/flee_target = target
			if(!flee_target)
				// try to flee from any enemies who aren't incapacitated
				for(var/mob/living/bystander in view(src))
					if(enemies[bystander])
						if(ishuman(bystander))
							var/mob/living/carbon/human/human_bystander = bystander
							if(human_bystander.IsDeadOrIncap())
								continue
						else if(stat != CONSCIOUS)
							continue
						// found an enemy who might be able to hurt us
						flee_target = bystander
			if(!flee_target || get_dist(src, flee_target) >= NPC_FLEE_DISTANCE)
				NPC_THINK("Done fleeing!")
				back_to_idle()
			else if(!is_move_blocked_by_grab()) // try to run offscreen if we aren't being grabbed by someone else
				NPC_THINK("Fleeing from [flee_target]!")
				// todo: use A* to find the shortest path to the farthest tile away from the flee target?
				walk_away(src, target, NPC_FLEE_DISTANCE, update_movespeed())
			else // can't flee and can't move, stop walking!
				NPC_THINK("I can't flee from [flee_target]!")
				walk(src, 0)
			return TRUE

	return IsStandingStill()


/mob/living/carbon/human/proc/back_to_idle()
	last_aggro_loss = world.time
	NPC_THINK("Losing interest in [target]!")
	if(pulling)
		stop_pulling()
	myPath = list()
	mode = NPC_AI_IDLE
	m_intent = MOVE_INTENT_WALK
	target = null
	a_intent = INTENT_HELP
	frustration = 0
	walk_to(src,0)

// attack using a held weapon otherwise bite the enemy, then if we are angry there is a chance we might calm down a little
/mob/living/carbon/human/proc/monkey_attack(mob/living/L)
	if(next_move > world.time)
		return
	var/obj/item/Weapon = get_active_held_item()
	var/obj/item/OffWeapon = get_inactive_held_item()
	if(Weapon && OffWeapon)
		if(OffWeapon.force > Weapon.force)
			swap_hand()
			Weapon = get_active_held_item()
			OffWeapon = get_inactive_held_item()
	if(!Weapon)
		swap_hand()
		Weapon = get_active_held_item()
		OffWeapon = get_inactive_held_item()
	if(!(mobility_flags & MOBILITY_STAND))
		aimheight_change(rand(1,4)) // Go for the knees!
	else
		aimheight_change(pick(rand(5, 8), rand(9, 11), rand(12,19))) // Arms, chest, head. Equal chance for each.
	NPC_THINK("Aiming for \the [zone_selected]!")

	// attack with weapon if we have one
	if(Weapon)
		if(!Weapon.wielded)
			if(Weapon.force_wielded > Weapon.force)
				if(!OffWeapon)
					Weapon.attack_self(src)
		rog_intent_change(1)
		used_intent = a_intent
		Weapon.melee_attack_chain(src, L)
	else
		rog_intent_change(4)
		used_intent = a_intent
		UnarmedAttack(L,1)

	var/adf = used_intent.clickcd
	if(istype(rmb_intent, /datum/rmb_intent/aimed))
		adf = round(adf * 1.4)
	if(istype(rmb_intent, /datum/rmb_intent/swift))
		adf = round(adf * 0.6)
	changeNext_move(adf)

	// no de-aggro
	if(aggressive)
		return

// get angry at a mob
/mob/living/carbon/human/proc/retaliate(mob/living/L)
	if(!wander)
		wander = TRUE
	if(L == src)
		return
	if(mode != NPC_AI_OFF)
		if(L.alpha == 0 && L.rogue_sneaking)
			// we just got hit by something hidden so try and find them
			if (prob(5))
				visible_message(span_notice("[src] begins searching around frantically..."))
			var/extra_chance = (health <= maxHealth * 50) ? 30 : 0 // if we're below half health, we're way more alert
			if (!npc_detect_sneak(L, extra_chance))
				return
		NPC_THINK("Hunting [L]!")
		mode = NPC_AI_HUNT
		// Interrupt ongoing actions on-hit, except for standing up or resisting.
		if(!resisting && (mobility_flags & MOBILITY_STAND))
			doing = FALSE
		last_aggro_loss = null
		face_atom(L)
		if(!target)
			emote("aggro")
		target = L
		enemies |= L

/mob/living/proc/npc_detect_sneak(mob/living/target, extra_prob = 0)
	if (target.alpha > 0 || !target.rogue_sneaking)
		return TRUE
	var/probby = 4 * STAPER //this is 10 by default - npcs get an easier time to detect to slightly thwart cheese
	probby += extra_prob
	var/sneak_bonus = 0
	if(target.mind)
		if (world.time < target.mob_timers[MT_INVISIBILITY])
			// we're invisible as per the spell effect, so use the highest of our arcane magic (or holy) skill instead of our sneaking
			sneak_bonus = (max(target.mind?.get_skill_level(/datum/skill/magic/arcane), target.mind?.get_skill_level(/datum/skill/magic/holy)) * 10)
			probby -= 20 // also just a fat lump of extra difficulty for the npc since spells are hard, you know?
		else
			sneak_bonus = (target.mind?.get_skill_level(/datum/skill/misc/sneaking) * 5)
		probby -= sneak_bonus
	if(!target.check_armor_skill())
		probby += 85 //armor is loud as fuck
		if (sneak_bonus)
			probby += sneak_bonus // you don't get sneak bonus in heavy armor at all, on top of that
	if (target.badluck(5))
		probby += (10 - target.STALUC) * 5 // drop 5% chance for every bit of fortune we're missing
	if (target.goodluck(5))
		probby -= (10 - target.STALUC) * 5 // make it 5% harder for every bit of fortune over 10 that we do have

	if (prob(probby))
		// whoops it saw us
		target.mob_timers[MT_FOUNDSNEAK] = world.time
		to_chat(target, span_danger("[src] sees me! I'm found!"))
		target.update_sneak_invis(TRUE)
		return TRUE
	else
		return FALSE

/mob/living/carbon/human/attackby(obj/item/W, mob/user, params)
	. = ..()
	if((W.force) && (!target) && (W.damtype != STAMINA) )
		retaliate(user)
