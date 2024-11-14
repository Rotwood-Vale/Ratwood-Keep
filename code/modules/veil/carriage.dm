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

/obj/structure/veil/barrier //Blocks sprite locations
	name = "DONT STAND HERE"
	desc = "The Undermaiden awaits."
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"
	density = TRUE
	anchored = TRUE

// looks like a normal carriage to the living, transforms into a portal in the veil.
/obj/structure/veil/carriage
	name = "Carriage"
	desc = "The Undermaiden awaits."
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

/obj/structure/veil/carriage/attack_hand(mob/dead/observer/rogue/veil/user)
	if(user)
		switch(alert("Are you ready to be judged?",,"Yes","No"))
			if("Yes")
				playsound(user, 'sound/misc/deadbell.ogg', 50, TRUE, -2, ignore_walls = TRUE)
				user.returntolobby()
			if("No")
				usr << "You delay fate."
	else
		to_chat(user, "<B><font size=3 color=red>It's LOCKED.</font></B>")
