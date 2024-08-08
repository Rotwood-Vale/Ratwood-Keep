/datum/component/wall_leaning

/datum/component/wall_leaning/Initialize()
	RegisterSignal(parent, COMSIG_MOUSEDROPPED_ONTO, PROC_REF(handle_mousedrop))

/datum/component/wall_leaning/proc/handle_mousedrop(datum/source, atom/movable/O, mob/user)
	if(!user == O)
		return
	if(!isliving(O))
		return
	var/mob/living/L = O
	if(isanimal(L))
		var/mob/living/simple_animal/A = L
		if (!A.dextrous)
			return
	if(L.mobility_flags & MOBILITY_MOVE)
		wallpress(L)
		return

/datum/component/wall_leaning/proc/wallpress(mob/living/user)
	if(user.wallpressed)
		return
	if(user.pixelshifted)
		return
	if(!(user.mobility_flags & MOBILITY_STAND))
		return
	var/dir2wall = get_dir(user, parent)
	if(!(dir2wall in GLOB.cardinals))
		return
	user.wallpressed = dir2wall
	user.update_wallpress_slowdown()
	user.visible_message(span_info("[user] leans against [parent]."))
	switch(dir2wall)
		if(NORTH)
			user.setDir(SOUTH)
			user.set_mob_offsets("wall_press", _x = 0, _y = 20)
		if(SOUTH)
			user.setDir(NORTH)
			user.set_mob_offsets("wall_press", _x = 0, _y = -10)
		if(EAST)
			user.setDir(WEST)
			user.set_mob_offsets("wall_press", _x = 12, _y = 0)
		if(WEST)
			user.setDir(EAST)
			user.set_mob_offsets("wall_press", _x = -12, _y = 0)
