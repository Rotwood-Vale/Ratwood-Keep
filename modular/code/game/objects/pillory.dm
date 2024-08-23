#define PILLORY_HEAD_OFFSET      2 // How much we need to move the player to center their head

/obj/structure/pillory
	name = "Pillory"
	desc = "To keep the criminals locked!"
	icon_state = "pillory_single"
	icon = 'modular/icons/obj/pillory.dmi'
	can_buckle = TRUE
	max_buckled_mobs = 1
	buckle_lying = 0
	buckle_prevents_pull = TRUE
	anchored = TRUE
	density = TRUE
	layer = ABOVE_ALL_MOB_LAYER
	plane = GAME_PLANE_UPPER
	var/latched = FALSE
	var/locked = FALSE
	var/base_icon = "pillory_single"
	var/list/lockid = list()

/obj/structure/pillory/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

//TOWN SQUARE

/obj/structure/pillory/town_square
	lockid = list("garrison", "dungeon", "church")

/obj/structure/pillory/town_square/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/town_square/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

//DUNGEON

/obj/structure/pillory/dungeon
	lockid = list("garrison", "dungeon")

/obj/structure/pillory/dungeon/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/dungeon/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

/obj/structure/pillory/Initialize()
	LAZYINITLIST(buckled_mobs)
	. = ..()

/obj/structure/pillory/examine(mob/user)
	. = ..()

	var/msg = "It is [latched ? "latched" : "unlatched"] and [locked ? "locked." : "unlocked."]<br/>"
	. += msg

/obj/structure/pillory/attack_right(mob/living/user)
	. = ..()
	if(!buckled_mobs.len)
		to_chat(user, span_warning("What's the point of latching it with nobody inside?"))
		return
	if(user in buckled_mobs)
		to_chat(user, span_warning("I can't reach the latch!"))
		return
	if(locked)
		to_chat(usr, span_warning("Unlock it first!"))
		return
	togglelatch(user)

/obj/structure/pillory/attackby(obj/item/P, mob/user, params)
	if(user in buckled_mobs)
		to_chat(user, span_warning("I can't reach the lock!"))
		return
	if(!latched)
		to_chat(user, span_warning("It's not latched shut!"))
		return
	if(istype(P, /obj/item/roguekey))
		var/obj/item/roguekey/K = P
		if(K.lockid in lockid)
			togglelock(user)
			return
		else
			to_chat(user, span_warning("Wrong key."))
			playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
			return
	if(istype(P, /obj/item/keyring))
		var/obj/item/keyring/K = P
		for(var/obj/item/roguekey/KE in K.keys)
			if(KE.lockid in lockid)
				togglelock(user)
				return

/obj/structure/pillory/proc/togglelatch(mob/living/user, silent)
	user.changeNext_move(CLICK_CD_MELEE)
	if(latched)
		user.visible_message(span_warning("[user] unlatches [src]."), \
			span_notice("I unlatch [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		latched = FALSE
	else
		user.visible_message(span_warning("[user] latches [src]."), \
			span_notice("I latch [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		latched = TRUE

/obj/structure/pillory/proc/togglelock(mob/living/user, silent)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!latched)
		to_chat(user, span_warning("\The [src] is not latched shut."))
	if(locked)
		user.visible_message(span_warning("[user] unlocks [src]."), \
			span_notice("I unlock [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		locked = FALSE
	else
		user.visible_message(span_warning("[user] locks [src]."), \
			span_notice("I lock [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		locked = TRUE

/obj/structure/pillory/buckle_mob(mob/living/M, force = FALSE, check_loc = TRUE)
	if (!anchored)
		return FALSE

	if(locked)
		to_chat(usr, span_warning("Unlock it first!"))
		return FALSE

	if (!istype(M, /mob/living/carbon/human))
		to_chat(usr, span_warning("It doesn't look like [M.p_they()] can fit into this properly!"))
		return FALSE // Can't hold non-humanoids

	return ..(M, force, FALSE)

/obj/structure/pillory/post_buckle_mob(mob/living/M)
	if (!istype(M, /mob/living/carbon/human))
		return

	var/mob/living/carbon/human/H = M

	if (H.dna)
		if (H.dna.species)
			var/datum/species/S = H.dna.species

			if (istype(S))
				//H.cut_overlays()
				H.update_body_parts_head_only()
				density = FALSE
				switch(H.dna.species.name)
					if ("Dwarf", "Dwarf", "Kobold", "Goblin", "Verminvolk")
						H.set_mob_offsets("bed_buckle", _x = 0, _y = PILLORY_HEAD_OFFSET)
				icon_state = "[base_icon]-over"
				update_icon()
			else
				unbuckle_all_mobs()
		else
			unbuckle_all_mobs()
	else
		unbuckle_all_mobs()

	..()

/obj/structure/pillory/post_unbuckle_mob(mob/living/M)
	//M.regenerate_icons()
	M.reset_offsets("bed_buckle")
	icon_state = "[base_icon]"
	update_icon()
	..()

/obj/structure/pillory/unbuckle_mob(mob/living/user)
	if(latched)
		if(user.STASTR >= 18)
			if(do_after(user, 25))
				user.visible_message(span_warning("[user] breaks [src] open!"))
				locked = FALSE
				latched = FALSE
				..()
		else
			to_chat(usr, span_warning("Unlock it first!"))
			return FALSE
	else
		..()
		density = TRUE
	..()
	density = TRUE

#undef PILLORY_HEAD_OFFSET

////TRIBAL STUFF////
/obj/item/roguekey/tribal
	name = "worn key"
	desc = "This key should unlock the pillories of the tribe."
	icon_state = "rustkey"
	lockid = "tribal"

/obj/structure/pillory/tribal
	name = "Tribal-Made Pillory"
	desc = "To keep the criminals locked! This one has more crude craftsmanship."
	lockid = list("tribal")

/obj/structure/pillory/tribal/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/tribal/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"
