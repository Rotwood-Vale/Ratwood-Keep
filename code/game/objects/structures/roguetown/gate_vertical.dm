/obj/structure/gate_vertical
	name = "vertical gate"
	desc = "A steel gate that blocks north-south."
	icon = 'icons/roguetown/misc/verticalgate.dmi'
	icon_state = "gate1"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	bound_width = 32
	bound_height = 96
	layer = ABOVE_MOB_LAYER

	var/base_state = "gate"
	var/isSwitchingStates = FALSE
	var/list/turfsy = list()
	var/list/blockers = list()
	var/gid
	var/obj/structure/attached_to

/obj/structure/gate_vertical/Initialize()
	. = ..()
	update_gate_icon()

	if(initial(opacity))
		var/turf/T = loc
		for(var/i in 1 to 3)
			T = get_step(T, NORTH)
			var/G = new /obj/gblock(T)
			turfsy += T
			blockers += G

	GLOB.biggates += src

/obj/structure/gate_vertical/Destroy()
	for(var/A in blockers)
		qdel(A)
	return ..()

/obj/structure/gate_vertical/proc/update_gate_icon()
	cut_overlays()
	icon_state = "[base_state][density ? 1 : 0]"
	if(!density && !isSwitchingStates)
		add_overlay(mutable_appearance(icon, "[base_state]0_part", ABOVE_MOB_LAYER))
	else
		add_overlay(mutable_appearance(icon, "[base_state]1_part", ABOVE_MOB_LAYER))

/obj/structure/gate_vertical/proc/toggle()
	if(density)
		open()
	else
		close()

/obj/structure/gate_vertical/proc/open()
	if(isSwitchingStates || !density)
		return
	isSwitchingStates = TRUE
	playsound(src, 'sound/misc/gate.ogg', 100, extrarange = 5)
	flick("[base_state]_opening", src)
	layer = initial(layer)
	sleep(15)
	density = FALSE
	opacity = FALSE
	for(var/obj/gblock/B in blockers)
		B.opacity = FALSE
	isSwitchingStates = FALSE
	update_gate_icon()

/obj/structure/gate_vertical/proc/close()
	if(isSwitchingStates || density)
		return
	isSwitchingStates = TRUE
	update_gate_icon()
	layer = ABOVE_MOB_LAYER
	playsound(src, 'sound/misc/gate.ogg', 100, extrarange = 5)
	flick("[base_state]_closing", src)
	sleep(10)

	for(var/turf/T in turfsy)
		for(var/mob/living/M in T)
			var/zone = ran_zone(probability = 0)
			var/obj/item/bodypart/part = M.get_bodypart(check_zone(zone))
			M.apply_damage(200, BRUTE, zone)
			if(part)
				if((istype(part, /obj/item/bodypart/chest) || istype(part, /obj/item/bodypart/head)) && prob(50))
					part.add_wound(/datum/wound/slash/disembowel)
				part.add_wound(/datum/wound/fracture)
				part.dismember()
				M.visible_message(span_warningbig("[M] is crushed by \the [src]!"), span_userdanger("OH [uppertext(M.patron.name)], MY [uppertext(part.name)]!!!"))
			else
				M.visible_message(span_warningbig("[M] is crushed by \the [src]!"), span_userdanger("OH [uppertext(M.patron.name)], THE PAIN!!!"))
			M.emote("agony")
			step(M, pick(NORTH, SOUTH))
			M.Knockdown(50)
			M.Stun(50)

	density = TRUE
	opacity = TRUE
	layer = initial(layer)
	for(var/obj/gblock/B in blockers)
		B.opacity = TRUE
	isSwitchingStates = FALSE
	update_gate_icon()