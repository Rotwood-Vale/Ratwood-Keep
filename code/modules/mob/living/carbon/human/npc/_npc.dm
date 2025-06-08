/mob/living/carbon/human
	var/aggressive=0 //0= retaliate only
	var/frustration=0
	var/pathing_frustration=0
	var/pickupTimer=0
	var/list/enemies = list()
	var/list/friends = list()
	var/mob/living/target
	var/obj/item/pickupTarget
	var/atom/pathfinding_target
	var/mode = NPC_AI_OFF
	var/list/myPath = list()
	var/is_currently_pathing = FALSE
	var/list/blacklistItems = list()
	var/maxStepsTick = 7 // can move a screen's width in one turn
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
	/// (BOOL) If TRUE, the mob will taunt players in certain situations. Psychological warfare!
	var/rude = FALSE
	/// (BOOL) If TRUE, the mob will attempt to climb trees to chase players. Evil!
	var/tree_climber = FALSE
	/// The number of steps moved so far, used to limit the total number of steps per turn + affect attack reaction time
	var/steps_moved_this_turn = 0
	/// Whether or not to check for targets above us.
	var/find_targets_above = TRUE
	
	// LEAPING
	/// The probability that an NPC will leap/jump if certain conditions are met.
	var/npc_jump_chance = 5
	/// If the NPC's target is more than this many tiles away, they will try to leap ahead on their path.
	var/npc_jump_distance = 4
	/// When above this amount of stamina, the NPC will not attempt to jump.
	var/npc_max_jump_stamina = 80

/mob/living/carbon/human/proc/IsStandingStill()
	return doing || resisting || pickpocketing

/mob/living/carbon/human/proc/handle_ai()
	if(client)
		if(!ai_when_client)
			return
	START_PROCESSING(SShumannpc,src)

/mob/living/carbon/human/proc/check_mouth_grabbed()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	if(!head)
		return FALSE
	for(var/obj/item/grabbing/grab in head.grabbedby)
		if(grab.sublimb_grabbed == BODY_ZONE_PRECISE_MOUTH)
			return TRUE
	return FALSE

/mob/living/carbon/human/species/deadite/npc_should_resist(ignore_grab = TRUE)
	if(!check_mouth_grabbed())
		ignore_grab ||= TRUE
	return ..(ignore_grab = ignore_grab)

/mob/living/carbon/human/proc/npc_should_resist(ignore_grab = FALSE)
	// zombie antags don't try to resist non-mouthgrabs
	if(mind?.has_antag_datum(/datum/antagonist/zombie) && !check_mouth_grabbed())
		ignore_grab ||= TRUE
	if(on_fire || buckled || restrained(ignore_grab = ignore_grab))
		return TRUE
	return FALSE

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
	steps_moved_this_turn = 0
	if(resisting) // already busy from a prior turn! stop!
		walk_to(src, 0)
		NPC_THINK("Still resisting, passing turn!")
		return // Your turn is already being used to continue a resist.
	if(npc_should_resist())
		resisting = TRUE
		walk_to(src,0)
		NPC_THINK("Starting to resist!")
		resist()
		resisting = FALSE
		return // Resisting passes your turn, you can't attack.
	if((mobility_flags & MOBILITY_CANSTAND) && !(mobility_flags & MOBILITY_STAND) && (world.time >= next_stand_attempt))
		resisting = TRUE
		npc_stand()
		resisting = FALSE
		return // Standing passes your turn, you can't attack.
	// If we're pathfinding somewhere, move along that path
	if(length(myPath))
		steps_moved_this_turn += move_along_path()
		// We could return here if we wanted to make moving use your turn.
	// Special case: Taunt people hiding in trees directly above us.
	var/turf/my_turf = get_turf(src)
	var/turf/their_turf = get_turf(target)
	if(!IsDeadOrIncap() && !length(myPath) && their_turf && my_turf.z < their_turf.z && my_turf.Distance_cardinal_3d(their_turf, src) == 1 && istransparentturf(their_turf))
		// They're directly above us, now are they in a tree?
		var/obj/structure/flora/newbranch/the_branch = locate() in their_turf
		var/should_try_taunt = prob(5) // this is a var so that when debugging i can just set it to TRUE
		if(tree_climber && can_zTravel(their_turf, UP)) // TIME TO BE EVIL
			if(the_branch)
				// follow the branch to get to the tree
				var/obj/structure/flora/newtree/the_tree = locate() in get_step_multiz(the_branch, GLOB.reverse_dir[the_branch.dir]|DOWN)
				the_tree.attack_hand(src)
				return TRUE // climbing uses your turn
		else if(rude && should_try_taunt) // taunt the enemy!
			npc_taunt_target()
			// don't return, taunting is a free action
	if(!handle_combat())
		if(mode == NPC_AI_IDLE && !pickupTarget)
			npc_idle()
			if(del_on_deaggro && last_aggro_loss && (world.time >= last_aggro_loss + del_on_deaggro))
				if(deaggrodel())
					return TRUE

