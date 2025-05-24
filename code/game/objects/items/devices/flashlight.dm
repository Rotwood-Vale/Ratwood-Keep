/obj/item/flashlight
	name = "flashlight"
	desc = ""
	custom_price = 10
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flashlight"
	item_state = "flashlight"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = null
	slot_flags = ITEM_SLOT_BELT
	light_system = MOVABLE_LIGHT
	possible_item_intents = list(INTENT_GENERIC)
	var/on = FALSE

/obj/item/flashlight/Initialize()
	. = ..()
	if(icon_state == "[initial(icon_state)]-on")
		on = TRUE
	update_brightness()

/obj/item/flashlight/proc/update_brightness(mob/user)
	if(on)
		icon_state = "[initial(icon_state)]-on"
	else
		icon_state = initial(icon_state)
	set_light_on(on)


/obj/item/flashlight/attack_self(mob/user)
	on = !on
	update_brightness(user)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()
	return 1

/obj/item/flashlight/suicide_act(mob/living/carbon/human/user)
	if (user.eye_blind)
		user.visible_message(span_suicide("[user] is putting [src] close to [user.p_their()] eyes and turning it on... but [user.p_theyre()] blind!"))
		return SHAME
	user.visible_message(span_suicide("[user] is putting [src] close to [user.p_their()] eyes and turning it on! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (FIRELOSS)

/obj/item/flashlight/attack(mob/living/carbon/M, mob/living/carbon/human/user)
	add_fingerprint(user)
	return ..()

// FLARES

/obj/item/flashlight/flare
	name = "flare"
	desc = ""
	w_class = WEIGHT_CLASS_SMALL
	light_range = 7 // Pretty bright.
	icon_state = "flare"
	item_state = "flare"
	actions_types = list()
	heat = 1000
	light_color = LIGHT_COLOR_FLARE
	grind_results = list(/datum/reagent/sulfur = 15)

	var/fuel = 12000
	var/on_damage = 7
	var/produce_heat = 1500
	var/times_used = 0

/obj/item/flashlight/flare/process()
	open_flame(heat)
	fuel = max(fuel - 1, 0)
	if(!fuel || !on)
		turn_off()
		if(!fuel)
			icon_state = "[initial(icon_state)]-empty"
		STOP_PROCESSING(SSobj, src)

/obj/item/flashlight/flare/ignition_effect(atom/A, mob/user)
	if(fuel && on)
		. = "<span class='notice'>[user] lights [A] with [src] like a real \
			badass.</span>"
	else
		. = ""

/obj/item/flashlight/flare/proc/turn_off()
	on = FALSE
	force = initial(src.force)
	damtype = initial(src.damtype)
	if(ismob(loc))
		var/mob/U = loc
		update_brightness(U)
	else
		update_brightness(null)

/obj/item/flashlight/flare/update_brightness(mob/user = null)
	..()
	if(on)
		item_state = "[initial(item_state)]-on"
	else
		item_state = "[initial(item_state)]"

/obj/item/flashlight/flare/attack_self(mob/user)

	// Usual checks
	if(!fuel)
		to_chat(user, span_warning("[src] is out of fuel!"))
		return
	if(on)
		to_chat(user, span_warning("[src] is already on!"))
		return

	. = ..()
	// All good, turn it on.
	if(.)
		user.visible_message(span_notice("[user] lights \the [src]."), span_notice("I light \the [src]!"))
		force = on_damage
//		damtype = "fire"
		START_PROCESSING(SSobj, src)

/obj/item/flashlight/flare/get_temperature()
	return on * heat

/obj/item/flashlight/flare/torch
	name = "torch"
	desc = "The light.. the promise of safety!"
	w_class = WEIGHT_CLASS_NORMAL
	light_range = 4
	light_color = LIGHT_COLOR_ORANGE
	force = 10
	icon = 'icons/roguetown/items/lighting.dmi'
	icon_state = "torch"
	item_state = "torch"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	light_color = "#da8c45"
	on_damage = 10
	flags_1 = null
	possible_item_intents = list(/datum/intent/hit, /datum/intent/use)
	slot_flags = ITEM_SLOT_HIP
	var/datum/looping_sound/torchloop/soundloop
	max_integrity = 200
	fuel = 30 MINUTES
	light_depth = 0
	light_height = 0
	metalizer_result = /obj/item/flashlight/flare/torch/lantern

/obj/item/flashlight/flare/torch/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -9,"sy" = 3,"nx" = 12,"ny" = 4,"wx" = -6,"wy" = 5,"ex" = 3,"ey" = 6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 2,"sturn" = 2,"wturn" = -2,"eturn" = -2,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/flashlight/flare/torch/Initialize()
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/flashlight/flare/torch/process()
	open_flame(heat)
	if(!fuel || !on)
		turn_off()
		STOP_PROCESSING(SSobj, src)
		if(!fuel)
			icon_state = "torch-empty"
		return
	if(!istype(loc,/obj/machinery/light/rogue/torchholder))
		if(!ismob(loc))
			if(prob(23))
				turn_off()
				STOP_PROCESSING(SSobj, src)
				return
		else
			var/mob/M = loc
			if(!(src in M.held_items))
				if(prob(23))
					turn_off()
					STOP_PROCESSING(SSobj, src)
					return
		fuel = max(fuel - 10, 0)

/obj/item/flashlight/flare/torch/attack_self(mob/user)

	// Usual checks
//	if(!fuel)
//		to_chat(user, span_warning("[src] doesn't have any pitch left!"))
//		return
	if(on)
		turn_off()

/obj/item/flashlight/flare/torch/extinguish()
	if(on)
		turn_off()

/obj/item/flashlight/flare/torch/turn_off()
	playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
	soundloop.stop()
	STOP_PROCESSING(SSobj, src)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
		M.update_inv_belt()
	damtype = BRUTE

/obj/item/flashlight/flare/torch/fire_act(added, maxstacks)
	if(fuel)
		if(!on)
			playsound(src.loc, 'sound/items/firelight.ogg', 100)
			on = TRUE
			damtype = BURN
			update_brightness()
			force = on_damage
			soundloop.start()
			if(ismob(loc))
				var/mob/M = loc
				M.update_inv_hands()
			START_PROCESSING(SSobj, src)
			return TRUE
	..()

/obj/item/flashlight/flare/torch/afterattack(atom/movable/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(on)
		if(prob(50) || (user.used_intent.type == /datum/intent/use))
			if(ismob(A))
				A.spark_act()
			else
				A.fire_act(3,3)

/obj/item/flashlight/flare/torch/spark_act()
	fire_act()

/obj/item/flashlight/flare/torch/get_temperature()
	if(on)
		return 150+T0C
	return ..()

/obj/item/flashlight/flare/torch/metal
	name = "torch"
	force = 15
	icon_state = "mtorch"
	light_range = 6
	fuel = 9999 MINUTES
	metalizer_result = null

/obj/item/flashlight/flare/torch/lantern
	name = "iron lamptern"
	icon_state = "lamp"
	desc = "Flames kept safe within an iron cage."
	light_range = 7
	on = FALSE
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_HIP
	obj_flags = CAN_BE_HIT
	force = 15
	on_damage = 15
	fuel = 9999 MINUTES
	var/open = TRUE
	var/list/occupants = list()
	var/max_occupants = 1 //Hard-cap so you can't have multiple seelie in one carrier
	metalizer_result = null
	smeltresult = /obj/item/ingot/iron

/obj/item/flashlight/flare/torch/lantern/process()
	open_flame(heat)
	fuel = max(fuel - 1, 0)
	if(!fuel || !on)
		turn_off()
		STOP_PROCESSING(SSobj, src)

/obj/item/flashlight/flare/torch/lantern/extinguish()
	return

/obj/item/flashlight/flare/torch/lantern/attack_self(mob/user)
	if(on && !(occupants.len))
		turn_off()

/obj/item/flashlight/flare/torch/lantern/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,
"sx" = -2,
"sy" = -4,
"nx" = 11,
"ny" = -4,
"wx" = 2,
"wy" = -4,
"ex" = 3,
"ey" = -4,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 0,
"sturn" = 0,
"wturn" = 0,
"eturn" = 0,
"nflip" = 0,
"sflip" = 0,
"wflip" = 0,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/flashlight/flare/torch/lantern/bronzelamptern
	name = "bronze lamptern"
	icon_state = "bronzelamp"
	item_state = "bronzelamp"
	desc = "A marvel of engineering that emits a strange green glow."
	light_range = 8
	light_color ="#4ac77e"
	on = FALSE
	smeltresult = /obj/item/ingot/bronze

//------------BEGIN LANTERN SEELIE CARRYING CODE--------------//

/obj/item/flashlight/flare/torch/lantern/fire_act(added, maxstacks)
	if(fuel)
		if(occupants.len)
			to_chat(loc, span_warning("There is an occupant, you'll burn them!"))
			return FALSE
		else if(!on)
			playsound(src.loc, 'sound/items/firelight.ogg', 100)
			on = TRUE
			damtype = BURN
			update_brightness()
			force = on_damage
			soundloop.start()
			if(ismob(loc))
				var/mob/M = loc
				M.update_inv_hands()
			START_PROCESSING(SSobj, src)
			return TRUE
	..()

//On exiting the lantern
/obj/item/flashlight/flare/torch/lantern/Exited(atom/movable/occupant)
	if(occupant in occupants && isliving(occupant))
		//var/mob/living/L = occupant
		occupants -= occupant
		//occupant_weight -= L.mob_size

//On being examined
/obj/item/flashlight/flare/torch/lantern/examine(mob/user)
	. = ..()
	if(occupants.len)
		for(var/V in occupants)
			var/mob/living/L = V
			. += span_notice("It has [L] inside.")
	else
		. += span_notice("It has nothing inside.")
	//if(user.canUseTopic(src))
		//. += span_notice("Activate it in your hand to [open ? "close" : "open"] its door.")

//Door closing and opening proc
/obj/item/flashlight/flare/torch/lantern/rmb_self(mob/living/user)
	if(open)
		to_chat(user, span_notice("I close [src]'s door."))
		playsound(user, 'sound/blank.ogg', 50, TRUE)
		open = FALSE
	else
		to_chat(user, span_notice("I open [src]'s door."))
		playsound(user, 'sound/blank.ogg', 50, TRUE)
		open = TRUE

/// Checks if target can be stored in the lantern.
/// User is the mob that receives feedback messages.
/obj/item/flashlight/flare/torch/lantern/proc/can_store_mob(mob/living/target, mob/living/user, do_warning = TRUE)
	if(!user)
		do_warning = FALSE
	if(!open)	//Lantern must be "open", or unlocked
		if(do_warning)
			to_chat(user, span_warning("I need to open \the [src]'s door!"))
		return FALSE
	var/they = target.p_they()
	var/them = target.p_them()
	var/target_string = "\the [target]"
	if(target == user)
		they = "you"
		them = "yourself"
		target_string = "you"
	if(!HAS_TRAIT(target, TRAIT_TINY))
		if(do_warning)
			to_chat(user, span_warning("How could [they] possibly fit?"))
		return FALSE
	if(target.buckled) //Seelie is buckled
		if(do_warning)
			to_chat(user, span_warning("Unbuckle [them] first."))
		return FALSE
	// Check if we're in a Seelie's inventory.
	if(item_flags & IN_INVENTORY)
		var/mob/living/holder = get(src, /mob/living) // Get the mob whose inventory we're in.
		if(holder == target)
			if(do_warning)
				var/user_string = (target == user) ? "you're" : "they're"
				to_chat(user, span_warning("\The [src] can't fit [target_string] while [user_string] holding it!"))
			return FALSE
		if(isseelie(holder)) //Left this one as a seelie check since they shrink items
			if(do_warning)
				to_chat(user, span_warning("\The [src] can't fit [target_string] while it's shrunken by a Seelie!"))
			return FALSE
	if(on)
		if(do_warning)
			to_chat(user, span_warning("[src] is lit, you'll burn [them]!"))
		return FALSE
	if(length(occupants) >= max_occupants)
		if(do_warning)
			to_chat(user, span_warning("[src] is already carrying a seelie!"))
		return FALSE
	return TRUE


//Handles loading of lantern via "attacking" (clicking) on mob with it
/obj/item/flashlight/flare/torch/lantern/attack(mob/living/target, mob/living/user)
	if(!(istype(user.rmb_intent, /datum/rmb_intent/weak)))	//Only allow caging seelie via weak intent rmb
		return ..()
	if(!can_store_mob(target, user))
		return
	load_occupant(user, target)

//Gets called when movement allows mob out of lantern
/obj/item/flashlight/flare/torch/lantern/relaymove(mob/living/user, direction)
	if(open)
		loc.visible_message(span_notice("[user] climbs out of [src]!"), \
			span_warning("[user] jumps out of [src]!"))
		remove_occupant(user)
		return
	//else if(user.client)
		//container_resist(user)

//Allows seelie held in the lantern the opportunity to unlock it from inside
/obj/item/flashlight/flare/torch/lantern/container_resist(mob/living/user)	//This spams messages while movement key is held down
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	loc.visible_message(span_warning("[src] starts rattling as something pushes against the door!"), ignored_mobs = user)
	to_chat(user, span_notice("I start pushing against the door of the [src]..."))
	if(do_after(user, 20 SECONDS, target = src) && !open && (user in occupants))
		loc.visible_message(span_warning("[user] shoves out of	[src]!"), ignored_mobs = user)
		to_chat(user, span_notice("I force open the [src]'s door and fall out!"))
		open = TRUE
		remove_occupant(user)
	else
		to_chat(user, span_notice("I fail to break out of [src]..."))

//Handle something (O) drag dropped onto lamp by (user)
/obj/item/flashlight/flare/torch/lantern/MouseDrop_T(atom/movable/O, mob/living/user)
	if(isliving(O) && HAS_TRAIT(O, TRAIT_TINY) && O == user && can_store_mob(user, user))
		loc.visible_message(span_notice("[user] starts climbing into [src]!"), \
		span_warning("[user] starts climbing into [src]!"))
		if(do_after(user, 12 SECONDS, target = src) && can_store_mob(user, user))
			add_occupant(O)
		return TRUE
	. = ..()


//Unloads via click-dragging onto an empty tile
/obj/item/flashlight/flare/torch/lantern/MouseDrop(atom/over_atom)
	. = ..()
	if(isopenturf(over_atom) && usr.Adjacent(over_atom) && open && occupants.len)
		usr.visible_message(span_notice("[usr] unloads [src]."), \
		span_notice("I unload [src] onto [over_atom]."))
		for(var/V in occupants)
			remove_occupant(V, over_atom)

//Handle the actual loading of the seelie
/obj/item/flashlight/flare/torch/lantern/proc/load_occupant(mob/living/user, mob/living/target)
	user.visible_message(span_notice("[user] starts loading [target] into [src]."), \
		span_notice("I start loading [target] into [src]..."), ignored_mobs = target)
	to_chat(target, span_danger("[user] starts loading you into [user.p_their()] [name]!"))
	if(!do_mob(user, target, 3 SECONDS))
		return
	if(target in occupants)
		return
	if(!can_store_mob(target, user)) //Run the checks again, just in case
		return
	user.visible_message(span_notice("[user] loads [target] into [src]!"), \
		span_notice("I load [target] into [src]."), ignored_mobs = target)
	to_chat(target, span_danger("[user] loads you into [user.p_their()] [name]!"))
	add_occupant(target)

//Adds the seelie to the list of occupants
/obj/item/flashlight/flare/torch/lantern/proc/add_occupant(mob/living/occupant)
	if(occupant in occupants || !istype(occupant))
		return
	occupant.forceMove(src)
	occupants += occupant
	// TODO: Make these variables once bronze lanterns have their own wisp sprites.
	icon_state = "lantern_wisp"
	item_state = "lantern_wisp"
	light_color = "#6e55fc"
	on = TRUE
	set_light_on(TRUE)
	if(ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_hands()
	START_PROCESSING(SSobj, src)
	//occupant_weight += occupant.mob_size

//Removes the seelie from the list of occupants
/obj/item/flashlight/flare/torch/lantern/proc/remove_occupant(mob/living/occupant, turf/new_turf)
	if(!(occupant in occupants) || !istype(occupant))
		return
	occupant.forceMove(new_turf ? new_turf : drop_location())
	occupants -= occupant
	icon_state = initial(icon_state)
	item_state = initial(icon_state)
	light_color = "#da8c45"
	on = FALSE
	set_light_on(FALSE)
	STOP_PROCESSING(SSobj, src)
	if(ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_hands()
		M.update_inv_belt()
	//occupant_weight -= occupant.mob_size
	occupant.setDir(SOUTH)

//------------END LANTERN SEELIE CARRYING CODE--------------//

/obj/item/flashlight/lantern
	name = "lantern"
	icon_state = "lantern"
	item_state = "lantern"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	desc = ""
	light_range = 6			// luminosity when on
