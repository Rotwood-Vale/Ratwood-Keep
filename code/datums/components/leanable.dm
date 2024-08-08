/datum/component/leanable

/datum/component/leanable/Initialize()
	RegisterSignal(parent, COMSIG_MOUSEDROPPED_ONTO, PROC_REF(handle_mousedrop))

/datum/component/leanable/proc/is_aggro_grabbing(mob/living/carbon/human/grabber, mob/living/victim)
	var/grabstate = null
	if(grabber.r_grab && grabber.r_grab.grabbed == victim)
		if(grabstate == null || grabber.r_grab.grab_state > grabstate)
			grabstate = grabber.r_grab.grab_state
	if(grabber.l_grab && grabber.l_grab.grabbed == victim)
		if(grabstate == null || grabber.l_grab.grab_state > grabstate)
			grabstate = grabber.l_grab.grab_state
	return (grabstate > GRAB_PASSIVE)

/datum/component/leanable/proc/handle_mousedrop(datum/source, atom/movable/O, mob/user)
	if(!is_aggro_grabbing(user, O) && !(user == O))
		return
	if(!isliving(O))
		return
	var/mob/living/L = O
	if(isanimal(L))
		var/mob/living/simple_animal/A = L
		if (!A.dextrous)
			return
	wallpress(L, user)

/datum/component/leanable/proc/wallpress(mob/living/leaning_mob, mob/living/pressing_mob = null)
	var/atom/A = parent
	if(!leaning_mob.Adjacent(A))
		return
	if(!A.density)
		return
	if(leaning_mob.cmode) // no combat leaning memes
		return
	if(leaning_mob.GetComponent(/datum/component/leaning))
		return
	if(leaning_mob.pixelshifted)
		return
	if(leaning_mob.buckled)
		return
	if(!(leaning_mob.mobility_flags & MOBILITY_STAND))
		return
	var/dir2wall = get_dir(leaning_mob, parent)
	if(!(dir2wall in GLOB.cardinals))
		return
	var/press_msg = "[leaning_mob] leans against [parent]."
	if(istype(pressing_mob) && pressing_mob != leaning_mob)
		pressing_mob.Move(get_step(pressing_mob, leaning_mob))
		pressing_mob.setDir(get_dir(pressing_mob, parent))
		press_msg = "[leaning_mob] is pushed against [parent] by [pressing_mob]."
	leaning_mob.visible_message(span_info(press_msg))
	leaning_mob.AddComponent(/datum/component/leaning, parent)
