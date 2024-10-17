//MOJAVE SUN LOCKPICKING ELEMENT SYSTEM//

#define LOCKPICK_MOUSEUP 0
#define LOCKPICK_MOUSEDOWN 1

//base element, tells thing it can be lockpicked

/datum/element/lockpickable
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	id_arg_index = 2
	///Difficulty of the lock. Smaller is harder.
	var/difficulty
	///picks able to be used
	var/list/lockpicks = list(/obj/item/ms13/lockpick)
	///wedges able to be used
	var/list/wedges = list(/obj/item/screwdriver/ms13)
	///shows the lock difficulty level on examine, like fallout
	var/shown_difficulty

/datum/element/lockpickable/Attach(datum/target, list/lockpicks, list/wedges, difficulty, shown_difficulty)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	switch(difficulty)
		if(1 to 3)
			shown_difficulty = "master"
		if(5 to 9)
			shown_difficulty = "expert"
		if(10 to 15)
			shown_difficulty = "standard"
		if(16 to 20)
			shown_difficulty = "novice"
		if(20 to 100)
			shown_difficulty = "beginner"

	if(!src.lockpicks)
		src.lockpicks = lockpicks.Copy()
	if(!src.wedges)
		src.wedges = wedges.Copy()
	src.difficulty = difficulty
	src.shown_difficulty = shown_difficulty
	var/obj/thing = target
	if(isobj(thing))
		thing.lock_locked = TRUE
		for(var/datum/component/storage/storage as anything in thing.GetComponents(/datum/component/storage))
			storage.locked = TRUE //locks

	RegisterSignal(target, COMSIG_PARENT_ATTACKBY, PROC_REF(check_pick))
	RegisterSignal(target, COMSIG_LOCKPICK_ATTACKBY, PROC_REF(pick_info))
	RegisterSignal(target, COMSIG_PARENT_EXAMINE, PROC_REF(examine))


/datum/element/lockpickable/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, list(COMSIG_PARENT_ATTACKBY, COMSIG_PARENT_EXAMINE))

/datum/element/lockpickable/proc/examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("[source] is fitted with a [shown_difficulty] difficulty lock.")

/datum/element/lockpickable/proc/pick_info(datum/source, list/mutable_lockpicks, list/mutable_wedges, mutable_difficulty)
	SIGNAL_HANDLER

	mutable_lockpicks += list(lockpicks)
	mutable_wedges += list(wedges)
	mutable_difficulty += difficulty
	return COMPONENT_BLOCK_LOCKPICK

/datum/element/lockpickable/proc/check_pick(atom/source, obj/item/L, mob/living/user)
	SIGNAL_HANDLER

	user.try_pick(source, L, lockpicks, wedges, user, difficulty, shown_difficulty)
	return COMPONENT_BLOCK_LOCKPICK

//user is told its picking

/mob/living/proc/try_pick(obj/P, obj/item/L, list/obj/lockpicks, list/obj/wedges, mob/living/user, difficulty, shown_difficulty)

	if(isobj(P))
		if(!(P.lock_locked))
			return
		if(P.being_picked)
			return

	var/obj/item/the_wedge = user.get_inactive_held_item()

	if(!is_type_in_list(L, lockpicks))
		return
	if(!is_type_in_list(the_wedge, wedges))
		to_chat(user, "<span class='notice'>You need a wedge in order to lockpick the [P]!</span>")
		return

	user.client.spawn_lockpicking_UI(P, user, L, the_wedge, difficulty, shown_difficulty)
	to_chat(P, "<span class='notice'[user.name] starts picking the [P.name]'s lock...")
	user.visible_message("<span class='notice'[user.name] starts picking the [name]s lock.")
	return TRUE

//ui is spawned, users screen is updated

