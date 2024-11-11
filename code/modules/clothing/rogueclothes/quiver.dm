
/obj/item/ammo_holder
	desc = ""
	icon = 'icons/roguetown/weapons/ammo.dmi'
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = NONE
	max_integrity = 0
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	alternate_worn_layer = UNDER_CLOAK_LAYER
	strip_delay = 20
	var/max_storage
	var/list/ammo = list()
	sewrepair = TRUE
	var/list/ammo_type

/obj/item/ammo_holder/quiver
	name = "quiver"
	icon_state = "quiver0"
	item_state = "quiver"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	max_storage = 20
	ammo_type = list (/obj/item/ammo_casing/caseless/rogue/arrow, /obj/item/ammo_casing/caseless/rogue/bolt)

/obj/item/ammo_holder/bullet
	name = "bullet pouch"
	icon_state = "pouch0"
	item_state = "pouch"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	max_storage = 10
	ammo_type = list(/obj/item/ammo_casing/caseless/rogue/bullet)

/obj/item/ammo_holder/attackby(obj/A, loc, params)
	for(var/i in ammo_type)
		if(istype(A, i))
			if(ammo.len < max_storage)
				A.forceMove(src)
				ammo += A
				update_icon()
			else
				to_chat(loc, span_warning("Full!"))
			return
	if(istype(A, /obj/item/gun/ballistic/revolver/grenadelauncher/bow))
		var/obj/item/gun/ballistic/revolver/grenadelauncher/bow/B = A
		if(ammo.len && !B.chambered)
			for(var/AR in ammo)
				if(istype(AR, /obj/item/ammo_casing/caseless/rogue/arrow))
					ammo -= AR
					B.attackby(AR, loc, params)
					break
		return
	..()

/obj/item/ammo_holder/attack_right(mob/user)
	if(ammo.len)
		var/obj/O = ammo[ammo.len]
		ammo -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		update_icon()
		return TRUE

/obj/item/ammo_holder/examine(mob/user)
	. = ..()
	if(ammo.len)
		. += span_notice("[ammo.len] inside.")

/obj/item/ammo_holder/update_icon()
	if(ammo.len)
		icon_state = "[item_state]1"
	else
		icon_state = "[item_state]0"

/obj/item/ammo_holder/quiver/arrows/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/rogue/arrow/iron/A = new()
		ammo += A
	update_icon()

/obj/item/ammo_holder/quiver/bolts/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/rogue/bolt/A = new()
		ammo += A
	update_icon()

/obj/item/ammo_holder/bullet/runed/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/rogue/bullet/A = new()
		ammo += A
	update_icon()
/*
/obj/item/ammo_holder/Parrows/Initialize()
	..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/rogue/arrow/poison/A = new()
		arrows += A
	update_icon()

/obj/item/ammo_holder/Pbolts/Initialize()
	..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/rogue/bolt/poison/A = new()
		arrows += A
	update_icon()
*/

