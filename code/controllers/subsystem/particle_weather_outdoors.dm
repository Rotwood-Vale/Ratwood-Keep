GLOBAL_LIST_EMPTY(SUNLIGHT_QUEUE_WORK)   /* turfs to be stateChecked */
GLOBAL_LIST_EMPTY(SUNLIGHT_QUEUE_UPDATE) /* turfs to have their colors updated via corners (filter out the unroofed dudes) */
GLOBAL_LIST_EMPTY(SUNLIGHT_QUEUE_CORNER) /* turfs to have their color/lights/etc updated */

SUBSYSTEM_DEF(outdoor_effects)
	name = "Outdoor Weather Calc"
	wait = LIGHTING_INTERVAL
	flags = SS_TICKER
	init_order = INIT_ORDER_OUTDOOR_EFFECTS
	var/list/atom/movable/screen/plane_master/weather_effect/weather_planes_need_vis = list()


/datum/controller/subsystem/outdoor_effects/proc/fullPlonk()
	for (var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
		for (var/turf/T in block(locate(1,1,z), locate(world.maxx,world.maxy,z)))
			GLOB.SUNLIGHT_QUEUE_WORK += T

/datum/controller/subsystem/outdoor_effects/Initialize(timeofday)
	if(!initialized)
		InitializeTurfs()
		initialized = TRUE
	fire(FALSE, TRUE)
	..()

/datum/controller/subsystem/outdoor_effects/proc/InitializeTurfs(list/targets)
	for (var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
		for (var/turf/T in block(locate(1,1,z), locate(world.maxx,world.maxy,z)))
			GLOB.SUNLIGHT_QUEUE_WORK += T

/* set sunlight color + add weather effect to clients */
/datum/controller/subsystem/outdoor_effects/fire(resumed, init_tick_checks)
	MC_SPLIT_TICK_INIT(3)
	if(!init_tick_checks)
		MC_SPLIT_TICK
	var/i = 0

	//Add our weather particle obj to any new weather screens
	if(SSParticleWeather.initialized)
		for (i in 1 to weather_planes_need_vis.len)
			var/atom/movable/screen/plane_master/weather_effect/W = weather_planes_need_vis[i]
			if(W)
				W.vis_contents = list(SSParticleWeather.getweatherEffect())
			if(init_tick_checks)
				CHECK_TICK
			else if (MC_TICK_CHECK)
				break
		if (i)
			weather_planes_need_vis.Cut(1, i+1)
			i = 0

	for (i in 1 to GLOB.SUNLIGHT_QUEUE_WORK.len)
		var/turf/T = GLOB.SUNLIGHT_QUEUE_WORK[i]
		if(T)
			T.get_sky_and_weather_states()
			if(T.outdoor_effect)
				GLOB.SUNLIGHT_QUEUE_UPDATE += T.outdoor_effect

		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if (i)
		GLOB.SUNLIGHT_QUEUE_WORK.Cut(1, i+1)
		i = 0


	if(!init_tick_checks)
		MC_SPLIT_TICK

	for (i in 1 to GLOB.SUNLIGHT_QUEUE_UPDATE.len)
		var/atom/movable/outdoor_effect/U = GLOB.SUNLIGHT_QUEUE_UPDATE[i]
		if(U)
			update_outdoor_effect_overlays(U)

		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if (i)
		GLOB.SUNLIGHT_QUEUE_UPDATE.Cut(1, i+1)
		i = 0


	if(!init_tick_checks)
		MC_SPLIT_TICK

	for (i in 1 to GLOB.SUNLIGHT_QUEUE_CORNER.len)
		var/turf/T = GLOB.SUNLIGHT_QUEUE_CORNER[i]
		var/atom/movable/outdoor_effect/U = T.outdoor_effect

		/* if we haven't initialized but we are affected, create new and check state */
		if(!U)
			T.outdoor_effect = new /atom/movable/outdoor_effect(T)
			T.get_sky_and_weather_states()
			U = T.outdoor_effect

			/* in case we aren't indoor somehow, wack us into the proc queue, we will be skipped on next indoor check */
			if(U.state != SKY_BLOCKED)
				GLOB.SUNLIGHT_QUEUE_UPDATE += T.outdoor_effect

		if(U.state != SKY_BLOCKED)
			continue

		//This might need to be run more liberally
		update_outdoor_effect_overlays(U)


		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break

	if (i)
		GLOB.SUNLIGHT_QUEUE_CORNER.Cut(1, i+1)
		i = 0


// Updates overlays and vis_contents for outdoor effects
/datum/controller/subsystem/outdoor_effects/proc/update_outdoor_effect_overlays(atom/movable/outdoor_effect/OE)

	//Get weather overlay if not weatherproof
	if(!OE.weatherproof)
		get_weather_overlay(OE)
	else
		cut_weather_overlay(OE)

//get our weather overlay
/datum/controller/subsystem/outdoor_effects/proc/get_weather_overlay(atom/movable/outdoor_effect/OE) //TODO: Restore this to 32x48 for some extra
	OE.icon 			  = 'icons/effects/weather_overlay.dmi'
	OE.icon_state 		  = "weather_overlay"
	OE.plane			  = WEATHER_OVERLAY_PLANE

//get our weather overlay
/datum/controller/subsystem/outdoor_effects/proc/cut_weather_overlay(atom/movable/outdoor_effect/OE) //TODO: Restore this to 32x48 for some extra
	OE.icon 			  = initial(OE.icon)
	OE.icon_state 		  = initial(OE.icon_state)
	OE.plane			  = initial(OE.plane)
