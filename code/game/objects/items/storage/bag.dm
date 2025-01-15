
/obj/item/storage/tray
	name = "tray"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "tray"
	desc = ""
	throwforce = 10
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = NONE
	max_integrity = 100

	component_type = /datum/component/storage/concrete/roguetown/tray

/obj/item/storage/tray/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE

/obj/item/storage/tray/psy
	name = "tray"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "tray_psy"
	desc = ""

/obj/item/storage/tray/attack(mob/living/M, mob/living/user)
	..()
	// Drop all the things. All of them.
	var/list/obj/item/oldContents = contents.Copy()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_QUICK_EMPTY)

	// Make each item scatter a bit
	for (var/obj/item/I in oldContents)
		if (I)
			do_scatter(I)

	if(prob(50))
		playsound(M, 'sound/blank.ogg', 50, TRUE)
	else
		playsound(M, 'sound/blank.ogg', 50, TRUE)

	if(ishuman(M) || ismonkey(M))
		if(prob(10))
			M.Paralyze(40)
	update_icon()

/obj/item/storage/tray/proc/do_scatter(obj/item/I)
	if (I)
		for (var/i in 1 to rand(1, 2))
			var/xOffset = rand(-16, 16)  // Adjust the range as needed
			var/yOffset = rand(-16, 16)  // Adjust the range as needed

			I.x = xOffset
			I.y = yOffset


			sleep(rand(2, 4))

/obj/item/storage/tray/update_icon()
	cut_overlays()
	for(var/obj/item/I in contents)
		var/mutable_appearance/I_copy = new(I)
		//some of the following is redundant
		I_copy.cut_overlays()
		I_copy.underlays = list()
		I_copy.icon = initial(I.icon)
		I_copy.icon_state = initial(I.icon_state)
		I_copy.plane = FLOAT_PLANE + 1
		I_copy.layer = FLOAT_LAYER
		add_overlay(I_copy)


/obj/item/storage/tray/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	update_icon()

/obj/item/storage/tray/Exited(atom/movable/gone, direction)
	. = ..()
	update_icon()

/obj/item/storage/tray/Moved()
	. = ..()
	update_icon()
