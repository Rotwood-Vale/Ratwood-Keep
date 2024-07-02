/obj/structure/abyssor_altar
	name = "attuned altar"
	desc = "An enhanced altar capable of transporting goods through attunement to Abyssor."
	icon = 'icons/obj/structures/abyssoraltar.dmi'
	icon_state = "abyssoraltar"
	density = FALSE
	max_integrity = 600
	anchored = TRUE

/obj/structure/abyssor_altar/examine(mob/user)
	. = ..()
	. += span_info("You feel that Abyssor has got [SSshipments.chest_amount] coffers ready")
