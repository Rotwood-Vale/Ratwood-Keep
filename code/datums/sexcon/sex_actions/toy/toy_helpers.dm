/proc/get_dildo_in_either_hand(mob/living/carbon/human/user)
	for(var/obj/item/thing in user.held_items)
		if(thing == null)
			continue
		if(!istype(thing, /obj/item/dildo))
			continue
		return thing
	return null

#define MAX_TOY_SIZE WEIGHT_CLASS_HUGE
#define MAX_INSERT_SIZE WEIGHT_CLASS_BULKY

/proc/get_funobject_in_hand(mob/living/user)
	var/obj/item/thing = user.get_active_held_item()
	if(thing != null && thing.w_class < MAX_TOY_SIZE) //Anything smaller than this fucks the puss.
		return thing
	return null

/proc/get_insertable_in_hand(mob/living/user)
	var/obj/item/thing = user.get_active_held_item()
	if(thing != null && thing.w_class <= MAX_INSERT_SIZE) //Anything smaller than this goes in the puss.
		if(thing.w_class > (MAX_INSERT_SIZE-1) && (istype(thing, /obj/item/rogueweapon) || istype(thing, /obj/item/clothing))) //no weapons unless one less than insert size
			return null
		return thing
	return null

#undef MAX_TOY_SIZE
#undef MAX_INSERT_SIZE
