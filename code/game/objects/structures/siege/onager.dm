/obj/structure/onager
	name = "Onager"
	desc = "A torsion-powered siege engine designed to throw massive projectiles."
	icon = 'icons/obj/structures/siege/onager/onager.dmi'
	icon_state = "idle"

	anchored = TRUE // Can't be moved unless packed
	density = TRUE
	drag_slowdown = 10

	/// Minimum tile target distance the projectile will always travel.
	var/min_target_distance = 20

	/// Maximum tile target distance the projectile can travel.
	var/max_target_distance = 75

	/// Tile target distance set by the user.
	var/target_distance = 0

	var/interactions = list("Fire!", "Set Direction", "Set Target Distance", "Pack Up")
	var/launch_sounds = list("sound/catapult/launch.ogg", "sound/catapult/launch2.ogg", "sound/catapult/launch3.ogg")
	var/aim_sounds = list("sound/catapult/aim.ogg", "sound/catapult/aim2.ogg")
	var/directions = list("NORTH", "SOUTH", "EAST", "WEST")

	/**
	* State variables
	* IDLE -> READY -> LOADED -> LAUNCHED -> IDLE ...
	* 
	* Special states
	* BEING_USED
	* PACKED -> IDLE
	*/

	/// Default state.
	var/idle = TRUE

	/// Is the onager ready to fire.
	var/ready = FALSE

	/// Is the onager loaded.
	var/loaded = FALSE

	/// Has the onager launched a projectile.
	var/launched = FALSE

	/// Is the onager packed for transport.
	var/packed = FALSE

	/// Is the onager being used by another player.
	var/being_used = FALSE

/**
 * Arguably just a bunch of boilerplate procs,
 * but this way we are sure we dont forget to reset any state variables whenever stuff happens.
 */

/obj/structure/onager/proc/reset_state()
	idle = FALSE
	ready = FALSE
	loaded = FALSE
	launched = FALSE
	packed = FALSE

/obj/structure/onager/proc/set_idle()
	reset_state()
	anchored = TRUE
	idle = TRUE
	update_icon()

/obj/structure/onager/proc/set_ready()
	reset_state()
	ready = TRUE
	update_icon()

/obj/structure/onager/proc/set_loaded()
	reset_state()
	ready = TRUE
	loaded = TRUE
	update_icon()

/obj/structure/onager/proc/set_launched()
	reset_state()
	launched = TRUE
	update_icon()

/obj/structure/onager/proc/set_packed()
	reset_state()
	anchored = FALSE
	packed = TRUE
	update_icon()

/obj/structure/onager/update_icon()

	cut_overlays(HIGH_OBJ_LAYER)

	if(idle || ready) // Default icon
		icon_state = "idle"

	if(loaded) // Idle icon with a boulder
		icon_state = "idle"
		add_overlay(image(icon='icons/obj/structures/siege/onager/onager.dmi',icon_state="boulder_overlay"), HIGH_OBJ_LAYER)
	
	if(launched) // Launched icon without a boulder
		icon_state = "launched"

	update_overlays()


/obj/structure/onager/attack_hand(mob/living/carbon/user)

	if(packed)
		to_chat(user, span_warning("The onager is packed for transport."))
		return 

	if(being_used)
		to_chat(user, span_warning("Someone else is using the onager."))
		return 

	if(!ready)
		ready()
		return

	var/choice = input("What would you like to do with the onager?", "Onager Actions") in interactions
	
	switch(choice)

		if("Fire!")
			try_fire()

		if("Set Direction")
			set_direction()

		if("Set Target Distance")
			set_target_distance()

		if("Pack Up")
			pack()

/obj/structure/onager/attackby(obj/item/I, mob/living/carbon/user)

	if(!ready)
		to_chat(user, span_warning("The onager's arm needs to be drawn back again."))
		return
		
	if(loaded)
		to_chat(user, span_warning("The onager is already loaded with a projectile."))
		return

	try_load(I, user)

/obj/structure/onager/MouseDrop(over_object, src_location, over_location)
	if(over_object == usr && Adjacent(usr) && (in_range(src, usr) && (packed) || usr.contents.Find(src)))
		if(!ishuman(usr))
			return
		
		unpack()

/obj/structure/onager/proc/ready()

	visible_message(span_notice("[usr] cranks the catapult's arm back into position."))
	playsound(src, "sound/catapult/adjusting.ogg", 50)

	if(do_after(usr, 30, src))
		set_ready()
		visible_message(span_notice("The catapult is ready to fire again."))

