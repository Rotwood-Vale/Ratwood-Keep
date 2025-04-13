/obj/structure/fluff/statue/faith
	name = "statue"
	desc = ""
	icon = 'icons/roguetown/misc/faithdlc.dmi'
	icon_state = "bstatue"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASH
	max_integrity = 5000
	dir = SOUTH

/obj/structure/fluff/statue/faith/OnCrafted(dirin, user)
	dirin = turn(dirin, 180)
	. = ..()

/obj/structure/fluff/statue/faith/attack_right(mob/user)
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


/obj/structure/fluff/statue/faith/CanPass(atom/movable/mover, turf/target)
	if(get_dir(loc, mover) == dir)
		return 0
	return !density

/obj/structure/fluff/statue/faith/CheckExit(atom/movable/O, turf/target)
	if(get_dir(O.loc, target) == dir)
		return 0
	return !density

/obj/structure/fluff/statue/faith/astrata
	name = "statue"
	desc = ""
	icon_state = "Astrata"	

/obj/structure/fluff/statue/faith/noc
	name = "statue"
	desc = ""
	icon_state = "Noc"		

/obj/structure/fluff/statue/faith/necra
	name = "statue"
	desc = ""
	icon_state = "Necra"		

/obj/structure/fluff/statue/faith/pestra
	name = "statue"
	desc = ""
	icon_state = "Pestra"	

/obj/structure/fluff/statue/faith/eora
	name = "statue"
	desc = ""
	icon_state = "Eora"

/obj/structure/fluff/statue/faith/malum
	name = "statue"
	desc = ""
	icon_state = "Malum"	

/obj/structure/fluff/statue/faith/dendor
	name = "statue"
	desc = ""
	icon_state = "Dendor"	

/obj/structure/fluff/statue/faith/malum
	name = "statue"
	desc = ""
	icon_state = "Malum"	

/obj/structure/fluff/statue/faith/ravox
	name = "statue"
	desc = ""
	icon_state = "Ravox"			

/obj/structure/fluff/statue/faith/abyssor
	name = "statue"
	desc = ""
	icon_state = "Abyssor"			

/obj/structure/fluff/statue/faith/xylix
	name = "statue"
	desc = ""
	icon_state = "Xylix"	