// separate override to ensure it happens last
/mob/living/carbon/human/process_ai()
	. = ..()
	// TODO: Better converted-deadite AI than this.
	if(mind?.has_antag_datum(/datum/antagonist/zombie))
		try_do_deadite_idle() // sort of a misnomer, just handles zombie noises

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
					step_towards(src, T, cached_multiplicative_slowdown)
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

/// Attempts to jump towards our next pathfinding step if it's far enough, or our target if we don't have a path planned.
/mob/living/carbon/human/proc/npc_try_jump(force = FALSE)
	if(!prob(npc_jump_chance))
		return FALSE
	if(next_move > world.time) // Jumped too recently!
		return FALSE
	if(stamina > npc_max_jump_stamina)
		return FALSE
	var/turf/our_turf = get_turf(src)
	if(our_turf.Distance_cardinal(get_turf(target), src) <= npc_jump_distance)
		return FALSE
	if(!check_armor_skill() || get_item_by_slot(SLOT_LEGCUFFED)) // don't even try if we could only make it 1 tile
		return FALSE
	// Find the turf to jump to.
	var/atom/jump_destination
	var/old_m_intent = m_intent
	m_intent = MOVE_INTENT_RUN
	var/jump_range = get_jump_range()
	var/squared_jump_range = jump_range ** 2
	/// used when trying to intentionally overshoot to move quicker
	var/squared_jump_range_bonus = HAS_TRAIT(src, TRAIT_LEAPER) ? squared_jump_range : (jump_range + 1) ** 2
	// if we have no path or can try to jump ahead in a straight line, try it
	if(!length(myPath) || inLineOfTravel(src, target))
		jump_destination = target
	else
		// Find the farthest-along tile in our path that's within range and closest to our target.
		// Basically: Try to cut ahead.
		var/min_squared_distance = INFINITY
		for(var/i in 1 to length(myPath))
			var/turf/new_destination = myPath[i]
			var/new_squared_distance = get_dist_euclidean_squared(target, new_destination)
			var/new_jump_dist = get_dist_euclidean_squared(src, new_destination)
			if(!new_destination.can_traverse_safely(src))
				continue
			if(new_squared_distance > min_squared_distance)
				continue
			// Handle intentional overshoot
			if(new_jump_dist > squared_jump_range && squared_jump_range_bonus > new_jump_dist)
				var/turf/prior_turf = get_step_towards(new_destination, src) // backtrack a tile
				if(!prior_turf.can_traverse_safely(src)) // we'd be in danger if we tried to overshoot
					continue
			if(new_jump_dist <= squared_jump_range_bonus && inLineOfTravel(src, new_destination))
				jump_destination = new_destination
				min_squared_distance = new_squared_distance
	if(!jump_destination)
		return FALSE
	var/jump_dist = get_dist_euclidean_squared(src, jump_destination)
	if(jump_dist < (jump_range - 1) ** 2) // check if we can just do a slower jump to save stam
		m_intent = MOVE_INTENT_WALK
	else if(!HAS_TRAIT(src, TRAIT_LEAPER)) // handle overshoot checks
		if(jump_dist <= squared_jump_range) // we're not intending to explicitly overshoot
			var/overshoot_dir = get_dir(src, jump_destination)
			var/turf/overshoot_turf = get_step(jump_destination, overshoot_dir)
			if(overshoot_turf.density || !overshoot_turf.can_traverse_safely(src))
				// we'd overshoot and land somewhere unsafe, or slam into a wall
				return FALSE
	if(jump_dist > 1)
		NPC_THINK("Trying to jump to [jump_destination]!")
		if(mmb_intent?.type != INTENT_JUMP)
			mmb_intent = new INTENT_JUMP(src) // switch to jump intent
		used_intent = mmb_intent
		. = try_jump(jump_destination) // return whether the jump succeeded or failed
		QDEL_NULL(mmb_intent) // unset our intent after
		m_intent = old_m_intent
		if(.)
			start_pathing_to(target) // regenerate path now that we've jumped
		return
	m_intent = old_m_intent
	return FALSE

