
//Snowflake path to mimick that of a quiver. Did the code the same way as the throwing knife belt minus the storage to avoid being able to hold other items in it.
/obj/item/javelinbag
	name = "javelin bag"
	desc = "A long, tube-like bag of fabric made to carry multiple javelins capable of being tossed over one's shoulder."
	icon_state = "javelinbag"
	item_state = "javelinbag"
	icon = 'icons/roguetown/clothing/storage.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	max_integrity = 150
	strip_delay = 20
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK		//No hip slot, too strong that way.
	var/max_storage = 4				//More than 4 is way too much given how effective they can be.
	var/list/arrows = list()		//Quiver-code, the javelins are just listed as arrows. Sue me.
	alternate_worn_layer = UNDER_CLOAK_LAYER
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE
	
/obj/item/javelinbag/attack_turf(turf/T, mob/living/user)
	if(arrows.len >= max_storage)
		to_chat(user, span_warning("Your [src.name] is full!"))
		return
	to_chat(user, span_notice("You begin to gather the javelins..."))
	for(var/obj/item/rogueweapon/spear/javelin/arrow in T.contents)
		if(do_after(user, 5))
			if(!eatarrow(arrow))
				break

/obj/item/javelinbag/proc/eatarrow(obj/A)
	if(A.type in subtypesof(/obj/item/rogueweapon/spear/javelin))
		if(arrows.len < max_storage)
			A.forceMove(src)
			arrows += A
			update_icon()
			return TRUE
		else
			return FALSE

/obj/item/javelinbag/attackby(obj/A, loc, params)
	if(A.type in subtypesof(/obj/item/rogueweapon/spear/javelin))
		if(arrows.len < max_storage)
			if(ismob(loc))
				var/mob/M = loc
				M.doUnEquip(A, TRUE, src, TRUE, silent = TRUE)
			else
				A.forceMove(src)
			arrows += A
			update_icon()
			to_chat(usr, span_notice("I discreetly slip [A] into [src]."))
		else
			to_chat(loc, span_warning("Full!"))
		return
	..()

/obj/item/javelinbag/attack_right(mob/user)
	if(arrows.len)
		var/obj/O = arrows[arrows.len]
		arrows -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		update_icon()
		return TRUE

/obj/item/javelinbag/examine(mob/user)
	. = ..()
	if(arrows.len)
		. += span_notice("[arrows.len] inside.")

/obj/item/javelinbag/update_icon()
	if(arrows.len)
		icon_state = "javelinbag1"
	else
		icon_state = "javelinbag0"

/obj/item/javelinbag/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/spear/javelin/A = new()
		arrows += A
	update_icon()
