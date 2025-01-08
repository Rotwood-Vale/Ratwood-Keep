/obj/effect/decal/cleanable/sigil
	name = "debug sigil"
	icon_state = "center"
	icon = null

	var/sigil_type = "Debug"

	/// The base ritual datum subtype associated with this sigil.
	var/rituals_type = /datum/ritual

	/// The list of rituals that can be performed with this sigil.
	var/rituals = list()

/obj/effect/decal/cleanable/sigil/N
	icon_state = "N"

/obj/effect/decal/cleanable/sigil/NE
	icon_state = "NE"

/obj/effect/decal/cleanable/sigil/E
	icon_state = "E"

/obj/effect/decal/cleanable/sigil/SE
	icon_state = "SE"

/obj/effect/decal/cleanable/sigil/S
	icon_state = "S"

/obj/effect/decal/cleanable/sigil/SW
	icon_state = "SW"

/obj/effect/decal/cleanable/sigil/W
	icon_state = "W"

/obj/effect/decal/cleanable/sigil/NW
	icon_state = "NW"

/obj/effect/decal/cleanable/sigil/examine(mob/user)
	. = ..()
	to_chat(user, "It is of the [sigil_type] circle.")

/obj/effect/decal/cleanable/sigil/Initialize(mapload)
	. = ..()
	// This can probably be done better.
	for(var/path in subtypesof(rituals_type))
		var/datum/ritual/G = path
		rituals[G.name] = G

/obj/effect/decal/cleanable/sigil/proc/consume_ingredients(datum/ritual/R)

	for(var/atom/A in get_step(src, NORTH))
		if(istype(A, R.n_req) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

	for(var/atom/A in get_step(src, SOUTH))
		if(istype(A, R.s_req) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

	for(var/atom/A in get_step(src, EAST))
		if(istype(A, R.e_req) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

	for(var/atom/A in get_step(src, WEST))
		if(istype(A, R.w_req) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

	for(var/atom/A in loc.contents)
		if(istype(A, R.center_requirement) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

/obj/effect/decal/cleanable/sigil/attack_hand(mob/living/user)
	. = ..()
	if(icon_state != "center") // fucking awful but it has to be this way
		return

	for(var/G in rituals)
		var/datum/ritual/path = rituals[G]
		if(path.circle == sigil_type)
			rituals |= path.name

	var/ritualnameinput = input(user, "Rituals", "RATWOOD") as null|anything in rituals
	var/datum/ritual/pickritual

	pickritual = rituals[ritualnameinput]

	var/cardinal_success = FALSE
	var/center_success = FALSE

	if(!pickritual)
		return

	var/dews = 0

	if(pickritual.e_req)
		for(var/atom/A in get_step(src, EAST))
			if(istype(A, pickritual.e_req))
				dews++
				break
			else
				continue
	else
		dews++

	if(pickritual.s_req)
		for(var/atom/A in get_step(src, SOUTH))
			if(istype(A, pickritual.s_req))
				dews++
				break
			else
				continue
	else
		dews++

	if(pickritual.w_req)
		for(var/atom/A in get_step(src, WEST))
			if(istype(A, pickritual.w_req))
				dews++
				break
			else
				continue
	else
		dews++

	if(pickritual.n_req)
		for(var/atom/A in get_step(src, NORTH))
			if(istype(A, pickritual.n_req))
				dews++
				break
			else
				continue
	else
		dews++

	if(dews >= 4)
		cardinal_success = TRUE

	for(var/atom/A in loc.contents)
		if(!istype(A, pickritual.center_requirement))
			continue
		else
			center_success = TRUE
			break

	var/badritualpunishment = FALSE
	if(cardinal_success != TRUE)
		if(badritualpunishment)
			return
		to_chat(user.mind, span_danger("\"The ritual fails...\""))
		user.electrocute_act(10, src)
		return

	if(center_success != TRUE)
		if(badritualpunishment)
			return
		to_chat(user.mind, span_danger("\"The ritual fails...\""))
		user.electrocute_act(10, src)
		return

	consume_ingredients(pickritual)
	call(pickritual.function)(user, loc)

/turf/open/floor/proc/generateSigils(mob/M, type, subtype)
	var/turf/T = get_turf(M.loc)
	for(var/obj/A in T)
		if(istype(A, /obj/effect/decal/cleanable/sigil))
			to_chat(M, span_warning("There is already a sigil here."))
			return
		if(A.density && !(A.flags_1 & ON_BORDER_1))
			to_chat(M, span_warning("There is already something here!"))
			return
	if(do_after(M, 5 SECONDS))
		M.bloody_hands--
		M.update_inv_gloves()

		//Very ugly, but it will do!
		var/list/sigilsPath = list()
		switch(type)
			if("ZIZO")
				var/obj/effect/decal/cleanable/sigil/zizo/C = new(src)
				C.sigil_type = subtype
				playsound(M, 'sound/items/write.ogg', 100)
				sigilsPath = list(
					/obj/effect/decal/cleanable/sigil/zizo/N,
					/obj/effect/decal/cleanable/sigil/zizo/S,
					/obj/effect/decal/cleanable/sigil/zizo/E,
					/obj/effect/decal/cleanable/sigil/zizo/W,
					/obj/effect/decal/cleanable/sigil/zizo/NE,
					/obj/effect/decal/cleanable/sigil/zizo/NW,
					/obj/effect/decal/cleanable/sigil/zizo/SE,
					/obj/effect/decal/cleanable/sigil/zizo/SW
				)
			if("DIVINE")
				var/obj/effect/decal/cleanable/sigil/divine/C = new(src)
				C.sigil_type = subtype
				playsound(M, 'sound/items/write.ogg', 100)
				sigilsPath = list(
					/obj/effect/decal/cleanable/sigil/divine/N,
					/obj/effect/decal/cleanable/sigil/divine/S,
					/obj/effect/decal/cleanable/sigil/divine/E,
					/obj/effect/decal/cleanable/sigil/divine/W,
					/obj/effect/decal/cleanable/sigil/divine/NE,
					/obj/effect/decal/cleanable/sigil/divine/NW,
					/obj/effect/decal/cleanable/sigil/divine/SE,
					/obj/effect/decal/cleanable/sigil/divine/SW
				)
			else
				stack_trace("Someone tried to draw an invalid sigil type. This is likely a bug in one of the draw_sigil procs.")
				return

		for(var/i = 1; i <= alldirs.len; i++)
			var/turf/floor = get_step(src, alldirs[i])
			var/sigil = sigilsPath[i]

			new sigil(floor)


