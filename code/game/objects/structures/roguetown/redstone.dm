GLOBAL_LIST_EMPTY(redstone_objs)


/obj/structure
	var/redstone_id
	var/list/redstone_attached = list()

/obj/structure/LateInitialize()
	. = ..()
	if(redstone_id)
		for(var/obj/structure/S in GLOB.redstone_objs)
			if(S.redstone_id == redstone_id)
				redstone_attached |= S
				S.redstone_attached |= src

/obj/structure/proc/redstone_triggered()
	return

/obj/structure/lever
	name = "lever"
	desc = "I want to pull it."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "leverfloor0"
	density = FALSE
	anchored = TRUE
	max_integrity = 3000
	var/toggled = FALSE

/obj/structure/lever/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		L.changeNext_move(CLICK_CD_MELEE)
		var/used_time = 100 - (L.STASTR * 10)
		user.visible_message(span_warning("[user] pulls the lever."))
		log_game("[key_name(user)] pulled the lever with redstone id \"[redstone_id]\"")
		if(do_after(user, used_time, target = user))
			for(var/obj/structure/O in redstone_attached)
				spawn(0) O.redstone_triggered()
			toggled = !toggled
			icon_state = "leverfloor[toggled]"
			playsound(src, 'sound/foley/lever.ogg', 100, extrarange = 3)

/obj/structure/lever/onkick(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		L.changeNext_move(CLICK_CD_MELEE)
		user.visible_message("<span class='warning'>[user] kicks the lever!</span>")
		playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
		if(prob(L.STASTR * 4))
			for(var/obj/structure/O in redstone_attached)
				spawn(0) O.redstone_triggered()
			toggled = !toggled
			icon_state = "leverfloor[toggled]"
			playsound(src, 'sound/foley/lever.ogg', 100, extrarange = 3)

/obj/structure/lever/wall
	icon_state = "leverwall0"

/obj/structure/lever/wall/attack_hand(mob/user)
	. = ..()
	icon_state = "leverwall[toggled]"

/obj/structure/lever/wall/onkick(mob/user)
	. = ..()
	icon_state = "leverwall[toggled]"

/obj/structure/repeater
	name = "repeater"
	desc = "Repeats a signal a set amount of times into an adjacently linked machine when activated by a signal. Looks suspiciously like a barrel."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "repeater"
	max_integrity = 5
	density = TRUE
	anchored = TRUE
	var/mode = 1 // 1 means repeat 5 times, 2 means random, 0 means indefinite but has chance to explode, 3 means indefinite no chance to explode
	var/obj/structure/linked_thing // because redstone code is weird

/obj/structure/repeater/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE, CALLBACK(src, PROC_REF(can_user_rotate)),CALLBACK(src, PROC_REF(can_be_rotated)),null)

/obj/structure/repeater/proc/can_be_rotated(mob/user)
	return TRUE

/obj/structure/repeater/proc/can_user_rotate(mob/user)
	var/mob/living/L = user

	if(istype(L))
		if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			return FALSE
		else
			return TRUE
	else if(isobserver(user) && CONFIG_GET(flag/ghost_interaction))
		return TRUE
	return FALSE

