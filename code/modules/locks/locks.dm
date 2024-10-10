//MOJAVE SUN LOCK OBJECTS AND FUNCTION FILE//
/obj/item/ms13/lock
	name = "base ms13 lock"
	desc = "Lock this guy up."
	icon = 'mojave/icons/objects/tools/locks_world.dmi'
	icon_state = "brass"
	lefthand_file = 'mojave/icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'mojave/icons/mob/inhands/items_righthand.dmi'
	worn_icon = 'mojave/icons/mob/worn_melee.dmi'
	worn_icon_state = "empty_placeholder"
	w_class = WEIGHT_CLASS_SMALL
	item_flags = LOCKING_ITEM
	grid_width = 32
	grid_height = 32
	//(1 Master, 5 Expert, 10 Standard, 17 Novice, 20+ Beginner)
	lock_difficulty = 10
	//if the lock is open and free to use
	var/lock_open = FALSE
	//if the lock object is locked
	var/item_lock_locked = FALSE

/obj/item/ms13/lock/Initialize()
	. = ..()
	AddElement(/datum/element/world_icon, null, icon, 'mojave/icons/objects/tools/locks_inventory.dmi')

/obj/item/ms13/lock/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!lock_open && !item_lock_locked)
		icon_state = "[initial(icon_state)]_open"
		lock_open = TRUE
	if(lock_open)
		icon_state = initial(icon_state)
		lock_open = FALSE

/*
/obj/item/ms13/lock/attack_atom(atom/attacked_atom, mob/living/user, params)
	. = ..()
	if(!isobj(attacked_atom))
		return
	var/obj/obj_to_lock = attacked_atom
	if(can_have_lock && !lock_locked)
		if(!user.transferItemToLoc(obj_to_lock.lock, src))
			return
		obj_to_lock.lock = src
		obj_to_lock.lock_locked = TRUE
		to_chat(user, span_notice("You attach the [name] to the [obj_to_lock.name]."))
		if(istype(obj_to_lock, /obj/machinery/door/unpowered/ms13))
			var/obj/machinery/door/door = obj_to_lock
			door.locked = TRUE
			AddElement(/datum/element/lockpickable, lock_difficulty)
*/
