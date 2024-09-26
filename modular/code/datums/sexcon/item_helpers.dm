/proc/get_feather_in_either_hand(mob/living/carbon/human/user)
	for(var/obj/item/thing in user.held_items)
		if(thing == null)
			continue
		if(!istype(thing, /obj/item/natural/feather))
			continue
		return thing
	return null

/proc/get_candle_in_either_hand(mob/living/carbon/human/user)
	for(var/obj/item/thing in user.held_items)
		if(thing == null)
			continue
		if(!istype(thing, /obj/item/candle))
			continue
		return thing
	return null