/// Force the NPC to jump to a specific destination. Handles 
/mob/living/carbon/human/proc/npc_try_jump_to(atom/jump_destination)
	if(!jump_destination)
		return FALSE
	if(next_move > world.time) // Jumped too recently!
		return FALSE
	var/old_m_intent = m_intent
	m_intent = MOVE_INTENT_RUN
	var/jump_range = get_jump_range()
	var/jump_dist = get_dist_euclidean_squared(src, jump_destination)
	if(jump_dist < (jump_range - 2) ** 2) // check if we can just do a slower jump to save stam
		m_intent = MOVE_INTENT_WALK
	if(jump_dist > 0)
		NPC_THINK("Trying to jump to [jump_destination]!")
		if(mmb_intent?.type != INTENT_JUMP)
			mmb_intent = new INTENT_JUMP(src) // switch to jump intent
		used_intent = mmb_intent
		. = try_jump(jump_destination) // return whether the jump succeeded or failed
		used_intent = null
		QDEL_NULL(mmb_intent) // unset our intent after
		m_intent = old_m_intent
		return
	m_intent = old_m_intent
	return FALSE

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
		clear_path()
	return !give_up // returns TRUE if the path is valid, FALSE otherwise

/mob/living/carbon/human/proc/clear_path()
	myPath = list()
	pathing_frustration = 0
	pathfinding_target = null

/// progress along an existing path or cancel it
/// returns # of steps taken
/mob/living/carbon/human/proc/move_along_path()
	if(!length(myPath))
		// no path, quit early
		NPC_THINK("Tried to move along a nonexistent path?!")
		return 0
	if(get_dist(src, myPath[1]) > 3) // too far away from our current path to continue
		if(!npc_try_jump()) // try jumping to get back on course
			pathing_frustration++
			NPC_THINK("TOO FAR! Strike [pathing_frustration]!")
			return 0
	// var/move_started = world.time
	var/old_pathfinding_target = pathfinding_target
	var/steps_to_take = maxStepsTick - steps_moved_this_turn // if this isn't our first movement step, limit how many we can take
	for(var/movement_turn in 1 to steps_to_take)
		if(!length(myPath))
			NPC_THINK("MOVEMENT TURN [movement_turn]: Path complete!")
			return
		// Try jumping prior to validation to avoid losing our path from being too far away.
		// Basically a catch-up step. Won't run every time.
		if(npc_try_jump())
			NPC_THINK("MOVEMENT TURN [movement_turn]: Jumped, waiting 1ds!")
			sleep(1)
			continue
		if(!validate_path())
			NPC_THINK("MOVEMENT TURN [movement_turn]: Path invalidated!")
			return
		if(pathfinding_target != old_pathfinding_target)
			NPC_THINK("Changed pathfinding target, ending movement!")
			return
		// We have a valid path, but our target might be next to us due to movement. Check and bail if so.
		// Only apply this to movables; if we're going to a specific turf we want to go ONTO it.
		else if(ismovable(pathfinding_target) && z == pathfinding_target.z && Adjacent(pathfinding_target))
			clear_path()
			return
		var/movespeed = cached_multiplicative_slowdown // this is recalculated on Moved() so we don't need to do it ourselves
		if(!(mobility_flags & MOBILITY_MOVE) || IsDeadOrIncap() || IsStandingStill() || is_move_blocked_by_grab())
			NPC_THINK("MOVEMENT TURN [movement_turn]: Waiting to move!")
			sleep(1) // wait 1ds to see if we're finished/recovered
			continue
		// this is unnecessary, we don't re-call handle_ai until this is done
