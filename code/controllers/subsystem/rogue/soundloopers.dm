
SUBSYSTEM_DEF(soundloopers)
	name = "soundloopers"
	wait = 1
	flags = SS_NO_INIT
	priority = FIRE_PRIORITY_DEFAULT
	var/list/processing = list()
	var/list/currentrun = list()
	var/client_ticker = 0

/datum/controller/subsystem/soundloopers/fire(resumed = 0)
	if (!resumed || !currentrun.len)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/current = src.currentrun

	while (current.len)
		var/datum/looping_sound/thing = current[current.len]
		current.len--
		if (!thing || QDELETED(thing))
			processing -= thing
			if (MC_TICK_CHECK)
				return
			continue

		if(world.time > thing.starttime + thing.mid_length) //Make sure we don't try to trigger it while a loop is playing
			if(thing.sound_loop())
				STOP_PROCESSING(SSsoundloopers, thing)

		client_ticker++ //Evaluate on a per client basis, not on a per sound basis, for speed
		if(client_ticker >= 5) //half a second, no need to spam this insano style
			client_ticker = 0
			for(var/client/C in GLOB.clients)
				if(C.mob) //Not in the lobby
					C.update_sounds()

		if (MC_TICK_CHECK)
			return

/client/proc/update_sounds()

	//First we need to periodically scan if we moved into range of an already-playing sound
	for(var/datum/looping_sound/PS in GLOB.persistent_sound_loops)
		if(PS in played_loops) //Make sure it's not already on the list
			continue

		var/turf/parent_turf = get_turf(PS.parent)
		if(get_dist(get_turf(mob),parent_turf) > world.view + PS.extra_range) //Too far away. get_dist shouldn't be too awful for repeated calcs
			continue

		//otherwise add it to the client loops and off we go from there
		var/sound/our_sound = PS.cursound
		if(!istype(our_sound)) //somehow it doesn't have a correct sound
			our_sound = sound(our_sound)
		if(!our_sound)
			continue //something fucked up and the loop has no cursound, wups. this should basically never happen

		mob.playsound_local(parent_turf, PS.cursound, PS.volume, PS.vary, PS.frequency, PS.falloff, PS.channel, FALSE, our_sound, repeat = PS)

	//Now we check how far away etc we are
	for(var/datum/looping_sound/loop in played_loops)
		if(mob && loop.parent == mob) //the sound's coming from inside the house!
			continue

		var/max_distance = world.view + loop.extra_range
		var/turf/source_turf = get_turf(loop.parent)
		var/distance_between = get_dist(mob,loop.parent)

		if(isturf(loop.parent))
			source_turf = loop.parent
		if(!source_turf) //somehow
			continue

		var/list/found_loop = played_loops[loop]
		var/sound/found_sound = found_loop["SOUND"]

		if(!found_loop || !istype(found_sound)) //somethin fucky goin on. lets ignore it
			played_loops -= loop
			continue

		if(distance_between > max_distance || mob.IsSleeping()) // || !mob in hearers(max_distance,source_turf))
			//We are too far away, turn it off, or suppress it if its a persistent tune like music boxes
			if(loop.persistent_loop)
				found_loop["MUTESTATUS"] = TRUE
				found_loop["VOL"] = 0
				mob.mute_sound(found_sound)
			else
				played_loops -= loop
				loop.thingshearing -= mob
				mob.stop_sound_channel(found_sound.channel)

		else if(distance_between <= max_distance)
			//We are close enough to hear, check if volume should be changed

			var/new_volume = loop.volume
			var/old_volume = found_loop["VOL"]

			new_volume -= (distance_between * (0.1 * new_volume)) //reduce volume by 10% per tile

			if(new_volume > 100)
				new_volume = 100 //could just min() this but whatever. we old skool

			if(new_volume <= 0) //Too quiet to hear despite being in range
				if(loop.persistent_loop) //Copy pasting instead of making a new proc? egads you monster
					found_loop["MUTESTATUS"] = TRUE
					found_loop["VOL"] = 0
					mob.mute_sound(found_sound)
				else
					played_loops -= loop
					loop.thingshearing -= mob
					mob.stop_sound_channel(found_sound.channel)
				continue

			if(source_turf.z == mob.z + 1 || source_turf.z == mob.z - 1) //Some hacks for z-levels
				new_volume = new_volume / 2
			else if (source_turf.z == mob.z + 2 || source_turf.z == mob.z - 2)
				new_volume = new_volume / 4

			new_volume = new_volume * (prefs.mastervol * 0.01) //Modify it at the end by the player's volume setting

			if(old_volume != new_volume)
				var/turf/T = get_turf(mob)
				var/dx = source_turf.x - T.x // Stolen/replicated from sound.dm
				if(dx <= 1 && dx >= -1)
					found_sound.x = 0
				else
					found_sound.x = dx
				var/dy = source_turf.y - T.y
				if(dy <= 1 && dy >= -1)
					found_sound.y = 0
				else
					found_sound.y = dy
				var/dz = (source_turf.z - T.z)
				found_sound.z = dz

				if(loop.persistent_loop && found_loop["MUTESTATUS"] == TRUE) //It was out of range and now back in range, reset it
					found_loop["MUTESTATUS"] = FALSE
					mob.unmute_sound(found_sound)
				found_loop["VOL"] = new_volume
				mob.update_sound_volume(played_loops[loop]["SOUND"], new_volume)


