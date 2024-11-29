/*
*	So, here's the general idea behind these:
*	These are static threat spawners. They routinely will, at random, generate enemies
*	in the same way that ambushes spawn them - that is, spawning them around random
*	trees/mushrooms/etc within view of the target. However, unlike ambushes, THESE
*	mobs will actually stick around and not despawn!
*
*	After a specified time into the round, the threat spawners become "active," and will
*	start a cooldown that is randomized between the min and max time. When the cooldown
*	hits 0, it spawns lingering enemies around any valid targets in much the same way
*	that ambushes spawn enemies. Then it goes on a randomized cooldown again, and the
*	cycle repeats for the rest of the round.
*/

GLOBAL_VAR_INIT(threatspawner_cd_min, 8 MINUTES)
GLOBAL_VAR_INIT(threatspawner_cd_max, 15 MINUTES)
// Determines different min/max possible ranges for # of enemies spawned.
// Makes it much more common that only a couple enemies spawn
// while making it unlikely but possible that a bunch of enemies spawn as a !!FUN SURPRISE!!
GLOBAL_LIST_INIT(threatspawner_quantities, list(
	list(1,2) = 20,
	list(2,3) = 10,
	list(3,4) = 3,
	list(4,6) = 1,
))


/obj/effect/landmark/threatspawner
	name = "static threat spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "tdome_admin"
	var/inital_cooldown = 30 MINUTES /// How long we wait at round start before becoming active
	var/spawn_range = 5 /// Max range around us to search for spawnable objects
	var/next_spawn_time = 0 /// The time at which we will spawn more dudes

/obj/effect/landmark/threatspawner/Initialize()
	. = ..()
	next_spawn_time = world.time + inital_cooldown
	START_PROCESSING(SSprocessing, src)

/obj/effect/landmark/threatspawner/Destroy(force)
	. = ..()
	STOP_PROCESSING(SSprocessing, src)

/obj/effect/landmark/threatspawner/process()
	if(world.time > next_spawn_time)
		consider_spawning()

/obj/effect/landmark/threatspawner/proc/consider_spawning()
	// I shamelessly stole a lot of this from ambush code hehehehe
	var/turf/T = get_turf(src)
	if(!T)
		return
	// First, make sure nobody is able to see us or anything we might spawn!
	var/viewers = 0
	for(var/mob/living/carbon/human/L in viewers(src, 7 + spawn_range))
		if(L.stat == CONSCIOUS)
			viewers++
	if(viewers)
		// If there are viewers, we'll just wait a bit and then try again.
		next_spawn_time = world.time + 30 SECONDS
		return
	// Now, make sure we don't have any lit objects around us!
	// (This way we don't wind up spawning dudes in a space a player might be building in)
	var/lights = 0
	for(var/obj/machinery/light/rogue/RF in view(spawn_range, src))
		if(RF.on)
			lights++
	if(lights > 0)
		// If there are, well, guess we'll wait a good while before checking again.
		start_cooldown()
		return
	spawn_threats()
	
/obj/effect/landmark/threatspawner/proc/spawn_threats()
	var/list/possible_targets = list()
	for(var/obj/structure/flora/F in view(src, spawn_range))
		if(isturf(F.loc))
			possible_targets += F.loc
	// If we find no valid flora to spawn them on, then um... uh... I guess we wait a while??
	if(!possible_targets.len)
		start_cooldown()
		return
	// First determine the minimum and maximum possible quantity of dudes we'll spawn
	var/list/minmax = pickweight(GLOB.threatspawner_quantities)
	var/amt2spawn = rand(minmax[1], minmax[2])
	// Now we actually spawn the dudes!!
	var/area/AR = get_area(src)
	var/spawnedtype = pickweight(AR.ambush_mobs)
	for(var/i in 1 to amt2spawn)
		var/spawnloc = pick(possible_targets)
		if(spawnloc)
			var/mob/spawnedmob = new spawnedtype(spawnloc)
			if(istype(spawnedmob, /mob/living/simple_animal/hostile))
				var/mob/living/simple_animal/hostile/M = spawnedmob
				M.attack_same = FALSE
			if(istype(spawnedmob, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = spawnedmob
				H.last_aggro_loss = world.time
	start_cooldown()



/obj/effect/landmark/threatspawner/proc/start_cooldown()
	next_spawn_time = world.time + rand(GLOB.threatspawner_cd_min, GLOB.threatspawner_cd_max)


/// Subtype of threat spawner with a short initial cooldown, intended for places that will be cleared out pretty early on.
/obj/effect/landmark/threatspawner/shortinit
	inital_cooldown = 15 MINUTES

/// Subtype of threat spawner with a longer initial cooldown, intended for places that will probably take a while before being cleared.
/obj/effect/landmark/threatspawner/longinit
	inital_cooldown = 45 MINUTES

/// Debug-only!!
/obj/effect/landmark/threatspawner/instant
	inital_cooldown = 1 SECONDS
