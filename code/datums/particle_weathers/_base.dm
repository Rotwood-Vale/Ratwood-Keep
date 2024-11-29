/particles/weather
	spawning = 0
	var/wind = 0 //Left/Right maximum movement increase per tick
	var/maxSpawning = 0 //Max spawner - Recommend you use this over Spawning, so severity can ease it in
	var/minSpawning = 0 //Weather should start with 0, but when easing, it will never go below this
	icon = 'icons/effects/particles/particle.dmi'


	spawning = 0
	width                  = 800  // I think this is supposed to be in pixels, but it doesn't match bounds, so idk - 800x800 seems to prevent particle-less edges
	height                 = 800
	count                  = 3000 // 3000 particles
	//Set bounds to rough screensize + some extra on the side and top movement for "wind"
	bound1                 = list(-500,-256,-10)
	bound2                 = list(500,500,10)
	lifespan               = 285   // live for 30s max (fadein + lifespan + fade)
	fade                   = 10    // 1s fade out
	fadein				   = 5     // 0.5s fade in

	//Obnoxiously 3D -- INCREASE Z level to make them further away
	transform			   = list( 1, 0, 0,  0  ,
								   0, 1, 0,  0  ,
								   0, 0, 1, 1/2, //Get twice as Small every 2 Z
								   0, 0, 0,  1  )

//Animate particle effect to a severity
/particles/weather/proc/animateSeverity(severityMod)

	//If we have no severity, just stop spawning
	if(!severityMod)
		spawning = 0
		return

	var newWind = wind * severityMod * pick(-1,1) //Wind can go left OR right!
	var newSpawning = max(minSpawning, maxSpawning * severityMod)

	//gravity might be x, xy, or xyz
	var/newGravity = gravity
	if(length(newGravity))
		newGravity[1] = newWind
	else
		newGravity = list(newWind)

	//The higher the severity, the faster the change - elastic easing for flappy wind
	gravity = newGravity
	spawning = newSpawning
	// animate(src, gravity=newGravity, spawning=newSpawning, time=1/severity * 10, easing=ELASTIC_EASING)

/**
 * Shitty particle weather by Gomble
 * Causes weather to occur on a z level in certain area types
 *
 * The effects of weather occur across an entire z-level. For instance, lavaland has periodic ash storms that scorch most unprotected creatures.
 * Weather always occurs on different z levels at different times, regardless of weather type.
 * Can have custom durations, targets, and can automatically protect indoor areas.
 *
 */


/datum/particle_weather

	// ==== Modify these ====

	/// name of weather
	var/name = "space wind"
	/// description of weather
	var/desc = "Heavy gusts of wind blanket the area, periodically knocking down anyone caught in the open."

	//messages to send at different severities
	var/list/weather_messages = list()

	// Sounds to play at different severities - order from lowest to highest
	var/list/weather_sounds = list()
	var/list/indoor_weather_sounds = list()

	//Scale volume with severity - good for if you only have 1 sound
	var/scale_vol_with_severity = FALSE

	//Our particle effect to display - min/max severity effects its wind and count
	var/particles/weather/particleEffectType = /particles/weather/rain


	/// See above - this is the lowest possible duration
	var/weather_duration_lower = 1 MINUTES
	/// See above - this is the highest possible duration
	var/weather_duration_upper = 3 MINUTES

	// Keep this between 1 and 100
	// Gentle rain shouldn't use the max rain wind speed, nor should a storm be a gentle breeze
	var/minSeverity = 1
	var/maxSeverity = 100
	//We will increase or decrease our severity by a random amount up to this value
	//If 0, we will pick a random value between min and max
	var/maxSeverityChange = 20
	//The number of times we will change our severity over the duration
	var/severitySteps = 5
	/// Used by mobs to prevent them from being affected by the weather
	var/immunity_type = TRAIT_WEATHER_IMMUNE
	/// Weight amongst other eligible weather. If zero, will never happen randomly.
	var/probability = 0

	/// The map weather type to target
	var/target_trait = PARTICLEWEATHER_RAIN

	// ==== Dont modify these ====

	//Times we have stepped severity
	var/severityStepsTaken = 0

	var/running = FALSE

	//Current severity - used for scaling effects, particle appearance, etc.
	var/severity = 0

	/// Whether a barometer can predict when the weather will happen
	var/barometer_predictable = FALSE
	/// For barometers to know when the next storm will hit
	var/next_hit_time = 0

	/// In deciseconds, how long the weather lasts once it begins
	var/weather_duration = 0

	//assoc list of mob=looping_sound
	var/list/currentSounds = list()

	//assoc list of mob=timestamp -> Next time we can send a message
	var/list/messagedMobs = list()

	var/last_message = ""

