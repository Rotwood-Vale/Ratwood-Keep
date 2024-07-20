/obj/structure/fluff/millstone
	name = "millstone"
	desc = "A millstone used to grind grain into flour."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "millstone"
	density = TRUE
	anchored = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 400

/obj/structure/fluff/millstone/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = W
		if(S.mill_result)
			if(do_after(user, 10, target = src))
				new S.mill_result(get_turf(loc))
				qdel(S)
			return
	if(istype(W, /obj/item/natural/stone))
		if(do_after(user, 10, target = src))
			new /obj/item/reagent_containers/powder/flour/salt(get_turf(loc))
			qdel(W)
		return
	..()