/obj/structure/repeater/attack_hand(mob/user)
	. = ..()
	if(user.used_intent.type == INTENT_HARM)
		if(user.cmode)
			var/datum/component/simple_rotation/rotcomp = GetComponent(/datum/component/simple_rotation)
			if(rotcomp)
				rotcomp.HandRot(null,usr,ROTATION_CLOCKWISE)
			return
		playsound(loc, 'sound/combat/hits/punch/punch (1).ogg', 100, FALSE, -1)
		sleep(1)
		switch(mode)
			if(0)
				mode = 1
				say("Mode: REPEATER")
				playsound(loc, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			if(1)
				mode = 2
				say("Mode: REPEATER RANDOM")
				playsound(loc, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			if(2)
				mode = 0
				say("Mode: INDEFINITE, DANGEROUS")
				playsound(loc, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return
	playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)
	linked_thing = null
	var/list/structures = list()
	for(var/adjc in get_step(src, dir).contents)
		if(!istype(adjc, /obj/structure))
			continue
		structures += adjc
	var/input = input("Choose structure to link", "ROGUETOWN") as null|anything in structures
	if(input)
		playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)
		if(istype(linked_thing, /obj/structure/repeater))
			say("AAAAAAAGH!!!")
			playsound(loc, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			sleep(10)
			explosion(src, light_impact_range = 1, flame_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
			return
		linked_thing = input

/obj/structure/repeater/redstone_triggered()
	. = ..()
	var/repeat_times = 0
	switch(mode)
		if(1)
			repeat_times = 5
		if(2)
			repeat_times = rand(2,10)
	if(repeat_times)
		for(var/i in 1 to repeat_times)
			linked_thing.redstone_triggered()
	else
		if(mode == 3)
			for(var/i in 1 to INFINITY)
				sleep(5)
				linked_thing.redstone_triggered()
		else
			for(var/i in 1 to INFINITY)
				sleep(5)
				if(prob(25))
					explosion(src, light_impact_range = 1, flame_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
					qdel(src)
					break
				linked_thing.redstone_triggered()

/obj/structure/pressure_plate
	name = "pressure plate"
	desc = "Be careful. Stepping on this could either mean a bomb exploding or a door closing on you."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "pressureplate"
	max_integrity = 45 // so it gets destroyed when used to explode a bomb
	density = FALSE
	anchored = TRUE

/obj/structure/pressure_plate/Crossed(atom/movable/AM)
	. = ..()
	if(!anchored)
		return
	if(isliving(AM))
		var/mob/living/L = AM
		to_chat(L, "<span class='info'>I feel something click beneath me.</span>")
		playsound(src, 'sound/misc/pressurepad_down.ogg', 65, extrarange = 2)

/obj/structure/pressure_plate/Uncrossed(atom/movable/AM)
	. = ..()
	if(!anchored)
		return
	if(isliving(AM))
		triggerplate()

/obj/structure/pressure_plate/proc/triggerplate()
	playsound(src, 'sound/misc/pressurepad_up.ogg', 65, extrarange = 2)
	for(var/obj/structure/O in redstone_attached)
		spawn(0) O.redstone_triggered()

/obj/structure/pressure_plate/attack_hand(mob/user)
	. = ..()
	if(user.used_intent.type == INTENT_HARM)
		playsound(loc, 'sound/combat/hits/punch/punch (1).ogg', 100, FALSE, -1)
		triggerplate()
		anchored = !anchored

/obj/structure/activator
	name = "activator"
	desc = "A strange structure with an opening for an item on the top with an arrow etched into it pointing to where it is possibly aiming."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "activator"
	max_integrity = 45 // so it gets destroyed when used to explode a bomb
	density = TRUE
	anchored = TRUE
	var/obj/item/containment
	var/obj/item/quiver/ammo // used if the contained item is a bow or crossbow

/obj/structure/activator/Initialize()
	. = ..()
	update_icon()

/obj/structure/activator/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE, CALLBACK(src, PROC_REF(can_user_rotate)),CALLBACK(src, PROC_REF(can_be_rotated)),null)

/obj/structure/activator/proc/can_be_rotated(mob/user)
	return TRUE

/obj/structure/activator/proc/can_user_rotate(mob/user)
	var/mob/living/L = user

	if(istype(L))
		if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			return FALSE
		else
			return TRUE
	else if(isobserver(user) && CONFIG_GET(flag/ghost_interaction))
		return TRUE
	return FALSE

/obj/structure/activator/update_icon()
	. = ..()
	cut_overlays()
	if(!containment)
		add_overlay("activator-e")

/obj/structure/activator/attack_hand(mob/user)
	. = ..()
	if(user.used_intent.type == INTENT_HARM)
		if(user.cmode)
			var/datum/component/simple_rotation/rotcomp = GetComponent(/datum/component/simple_rotation)
			if(rotcomp)
				rotcomp.HandRot(null,usr,ROTATION_CLOCKWISE)
			return
	playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)
	sleep(7)
	if(containment)
		playsound(src, 'sound/misc/hiss.ogg', 100, FALSE, -1)
		containment.forceMove(get_turf(src))
		containment = null
	if(ammo)
		playsound(src, 'sound/misc/hiss.ogg', 100, FALSE, -1)
		ammo.forceMove(get_turf(src))
		ammo = null
	update_icon()

/obj/structure/activator/attackby(obj/item/I, mob/user, params)
	if(!user.cmode)
		if(!containment && !istype(I, /obj/item/quiver) && !istype(I, /obj/item/roguegear))
			if(!user.transferItemToLoc(I, src))
				return
			containment = I
			playsound(src, 'sound/misc/chestclose.ogg', 25)
			update_icon()
			return
		if(!ammo && istype(I, /obj/item/quiver))
			if(!user.transferItemToLoc(I, src))
				return
			playsound(src, 'sound/misc/chestclose.ogg', 25)
			ammo = I
			return
	return ..()

/obj/structure/floordoor
	name = "floorhatch"
	desc = "A handy floor hatch for people who need privacy upstairs."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "floorhatch1"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_OPEN_TURF_LAYER
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
	var/togg = FALSE
	var/base_state = "floorhatch"
	max_integrity = 0
/*
/obj/structure/floordoor/Initialize()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/FTMET_A1.ogg','sound/foley/footsteps/FTMET_A2.ogg','sound/foley/footsteps/FTMET_A3.ogg','sound/foley/footsteps/FTMET_A4.ogg'), 100)
	return ..()
*/
/obj/structure/floordoor/obj_break(damage_flag)
	obj_flags = null
	..()

/obj/structure/floordoor/redstone_triggered()
	if(obj_broken)
		return
	togg = !togg
	if(togg)
		icon_state = "[base_state]0"
		obj_flags = null
		var/turf/T = loc
		if(istype(T))
			for(var/atom/movable/M in loc)
				T.Entered(M)
	else
		icon_state = "[base_state]1"
		obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP

/obj/structure/floordoor/gatehatch
	name = ""
	desc = ""
	base_state = ""
	icon_state = ""
	var/changing_state = FALSE
	var/delay2open = 0
	var/delay2close = 0
	max_integrity = 0
	nomouseover = TRUE
	mouse_opacity = 0

/obj/structure/floordoor/gatehatch/Initialize()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/FTMET_A1.ogg','sound/foley/footsteps/FTMET_A2.ogg','sound/foley/footsteps/FTMET_A3.ogg','sound/foley/footsteps/FTMET_A4.ogg'), 100)
	return ..()

/obj/structure/floordoor/gatehatch/redstone_triggered()
	if(changing_state)
		return
	if(obj_broken)
		return
	changing_state = TRUE
	togg = !togg
	if(togg)
		sleep(delay2open)
		icon_state = "[base_state]0"
		obj_flags = null
		var/turf/T = loc
		if(istype(T))
			for(var/atom/movable/M in loc)
				T.Entered(M)
		sleep(40-delay2open)
		changing_state = FALSE
	else
		sleep(delay2close)
		icon_state = "[base_state]1"
		obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
		sleep(40-delay2close)
		changing_state = FALSE

/obj/structure/floordoor/gatehatch/inner
	delay2open = 10
	delay2close = 30

/obj/structure/floordoor/gatehatch/outer
	delay2open = 30
	delay2close = 10

/obj/structure/kybraxor
	name = "Kybraxor the Devourer"
	desc = "The mad duke's hungriest pet."
	density = FALSE
	nomouseover = TRUE
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "kybraxor1"
	redstone_id = "gatelava"
	var/openn = FALSE
	var/changing_state = FALSE
	layer = ABOVE_OPEN_TURF_LAYER
	max_integrity = 0

/obj/structure/kybraxor/redstone_triggered()
	if(changing_state)
		return
	if(obj_broken)
		return
	changing_state = TRUE
	openn = !openn
	if(openn)
		playsound(src, 'sound/misc/kybraxorop.ogg', 100, FALSE)
		flick("kybraxoropening",src)
		sleep(40)
		icon_state = "kybraxor0"
		changing_state = FALSE
	else
		playsound(src, 'sound/misc/kybraxor.ogg', 100, FALSE)
		flick("kybraxorclosing",src)
		sleep(40)
		icon_state = "kybraxor1"
		changing_state = FALSE
