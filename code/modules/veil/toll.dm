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
			new /obj/item/veil/toll/tracked(L.loc)

/obj/item/veil/toll
	name = "The Toll"
	desc = "This is more than just a coin."
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = null

	var/image/veil_icon

/obj/item/veil/toll/Initialize()
	veil_icon = image(
				icon = src.icon,
				icon_state = "soultoken",
				loc = src
			)
	// let's assume it always spawns on the ground
	apply_veil(veil_icon, src)

/obj/item/veil/toll/update_icon()
	. = ..()
	apply_veil(veil_icon, src)

/// Tracked version thats spawned in the map.
/obj/item/veil/toll/tracked/Initialize(mapload)
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

// this is kind of an hack that simulates picking up the toll
/obj/item/veil/toll/attack_ghost(mob/dead/observer/rogue/veil/ghost)

	if(ghost.collected_toll)
		return FALSE

	message_admins("The veil ghost has picked up a toll.")
	
	ghost.collected_toll = TRUE
	qdel(src)

/obj/item/veil/toll/Crossed(mob/dead/observer/rogue/veil/ghost)
	. = ..()

	if(ghost.collected_toll)
		return FALSE

	message_admins("The veil ghost has picked up a toll.")
	
	ghost.collected_toll = TRUE
	qdel(src)
