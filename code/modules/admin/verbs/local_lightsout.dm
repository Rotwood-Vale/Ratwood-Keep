/client/proc/local_lightsout()
	set category = "Fun"
	set name = "Local Lightsout"

	if(!check_rights(R_ADMIN))
		return

	for(var/obj/O in view(usr.client))
		O.extinguish()
		if(O.type == /obj/machinery/light/roguestreet/)
			var/obj/machinery/light/roguestreet/streetlamp = O
			streetlamp.lights_out()
