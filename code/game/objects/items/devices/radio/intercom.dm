/obj/item/radio/intercom
	name = "station intercom"
	desc = ""
	icon_state = "intercom"
	anchored = TRUE
	w_class = WEIGHT_CLASS_BULKY
	canhear_range = 2
	var/number = 0
	var/anyai = 1
	var/mob/living/silicon/ai/ai = list()
	var/last_tick //used to delay the powercheck
	dog_fashion = null
	var/unfastened = FALSE

/obj/item/radio/intercom/unscrewed
	unfastened = TRUE

/obj/item/radio/intercom/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)
	START_PROCESSING(SSobj, src)

/obj/item/radio/intercom/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/radio/intercom/examine(mob/user)
	. = ..()
	if(!unfastened)
		. += span_notice("It's <b>screwed</b> and secured to the wall.")
	else
		. += span_notice("It's <i>unscrewed</i> from the wall, and can be <b>detached</b>.")

/obj/item/radio/intercom/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(unfastened)
			user.visible_message(span_notice("[user] starts tightening [src]'s screws..."), span_notice("I start screwing in [src]..."))
			if(I.use_tool(src, user, 30, volume=50))
				user.visible_message(span_notice("[user] tightens [src]'s screws!"), span_notice("I tighten [src]'s screws."))
				unfastened = FALSE
		else
			user.visible_message(span_notice("[user] starts loosening [src]'s screws..."), span_notice("I start unscrewing [src]..."))
			if(I.use_tool(src, user, 40, volume=50))
				user.visible_message(span_notice("[user] loosens [src]'s screws!"), span_notice("I unscrew [src], loosening it from the wall."))
				unfastened = TRUE
		return
	else if(I.tool_behaviour == TOOL_WRENCH)
		if(!unfastened)
			to_chat(user, span_warning("I need to unscrew [src] from the wall first!"))
			return
		user.visible_message(span_notice("[user] starts unsecuring [src]..."), span_notice("I start unsecuring [src]..."))
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 80))
			user.visible_message(span_notice("[user] unsecures [src]!"), span_notice("I detach [src] from the wall."))
			playsound(src, 'sound/blank.ogg', 50, TRUE)
			new/obj/item/wallframe/intercom(get_turf(src))
			qdel(src)
		return
	return ..()

/obj/item/radio/intercom/attack_ai(mob/user)
	interact(user)

/obj/item/radio/intercom/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	interact(user)

/obj/item/radio/intercom/interact(mob/user)
	..()
	ui_interact(user, state = GLOB.default_state)

/obj/item/radio/intercom/can_receive(freq, level)
	if(!on)
		return FALSE
	if(wires.is_cut(WIRE_RX))
		return FALSE
	if(!(0 in level))
		var/turf/position = get_turf(src)
		if(isnull(position) || !(position.z in level))
			return FALSE
	if(!src.listening)
		return FALSE
	if(freq == FREQ_SYNDICATE)
		if(!(src.syndie))
			return FALSE//Prevents broadcast of messages over devices lacking the encryption

	return TRUE


/obj/item/radio/intercom/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, list/spans, message_mode, original_message)
	. = ..()
	if (message_mode == MODE_INTERCOM)
		return  // Avoid hearing the same thing twice
	if(!anyai && !(speaker in ai))
		return
	..()

/obj/item/radio/intercom/process()
	if(((world.timeofday - last_tick) > 30) || ((world.timeofday - last_tick) < 0))
		last_tick = world.timeofday

		var/area/A = get_area(src)
		if(!A || emped)
			on = FALSE
		else
			on = A.powered(EQUIP) // set "on" to the power status

		if(!on)
			icon_state = "intercom-p"
		else
			icon_state = initial(icon_state)

/obj/item/radio/intercom/add_blood_DNA(list/blood_dna)
	return FALSE

/obj/item/radio/intercom/end_emp_effect(curremp)
	. = ..()
	if(!.)
		return
	on = FALSE

//Created through the autolathe or through deconstructing intercoms. Can be applied to wall to make a new intercom on it!
/obj/item/wallframe/intercom
	name = "intercom frame"
	desc = ""
	icon_state = "intercom"
	result_path = /obj/item/radio/intercom/unscrewed
	pixel_shift = 29
	inverse = TRUE
	custom_materials = list(/datum/material/iron = 75, /datum/material/glass = 25)
