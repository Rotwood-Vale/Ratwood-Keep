// Unused normal carriage. Here so people dont use the special veil one by accident.
/obj/structure/carriage
	name = "Carriage"
	desc = "The ride stopped here..."
	icon = 'icons/roguetown/underworld/enigma_carriage.dmi'
	icon_state = "carriage_normal"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE

// looks like a normal carriage to the living, transforms into a portal in the veil.
/obj/structure/veil/carriage
	name = "Carriage"
	desc = "The ride stopped here..."
	icon = 'icons/roguetown/underworld/enigma_carriage.dmi'
	icon_state = "carriage_normal"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE
	var/image/veil_icon

/obj/structure/veil/carriage/Initialize()
	. = ..()
	veil_icon = image(
				icon = 'icons/roguetown/underworld/enigma_carriage.dmi',
				icon_state = "carriage_lit",
				loc = src
			)
	apply_veil(veil_icon, src)

/obj/structure/veil/carriage/update_icon()
	. = ..()
	apply_veil(veil_icon, src)

/obj/structure/veil/carriage/attack_ghost(mob/dead/observer/rogue/veil/ghost)

	if(!ghost)
		return FALSE

	if(!istype(ghost, /mob/dead/observer/rogue/veil))
		return FALSE

	if(!ghost.Adjacent(src))
		return FALSE

	if(!ghost.paid_toll)
		to_chat(ghost, span_bold("<br><font color=purple>IT REMAINS LOCKED.</font>"))
		return FALSE

	switch(alert("Are you ready to be judged?",,"Yes","No"))
		if("Yes")
			playsound(ghost, 'sound/misc/deadbell.ogg', 50, TRUE, -2, ignore_walls = TRUE)
			ghost.returntolobby()
			return TRUE
		if("No")
			ghost << "You delay fate."
			return FALSE
