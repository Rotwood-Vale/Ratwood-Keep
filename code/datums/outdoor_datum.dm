//todo: handle moving sunlight turfs - see various uses of get_turf in lighting_object


/*

Sunlight System

	Objects + Details
		Sunlight Objects (this file)
			- Grayscale version of lighting_object
			- Has 3 states
				- SKY_BLOCKED  (0)
					- Turfs that have an opaque turf above them. Has no light themselves but is affected by SKY_VISIBLE_BORDER
				- SKY_VISIBLE (1)
					- Turfs that with no opaque turfs above it (no roof, glass roof, etc), with no neighbouring SKY_BLOCKED tiles
					  Emits no light, but is fully white to display the overlay color
				- SKY_VISIBLE_BORDER  (2)
					- Turfs that with no opaque turfs above it (no roof, glass roof, etc), which neighbour at least one SKY_BLOCKED tile.
				     Emits light to SKY_BLOCKED tiles, and fully white to display the overlay color

*/
/obj
	var/weatherproof = FALSE
	var/weather = FALSE

/obj/proc/weather_act_on(weather_trait, severity)
	return

/atom/movable/outdoor_effect
	name = ""
	mouse_opacity = 0
	anchored = 1
	appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
	plane = WEATHER_EFFECT_PLANE

	/* misc vars */
	var/state 					 = SKY_VISIBLE	// If we can see the see the sky, are blocked, or we have a blocked neighbour (SKY_BLOCKED/VISIBLE/VISIBLE_BORDER)
	var/weatherproof			 = FALSE        // If we have a weather overlay
	var/turf/source_turf

/atom/movable/outdoor_effect/Destroy(force)
	if (!force)
		return QDEL_HINT_LETMELIVE

	//Remove ourselves from our turf
	if(source_turf && source_turf.outdoor_effect == src)
		source_turf.outdoor_effect = null


	return ..()



/atom/movable/outdoor_effect/Initialize(mapload)
	. = ..()
	source_turf = loc
	if (source_turf.outdoor_effect)
		qdel(source_turf.outdoor_effect, force = TRUE)
		source_turf.outdoor_effect = null //No qdel_null force
	source_turf.outdoor_effect = src


/* Related object changes */
/* I moved this here to consolidate sunlight changes as much as possible, so its easily disabled */

/* area fuckery */
/area/var/turf/pseudo_roof

/* turf fuckery */
/turf/var/tmp/atom/movable/outdoor_effect/outdoor_effect /* a turf's sunlight overlay */
/turf/var/turf/pseudo_roof /* our roof turf - may be a path for top z level, or a ref to the turf above*/

//non-weatherproof turfs
/turf/var/weatherproof = TRUE
/turf/open/transparent/openspace/weatherproof = FALSE

/turf/proc/reassess_stack()
	GLOB.SUNLIGHT_QUEUE_WORK += src
	var/turf/T = SSmapping.get_turf_below(src)
	if(T)
		T.reassess_stack()

/* check ourselves and neighbours to see what outdoor effects we need */
/* turf won't initialize an outdoor_effect if sky_blocked*/
/turf/proc/get_sky_and_weather_states()
	var/TempState

	var/roofStat = get_ceiling_status()
	var/tempRoofStat
	if(roofStat["SKYVISIBLE"])
		TempState = SKY_VISIBLE
		for(var/turf/CT in RANGE_TURFS(1, src))
			tempRoofStat = CT.get_ceiling_status()
			if(!tempRoofStat["SKYVISIBLE"]) /* if we have a single roofed/indoor neighbour, we are a border */
				TempState = SKY_VISIBLE_BORDER
				break
	else /* roofed, so turn off the lights */
		TempState = SKY_BLOCKED

	/* if border or indoor, initialize. Set sunlight state if valid */
	if(!outdoor_effect && (TempState <> SKY_BLOCKED || !roofStat["WEATHERPROOF"]))
		outdoor_effect = new /atom/movable/outdoor_effect(src)
	if(outdoor_effect)
		outdoor_effect.state = TempState
		outdoor_effect.weatherproof = roofStat["WEATHERPROOF"]

/* runs up the Z stack for this turf, returns a assoc (SKYVISIBLE, WEATHERPROOF)*/
/* pass recursionStarted=TRUE when we are checking our ceiling's stats */
/turf/proc/get_ceiling_status(recursionStarted = FALSE)
	. = list()

	//Check yourself (before you wreck yourself)
	if(isclosedturf(src)) //Closed, but we might be transparent
		.["SKYVISIBLE"]   =  istransparentturf(src) // a column of glass should still let the sun in
		.["WEATHERPROOF"] =  TRUE
	else
		if(recursionStarted)
			// This src is acting as a ceiling - so if we are a floor we weatherproof + block the sunlight of our down-Z turf
			.["SKYVISIBLE"]   = istransparentturf(src) //If we are glass floor, we don't block
			for(var/obj/structure/thing in src.contents) // Checks to see if weatherproof objects on the tile
				if(thing.weatherproof == TRUE)
					.["WEATHERPROOF"] = TRUE // returns true to block the weather
					return .
			.["WEATHERPROOF"] = weatherproof //If we are air or space, we aren't weatherproof
		else //We are open, so assume open to the elements
			.["SKYVISIBLE"]   = TRUE
			.["WEATHERPROOF"] = FALSE

	// Early leave if we can't see the sky - if we are an opaque turf, we already know the results
	// I can't think of a case where we would have a turf that would block light but let weather effects through - Maybe a vent?
	// fix this if that is the case
	if(!.["SKYVISIBLE"])
		return .

	//Ceiling Check
	// Psuedo-roof, for the top of the map (no actual turf exists up here) -- We assume these are solid, if you add glass pseudo_roofs then fix this
	if (pseudo_roof)
		.["SKYVISIBLE"]   =  FALSE
		.["WEATHERPROOF"] =  TRUE
	else
		// EVERY turf must be transparent for sunlight - so &=
		// ANY turf must be closed for weatherproof - so |=
		var/turf/ceiling = get_step_multiz(src, UP)
		if(ceiling)
			var/list/ceilingStat = ceiling.get_ceiling_status(TRUE) //Pass TRUE because we are now acting as a ceiling
			.["SKYVISIBLE"]   &= ceilingStat["SKYVISIBLE"]
			.["WEATHERPROOF"] |= ceilingStat["WEATHERPROOF"]

	var/area/turf_area = get_area(src)
	var/turf/above_turf = get_step_multiz(src, UP)
	if((!above_turf && !turf_area.outdoors))
		.["SKYVISIBLE"]   =  FALSE
		.["WEATHERPROOF"] =  TRUE
