/obj/item/seeds
	name = "seeds"
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed"
	var/plant_def_type

/obj/item/seeds/attack_turf(turf/T, mob/living/user)
	var/obj/structure/soil/soil = get_soil_on_turf(T)
	if(soil)
		try_plant_seed(user, soil)
		return
	else if(istype(T, /turf/open/floor/rogue/dirt))
		to_chat(user, span_notice("I begin making a mound for the seeds..."))
		if(do_after(user, get_farming_do_time(user, 10 SECONDS), target = src))
			apply_farming_fatigue(user, 30)
			soil = get_soil_on_turf(T)
			if(!soil)
				soil = new /obj/structure/soil(T)
		return
	. = ..()

/obj/item/seeds/proc/try_plant_seed(mob/living/user, obj/structure/soil/soil)
	if(soil.plant)
		to_chat(user, span_warning("There is already something planted in \the [soil]!"))
		return
	if(!plant_def_type)
		return
	to_chat(user, span_notice("I plant \the [src] in \the [soil]."))
	soil.insert_plant(GLOB.plant_defs[plant_def_type])
	qdel(src)

/obj/item/seeds/wheat
	name = "wheat seeds"
	plant_def_type = /datum/plant_def/wheat

/obj/item/seeds/wheat/oat
	name = "oat seeds"
	plant_def_type = /datum/plant_def/oat

/obj/item/seeds/apple
	name = "apple seeds"
	plant_def_type = /datum/plant_def/apple

/obj/item/seeds/pipeweed
	name = "westleach leaf seeds"
	plant_def_type = /datum/plant_def/pipeweed

/obj/item/seeds/sweetleaf
	name = "swampweed seeds"
	plant_def_type = /datum/plant_def/sweetleaf

/obj/item/seeds/berryrogue
	name = "berry seeds"
	plant_def_type = /datum/plant_def/berry

/obj/item/seeds/berryrogue/poison
	name = "berry seeds"
	plant_def_type = /datum/plant_def/berry_poison

