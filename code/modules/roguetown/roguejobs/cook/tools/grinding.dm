/obj/structure/fluff/millstone
	name = "millstone"
	desc = "A millstone used to grind grain into flour."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "millstone"
	density = TRUE
	anchored = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 400
	var/list/obj/item/to_grind = list()

/obj/structure/fluff/millstone/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item))
		var/obj/item/I = W
		if(I.mill_result)
			playsound(get_turf(user), 'modular/Neu_Food/sound/milling.ogg', 100, TRUE, -1)
			if(do_after(user, 30, target = src))
				new I.mill_result(get_turf(loc))
				qdel(I)
			return
	..()
