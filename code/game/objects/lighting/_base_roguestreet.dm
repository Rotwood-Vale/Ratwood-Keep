/obj/machinery/light/roguestreet
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "slamp1"
	base_state = "slamp"
	brightness = 10
	nightshift_allowed = FALSE
	fueluse = 0
	bulb_colour = "#f9e080"
	bulb_power = 0.85
	max_integrity = 0
	use_power = NO_POWER_USE
	var/datum/looping_sound/soundloop
	pass_flags = LETPASSTHROW

/obj/machinery/light/roguestreet/midlamp
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "midlamp1"
	base_state = "midlamp"
	pixel_x = -16
	density = TRUE

/obj/machinery/light/roguestreet/proc/lights_out()
	if(soundloop)
		soundloop.stop()
	on = FALSE
	set_light(0)
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(lights_on)), 5 MINUTES)

/obj/machinery/light/roguestreet/proc/lights_on()
	on = TRUE
	update()
	update_icon()
	if(soundloop)
		soundloop.start()

/obj/machinery/light/roguestreet/update_icon()
	if(on)
		icon_state = "[base_state]1"
	else
		icon_state = "[base_state]0"

/obj/machinery/light/roguestreet/update()
	. = ..()
	if(on)
		GLOB.fires_list |= src
	else
		GLOB.fires_list -= src

/obj/machinery/light/roguestreet/Initialize()
	soundloop = pick(/datum/looping_sound/streetlamp1,/datum/looping_sound/streetlamp2,/datum/looping_sound/streetlamp3)
	if(soundloop)
		soundloop = new soundloop(list(src), FALSE)
		soundloop.start()
	GLOB.streetlamp_list += src
	update_icon()
	. = ..()

/obj/machinery/light/roguestreet/update_icon()
	if(on)
		icon_state = "[base_state]1"
	else
		icon_state = "[base_state]0"
