/datum/component/leaning
	var/atom/leaning_on
	var/mob/living/MLparent

/datum/component/leaning/Initialize(var/atom/atom_to_lean_on)
	if(!istype(parent, /mob/living))
		return COMPONENT_INCOMPATIBLE
	leaning_on = atom_to_lean_on
	MLparent = parent
	MLparent.wallpressed = TRUE
	MLparent.add_movespeed_modifier("wallpress", TRUE, 100, override = TRUE, multiplicative_slowdown = 3)
	RegisterSignal(parent, COMSIG_MOVABLE_BUCKLE, PROC_REF(RemoveComponent))
	RegisterSignal(parent, COMSIG_MOB_CMODE_ENABLED, PROC_REF(RemoveComponent))
	RegisterSignal(parent, COMSIG_LIVING_MOBILITY_UPDATED, PROC_REF(mobility_check))
	update_offsets()
	. = ..()

/datum/component/leaning/RemoveComponent()
	MLparent.wallpressed = FALSE
	MLparent.remove_movespeed_modifier("wallpress")
	MLparent.reset_offsets("wall_press")
	. = ..()
	
/datum/component/leaning/proc/wallhug_check(turf/T, atom/newloc, direct)
	var/atom/new_leaning_on = get_leanable(newloc)
	if(MLparent.fixedeye && new_leaning_on && leaning_on.Adjacent(new_leaning_on))
		leaning_on = new_leaning_on
		update_offsets()
		return
	RemoveComponent()

/datum/component/leaning/proc/get_leanable(turf/T)
	var/turf/leanable_location = get_step(T, get_dir(parent, leaning_on))
	var/obj/structure/leanable_structure = locate(/obj/structure) in leanable_location
	if(leanable_structure?.GetComponent(/datum/component/leanable))
		return leanable_structure
	if(isclosedturf(leanable_location))
		var/turf/closed/leanable_turf = leanable_location
		if(leanable_turf?.GetComponent(/datum/component/leanable))
			return leanable_turf
	return null

/datum/component/leaning/proc/update_offsets()
	var/dir2wall = get_dir(parent, leaning_on)
	switch(dir2wall)
		if(NORTH)
			MLparent.setDir(SOUTH)
			MLparent.set_mob_offsets("wall_press", _x = 0, _y = 20)
		if(SOUTH)
			MLparent.setDir(NORTH)
			MLparent.set_mob_offsets("wall_press", _x = 0, _y = -10)
		if(EAST)
			MLparent.setDir(WEST)
			MLparent.set_mob_offsets("wall_press", _x = 12, _y = 0)
		if(WEST)
			MLparent.setDir(EAST)
			MLparent.set_mob_offsets("wall_press", _x = -12, _y = 0)

/datum/component/leaning/proc/mobility_check(mob/living/L)
	if(!(MLparent.mobility_flags & MOBILITY_STAND))
		RemoveComponent()

