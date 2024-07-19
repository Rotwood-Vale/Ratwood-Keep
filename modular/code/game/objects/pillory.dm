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

/obj/structure/pillory/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

/obj/structure/pillory/Initialize()
	LAZYINITLIST(buckled_mobs)
	. = ..()

/obj/structure/pillory/examine(mob/user)
	. = ..()

	var/msg = "It is [locked ? "locked." : "unlocked."]<br/>"
	. += msg

/obj/structure/pillory/attackby(obj/item/P, mob/user, params)
	if(user in src)
		to_chat(user, span_warning("I can't reach the lock!"))
		return
	if(istype(P, /obj/item/roguekey))
		var/obj/item/roguekey/K = P
		if(K.lockid == "dungeon" || K.lockid == "garrison")
			togglelock(user)
			return attack_hand(user)
		else
			to_chat(user, span_warning("Wrong key."))
			playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
			return
	if(istype(P, /obj/item/keyring))
		var/obj/item/keyring/K = P
		for(var/obj/item/roguekey/KE in K.keys)
			if(KE.lockid == "dungeoneer" || KE.lockid == "garrison")
				togglelock(user)
				return attack_hand(user)

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

////TRIBAL STUFF////
/obj/item/roguekey/tribal
	name = "worn key"
	desc = "This key should unlock the pillories of the tribe."
	icon_state = "rustkey"
	lockid = "tribal"

/obj/structure/pillory/tribal
	name = "Tribal-Made Pillory"
	desc = "To keep the criminals locked! This one has more crude craftsmanship."

/obj/structure/pillory/tribal/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/tribal/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

/obj/structure/pillory/tribal/attackby(obj/item/P, mob/user, params)
	if(user in src)
		to_chat(user, span_warning("I can't reach the lock!"))
		return
	if(istype(P, /obj/item/roguekey))
		var/obj/item/roguekey/K = P
		if(K.lockid == "tribal")
			togglelock(user)
			return attack_hand(user)
		else
			to_chat(user, span_warning("Wrong key."))
			playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
			return
	if(istype(P, /obj/item/keyring))
		var/obj/item/keyring/K = P
		for(var/obj/item/roguekey/KE in K.keys)
			if(KE.lockid == "tribal")
				togglelock(user)
				return attack_hand(user)


#undef PILLORY_HEAD_OFFSET
#undef PILLORY_LAYER_DIFF
