/**
 * This list contains all tracked veil tolls in the game.
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
	icon_state = null

	/// Discriminating overlays used to make sure they are only visible to spirits
	var/image/icon_on_turf
	var/image/icon_in_hand

/obj/item/veil/toll/Initialize()
	icon_on_turf = image(
				icon = 'icons/roguetown/underworld/enigma_husks.dmi',
				icon_state = "soultoken_floor",
				loc = src
			)
	icon_in_hand = image(
				icon = 'icons/roguetown/underworld/enigma_husks.dmi',
				icon_state = "soultoken",
				loc = src
			)
	// let's assume it always spawns on the ground
	apply_veil(icon_on_turf, src)

/obj/item/veil/toll/pickup(mob/user)
	..()
	apply_veil(icon_in_hand, src)

/obj/item/veil/toll/dropped(mob/user)
	..()
	apply_veil(icon_on_turf, src)
	

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
