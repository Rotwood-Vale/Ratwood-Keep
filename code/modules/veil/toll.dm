/**
 * This list keeps track of all the underworld coins in the game.
 * It is used to avoid having too many coins in the game at once.
 */
GLOBAL_VAR_INIT(veil_tolls, 0)

#define MINIMUM_VEIL_TOLLS 8

/**
 * Called whenever a toll is picked up or dropped.
 * Ensures there's always enough tolls in the game.
 */
/proc/check_toll_upkeep()
	if(GLOB.veil_tolls < MINIMUM_VEIL_TOLLS)
		for(var/obj/effect/landmark/veil/toll/L in GLOB.landmarks_list)
			new /obj/item/veil/toll(L.loc)

/obj/item/veil/toll
	name = "The Toll"
	desc = "This is more than just a coin."
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken_floor"

/obj/item/veil/toll/pickup(mob/user)
	..()
	icon_state = "soultoken"

/obj/item/veil/toll/dropped(mob/user)
	..()
	icon_state = "soultoken_floor"
	

/// Tracked version thats spawned in the map.
/obj/item/veil/toll/tracked/Initialize()
	. = ..()
	GLOB.veil_tolls += 1

/obj/item/veil/toll/tracked/Destroy()
	GLOB.veil_tolls -= 1
	check_toll_upkeep()
	return ..()

/obj/item/veil/toll/tracked/pickup(mob/user)
	..()
	GLOB.veil_tolls -= 1
	check_toll_upkeep()

/obj/item/veil/toll/tracked/dropped(mob/user)
	..()
	GLOB.veil_tolls += 1