/* 		if(world.time > (move_started + /datum/controller/subsystem/humannpc::wait))
			// we ran out of time and started the next tick!
			NPC_THINK("MOVEMENT TURN [movement_turn]: Out of time to move!")
			return */
		var/turf/next_path_turf = myPath[1]
		var/move_dir = get_dir(src, myPath[1])
		var/turf/next_step = get_step(src, move_dir)
		if(next_path_turf.z != z) // if moving up or down z-levels, need specific checks
			var/obj/structure/stairs/the_stairs = locate() in get_turf(src)
			if(!the_stairs && HAS_TRAIT(src, TRAIT_ZJUMP)) // do a fancy Z-jump!
				if(npc_try_jump_to(next_path_turf))
					pathing_frustration = 0
					myPath -= myPath[1]
					NPC_THINK("MOVEMENT TURN [movement_turn]: Z-jump succeeded, movement on cooldown for [movespeed/10] seconds!")
					sleep(movespeed) // wait until next move
				else
					var/time_to_wait = AmountOffBalanced() || (1 SECONDS)
					NPC_THINK("MOVEMENT TURN [movement_turn]: Z-jump failed, trying again in [time_to_wait/10] seconds!")
					pathing_frustration++
					sleep(time_to_wait)
				continue
			// if moving up, go in the direction of the stairs, else go the opposite direction
			move_dir = next_path_turf.z > z ? the_stairs.dir : GLOB.reverse_dir[the_stairs.dir]
			next_step = the_stairs.get_target_loc(move_dir)
		if(!next_step)
			pathing_frustration++
			NPC_THINK("MOVEMENT TURN [movement_turn]: Unable to find turf to move to! Strike [pathing_frustration]!")
			myPath -= myPath[1]
			continue
		if(!next_step.can_traverse_safely(src)) // some sort of hazard we'd want to jump over!
			var/old_m_intent = m_intent
			var/turf/jump_turf = LAZYACCESS(myPath, 2)
			if(jump_turf && !jump_turf.can_traverse_safely(src)) // we can jump 2-tile gaps if we sprint
				jump_turf = LAZYACCESS(myPath, 3)
				if(jump_turf)
					m_intent = MOVE_INTENT_RUN
			if(!jump_turf) // our path's screwed, give up and try again later
				clear_path()
				return
			var/did_jump = npc_try_jump_to(jump_turf)
			m_intent = old_m_intent
			if(did_jump)
				myPath.Cut(1, 3)
				pathing_frustration = 0
				NPC_THINK("MOVEMENT TURN [movement_turn]: Movement on cooldown for [movespeed/10] seconds!")
				sleep(movespeed) // wait until next move
			else
				var/time_to_wait = AmountOffBalanced() || (1 SECONDS)
				NPC_THINK("MOVEMENT TURN [movement_turn]: Jump failed, trying again in [time_to_wait/10] seconds!")
				pathing_frustration++
				sleep(time_to_wait)
			continue
		else if(!step(src, move_dir, cached_multiplicative_slowdown)) // try to move onto or along our path
			for(var/obj/structure/O in next_step)
				if(O.density && O.climbable)
					NPC_THINK("MOVEMENT TURN [movement_turn]: Trying to climb over [O]!")
					O.climb_structure(src)
					break
		if(loc != next_step) // movement failed and so did climb_structure
			pathing_frustration++
			NPC_THINK("MOVEMENT TURN [movement_turn]: Move failed! Strike [pathing_frustration]!")
			sleep(1)
		else if(loc == myPath[1]) // if we made it to the right part of our path
			.++
			pathing_frustration = 0
			myPath -= myPath[1]
			NPC_THINK("MOVEMENT TURN [movement_turn]: Movement on cooldown for [movespeed/10] seconds!")
			sleep(movespeed) // wait until next move

