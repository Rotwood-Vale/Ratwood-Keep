/obj/structure/bell_common
	name = "bell"
	desc = "A good way to get someone's attention... or piss them off."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "bell_common"
	density = FALSE
	max_integrity = 0
	anchored = TRUE
	var/last_ring

/obj/structure/bell_common/attack_hand(mob/user)
	if(world.time < last_ring + 15)
		return
	user.visible_message(span_info("[user] starts ringing the bell."))
	playsound(src, 'sound/misc/bell_common.ogg', 100, extrarange = 8, ignore_walls = TRUE)
	flick("bell_commonpressed", src)
	last_ring = world.time
