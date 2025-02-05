
/obj/item/natural
	icon = 'icons/roguetown/items/natural.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	desc = ""
	w_class = WEIGHT_CLASS_TINY
	var/bundletype = null
	var/bundling_time = 4 SECONDS

/obj/item/natural/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/natural/bundle))
		var/obj/item/natural/bundle/B = W
		if(istype(src, B.stacktype))
			if(B.amount < B.maxamount)
				B.amount++
				B.update_bundle()
				user.visible_message("[user] adds [src] to [W].")
				qdel(src)
			else
				to_chat(user, "There's not enough space in [W].")
			return
	else if(istype(W, /obj/item/natural))
		var/obj/item/natural/B = W
		if(B.bundletype == src.bundletype && src.bundletype != null)
			var/obj/item/natural/bundle/N = new bundletype(src.loc)
			qdel(B)
			qdel(src)
			user.put_in_hands(N)
			to_chat(user, "You tie the [N.stackname] into a bundle.")
	else
		return ..()


/obj/item/natural/bundle
	name = "bundle"
	desc = "You shouldn't be seeing this."
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	var/firemod = 5 MINUTES
	var/amount = 2
	var/maxamount = 10
	var/icon1 = "fibersroll1"
	var/icon1step = 3
	var/icon2 = "fibersroll2"
	var/icon2step = 6
	var/icon3 = null
	var/stacktype = /obj/item/natural/fibers/
	var/stackname = "fibers"

/obj/item/natural/bundle/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/natural/bundle))
		var/obj/item/natural/bundle/B = W
		if(src.stacktype == B.stacktype)
			if(src.amount + B.amount > maxamount)
				B.amount = (src.amount + B.amount) - maxamount
				src.amount = maxamount
				src.update_bundle()
				B.update_bundle()
				to_chat(user, "There's not enough space in [src].")
				if(B.amount == 1)
					var/obj/H = new stacktype(src.loc)
					user.put_in_hands(H)
					qdel(B)
			else
				to_chat(user, "You add the [W] to the [src].")
				src.amount += B.amount
				update_bundle()
				qdel(B)
	else if(istype(W, stacktype))
		if(item_flags & IN_STORAGE)
			return
		if(src.amount < src.maxamount)
			to_chat(user, "You add the [W] to the [src].")
			src.amount++
			qdel(W)
		else
			to_chat(user, "There's not enough space in [src].")
	else
		return ..()

/obj/item/natural/bundle/attack_right(mob/user)
	var/mob/living/carbon/human/H = user
	switch(amount)
		if(2)
			var/obj/F = new stacktype(src.loc)
			var/obj/I = new stacktype(src.loc)
			qdel(src)
			H.put_in_hands(F)
			H.put_in_hands(I)
			return
		else
			amount -= 1
			var/obj/F = new stacktype(src.loc)
			H.put_in_hands(F)
			user.visible_message("[user] removes [F] from [src]")
	update_bundle()

/obj/item/natural/bundle/attack_turf(turf/T, mob/living/user)
	var/list/obj/item/stackables = list()
	for(var/obj/I in T.contents)
		if(I.type == stacktype)
			stackables += I
	if(stackables.len)
		if(amount >= maxamount)
			to_chat(user, span_info("[src] can't hold any more without falling apart."))
			return
		to_chat(user, span_info("I begin filling [src]..."))
		for(var/obj/I in stackables)
			if(amount >= maxamount)
				break
			if(I.type == stacktype)
				if(!do_after(user, 5, TRUE, src))
					break
				if(!(I in T.contents))
					continue
				qdel(I)
				src.amount++
				update_bundle()

/obj/item/natural/bundle/examine(mob/user)
	. = ..()
	if(amount == maxamount )
		to_chat(user, span_notice("There are [amount] [stackname] in this bundle. It can not take any more."))
	else
		to_chat(user, span_notice("There are [amount] [stackname] in this bundle."))

/obj/item/natural/bundle/pre_attack_right(atom/A, mob/living/user, params)
	if(amount <= 0) //how did you manage to do this
		qdel(src)
		return
	if(ismob(A))
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)
	if(amount >= maxamount)
		to_chat(user, span_warning("There's not enough space in [src]."))
		return TRUE
	user.visible_message("[user] begins to gather all the [stackname] in front of them.", "I begin gathering all the [stackname] in front of me...")
	var/turf/turflocation = get_turf(A)
	for(var/obj/item/item in turflocation)
		if(amount >= maxamount)
			break
		if(!istype(item, stacktype) && !istype(item, /obj/item/natural/bundle))
			continue
		if(!do_after(user, 5, TRUE, src))
			break
		if(item.loc != turflocation)
			continue
		if(istype(item, stacktype))
			amount++
			qdel(item)
		else if(istype(item, /obj/item/natural/bundle))
			var/obj/item/natural/bundle/B = item
			if(B.stacktype == stacktype)
				if(amount + B.amount > maxamount)
					B.amount = (amount + B.amount) - maxamount
					amount = maxamount
					if(B.amount == 1)
						new B.stacktype(B.loc)
						qdel(B)
					else
						B.update_bundle()
				else
					amount += B.amount
					qdel(B)
		update_bundle()
	return TRUE

/obj/item/natural/bundle/proc/update_bundle()
	if(firefuel != 0)
		firefuel = firemod * amount
	if((amount <= icon1step) && (icon1 != null))
		icon_state = icon1
	else if((icon1step < amount <= icon2step) && (icon2 != null))
		icon_state = icon2
	else
		if(icon3 != null)
			icon_state = icon3
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