// blocks, but only while path is being calculated
/mob/living/carbon/human/proc/start_pathing_to(new_target)
	if(!new_target)
		back_to_idle()
		return FALSE

	pathfinding_target = new_target
	var/turf/turf_of_target = get_turf(new_target)
	if(!turf_of_target)
		back_to_idle()
		return FALSE
	if(is_currently_pathing)
		NPC_THINK("Already pathing!")
		return FALSE
	if(!length(myPath)) // need a new path
		var/const/MAX_RANGE_FIND = 32
		NPC_THINK("Pathfinding to [pathfinding_target]...")
		is_currently_pathing = TRUE
		myPath = get_path_to(src, turf_of_target, TYPE_PROC_REF(/turf, Heuristic_cardinal_3d), MAX_RANGE_FIND + 1, 250, 1, adjacent = TYPE_PROC_REF(/turf, reachableTurftest3d))
		is_currently_pathing = FALSE
		if(length(myPath))
			myPath -= get_turf(src) // remove the turf we start on
			pathing_frustration = 0
			NPC_THINK("Found a path with length [length(myPath)]!")
			return TRUE
	NPC_THINK("Failed to find a path!")
	//too far away or pathing failed; don't immediately lose aggro though
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
				// If we search for targets above, we need to do this twice.
				// Yes, this is kind of terrible, but it works(?). If it's enabled we do it a second time with is_checking_above = TRUE.
				for(var/is_checking_above in FALSE to find_targets_above)
					var/atom/search_location = src
					if(is_checking_above)
						var/turf/turf_above = GET_TURF_ABOVE(get_turf(src)) // may be null
						if(istransparentturf(turf_above))
							search_location = turf_above
						else // null or not transparent
							break // don't check above, we can't see through that turf
					for(var/mob/living/L in view(7, search_location)) // scan for enemies
						if(should_target(L))
							retaliate(L)
						// don't detect sneaking enemies if you're looking above you
						if (!is_checking_above && world.time >= next_passive_detect && L.alpha == 0 && L.rogue_sneaking && prob(STAPER / 2))
							if (!npc_detect_sneak(L, -20)) // attempt a passive detect with 20% increased difficulty
								next_passive_detect = world.time + STAPER SECONDS

		if(NPC_AI_HUNT)		// hunting for attacker
			// basic behavior chain: targeting > fleeing > picking up a weapon > attacking
			// VALIDATE TARGET
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
				var/turf/my_turf = get_turf(src)
				var/turf/target_turf = get_turf(target)
				// only path if we're more than one tile away
				if(my_turf.Distance_cardinal_3d(target_turf, src) > 1)
					if(!length(myPath)) // create a new path to the target
						start_pathing_to(target)

			// Flee before trying to pick up a weapon.
			if(flee_in_pain && target && (target.stat == CONSCIOUS))
				var/paine = get_complex_pain()
				if(paine >= ((STAEND * 10)*0.75)) // pain threshold decreased from END*10*0.9 due to all NPCs having insane END for some reason
					NPC_THINK("Ouch! Entering flee mode!")
					mode = NPC_AI_FLEE
					m_intent = MOVE_INTENT_RUN
					clear_path()
					return TRUE

			if(!get_active_held_item() && !HAS_TRAIT(src, TRAIT_CHUNKYFINGERS) && (mobility_flags & MOBILITY_PICKUP))
				// pickup any nearby weapon
				for(var/obj/item/I in view(1,src))
					if(!isturf(I.loc))
						continue
					if(blacklistItems[I])
						continue
					if(I.force > 7 && equip_item(I))
						// Picked up an item, end turn.
						return TRUE

			// if can't reach target for long enough, go idle
			if(frustration >= 15)
				back_to_idle()
				return TRUE

			// if we COULD attack, check reaction time
			var/should_frustrate = TRUE
			if(Adjacent(target) && isturf(target.loc))
				should_frustrate = FALSE
				// REACTION TIME: NPCs have a PER- and SPD-based random delay before they attempt to attack
				// so that it's easier to juke a moving NPC
				// 2ds at 10 PER, 2.9ds for 1 PER, 1ds for 20 PER
				// with a variance of 0.5ds
				// 2 + (STAPER-10)/10 + round(rand()*0.5, 0.1), roughly, but rand hates decimals so this is better
				var/reaction_time = (20 + (STAPER - 10) + rand(-5, 5)) / 10
				// if you just moved, you have a higher reaction time
				// SPD makes you recover faster though
				if(steps_moved_this_turn > 0 && STASPD < 15) // 15+ SPD removes the movement debuff
					reaction_time *= 1 + (15 - STASPD) / 10 // *1.1 at 14 spd, *2 at 5 spd
				#ifdef NPC_THINK_DEBUG
					var/movement_penalty = 1 + (15 - STASPD) / 10
					NPC_THINK("Reaction time [reaction_time]ds (movement penalty [movement_penalty]x)")
				else
					NPC_THINK("Reaction time [reaction_time]ds")
				#endif
				sleep(reaction_time)

			if(Adjacent(target) && isturf(target.loc))	// if right next to perp
				frustration = 0
				face_atom(target)
				monkey_attack(target)
				steps_moved_this_turn++ // an attack costs, currently, 1 movement step
				// JUKE: backstep after attacking if you're fast and have movement left
				NPC_THINK("Used [steps_moved_this_turn] moves out of [maxStepsTick]!")
				if(target && (steps_moved_this_turn < maxStepsTick))
					var/const/base_juke_chance = 5
					// for every point of STASPD above 10 you get an extra 5% juke chance
					var/const/min_spd_for_juke = 10
					var/const/juke_per_overspd = 5
					var/juke_spd_bonus = STASPD > min_spd_for_juke ? (STASPD - min_spd_for_juke) * juke_per_overspd : 0
					if(prob(base_juke_chance + juke_spd_bonus))
						NPC_THINK("Succeeded juke roll ([base_juke_chance + juke_spd_bonus]%)!")
						// pick a random turf to juke to
						var/list/turf/juke_candidates = get_dodge_destinations(target)
						if(length(juke_candidates))
							// temporarily force us to path to this turf
							myPath = list(pick(juke_candidates))
							var/old_pathfinding_target = pathfinding_target
							pathfinding_target = myPath[1]
							steps_moved_this_turn += move_along_path()
							pathfinding_target = old_pathfinding_target
					else
						NPC_THINK("Failed juke roll ([base_juke_chance + juke_spd_bonus]%)!")
				return TRUE
			else if(should_frustrate) // not next to perp, and we didn't fail due to reaction time
				frustration++

		if(NPC_AI_FLEE)
			var/const/NPC_FLEE_DISTANCE = 8
			if(!target || get_dist(src, target) >= NPC_FLEE_DISTANCE)
				// try to flee from any enemies who aren't incapacitated
				for(var/mob/living/bystander in view(src, 7))
					if(ishuman(bystander))
						var/mob/living/carbon/human/human_bystander = bystander
						if(human_bystander.IsDeadOrIncap())
							continue
					else if(stat != CONSCIOUS)
						continue
					// found an enemy who might be able to hurt us!
					// if our current candidate is closer, ignore this one
					if(target && (get_dist(src, target) <= get_dist(src, bystander)))
						continue
					// we assume if we want to hurt them they want to hurt us back
					if(should_target(bystander))
						target = bystander // We're trying to run from this person now
			if(!target || get_dist(src, target) >= NPC_FLEE_DISTANCE)
				NPC_THINK("Done fleeing!")
				back_to_idle()
			else if(!is_move_blocked_by_grab()) // try to run offscreen if we aren't being grabbed by someone else
				NPC_THINK("Fleeing from [target]!")
				// todo: use A* to find the shortest path to the farthest tile away from the flee target?
				walk_away(src, target, NPC_FLEE_DISTANCE, cached_multiplicative_slowdown)
			else // can't flee and can't move, stop walking!
				NPC_THINK("I can't flee from [target]!")
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