/client/proc/spawn_lockpicking_UI(obj/lock, mob/living/user, obj/lockpick, obj/wedge, difficulty, shown_d) //potentially different sprites for locks and picks, put here
	switch(shown_d) //for UI capitilsation
		if("master")
			shown_d = "MASTER"
		if("expert")
			shown_d = "EXPERT"
		if("standard")
			shown_d = "STANDARD"
		if("novice")
			shown_d = "NOVICE"
		if("beginner")
			shown_d = "BEGINNER"

	var/atom/movable/screen/movable/snap/ms13/lockpicking/imagery = new
	imagery.picking_object = lock
	imagery.picker = user
	imagery.sweet_spot = rand(1,179)
	imagery.clicker = src
	imagery.difficulty = difficulty
	imagery.maptext += MAPTEXT("<br><div align='center'><font color='#f0dd5f'> [shown_d] LOCK<br></div>")
	imagery.maptext += MAPTEXT("<br><div align='center'><font color='#f0dd5f'>       \[R Click) Exit\]</font></div><br>")
	imagery.maptext_width = 100
	imagery.maptext_x = 253
	imagery.maptext_y = 150
	imagery.the_lockpick = lockpick
	imagery.the_wedge = wedge
	lock.being_picked = TRUE

	//for blur effect
	var/atom/movable/plane_master_controller/game_plane_master_controller = user.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.add_filter("lockpicking_blur", 1, gauss_blur_filter(4))

	playsound(user, 'mojave/sound/ms13effects/lockpicking/lockpick_enter.ogg', 100)

	screen += imagery
	imagery.autofire_on(imagery.clicker)

//the lockpicking UI, everything contained on this

/atom/movable/screen/movable/snap/ms13/lockpicking
	name = "lock"
	icon = 'mojave/icons/hud/lockpicking.dmi'
	icon_state = "base"
	screen_loc = "1,1"
	locked = TRUE
	plane = HUD_PLANE
	layer = 1

	///Angle of the lock itself. Determined by holding down mouse1.
	var/lock_angle = 0
	///Angle of the wedge. Determined by the lock.
	var/wedge_angle = 0
	///Angle of the lockpick. Determined by mouse coordinates.
	var/pick_angle = 0
	///The angle of the sweet spot.
	var/sweet_spot = 0
	//How far are we, in angular units, are we from the sweet spot?
	var/angle_distance
	///Difficulty of the lock. Smaller is harder.
	var/difficulty
	///client clicking
	var/client/clicker
	//state of the mouse
	var/mouse_status = LOCKPICK_MOUSEUP

	//the lockpick being used
	var/the_lockpick
	//the wedge being used
	var/the_wedge

	var/obj/picking_object

	///Person picking the lock
	var/mob/picker

	///used for completed lock
	var/frozen = FALSE

	var/playing_lock_sound = FALSE

	///sprite tomfoolery
	var/image/linked_background
	var/obj/linked_lock
	var/obj/linked_pick
	var/obj/linked_wedge

/atom/movable/screen/movable/snap/ms13/lockpicking/Initialize()
	. = ..()
	QDEL_NULL(linked_lock)
	QDEL_NULL(linked_pick)
	QDEL_NULL(linked_wedge)

	if(!linked_background)
		linked_background = new /image()
		linked_background.icon_state = "dim"
		linked_background.layer = 0.9
		add_overlay(linked_background)

	linked_lock = new(src)
	linked_lock.icon = initial(icon)
	linked_lock.icon_state = "lock"
	linked_lock.plane = FLOAT_PLANE
	linked_lock.layer = 2
	linked_lock.mouse_opacity = 0
	vis_contents += linked_lock

	linked_wedge = new(src)
	linked_wedge.icon = initial(icon)
	linked_wedge.icon_state = "wedge"
	linked_wedge.plane = FLOAT_PLANE + 2
	linked_wedge.layer = 4
	linked_wedge.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_contents += linked_wedge

	linked_pick = new(src)
	linked_pick.icon = initial(icon)
	linked_pick.icon_state = "pick"
	linked_pick.plane = FLOAT_PLANE + 1
	linked_pick.layer = 3
	linked_pick.pixel_y = 6
	linked_pick.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_contents += linked_pick

/atom/movable/screen/movable/snap/ms13/lockpicking/MouseMove(location, control, params)

	. = ..()

	if(!frozen && linked_pick)
		var/list/new_params = params2list(params)

		var/icon_x = text2num(new_params["icon-x"]) - 304
		var/icon_y = text2num(new_params["icon-y"]) - 240

		icon_y = max(1,icon_y)

		pick_angle = ATAN2(icon_x,icon_y)

		pick_angle = clamp(pick_angle,1,179)

		var/matrix/M = matrix()
		M.Turn(90 - pick_angle)
		linked_pick.transform = M

