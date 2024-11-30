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
	locked = FALSE
	var/base_icon = "pillory_single"
	var/list/accepted_id = list()
	var/keylock = TRUE

/obj/structure/pillory/double/custom
	keylock = FALSE

/obj/structure/pillory/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

/obj/structure/pillory/town_square
	accepted_id = list("keep_dungeon", "keep_barracks", "town_dungeon", "town_barracks", "bog_dungeon", "bog_barracks", "church")

/obj/structure/pillory/reinforced/keep_dungeon
	accepted_id = list("keep_dungeon")

/obj/structure/pillory/reinforced/town_dungeon
	accepted_id = list("town_dungeon")

/obj/structure/pillory/reinforced/bog_dungeon
	accepted_id = list("bog_dungeon")


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
	if(istype(P, /obj/item/customlock/finished))
		var/obj/item/customlock/finished/K = P
		if(keylock)
			to_chat(user, span_warning("[src] already has a lock."))
		else
			keylock = TRUE
			accepted_id = list(K.lockhash)
			to_chat(user, span_notice("You add [K] to [P]."))
			qdel(P)
		return
	if(user in buckled_mobs)
		to_chat(user, span_warning("I can't reach the lock!"))
		return
	if(!latched && keylock)
		to_chat(user, span_warning("It's not latched shut!"))
		return
	if(istype(P, /obj/item/key))
		var/obj/item/key/K = P
		if (!keylock)
			to_chat(user, span_warning("\The [src] lacks a lock."))
			return
		if(K.lockid in accepted_id)
			togglelock(user)
			return
		else
			to_chat(user, span_warning("Wrong key."))
			playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
			return
	if(istype(P, /obj/item/keyring))
		var/obj/item/keyring/K = P
		for(var/obj/item/key/KE in K.keys)
			if(KE.lockid in accepted_id)
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

	if ((!istype(M, /mob/living/carbon/human)) || HAS_TRAIT(M, TRAIT_TINY))
		to_chat(usr, span_warning("It doesn't look like [M.p_they()] can fit into this properly!"))
		return FALSE // Can't hold non-humanoids

	for(var/obj/item/grabbing/G in M.grabbedby)
		if(G.grab_state == 1)
			return ..(M, force, FALSE)
	to_chat(usr, span_warning("I must grab them more forcefully to put them in the pillory."))
	return FALSE

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
				switch(H.dna.species.name)
					if ("Dwarf", "Dwarf", "Kobold", "Goblin", "Verminvolk")
						H.set_mob_offsets("bed_buckle", _x = 0, _y = PILLORY_HEAD_OFFSET)
				icon_state = "[base_icon]-over"
				update_icon()
				H.setDir(SOUTH) //Makes the person always face south, in case someone constructed the pillory on the wrong direction
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

	..()

#undef PILLORY_HEAD_OFFSET
