/datum/component/leaning
	var/mob/living/MLparent
	var/atom/leaning_on
	var/dir2wall

/datum/component/leaning/Initialize(var/atom/atom_to_lean_on)
	if(!istype(parent, /mob/living))
		return COMPONENT_INCOMPATIBLE
	leaning_on = atom_to_lean_on
	MLparent = parent
	MLparent.wallpressed = TRUE
	MLparent.add_movespeed_modifier("wallpress", TRUE, 100, override = TRUE, multiplicative_slowdown = 3)
	dir2wall = get_dir(parent, leaning_on)
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

	RegisterSignal(parent, COMSIG_MOVABLE_BUCKLE, PROC_REF(RemoveComponent))
	RegisterSignal(parent, COMSIG_MOB_CMODE_ENABLED, PROC_REF(RemoveComponent))
	RegisterSignal(parent, COMSIG_LIVING_MOBILITY_UPDATED, PROC_REF(mobility_check))

	RegisterSignal(leaning_on, COMSIG_DOOR_OPEN, PROC_REF(collapse))
	RegisterSignal(leaning_on, COMSIG_PARENT_QDELETING, PROC_REF(collapse))
	
	. = ..()

/datum/component/leaning/RemoveComponent()
	MLparent.wallpressed = FALSE
	MLparent.remove_movespeed_modifier("wallpress")
	MLparent.reset_offsets("wall_press")
	if(leaning_on)
		UnregisterSignal(leaning_on, COMSIG_DOOR_OPEN, PROC_REF(collapse))
		UnregisterSignal(leaning_on, COMSIG_PARENT_QDELETING, PROC_REF(collapse))

		UnregisterSignal(parent, COMSIG_MOVABLE_BUCKLE, PROC_REF(RemoveComponent))
		UnregisterSignal(parent, COMSIG_MOB_CMODE_ENABLED, PROC_REF(RemoveComponent))
		UnregisterSignal(parent, COMSIG_LIVING_MOBILITY_UPDATED, PROC_REF(mobility_check))
	. = ..()
	
/datum/component/leaning/proc/wallhug_check(turf/T, atom/newloc, direct)
	var/atom/new_leaning_on = get_leanable(get_turf(newloc))

	if(!MLparent.fixedeye)
		RemoveComponent()
		return
	if(!new_leaning_on?.density) 
		RemoveComponent()
		return
	if(!leaning_on.Adjacent(new_leaning_on))
		RemoveComponent()
		return

	UnregisterSignal(leaning_on, COMSIG_DOOR_OPEN, PROC_REF(collapse))
	UnregisterSignal(leaning_on, COMSIG_PARENT_QDELETING, PROC_REF(collapse))
	RegisterSignal(new_leaning_on, COMSIG_DOOR_OPEN, PROC_REF(collapse))
	RegisterSignal(new_leaning_on, COMSIG_PARENT_QDELETING, PROC_REF(collapse))

	leaning_on = new_leaning_on


/datum/component/leaning/proc/get_leanable(turf/T)
	var/turf/leanable_location = get_step(T, dir2wall)
	var/obj/structure/leanable_structure = locate(/obj/structure) in leanable_location
	if(leanable_structure?.GetComponent(/datum/component/leanable))
		return leanable_structure
	if(leanable_location?.GetComponent(/datum/component/leanable))
		return leanable_location
	return null

/datum/component/leaning/proc/mobility_check(mob/living/L)
	if(!(MLparent.mobility_flags & MOBILITY_STAND))
		RemoveComponent()

/datum/component/leaning/proc/collapse()
	MLparent.Move(get_step(parent, dir2wall))
	MLparent.Knockdown(20)
