/atom/movable
	// Text-to-bark sounds
	var/sound/vocal_bark
	var/vocal_bark_id
	var/vocal_pitch = 1
	var/vocal_pitch_range = 0.2 //Actual pitch is (pitch - (vocal_pitch_range*0.5)) to (pitch + (vocal_pitch_range*0.5))
	var/vocal_volume = 70 //Baseline. This gets modified by yelling and other factors
	var/vocal_speed = 4 //Lower values are faster, higher values are slower

	var/vocal_current_bark //When barks are queued, this gets passed to the bark proc. If vocal_current_bark doesn't match the args passed to the bark proc (if passed at all), then the bark simply doesn't play. Basic curtailing of spam~

/atom/movable/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_BARK, PROC_REF(handle_special_bark)) //There must be a better way to do this

/atom/movable/Destroy()
	UnregisterSignal(src, COMSIG_MOVABLE_BARK)
	. = ..()

/// Sets the vocal bark for the atom, using the bark's ID
/atom/movable/proc/set_bark(id)
	if(!id)
		return FALSE
	var/datum/bark/B = GLOB.bark_list[id]
	if(!B)
		return FALSE
	vocal_bark = sound(initial(B.soundpath))
	vocal_bark_id = id
	return vocal_bark

/atom/movable/proc/handle_special_bark(atom/movable/source, list/hearers, distance, volume, pitch)
	SIGNAL_HANDLER

	if(!CONFIG_GET(flag/enable_global_barks))
		return //No need to run if there are no barks to begin with

	var/list/soundpaths
	switch(GLOB.bark_list[source.vocal_bark_id])
		if(/datum/bark/gaster)
			soundpaths = list(
				'sound/barks/voice_gaster_1.ogg',
				'sound/barks/voice_gaster_2.ogg',
				'sound/barks/voice_gaster_3.ogg',
				'sound/barks/voice_gaster_4.ogg',
				'sound/barks/voice_gaster_5.ogg',
				'sound/barks/voice_gaster_6.ogg',
				'sound/barks/voice_gaster_7.ogg'
			)
		else
			return //No change needed

	source.vocal_bark = sound(pick(soundpaths))
