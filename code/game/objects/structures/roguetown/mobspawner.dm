var/global/total_spawned_mobs = 0
var/global/max_total_spawned_mobs = 30 // New global variable for the total limit

/obj/effect/mob_spawner
	var/spawn_timer
	var/max_spawned_mobs = 1
	var/current_spawned_mobs = 0
	var/spawn_interval = 600 // Default to 60 seconds
	var/list/ambush_mobs = list(
		/mob/living/carbon/human/species/skeleton/npc/ambush = 20,
		/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 40,
		/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 60,
		/mob/living/simple_animal/hostile/retaliate/rogue/spider = 40,
		/mob/living/carbon/human/species/goblin/npc/ambush/cave = 30
	)
	var/list/adventurer_landmarks = list() // Store landmarks here
	var/area/valid_area = /area/rogue/outdoors/bog // Define the valid area

	New()
		..() // Call the parent constructor
		spawn_interval = rand(600, 1200) // RNG between 60 seconds and 120 seconds
		adventurer_landmarks = get_all_adventurer_landmarks()
		if (!is_in_valid_area(src))
			del src  // Delete the spawner if it's not in the valid area
		else
			start_spawning()

	proc/start_spawning()
		spawn_timer = addtimer(CALLBACK(src, .proc/spawn_and_continue), spawn_interval, TIMER_STOPPABLE)

	proc/spawn_and_continue()
		if (total_spawned_mobs < max_total_spawned_mobs)
			spawn_random_mobs(1) // Attempt to spawn 3 mobs each time
		start_spawning()

	proc/spawn_random_mobs(var/num_to_spawn)
		var/spawn_chance = 100 // 100% chance to spawn if conditions are met
		if (prob(spawn_chance) && total_spawned_mobs < max_total_spawned_mobs)
			var/turf/spawn_turf
			var/mob_type
			var/mob/new_mob
			var/i = 0
			while (i < num_to_spawn && total_spawned_mobs < max_total_spawned_mobs)
				spawn_turf = get_random_valid_turf()
				if (spawn_turf)
					mob_type = pickweight(ambush_mobs)
					new_mob = new mob_type(spawn_turf)
					if (new_mob)
						current_spawned_mobs++
						total_spawned_mobs++
						RegisterSignal(new_mob, COMSIG_PARENT_QDELETING, .proc/on_mob_destroy)
				i++

	proc/get_random_valid_turf()
		var/list/valid_turfs = list()
		for (var/turf/T in range(7, src))
			if (is_valid_spawn_turf(T))
				valid_turfs += T
		if (valid_turfs.len == 0)
			return null
		return pick(valid_turfs)

	proc/is_valid_spawn_turf(turf/T)
		if (!(istype(T, /turf/open/floor/rogue/dirt) || \
			  istype(T, /turf/open/floor/rogue/grass) || \
			  istype(T, /turf/open/water)))
			return FALSE
		if (istype(T, /turf/closed))
			return FALSE
		if (!is_in_valid_area(T))
			return FALSE
		if (T.get_lumcount() > 0.2)
			return FALSE
		for (var/L in adventurer_landmarks)
			if (get_dist(T, L) < 10)
				return FALSE
		if (players_nearby(T, 15))
			return FALSE
		return TRUE

	proc/is_in_valid_area(atom/A)
		var/area/area_check = get_area(A)
		return istype(area_check, valid_area)

	proc/get_all_adventurer_landmarks()
		var/list/landmarks = list()
		for (var/obj/effect/landmark/start/adventurer/L in world)
			landmarks += L
		for (var/obj/effect/landmark/start/adventurerlate/L in world)
			landmarks += L
		return landmarks

	proc/on_mob_destroy(mob/M)
		UnregisterSignal(M, COMSIG_PARENT_QDELETING)
		current_spawned_mobs = max(0, current_spawned_mobs - 1)
		total_spawned_mobs = max(0, total_spawned_mobs - 1)

	proc/players_nearby(turf/T, distance)
		for (var/mob/living/carbon/human/H in range(distance, T))
			if (H.client)
				return TRUE
		return FALSE
