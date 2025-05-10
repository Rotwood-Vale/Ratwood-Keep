/datum/component/storage/concrete/pot
    max_w_class = WEIGHT_CLASS_NORMAL
    max_items = 6


/datum/component/storage/concrete/pot/mob_item_insertion_feedback(mob/user, mob/M, obj/item/I, override = FALSE)
	if(silent && !override)
		return
    //TO DO play sound based on if wet or dry
	for(var/mob/viewing in viewers(user, null))
		if(M == viewing)
			to_chat(usr, span_notice("I drop [I] [insert_preposition]to \the [parent]."))
		else if(in_range(M, viewing)) //If someone is standing close enough, they can tell what it is...
			viewing.show_message(span_notice("[M] drops [I] [insert_preposition]to \the [parent]."), MSG_VISUAL)
		else
			viewing.show_message(span_notice("[M] drops something [insert_preposition]to \the [parent]."), MSG_VISUAL)

//had to rewrite this just to add the hearth check!!!! messed up!
/datum/component/storage/concrete/pot/can_be_inserted(obj/item/I, stop_messages = FALSE, mob/M)
	if(!istype(I) || (I.item_flags & ABSTRACT))
		return FALSE //Not an item
	if(I == parent)
		return FALSE	//no paradoxes for you
	var/atom/real_location = real_location()
	var/atom/host = parent
	stop_messages = TRUE
	if(real_location == I.loc)
		return FALSE //Means the item is already in the storage item
	if(!ismob(host.loc) && !isturf(host.loc) && !istype(host.loc, /obj/machinery/light/rogue/hearth))
		testing("fugg [host] | [host.loc] | [M]")
		return FALSE
	if(locked)
		if(M && !stop_messages)
			host.add_fingerprint(M)
//			to_chat(M, span_warning("[host] seems to be locked!"))
		return FALSE
	if(real_location.contents.len >= max_items)
		if(!stop_messages)
			to_chat(M, span_warning("[host] is full, make some space!"))
		return FALSE //Storage item is full
	if(length(can_hold))
		if(!is_type_in_typecache(I, can_hold))
			if(!stop_messages)
				to_chat(M, span_warning("[host] cannot hold [I]!"))
			return FALSE
	if(is_type_in_typecache(I, cant_hold)) //Check for specific items which this container can't hold.
		if(!stop_messages)
			to_chat(M, span_warning("[host] cannot hold [I]!"))
		return FALSE
	if(I.w_class > max_w_class && !is_type_in_typecache(I, exception_hold))
		if(!stop_messages)
			to_chat(M, span_warning("[I] is too big for [host]!"))
		return FALSE
	var/datum/component/storage/biggerfish = real_location.loc.GetComponent(/datum/component/storage)
	if(biggerfish && biggerfish.max_w_class < max_w_class)//return false if we are inside of another container, and that container has a smaller max_w_class than us (like if we're a bag in a box)
		if(!stop_messages)
			to_chat(M, span_warning("[I] can't fit in [host] while [real_location.loc] is in the way!"))
		return FALSE
	var/sum_w_class = I.w_class
	for(var/obj/item/_I in real_location)
		sum_w_class += _I.w_class //Adds up the combined w_classes which will be in the storage item if the item is added to it.
	if(sum_w_class > max_combined_w_class)
		if(!stop_messages)
			to_chat(M, span_warning("[I] won't fit in [host], make some space!"))
		return FALSE
	if(isitem(host))
		var/obj/item/IP = host
		var/datum/component/storage/STR_I = I.GetComponent(/datum/component/storage)
		if((I.w_class >= IP.w_class) && STR_I && !allow_big_nesting)
			if(!stop_messages)
				to_chat(M, span_warning("[IP] cannot hold [I] as it's a storage item of the same size!"))
			return FALSE //To prevent the stacking of same sized storage items.
		if(IP.StorageBlock(I, M))
			return FALSE
	if(HAS_TRAIT(I, TRAIT_NODROP)) //SHOULD be handled in unEquip, but better safe than sorry.
		if(!stop_messages)
			to_chat(M, span_warning("\the [I] is stuck to your hand, you can't put it in \the [host]!"))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master.slave_can_insert_object(src, I, stop_messages, M)

/*
/datum/component/storage/concrete/pot/signal_take_obj(datum/source, atom/movable/AM, new_loc, force = FALSE)
	world.log << "This ran??"
	var/atom/host = parent
	if(istype(host.loc, /obj/machinery/light/rogue/hearth))
		world.log << "I am here"
		return remove_from_storage(AM, new_loc)

	..()
*/