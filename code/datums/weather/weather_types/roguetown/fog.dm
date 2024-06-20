/* /datum/weather/fog
	name = "fog"
	desc = ""

	telegraph_duration = 10 SECONDS
	telegraph_message = span_warning("The fog is coming.")
	telegraph_sound = 'sound/blank.ogg'
	weather_message = ""
	weather_overlay = "rain1"
	weather_duration_lower = 5 MINUTES
	weather_duration_upper = 15 MINUTES
	weather_sound = 'sound/blank.ogg'
	weather_alpha = 200

	probability = 3

	end_duration = 5 SECONDS
	end_message = ""
	end_sound = 'sound/blank.ogg'

	area_type = /area/rogue/outdoors
	protected_areas = list(/area/rogue/indoors,/area/rogue/under)
	impacted_z_levels = list()
	var/lastlightning = 0

	particles = list(/atom/movable/screen/weather/fog)


/datum/weather/fog/process()
#ifndef TESTSERVER
	if(GLOB.forecast != "fog")
		wind_down()
		return
#endif */
