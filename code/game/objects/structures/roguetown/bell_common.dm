/obj/structure/bell_common
	name = "bell"
	desc = "A good way to get someone's attention... or piss them off."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "bell_common"
	density = FALSE
	max_integrity = 0
	anchored = TRUE
	var/last_ring
	var/datum/looping_sound/boatloop/soundloop

/obj/structure/bell_common/Initialize()
	soundloop = new(list(src), FALSE)
	soundloop.start()
	. = ..()

/obj/structure/bell_common/attack_hand(mob/user)
	if(world.time < last_ring + 15)
		return
	user.visible_message(span_info("[user] rings the bell."))
	SSshuttle.moveShuttle("supply", "supply_away", TRUE)
	playsound(src, 'sound/misc/bell_common.ogg', 100, extrarange = 5)
	last_ring = world.time