/atom/movable/screen/movable/snap/ms13/lockpicking/proc/autofire_on(client/usercli)
	SIGNAL_HANDLER

	clicker = usercli
	RegisterSignal(clicker, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(on_mouse_down))
	RegisterSignal(clicker, COMSIG_CLIENT_MOUSEUP, PROC_REF(on_mouse_up))
	RegisterSignal(picker,COMSIG_MOVABLE_MOVED, PROC_REF(close_lockpick))
	RegisterSignal(picker, COMSIG_PARENT_EXAMINE_MORE, PROC_REF(mob_detection))

	//checks both for each just incase they switch hands for no reason mid lockpick
	var/obj/item/held_lockmain = picker.get_active_held_item()
	var/obj/item/held_lockother = picker.get_inactive_held_item()

	var/obj/item/held_wedgemain = picker.get_active_held_item()
	var/obj/item/held_wedgeother = picker.get_inactive_held_item()

	if(istype(held_lockmain, the_lockpick))
		RegisterSignal(the_lockpick, COMSIG_ITEM_DROPPED, PROC_REF(close_lockpick))
	if(istype(held_lockother, the_lockpick))
		RegisterSignal(the_lockpick, COMSIG_ITEM_DROPPED, PROC_REF(close_lockpick))
	if(istype(held_wedgemain, the_wedge))
		RegisterSignal(the_wedge, COMSIG_ITEM_DROPPED, PROC_REF(close_lockpick))
	if(istype(held_wedgeother, the_wedge))
		RegisterSignal(the_wedge, COMSIG_ITEM_DROPPED, PROC_REF(close_lockpick))

	START_PROCESSING(SSfastprocess, src)

/atom/movable/screen/movable/snap/ms13/lockpicking/proc/on_mouse_down(client/source, atom/_target, turf/location, control, params)
	SIGNAL_HANDLER
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		return
	if(LAZYACCESS(modifiers, RIGHT_CLICK)) //right click to close
		close_lockpick()
		return
	if(source.mob.throw_mode)
		return
	if(!isturf(source.mob.loc))
		return
	if(get_dist(source.mob, _target) < 2) //Adjacent clicking.
		return

	if(SEND_SIGNAL(src, COMSIG_LOCKPICK_ONMOUSEDOWN, source, _target, location, control, params) & COMPONENT_LOCKPICK_ONMOUSEDOWN_BYPASS)
		return

	source.click_intercept_time = world.time //From this point onwards Click() will no longer be triggered.

	INVOKE_ASYNC(src, PROC_REF(move_pick_forward))