/// Try to attack using an offhand grab.
/mob/living/carbon/human/proc/npc_try_use_grab(mob/living/victim, obj/item/grabbing/the_grab)
	// set the intent 'intelligently'
	if(isitem(the_grab.sublimb_grabbed) && prob(30))
		rog_intent_change(1) // 30% chance to remove the embedded weapon, 70% to twist it
	else
		rog_intent_change(rand(1, length(possible_a_intents))) // choose choke/twist/smash/take at your leisure. todo: situational usage
	// now use it
	if(used_intent.type == /datum/intent/grab/smash) // special, need to smash them into something
		var/atom/smash_target // structure or turf
		// first check for a structure to smash someone into
		for(var/obj/structure/smashy_struct in view(1, src))
			if(!victim.Adjacent(smashy_struct)) // have to find a structure we're both adjacent to
				continue
			if(smashy_struct.blade_dulling != DULLING_CUT) // smashable!
				smash_target = smashy_struct
				break
		if(!smash_target) // now check turfs
			// if standing you have to slam them into a wall; otherwise slam them into the floor
			var/victim_standing = victim.mobility_flags & MOBILITY_STAND
			for(var/turf/smashy_turf in view(1, src))
				if(victim_standing)
					if(isopenturf(smashy_turf))
						continue
				else
					if(isclosedturf(smashy_turf))
						continue
				if(!victim.Adjacent(smashy_turf))
					continue
				smash_target = smashy_turf
				break
		if(smash_target) // now actually smash!
			NPC_THINK("Trying to smash [victim] into [smash_target]!")
			the_grab.melee_attack_chain(src, smash_target)
			return TRUE
		NPC_THINK("Failed to find something to smash [victim] into!")
		return FALSE
	// otherwise just use it normally
	NPC_THINK("Trying to [used_intent.name] a grab on [victim]!")
	the_grab.melee_attack_chain(src, victim)
	return TRUE

