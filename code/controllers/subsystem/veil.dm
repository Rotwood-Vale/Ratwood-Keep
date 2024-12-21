/**
 * This list contains all tracked veil tolls in the game.
 * It is used to avoid having too many coins in the game at once.
 */
GLOBAL_VAR_INIT(veil_tolls, 0)

#define MINIMUM_VEIL_TOLLS 40

/**
 * This tiny subsystem is responsible for managing the veil tolls.
 */
SUBSYSTEM_DEF(veil)
	name = "Veil"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_VEIL

/datum/controller/subsystem/veil/Initialize(timeofday)
	Initialize_tolls()
	return ..()

/// Places tolls in the map, one per landmark
/datum/controller/subsystem/veil/proc/Initialize_tolls()

	shuffle_inplace(GLOB.landmarks_list)

	for(var/obj/effect/landmark/veil/toll/L in GLOB.landmarks_list)

		if(GLOB.veil_tolls >= MINIMUM_VEIL_TOLLS)
			break

		new /obj/item/veil/toll/tracked(L.loc) 

/**
 * Called whenever a toll is picked up.
 * Ensures there's always enough tolls in the game.
 */
/datum/controller/subsystem/veil/proc/check_toll_upkeep()

	if(GLOB.veil_tolls < MINIMUM_VEIL_TOLLS)

		for(var/obj/effect/landmark/veil/toll/L in GLOB.landmarks_list)

			// Skip if there's already a toll in this landmark
			if((locate(/obj/item/veil/toll/tracked) in get_turf(L.loc)))
				continue

			new /obj/item/veil/toll/tracked(L.loc)
			break //only one
