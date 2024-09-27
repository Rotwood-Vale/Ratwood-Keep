/obj/structure/timeddoor
	name = "mysterious mechanism"
	desc = "An impassable mechanism, fortified with magic and steel. Seems to be Dwarven in origin."
	icon = 'icons/roguetown/misc/doors.dmi'
	icon_state = "timedoor"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/deletion_time = 30 MINUTES

/obj/structure/timeddoor/sixtyminute
	deletion_time = 60 MINUTES

/obj/structure/timeddoor/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/timeddeletedoor), deletion_time)

/obj/structure/timeddoor/proc/timeddeletedoor()
	playsound(loc, 'modular_hearthstone/sound/misc/timedoor.ogg', 50, TRUE, -1)
	qdel(src)
