// Picture frames
/obj/item/wallframe
	icon = 'icons/obj/wallframe.dmi'
	flags_1 = CONDUCT_1
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/result_path
	var/inverse = 0 // For inverse dir frames like light fixtures.
	var/pixel_shift //The amount of pixels

/obj/item/wallframe/proc/try_build(turf/on_wall, mob/user)
	if(get_dist(on_wall,user)>1)
		return
	var/ndir = get_dir(on_wall, user)
	if(!(ndir in GLOB.cardinals))
		return
	var/turf/T = get_turf(user)
	if(!isfloorturf(T))
		to_chat(user, "<span class='warning'>I cannot place [src] on this spot!</span>")
		return
	if(gotwallitem(T, ndir, inverse*2))
		to_chat(user, "<span class='warning'>There's already an item on this wall!</span>")
		return

	return TRUE

/obj/item/wallframe/proc/attach(turf/on_wall, mob/user)
	if(result_path)
		playsound(src.loc, 'sound/blank.ogg', 75, TRUE)
		user.visible_message("<span class='notice'>[user.name] attaches [src] to the wall.</span>",
			"<span class='notice'>I attach [src] to the wall.</span>",
			"<span class='hear'>I hear clicking.</span>")
		var/ndir = get_dir(on_wall,user)
		if(inverse)
			ndir = turn(ndir, 180)

		var/obj/O = new result_path(get_turf(user), ndir, TRUE)
		if(pixel_shift)
			switch(ndir)
				if(NORTH)
					O.pixel_y = pixel_shift
				if(SOUTH)
					O.pixel_y = -pixel_shift
				if(EAST)
					O.pixel_x = pixel_shift
				if(WEST)
					O.pixel_x = -pixel_shift
		after_attach(O)

	qdel(src)

/obj/item/wallframe/proc/after_attach(obj/O)
	transfer_fingerprints_to(O)

/obj/item/wallframe/picture
	name = "picture frame"
	desc = ""
	icon = 'icons/obj/decals.dmi'
	custom_materials = null
	flags_1 = 0
	icon_state = "frame-empty"
	result_path = /obj/structure/sign/picture_frame
	var/obj/item/photo/displayed

/obj/item/wallframe/picture/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/photo))
		if(!displayed)
			if(!user.transferItemToLoc(I, src))
				return
			displayed = I
			update_icon()
		else
			to_chat(user, "<span class=notice>\The [src] already contains a photo.</span>")
	..()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/wallframe/picture/attack_hand(mob/user)
	if(user.get_inactive_held_item() != src)
		..()
		return
	if(contents.len)
		var/obj/item/I = pick(contents)
		user.put_in_hands(I)
		to_chat(user, span_notice("I carefully remove the photo from \the [src]."))
		displayed = null
		update_icon()
	return ..()

/obj/item/wallframe/picture/attack_self(mob/user)
	user.examinate(src)

/obj/item/wallframe/picture/examine(mob/user)
	if(user.is_holding(src) && displayed)
		displayed.show(user)
		return list()
	else
		return ..()

/obj/item/wallframe/picture/update_icon()
	cut_overlays()
	if(displayed)
		add_overlay(image(displayed))

/obj/item/wallframe/picture/after_attach(obj/O)
	..()
	var/obj/structure/sign/picture_frame/PF = O
	PF.copy_overlays(src)
	if(displayed)
		PF.framed = displayed
	if(contents.len)
		var/obj/item/I = pick(contents)
		I.forceMove(PF)

/obj/structure/sign/picture_frame
	name = "picture frame"
	desc = ""
	icon = 'icons/obj/decals.dmi'
	icon_state = "frame-empty"
	var/obj/item/photo/framed
	var/persistence_id
	var/can_decon = TRUE

#define FRAME_DEFINE(id) /obj/structure/sign/picture_frame/##id/persistence_id = #id

//Put default persistent frame defines here!

#undef FRAME_DEFINE

/obj/structure/sign/picture_frame/Initialize(mapload, dir, building)
	. = ..()
	AddComponent(/datum/component/art, 20)
	LAZYADD(SSpersistence.photo_frames, src)
	if(dir)
		setDir(dir)
	if(building)
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -30 : 30)
		pixel_y = (dir & 3)? (dir ==1 ? -30 : 30) : 0

/obj/structure/sign/picture_frame/Destroy()
	LAZYREMOVE(SSpersistence.photo_frames, src)
	return ..()

/obj/structure/sign/picture_frame/proc/get_photo_id()
	if(istype(framed) && istype(framed.picture))
		return framed.picture.id

//Manual loading, DO NOT USE FOR HARDCODED/MAPPED IN ALBUMS. This is for if an album needs to be loaded mid-round from an ID.
/obj/structure/sign/picture_frame/proc/persistence_load()
	var/list/data = SSpersistence.GetPhotoFrames()
	if(data[persistence_id])
		load_from_id(data[persistence_id])

/obj/structure/sign/picture_frame/proc/load_from_id(id)
	var/obj/item/photo/old/P = load_photo_from_disk(id)
	if(istype(P))
		if(istype(framed))
			framed.forceMove(drop_location())
		else
			qdel(framed)
		framed = P
		update_icon()

/obj/structure/sign/picture_frame/examine(mob/user)
	if(in_range(src, user) && framed)
		framed.show(user)
		return list()
	else
		return ..()

/obj/structure/sign/picture_frame/attackby(obj/item/I, mob/user, params)
	if(can_decon && (I.tool_behaviour == TOOL_SCREWDRIVER || I.tool_behaviour == TOOL_WRENCH))
		to_chat(user, span_notice("I start unsecuring [name]..."))
		if(I.use_tool(src, user, 30, volume=50))
			playsound(loc, 'sound/blank.ogg', 50, TRUE)
			to_chat(user, span_notice("I unsecure [name]."))
			deconstruct()

	else if(I.tool_behaviour == TOOL_WIRECUTTER && framed)
		framed.forceMove(drop_location())
		framed = null
		user.visible_message(span_warning("[user] cuts away [framed] from [src]!"))
		return

	else if(istype(I, /obj/item/photo))
		if(!framed)
			var/obj/item/photo/P = I
			if(!user.transferItemToLoc(P, src))
				return
			framed = P
			update_icon()
		else
			to_chat(user, "<span class=notice>\The [src] already contains a photo.</span>")

	..()

/obj/structure/sign/picture_frame/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(framed)
		framed.show(user)

/obj/structure/sign/picture_frame/update_icon()
	cut_overlays()
	if(framed)
		add_overlay(image(framed))

/obj/structure/sign/picture_frame/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/obj/item/wallframe/picture/F = new /obj/item/wallframe/picture(loc)
		if(framed)
			F.displayed = framed
			framed = null
		if(contents.len)
			var/obj/item/I = pick(contents)
			I.forceMove(F)
		F.update_icon()
	qdel(src)
