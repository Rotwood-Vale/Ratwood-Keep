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
	var/locked = 0
	var/base_icon = "pillory_single"
	var/lockhash
	var/lockid = "dungeon"
	var/masterkey = FALSE

/obj/structure/pillory/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

/obj/structure/pillory/Initialize()
	LAZYINITLIST(buckled_mobs)
	if(lockid)
		if(GLOB.lockids[lockid])
			lockhash = GLOB.lockids[lockid]
		else
			lockhash = rand(1000,9999)
			while(lockhash in GLOB.lockhashes)
				lockhash = rand(1000,9999)
			GLOB.lockhashes += lockhash
			GLOB.lockids[lockid] = lockhash
	else
		lockhash = rand(1000,9999)
		while(lockhash in GLOB.lockhashes)
			lockhash = rand(1000,9999)
		GLOB.lockhashes += lockhash
	. = ..()

/obj/structure/pillory/examine(mob/user)
	. = ..()

	var/msg = "It is [locked ? "locked." : "unlocked."]<br/>"
	. += msg

/obj/structure/pillory/attackby(obj/item/W, mob/user, params)
	if(user in src)
		to_chat(user, span_warning("I can't reach the lock!"))
		return
	if(istype(W, /obj/item/roguekey) || istype(W, /obj/item/keyring))
		trykeylock(W, user)
		return
	else
		return ..()

/obj/structure/pillory/proc/trykeylock(obj/item/I, mob/user)
	if(istype(I,/obj/item/keyring))
		var/obj/item/keyring/R = I
		if(!R.keys.len)
			return
		var/list/keysy = shuffle(R.keys.Copy())
		for(var/obj/item/roguekey/K in keysy)
			if(user.cmode)
				if(!do_after(user, 10, TRUE, src))
					break
			if(K.lockhash == lockhash)
				togglelock(user)
				break
			else
				if(user.cmode)
					playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
		return
	else
		var/obj/item/roguekey/K = I
		if(K.lockhash == lockhash)
			togglelock(user)
			return
		else
			playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)

/obj/structure/pillory/proc/togglelock(mob/living/user, silent)
	user.changeNext_move(CLICK_CD_MELEE)
	if(locked)
		user.visible_message(span_warning("[user] unlocks [src]."), \
			span_notice("I unlock [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		locked = 0
	else
		user.visible_message(span_warning("[user] locks [src]."), \
			span_notice("I lock [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		locked = 1

/obj/structure/pillory/buckle_mob(mob/living/M, force = FALSE, check_loc = TRUE)
	if (!anchored)
		return FALSE

	if(locked)
		to_chat(usr, span_warning("Unlock it first!"))
		return FALSE

	if (!istype(M, /mob/living/carbon/human))
		to_chat(usr, span_warning("It doesn't look like [M.p_they()] can fit into this properly!"))
		return FALSE // Can't decapitate non-humans

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
	if(locked)
		if(user.STASTR >= 18)
			if(do_after(user, 25))
				user.visible_message(span_warning("[user] breaks [src] open!"))
				locked = 0
				..()
		else
			to_chat(usr, span_warning("Unlock it first!"))
			return FALSE
	else
		..()

	..()

#undef PILLORY_HEAD_OFFSET
#undef PILLORY_LAYER_DIFF