/// Tries to fire the onager, behavior depends on state.
/obj/structure/onager/proc/try_fire()

	if(is_obstructed())
		to_chat(usr, span_warning("The catapult is obstructed by something directly above it."))
		return 

	if(!loaded)
		to_chat(usr, span_warning("The catapult is not loaded yet."))
		return

	if(target_distance == 0) //assume if it's 0, it wasnt aimed
		to_chat(usr, span_warning("[src] needs to be aimed first."))
		return

	fire() // Pass the distance to fire_catapult

/// Fires the onager
/obj/structure/onager/proc/fire()

	var/xoffset = rand(-3, 3)
	var/yoffset = rand(-3, 3)
	var/turf/targetx = get_ranged_target_turf(src, dir, target_distance).x
	var/turf/targety = get_ranged_target_turf(src, dir, target_distance).y
	var/turf/T = locate(targetx + xoffset, targety + yoffset, src.z)

	if(!isturf(T))
		for(var/turf/O in range(2,T))
			T = O
			continue

	playsound(src, pick(launch_sounds), 50)
	spawn(10)
		var/obj/item/boulder/P = /obj/item/boulder
		visible_message(span_notice("[usr] fires the onager!"))

		// Start one level above
		var/z_position = src.z + 1

		for(var/atom/movable/AM in src)
			qdel(AM)
		new P(locate(src.x, src.y, z_position))

		for(P in (locate(src.x, src.y, z_position)))
			P.launched = TRUE
			P.throw_at(get_turf(T), get_dist(src, T), 3)
			P.travel_time = get_dist(P, src)

		set_launched()

/// Checks if the onager is obstructed.
/obj/structure/onager/proc/is_obstructed()
	var/turf/T = get_turf(src)
	if(istype(T, /turf/open/floor) && T.z > src.z)
		return TRUE
	return FALSE

/// Tries to load something into the onager, behavior depends on projectile type.
/obj/structure/onager/proc/try_load(obj/item/I, mob/living/carbon/user)

	if(istype(I, /obj/item/boulder))
		var/obj/item/boulder/B = I

		user.dropItemToGround(B, src)
		B.forceMove(src)
		B.loc = src 
		
		user.visible_message(span_notice("[user] loads \a [B.name] into the catapult."))
		playsound(src, 'sound/foley/hit_rock.ogg', 70)
		set_loaded()

	else
		to_chat(user, span_warning("I'm not sure I can load this into the onager."))

/// Sets the direction of the onager. Only meant to be used when unpacked.
/obj/structure/onager/proc/set_direction()
	var/current_direction = dir
	var/direction = input("Directions", "Select a direction") as anything in directions
	var/texttodirection = text2dir(direction)

	if(being_used)
		to_chat(usr, span_warning("Someone else is currently using this catapult."))
		return

	if(texttodirection == current_direction)
		to_chat(usr, span_warning("The [src] is already facing [direction]."))
		return

	playsound(src, pick(aim_sounds),  60)
	visible_message(span_notice("[usr] tries to turn the [src] to face [direction]."))

	being_used = TRUE

	if(do_after(usr, 30, src))
		dir = texttodirection
		visible_message(span_notice("[usr] set the [src]'s firing direction to [direction]."),
		span_notice("You finish adjusting [src]'s firing direction."))

	being_used = FALSE

/// Sets the target distance of the onager, within min and max.
/obj/structure/onager/proc/set_target_distance()

	var/distance_input = input("Set target distance", "tiles") as num

	if(distance_input > max_target_distance)
		to_chat(usr, span_warning("The catapult can only fire at the maximum distance of [max_target_distance] meters."))
		return

	if(distance_input < min_target_distance)
		to_chat(usr, span_warning("The range must be at the minimum distance of [min_target_distance] meters."))
		return

	being_used = TRUE
	playsound(src, pick(aim_sounds),  60)
	visible_message(span_notice("[usr] begins to set the [src]'s firing distance."))

	if(do_after(usr, 30, src))
		target_distance = distance_input
		visible_message(span_notice("[usr] sets the [src] to fire at the distance of [target_distance] meters."))

	being_used = FALSE

/// Unpacks the onager, unanchoring it.
/obj/structure/onager/proc/unpack()

	visible_message(span_notice("[usr] sets up the [src]."))
	playsound(src, "sound/catapult/adjusting.ogg",  50)

	if(do_after(usr, 10 SECONDS, target = src))
		set_idle()

/// Packs the onager, anchoring it.
/obj/structure/onager/proc/pack()

	being_used = TRUE

	visible_message(span_notice("[usr] begins to pack the catapult up."))
	playsound(src, "sound/catapult/adjusting.ogg", 50)

	if(do_after(usr, 10 SECONDS, target = src))
		visible_message(span_notice("[usr] has packed the catapult up for moving."))
		target_distance = 0
		set_packed()
	
	being_used = FALSE
