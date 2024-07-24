var/global/total_spawned_mobs = 0

/obj/effect/mob_spawner
    var/spawn_timer
    var/max_spawned_mobs = 40
    var/current_spawned_mobs = 0
    var/spawn_interval = 30 // seconds, for periodic spawning
    var/list/mob_types = list(
        /mob/living/simple_animal/hostile/retaliate/rogue/bigrat,
        /mob/living/simple_animal/hostile/retaliate/rogue/wolf,
        /mob/living/carbon/human/species/skeleton/npc/ambush,
        /mob/living/simple_animal/hostile/retaliate/rogue/spider,
        /mob/living/carbon/human/species/goblin/npc/ambush
    )
    var/list/adventurer_landmarks = list() // Store landmarks here
    var/area/valid_area = /area/rogue/outdoors/bog // Define the valid area

    New()
        ..() // Call the parent constructor
        // Initialize landmarks
        adventurer_landmarks = get_all_adventurer_landmarks()
        // Start the spawning process immediately upon creation
        start_spawning()
        // Test spawn directly
        spawn_random_mobs(1)

    proc/start_spawning()
        world << "Debug: Starting spawn timer"
        spawn_timer = addtimer(spawn_interval, CALLBACK(src, .proc/spawn_and_continue))

    proc/spawn_and_continue()
        world << "Debug: Checking spawn conditions"
        if (current_spawned_mobs < max_spawned_mobs)
            world << "Debug: Attempting to spawn mobs"
            spawn_random_mobs(1) // Attempt to spawn 1 mob each time
        spawn_timer = addtimer(spawn_interval, CALLBACK(src, .proc/spawn_and_continue))

    proc/spawn_random_mobs(var/num_to_spawn)
        var/spawn_chance = 100 // 100% chance to spawn if conditions are met
        var/i = 0 // Initialize counter variable
        while (i < num_to_spawn && current_spawned_mobs < max_spawned_mobs)
            if (prob(spawn_chance))
                var/turf/spawn_turf = get_random_valid_turf() // Use random valid turf for spawn location
                if (spawn_turf)
                    var/mob_type = pick(mob_types) // Pick a random mob type from the list
                    if (mob_type)
                        if (total_spawned_mobs < max_spawned_mobs)
                            var/mob/new_mob = new mob_type(spawn_turf)
                            if (new_mob)
                                current_spawned_mobs++
                                total_spawned_mobs++ // Increment global counter
                                RegisterSignal(new_mob, COMSIG_PARENT_QDELETING, .proc/on_mob_destroy)
            i++ // Increment counter

    proc/get_random_valid_turf()
        var/list/valid_turfs = list()
        for (var/turf/T in range(7, src)) // Check a range of turfs around the spawner
            if (is_valid_spawn_turf(T))
                valid_turfs += T
        world << "Debug: Found " + valid_turfs.len + " valid turfs"
        if (valid_turfs.len > 0)
            return pick(valid_turfs)
        return null // Return null if no valid turfs found

    proc/is_valid_spawn_turf(turf/T)
        if (!(istype(T, /turf/open/floor/rogue/dirt) || \
            istype(T, /turf/open/floor/rogue/grass) || \
            istype(T, /turf/open/water)))
            return FALSE
        if (!is_in_valid_area(T))
            return FALSE
        for (var/obj/effect/landmark/start/adventurer/L in adventurer_landmarks)
            if (get_dist(T, L) < 10) // Replace 10 with your desired radius
                return FALSE
        return TRUE

    proc/is_in_valid_area(turf/T)
        var/area/A = locate(T.x, T.y, T.z)
        world << "Debug: Turf " + T + " is in area " + A
        return (A == valid_area)

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
        total_spawned_mobs = max(0, total_spawned_mobs - 1) // Decrement global counter
        if (total_spawned_mobs < max_spawned_mobs)
            spawn_random_mobs(1)

    proc/players_nearby(turf/T, distance)
        return FALSE