/datum/particle_weather/proc/severityMod()
	return max(0.3, severity / maxSeverity)
/*
* arbitrary effects to run every time the particle_weather SS ticks
* for storms this might be a random chance for lightning, etc.
*/
/datum/particle_weather/proc/tick()
	return

/datum/particle_weather/Destroy()
	for(var/S in currentSounds)
		var/datum/looping_sound/looping_sound = currentSounds[S]
		looping_sound.stop()
		qdel(looping_sound)
	return ..()

/**
 * Starts the actual weather and effects from it
 *
 * Updates area overlays and sends sounds and messages to mobs to notify them
 * Begins dealing effects from weather to mobs in the area
 *
 */
/datum/particle_weather/proc/start()
	if(running)
		return //some cheeky git has started you early
	weather_duration = rand(weather_duration_lower, weather_duration_upper)
	running = TRUE
	addtimer(CALLBACK(src, PROC_REF(wind_down)), weather_duration)

	if(particleEffectType)
		SSParticleWeather.SetparticleEffect(new particleEffectType);

	//Always step severity to start
	ChangeSeverity()


/datum/particle_weather/proc/ChangeSeverity()
	if(!running)
		return
	severityStepsTaken++

	if(maxSeverityChange == 0)
		severity = rand(minSeverity, maxSeverity)
	else
		var/newSeverity = severity + rand(-maxSeverityChange,maxSeverityChange)
		newSeverity = min(max(newSeverity,minSeverity), maxSeverity)
		severity = newSeverity


	if(SSParticleWeather.particleEffect)
		SSParticleWeather.particleEffect.animateSeverity(severityMod())

	//Send new severity message if the message has changed
	if(last_message != scale_range_pick(minSeverity, maxSeverity, severity, weather_messages))
		messagedMobs = list()

	//Tick on
	if(severityStepsTaken < severitySteps)
		addtimer(CALLBACK(src, PROC_REF(ChangeSeverity)), weather_duration / severitySteps)


/**
 * Weather enters the winding down phase, stops effects
 *
 * Updates areas to be in the winding down phase
 * Sends sounds and messages to mobs to notify them
 *
 */
/datum/particle_weather/proc/wind_down()
	severity = 0
	if(SSParticleWeather.particleEffect)
		SSParticleWeather.particleEffect.animateSeverity(severityMod())

		//Wait for the last particle to fade, then qdel yourself
		addtimer(CALLBACK(src, PROC_REF(end)), SSParticleWeather.particleEffect.lifespan + SSParticleWeather.particleEffect.fade)



/**
 * Fully ends the weather
 *
 * Effects no longer occur and particles are wound down
 * Removes weather from processing completely
 *
 */
/datum/particle_weather/proc/end()
	running = FALSE
	SSParticleWeather.stopWeather()


/**
 * Returns TRUE if the living mob can hear the weather (you might be immune, but you get to listen to the pitter patter)
 */
/datum/particle_weather/proc/can_weather(mob/living/mob_to_check)
	var/turf/mob_turf = get_turf(mob_to_check)

	if(!mob_turf)
		return

	if(!mob_turf.outdoor_effect || mob_turf.outdoor_effect.weatherproof)
		return

	return TRUE