/mob/living/carbon/human/proc/npc_try_make_grab(mob/living/victim)
	NPC_THINK("Trying to grab [victim]!")
	swap_hand() // switch to offhand
	rog_intent_change(3) // grab intent
	npc_choose_grab_zone(victim)
	UnarmedAttack(victim, TRUE) // instead of start_pulling(victim)
	var/stam_penalty = used_intent.releasedrain
	if(istype(rmb_intent, /datum/rmb_intent/strong) || istype(rmb_intent, /datum/rmb_intent/swift))
		stam_penalty += 4 // as opposed to 10 for a weapon; these are your hands, it's easier to move them
	stamina_add(stam_penalty)
	if(pulling != victim)
		aftermiss()
	rog_intent_change(1) // and back to normal intent to avoid getting stuck on grabs
	swap_hand() // switch back to mainhand
	return TRUE // end your turn

/// A proc used in monkey_attack. Selects and performs our preferred attack.
/// Returns TRUE if our turn has been used.
/mob/living/carbon/human/proc/do_best_melee_attack(mob/living/victim)
	// TODO: Better converted-deadite AI than this.
	// My life for a refactor of this system to use the new AI controllers... maybe.
	if(mind?.has_antag_datum(/datum/antagonist/zombie))
		if(do_deadite_attack(victim))
			return TRUE // turn was used by biting
	var/obj/item/Weapon = get_active_held_item()
	var/obj/item/OffWeapon = get_inactive_held_item()
	// if we're weaponless or our offhand is stronger, switch hands
	// since grabs have a force of 0 this has the fun effect of putting embed grabs in the offhand too, which is useful later
	if(OffWeapon && (!Weapon || OffWeapon.force > Weapon.force))
		if(!istype(OffWeapon, /obj/item/grabbing)) // don't move grabs into your main hand please
			NPC_THINK("Switching active hand to [OffWeapon]!")
			swap_hand()
	// in case we swapped, reset weapon/offweapon
	Weapon = get_active_held_item()
	OffWeapon = get_inactive_held_item()

	// What is the chance we try to grab with our offhand?
	var/make_grab_chance = Weapon ? 5 : 20 // If unarmed, 20% chance; otherwise 5%
	var/use_grab_chance = 30 // 30% chance to use a grab if we already have one
	var/const/upgrade_grab_chance = 20 // make this non-const if anything ever wants to change it
	if(HAS_TRAIT(victim, TRAIT_CHUNKYFINGERS))
		make_grab_chance = 30 // we can't use normal weapons, so try to grapple harder because we don't care about having a free hand
		use_grab_chance = 50
	// we always try to move our grab into our offhand where possible, so no need to worry about main-hand weapons
	var/obj/item/grabbing/the_grab = OffWeapon
	if(istype(the_grab)) // if we already have a grab in our offhand, we might want to use it
		if(prob(use_grab_chance) && the_grab.grabbed == victim) // already pulling, fuck with them a bit
			swap_hand() // switch to grab
			if(grab_state < GRAB_AGGRESSIVE && prob(upgrade_grab_chance)) // upgrade!
				stamina_add(rand(7,15))
				victim.grippedby(src)
				return TRUE // used our turn
			npc_try_use_grab(victim, the_grab) // twist, smash, choke, whatever
			swap_hand() // switch back to mainhand to avoid fucking up the rest of combat
			return TRUE // and end turn
	else if(!OffWeapon && prob(make_grab_chance)) // grab with our empty offhand instead of attack
		if(npc_try_make_grab(victim)) // returns TRUE if we've finished our turn, not if we succeeded at the grab
			return TRUE


	// attack with weapon if we have one
	if(Weapon)
		if(!Weapon.wielded && Weapon.force_wielded > Weapon.force)
			// todo: decide to drop the offhand maybe?
			if(!OffWeapon) // wield it!
				Weapon.attack_self(src)
		rog_intent_change(1)
		Weapon.melee_attack_chain(src, victim)
		// attackby and attack_obj handles cooldowns already
		return TRUE
	else // unarmed
		rog_intent_change(4) // punch
		UnarmedAttack(victim, 1)
		// handle cooldowns since that's not done directly in UnarmedAttack
		var/adf = used_intent.clickcd
		if(istype(rmb_intent, /datum/rmb_intent/aimed))
			adf = round(adf * 1.4)
		if(istype(rmb_intent, /datum/rmb_intent/swift))
			adf = round(adf * 0.6)
		changeNext_move(adf)
		return TRUE

