/obj/structure/fluff/statue/PileOfPower
	name = "statue"
	desc = ""
	icon = 'icons/roguetown/topadd/delinefortune/faithdlc.dmi'
	icon_state = "PileOfPower"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASH
	max_integrity = 5000
	dir = SOUTH

/obj/structure/fluff/statue/PileOfPower/OnCrafted(dirin, user)
	dirin = turn(dirin, 180)
	. = ..()

/obj/structure/fluff/statue/PileOfPower/attack_right(mob/user)
	if(user.mind && isliving(user))
		if(user.mind.special_items && user.mind.special_items.len)
			var/item = input(user, "What will I take?", "STASH") as null|anything in user.mind.special_items
			if(item)
				if(user.Adjacent(src))
					if(user.mind.special_items[item])
						var/path2item = user.mind.special_items[item]
						user.mind.special_items -= item
						var/obj/item/I = new path2item(user.loc)
						user.put_in_hands(I)
			return


/obj/structure/fluff/statue/PileOfPower/CanPass(atom/movable/mover, turf/target)
	if(get_dir(loc, mover) == dir)
		return 0
	return !density

/obj/structure/fluff/statue/PileOfPower/CheckExit(atom/movable/O, turf/target)
	if(get_dir(O.loc, target) == dir)
		return 0
	return !density
