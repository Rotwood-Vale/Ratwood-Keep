/**
 * This tiny subsystem is responsible for managing the veil tolls.
 */
SUBSYSTEM_DEF(veil)
	name = "veil"
	flags = SS_NO_FIRE

/datum/controller/subsystem/veil/Initialize(timeofday)
	Initialize_tolls()
	return ..()

/**
 * This list contains all tracked veil tolls in the game.
 * It is used to avoid having too many coins in the game at once.
 */
GLOBAL_VAR_INIT(veil_tolls, 0)

#define MINIMUM_VEIL_TOLLS 20

/**
 * Places MINIMUM_VEIL_TOLLS in the map, distributed among the landmarks.
 */
/datum/controller/subsystem/veil/proc/Initialize_tolls()
	if(GLOB.veil_tolls < MINIMUM_VEIL_TOLLS)
		for(var/obj/effect/landmark/veil/toll/L in GLOB.landmarks_list)

			// reached the minimum?
			if(GLOB.veil_tolls >= MINIMUM_VEIL_TOLLS)
				break

			// place one per landmark
			new /obj/item/veil/toll/tracked(L.loc)
			continue 

/**
 * Called whenever a toll is picked up or dropped.
 * Ensures there's always enough tolls in the game.
 */
/datum/controller/subsystem/veil/proc/check_toll_upkeep()
	if(GLOB.veil_tolls < MINIMUM_VEIL_TOLLS)
		for(var/obj/effect/landmark/veil/toll/L in GLOB.landmarks_list)
			new /obj/item/veil/toll/tracked(L.loc)
			break //only one
