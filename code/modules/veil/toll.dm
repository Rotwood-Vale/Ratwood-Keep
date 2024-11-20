/obj/item/veil/toll
	name = "The Toll"
	desc = "This is more than just a coin."
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken"
	invisibility = INVISIBILITY_OBSERVER

/// Tracked version thats spawned in the map.
/obj/item/veil/toll/tracked/Initialize(mapload)
	. = ..()
	GLOB.veil_tolls += 1

/obj/item/veil/toll/tracked/Destroy()
	GLOB.veil_tolls -= 1
	SSveil.check_toll_upkeep()
	return ..()

// this is kind of an hack that simulates picking up the toll
/obj/item/veil/toll/attack_ghost(mob/dead/observer/rogue/veil/ghost)

	if(!ghost)
		return FALSE

	if(!istype(ghost, /mob/dead/observer/rogue/veil))
		return FALSE
	
	if(!ghost.Adjacent(src))
		return FALSE

	if(ghost.collected_toll)
		to_chat(ghost, span_bold("I already found a toll."))
		return FALSE

	to_chat(ghost, span_bold("My passage is paid."))
	ghost << sound('sound/misc/carriage4.ogg', 0, 0 ,0, 50)
	ghost.collected_toll = TRUE
	qdel(src)