/mob/living/carbon/human/proc/npc_choose_grab_zone(mob/living/victim)
	// My life for a better way to handle deadite AI.
	var/victim_is_deadite = istype(victim, /mob/living/carbon/human/species/deadite) || victim.mind?.has_antag_datum(/datum/antagonist/zombie)
	// if we're standing, or neither of us are, then we can grab mouth
	var/can_mouthgrab = (mobility_flags & MOBILITY_STAND) || !(victim.mobility_flags & MOBILITY_STAND)
	var/deadite_mouthgrab_chance = clamp(50 + (STAINT - 10)*5, 25, 100) // int of 5 -> 25%, int of 15 -> 75%, int of 20 -> 100%
	if(prob(deadite_mouthgrab_chance) && can_mouthgrab && victim_is_deadite && !istype(victim.get_item_by_slot(SLOT_MOUTH), /obj/item/grabbing/bite)) // 60% chance to go for the mouth to stop biting
		zone_selected = BODY_ZONE_PRECISE_MOUTH
	else
		npc_choose_attack_zone(victim)

/mob/living/carbon/human/proc/npc_choose_attack_zone(mob/living/victim)
	// My life for a better way to handle deadite AI.
	if(mind?.has_antag_datum(/datum/antagonist/zombie))
		aimheight_change(deadite_get_aimheight(victim))
		return
	if(!(mobility_flags & MOBILITY_STAND))
		aimheight_change(rand(1, 4)) // Go for the knees!
		return
	if(HAS_TRAIT(victim, TRAIT_BLOODLOSS_IMMUNE)) // Go for the head!
		aimheight_change(rand(12, 19))
		return
	aimheight_change(pick(rand(5, 8), rand(9, 11), rand(12, 19))) // Arms, chest, head. Equal chance for each.

// attack using a held weapon otherwise bite the enemy, then if we are angry there is a chance we might calm down a little
/mob/living/carbon/human/proc/monkey_attack(mob/living/L)
	if(next_move > world.time)
		return
	
	npc_choose_attack_zone(L)
	NPC_THINK("Aiming for \the [zone_selected]!")
	do_best_melee_attack(L)

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
		if(pathfinding_target != target)
			clear_path() // Cancel pathfinding so that we can pursue our new enemy.
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

/mob/living/carbon/human/proc/npc_taunt_target()
	var/list/possible_taunts = list("laugh" = null)
	if(!restrained() && get_num_arms() != 0)
		possible_taunts["point"] = "\the [target]"
	var/the_emote = pick(possible_taunts)
	emote(the_emote, message = possible_taunts[the_emote])
