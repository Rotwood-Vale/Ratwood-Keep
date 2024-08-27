//Technically should just be a quiver, but fuck it - we snowflake up in this bitch.
//Holds 1/3rd the amount of rounds as a quiver holds arrows, but pretty damn strong against armor so - yeah, suffer.
/obj/item/ammopouch
	name = "bullet pouch"
	desc = ""
	icon_state = "pouch0"
	item_state = "pouch"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_HIP
	resistance_flags = NONE
	max_integrity = 0
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	alternate_worn_layer = UNDER_CLOAK_LAYER
	strip_delay = 10
	var/max_storage = 10
	var/list/bullets = list()
	sewrepair = TRUE

/obj/item/ammopouch/attackby(obj/A, loc, params)
	if(A.type in subtypesof(/obj/item/ammo_casing/caseless/rogue))
		if(bullets.len < max_storage)
			A.forceMove(src)
			bullets += A
			update_icon()
		else
			to_chat(loc, span_warning("Full!"))
		return
	if(istype(A, /obj/item/gun/ballistic/revolver/grenadelauncher/matchlock))
		var/obj/item/gun/ballistic/revolver/grenadelauncher/matchlock/B = A
		if(bullets.len && !B.chambered)
			for(var/AR in bullets)
				if(istype(AR, /obj/item/ammo_casing/caseless/rogue/bullet))
					bullets -= AR
					B.attackby(AR, loc, params)
					break
		return
	..()

/obj/item/ammopouch/attack_right(mob/user)
	if(bullets.len)
		var/obj/O = bullets[bullets.len]
		bullets -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		update_icon()
		return TRUE

/obj/item/ammopouch/examine(mob/user)
	. = ..()
	if(bullets.len)
		. += span_notice("[bullets.len] inside.")

/obj/item/ammopouch/update_icon()
	if(bullets.len)
		icon_state = "pouch1"
	else
		icon_state = "pouch0"

/obj/item/ammopouch/bullets/Initialize()
	..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/rogue/bullet/A = new()
		bullets += A
	update_icon()