/**
 * Returns TRUE if the living mob can be affected by the weather
 */
/datum/particle_weather/proc/can_weather_effect(mob/living/mob_to_check)

	//If mob is not in a turf
	var/turf/mob_turf = get_turf(mob_to_check)
	var/atom/loc_to_check = mob_to_check.loc
	while(loc_to_check != mob_turf)
		if((immunity_type && HAS_TRAIT(loc_to_check, immunity_type)) || HAS_TRAIT(loc_to_check, TRAIT_WEATHER_IMMUNE))
			return
		loc_to_check = loc_to_check.loc

	return TRUE

/**
 * Try to do weather effects - if we can hear sound, play it
 * If we are affected by weather (i.e damage), do effect and send severity message
 */
/datum/particle_weather/proc/try_weather_act(mob/living/L)
	if(!L.mind)
		return
	if(can_weather(L))
		weather_sound_effect(L)
		if(can_weather_effect(L))
			weather_act(L)
			if(!messagedMobs[L] || world.time > messagedMobs[L])
				weather_message(L) //Try not to spam
	else
		stop_weather_sound_effect(L)
		messagedMobs[L] = 0 //resend a message next time they go outside

//Overload with weather effects
/datum/particle_weather/proc/weather_act(mob/living/L)
	return

//weather effects for objects
/datum/particle_weather/proc/weather_obj_act(obj/L)
	if(can_weather_act_obj(L))
		L.weather = TRUE
		L.weather_act_on(target_trait, severity)
	else
		L.weather = FALSE


//Not using looping_sounds properly. somebody smart should fix this
/datum/particle_weather/proc/weather_sound_effect(mob/living/L)
	var/datum/looping_sound/currentSound = currentSounds[L]
	if(currentSound)
		//SET VOLUME
		if(scale_vol_with_severity)
			currentSound.volume = initial(currentSound.volume) * severityMod()
		if(!currentSound.loop_started) //don't restart already playing sounds
			currentSound.start()
		return
	var/tempSound = scale_range_pick(minSeverity, maxSeverity, severity, weather_sounds)
	if(tempSound)
		currentSound = new tempSound(list(L), FALSE, TRUE, CHANNEL_WEATHER)
		currentSounds[L] = currentSound
		//SET VOLUME
		if(scale_vol_with_severity)
			currentSound.volume = initial(currentSound.volume) * severityMod()
		currentSound.start()

/datum/particle_weather/proc/stop_weather_sound_effect(mob/living/L)
	var/datum/looping_sound/currentSound = currentSounds[L]
	if(currentSound)
		currentSound.stop()


/datum/particle_weather/proc/weather_message(mob/living/L)
	messagedMobs[L] = world.time + 60 SECONDS //Chunky delay - this spams otherwise - Severity changes and going indoors resets this timer
	last_message = scale_range_pick(minSeverity, maxSeverity, severity, weather_messages)
	if(last_message)
		to_chat(L, last_message)

/datum/particle_weather/proc/can_weather_act_obj(obj/obj_to_check)
	var/turf/obj_turf = get_turf(obj_to_check)

	if(!obj_turf)
		return

	if(obj_turf.outdoor_effect?.weatherproof)
		return

	return TRUE


/client/proc/run_particle_weather()
	set category = "GameMaster"
	set name = "Run Particle Weather"
	set desc = "Triggers a particle weather"

	if(!holder)
		return

	var/weather_type = input("Choose a weather", "Weather")  as null|anything in sortList(subtypesof(/datum/particle_weather), /proc/cmp_typepaths_asc)
	if(!weather_type)
		return

	SSParticleWeather.run_weather(weather_type, TRUE)

	message_admins("[key_name_admin(usr)] started weather of type [weather_type].")
	log_admin("[key_name(usr)] started weather of type [weather_type].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Run Particle Weather")
