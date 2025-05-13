#define STAIR_TERMINATOR_AUTOMATIC 0
#define STAIR_TERMINATOR_NO 1
#define STAIR_TERMINATOR_YES 2

// dir determines the direction of travel to go upwards (due to lack of sprites, currently only 1 and 2 make sense)
// stairs require /turf/open/transparent/openspace as the tile above them to work
// multiple stair objects can be chained together; the Z level transition will happen on the final stair object in the chain

/obj/structure/stairs
	name = "stairs"
	icon = 'icons/obj/stairs.dmi'
	icon_state = "stairs"
	anchored = TRUE
	layer = 2
	nomouseover = TRUE

/obj/structure/stairs/stone
	name = "stone stairs"
	icon = 'icons/obj/stairs.dmi'
	icon_state = "stonestairs"
	max_integrity = 600

//	climb_offset = 10
	//RTD animate climbing offset so this can be here

/obj/structure/stairs/fancy
	icon_state = "fancy_stairs"

/obj/structure/stairs/fancy/c
	icon_state = "fancy_stairs_c"

/obj/structure/stairs/fancy/r
	icon_state = "fancy_stairs_r"

/obj/structure/stairs/fancy/l
	icon_state = "fancy_stairs_l"

/obj/structure/stairs/fancy/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/structure/stairs/fancy/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/structure/stairs/fancy/lordcolor(primary,secondary)
	if(!primary || !secondary)
		return
	var/mutable_appearance/M = mutable_appearance(icon, "[icon_state]_primary", -(layer+0.1))
	M.color = primary
	add_overlay(M)
	GLOB.lordcolor -= src


/obj/structure/stairs/OnCrafted(dirin)
	. = ..()
	var/turf/partner = get_step_multiz(get_turf(src), UP)
	partner = get_step(partner, dirin)
	if(isopenturf(partner))
		var/obj/stairs = new /obj/structure/stairs(partner)
		stairs.dir = dirin

/obj/structure/stairs/d/OnCrafted(dirin)
	dir = turn(dirin, 180)
	var/turf/partner = get_step_multiz(get_turf(src), DOWN)
	partner = get_step(partner, dirin)
	if(isopenturf(partner))
		var/obj/stairs = new /obj/structure/stairs(partner)
		stairs.dir = turn(dirin, 180)

/obj/structure/stairs/stone/d/OnCrafted(dirin)
	dir = turn(dirin, 180)
	var/turf/partner = get_step_multiz(get_turf(src), DOWN)
	partner = get_step(partner, dirin)
	if(isopenturf(partner))
		var/obj/stairs = new /obj/structure/stairs/stone(partner)
		stairs.dir = turn(dirin, 180)

/obj/structure/stairs/Initialize(mapload)
	return ..()

/obj/structure/stairs/Destroy()
	return ..()

/obj/structure/stairs/Uncross(atom/movable/AM, turf/newloc)
	if(!newloc || !AM)
		return ..()
	var/moved = get_dir(src, newloc)
	if(user_walk_into_target_loc(AM, moved))
		return FALSE
	return ..()

/obj/structure/stairs/proc/stair_ascend(atom/movable/AM, dirmove)
	return user_walk_into_target_loc(AM, dirmove)

/obj/structure/stairs/proc/stair_descend(atom/movable/AM, dirmove)
	return user_walk_into_target_loc(AM, dirmove)

/// Get the turf above/below us corresponding to the direction we're moving on the stairs.
/obj/structure/stairs/proc/get_target_loc(dirmove)
	var/turf/zturf
	if(dirmove == dir)
		zturf = GET_TURF_ABOVE(get_turf(src))
	else if(dirmove == GLOB.reverse_dir[dir])
		zturf = GET_TURF_BELOW(get_turf(src))
	if(!zturf)
		return // not moving up or down
	var/turf/newtarg = get_step(zturf, dirmove)
	if(!newtarg)
		return // nowhere to move to???
	for(var/obj/structure/stairs/partner in newtarg)
		if(partner.dir == dir) // partner matches our dir
			return newtarg

/obj/structure/stairs/proc/user_walk_into_target_loc(atom/movable/AM, dirmove)
	var/turf/newtarg = get_target_loc(dirmove)
	if(newtarg)
		movable_travel_z_level(AM, newtarg)
		return TRUE
	return FALSE

/// A helper proc to handle chained atoms moving across Z-levels. Currently only handles mobs pulling movables.
/proc/movable_travel_z_level(atom/movable/AM, turf/newtarg)
	if(!isliving(AM))
		AM.forceMove(newtarg)
		return
	var/mob/living/L = AM
	var/atom/movable/pulling = L.pulling
	var/was_pulled_buckled = FALSE
	if(pulling)
		if(pulling in L.buckled_mobs)
			was_pulled_buckled = TRUE
	L.forceMove(newtarg)
	if(pulling)
		L.stop_pulling()
		pulling.forceMove(newtarg)
		L.start_pulling(pulling, supress_message = TRUE)
		if(was_pulled_buckled) // Assume this was a fireman carry since piggybacking is not a thing
			L.buckle_mob(pulling, TRUE, TRUE, 90, 0, 0)
