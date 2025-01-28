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

/obj/item/natural/bundle/update_bundle()
	. = ..()
	var/increases = FLOOR(amount / items_per_increase, 1)
	var/height = FALSE
	grid_height = base_height
	grid_width = base_width
	for(var/i = 1 to increases)
		if(height)
			height = FALSE
			grid_height += 32
		else
			height = TRUE
			grid_width += 32
	if(item_flags & IN_STORAGE)
		var/obj/item/location = loc
		var/datum/component/storage/storage = location.GetComponent(/datum/component/storage)
		storage.update_item(src)
		storage.orient2hud()