/atom/movable/screen/movable/snap/ms13/lockpicking/proc/mob_detection(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("They are picking the [picking_object]'s lock!")

/atom/movable/screen/movable/snap/ms13/lockpicking/proc/close_lockpick(client/source, atom/_target, turf/location, control, params)
	SIGNAL_HANDLER
	qdel(src)
	picking_object.being_picked = FALSE

	var/atom/movable/plane_master_controller/game_plane_master_controller = picker.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("lockpicking_blur")

	to_chat(picker, "<span class='notice'>You stop picking the [picking_object.name]s lock.</span>")

/atom/movable/screen/movable/snap/ms13/lockpicking/proc/on_mouse_up(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	mouse_status = LOCKPICK_MOUSEUP
	lock_angle -= 10
	process()

/atom/movable/screen/movable/snap/ms13/lockpicking/proc/move_pick_forward(control, params)
	SIGNAL_HANDLER
	mouse_status = LOCKPICK_MOUSEDOWN
	lock_angle += 10
	process()

//compilcated circle mathematics about rotations and shit, signals and the like
/atom/movable/screen/movable/snap/ms13/lockpicking/process()

	if(!linked_lock || !picker)
		lock_angle = 0
		return FALSE

	switch(mouse_status)
		if(LOCKPICK_MOUSEDOWN)
			lock_angle += 10
		if(LOCKPICK_MOUSEUP)
			lock_angle -= 10

	lock_angle = clamp(lock_angle,0,90)

	var/complete_multiplier = lock_angle/90 // 1 means we've unlocked it.
	angle_distance = abs(sweet_spot-pick_angle) //How far are we, in angular units, are we from the sweet spot?
	//The larger the angle distance, the easier it is to fail.

	var/failing = (angle_distance * complete_multiplier) > difficulty

	var/matrix/M = matrix()
	M.Turn(lock_angle)
	animate(linked_lock,transform = M,time=1)

	var/wedge_x = -sin(lock_angle)*8
	var/wedge_y = -cos(lock_angle)*8 + 8

	var/matrix/W = matrix()
	W.Turn(wedge_angle)
	animate(linked_wedge,pixel_x = wedge_x, pixel_y = wedge_y,time=1)
	animate(linked_wedge,transform = M,time=1)

	var/pick_x = sin(lock_angle)*6
	var/pick_y = 6 + cos(lock_angle)*6 - 6
	if(failing)
		lock_angle -= 20
		playsound(picker.loc, pick(LOCKPICKING_TENSION_SOUNDS), 100)
	if(lock_angle >= 1 && !failing && !playing_lock_sound)
		play_turn_sound()
		playing_lock_sound = TRUE

	animate(linked_pick,pixel_x = pick_x, pixel_y = pick_y,time= failing ? 0.1 : 1)

	if(complete_multiplier <= 0)
		lock_angle = 0
		return FALSE

	if(complete_multiplier >= 1)
		frozen = TRUE
		if(picking_object)
			picking_object.picked(picker, the_lockpick)
			qdel(src)
		return FALSE

	return TRUE

/atom/movable/screen/movable/snap/ms13/lockpicking/proc/play_turn_sound(timerd)
	playsound(picker.loc, pick(LOCKPICKING_TURN_SOUNDS), 50)
	addtimer(CALLBACK(src, PROC_REF(turn_sound_reset)), 0.7 SECONDS) //stops the spam

/atom/movable/screen/movable/snap/ms13/lockpicking/proc/turn_sound_reset()
	playing_lock_sound = FALSE

//obj is told its picked, theoretically can be used for any objects

/obj/proc/picked(mob/living/user, obj/lockpick_used)

	finish_lockpicking(user)

	var/list/is_storage = list(/datum/component/storage, /datum/component/storage/concrete)

	for(var/storages in is_storage)
		var/has_component = src.GetComponent(storages)

		if(has_component)
			unlock_storage()

	if(prob(50))
		to_chat(user, "<span class='notice'>Your [lockpick_used.name] broke!</span>")
		playsound(loc, 'mojave/sound/ms13effects/lockpicking/lockpick_break.ogg', 40)
		qdel(lockpick_used)

	//special cases that need telling what to do due to others shartcode
	var/obj/machinery/door/unpowered/A = src
	if(istype(A) && lock_locked)
		A.locked = FALSE
	var/obj/structure/ms13/celldoor/B = src
	if(istype(B) && lock_locked)
		B.locked = FALSE
	var/obj/structure/safe/C = src
	if(istype(C) && lock_locked)
		C.has_been_lockpicked = TRUE
		C.open = TRUE
	if(lock)
		lock.item_lock_locked = FALSE
	RemoveElement(/datum/element/lockpickable)
	lock_locked = FALSE
	playsound(loc, 'mojave/sound/ms13effects/lockpicking/lockpicked.ogg', 150)
	return TRUE

/obj/proc/finish_lockpicking(mob/living/user)

	var/atom/movable/plane_master_controller/game_plane_master_controller = user.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("lockpicking_blur")

	if(!user)
		return FALSE

	to_chat(user, "<span class='notice'>You pick the [name]s lock.</span>")
	user.visible_message("<span class='notice'[user.name] picks the [name]s lock.", "<span class='notice'You pick the [name]s lock.")

	being_picked = FALSE

	return TRUE

/// testing shit ///

/obj/structure/lockpicking_lawyer
	name = "test lockpicking thing"
	icon = 'mojave/icons/structure/storage.dmi'
	icon_state = "safe"

/obj/structure/lockpicking_lawyer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lockpickable, difficulty = 10)

/obj/structure/lockpicking_lawyer/o
	name = "test lockpicking thing"
	icon = 'mojave/icons/structure/storage.dmi'
	icon_state = "safe"

/obj/structure/lockpicking_lawyer/o/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lockpickable, difficulty = 50)
