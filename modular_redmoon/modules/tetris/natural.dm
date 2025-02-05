/obj/item/natural
	grid_width = 32
	grid_height = 32

/obj/item/natural/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/natural/bundle))
		if(item_flags & IN_STORAGE)
			to_chat(user, span_warning("It's hard to find [W] in my bag."))
			return
	. = ..()

/obj/item/natural/bundle
	var/items_per_increase = 5
	var/base_width = 32
	var/base_height = 32

/obj/item/natural/bundle/attack_right(mob/user)
	if(item_flags & IN_STORAGE)
		return
	. = ..()
