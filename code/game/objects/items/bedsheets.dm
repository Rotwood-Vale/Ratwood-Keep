/*
CONTAINS:
BEDSHEETS
LINEN BINS
*/

/obj/item/bedsheet
	name = "bedsheet"
	desc = ""
	icon = 'icons/obj/bedsheets.dmi'
	lefthand_file = 'icons/mob/inhands/misc/bedsheet_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/bedsheet_righthand.dmi'
	icon_state = "sheetwhite"
	item_state = "sheetwhite"
	layer = MOB_LAYER
	plane = GAME_PLANE_FOV_HIDDEN
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	dying_key = DYE_REGISTRY_BEDSHEET

	dog_fashion = /datum/dog_fashion/head/ghost
	var/list/dream_messages = list("white")

/obj/item/bedsheet/attack_self(mob/user)
	if(!user.CanReach(src))		//No telekenetic grabbing.
		return
	if(!user.dropItemToGround(src))
		return
	if(layer == initial(layer))
		layer = ABOVE_MOB_LAYER
		to_chat(user, "<span class='notice'>I cover myself with [src].</span>")
		pixel_x = 0
		pixel_y = 0
	else
		layer = initial(layer)
		to_chat(user, "<span class='notice'>I smooth [src] out beneath you.</span>")
	add_fingerprint(user)
	return

/obj/item/bedsheet/rogue/cloth
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "cloth_bedsheet"
	item_state = "cloth_bedsheet"
	pixel_y = 5

/obj/item/bedsheet/rogue/pelt
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "pelt_bedsheet"
	item_state = "pelt_bedsheet"
	pixel_y = 5

/obj/item/bedsheet/rogue/wool
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "wool_bedsheet"
	item_state = "wool_bedsheet"
	pixel_y = 5

/obj/item/bedsheet/rogue/double_pelt
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "double_pelt_bedsheet"
	item_state = "double_pelt_bedsheet"

/obj/item/bedsheet/rogue/fabric
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "fabric_bedsheet"
	item_state = "fabric_bedsheet"
	pixel_y = 5

/obj/item/bedsheet/rogue/fabric_double
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "double_fabric_bedsheet"
	item_state = "double_fabric_bedsheet"

/obj/item/bedsheet/random
	icon_state = "random_bedsheet"
	name = "random bedsheet"
	desc = ""
