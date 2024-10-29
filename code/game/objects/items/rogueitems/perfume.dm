/obj/item/perfume

	name = "perfume bottle"
	desc = "A bottle of pleasantly smelling fragrance."
	icon = 'icons/roguetown/items/perfume.dmi'
	icon_state = "perfume-bottle-empty"

	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON

	/// What fragrance is the perfume
	var/datum/pollutant/fragrance/fragrance_type
	/// How many uses remaining has it got
	var/uses_remaining = 10


/obj/item/perfume/Initialize()
	. = ..()
	if(!fragrance_type)
		uses_remaining = 0
	update_icon()

/obj/item/perfume/pickup()
	. = ..()
	update_icon()

/obj/item/perfume/update_icon()
	. = ..()
	var/mutable_appearance/perfume_overlay = mutable_appearance(icon, "perfume-bottle-overlay")
	if(!uses_remaining)
		underlays.Cut()
	else
		perfume_overlay.color = fragrance_type.color
		underlays.Add(perfume_overlay)

/obj/item/perfume/examine(mob/user)
	. = ..()
	if(uses_remaining)
		. += "It has [uses_remaining] use\s left."
	else
		. += "It is empty."

/obj/item/perfume/afterattack(atom/target, mob/user)
	. = ..()
	if(.)
		return
	if(!ismovable(target))
		return
	if(!uses_remaining)
		to_chat(user, span_warning("\The [src] is empty!"))
		update_icon()
		return

	uses_remaining--
	update_icon()
	if(target == user)
		user.visible_message(span_notice("[user] sprays \themself with \the [src]."), span_notice("You spray yourself with \the [src]."))
	else
		user.visible_message(span_notice("[user] sprays [target] with \the [src]."), span_notice("You spray [target] with \the [src]."))
	user.changeNext_move(CLICK_CD_RANGE*2)
	playsound(user.loc, 'sound/items/perfume.ogg', 100, TRUE)
	target.AddComponent(/datum/component/pollutant, fragrance_type, 10 MINUTES)

/obj/item/perfume/random/Initialize()
	fragrance_type = pick(subtypesof(/datum/pollutant/fragrance))
	name = fragrance_type.name + " perfume"
	. = ..()

/obj/item/perfume/lavender
	name = "lavender perfume"
	fragrance_type = /datum/pollutant/fragrance/lavender

/obj/item/perfume/cherry
	name = "cherry perfume"
	fragrance_type = /datum/pollutant/fragrance/cherry

/obj/item/perfume/rose
	name = "rose perfume"
	fragrance_type = /datum/pollutant/fragrance/rose

/obj/item/perfume/jasmine
	name = "jasmine perfume"
	fragrance_type = /datum/pollutant/fragrance/jasmine

/obj/item/perfume/mint
	name = "mint perfume"
	fragrance_type = /datum/pollutant/fragrance/mint

/obj/item/perfume/vanilla
	name = "vanilla perfume"
	fragrance_type = /datum/pollutant/fragrance/vanilla

/obj/item/perfume/pear
	name = "pear perfume"
	fragrance_type = /datum/pollutant/fragrance/pear

/obj/item/perfume/strawberry
	name = "strawberry perfume"
	fragrance_type = /datum/pollutant/fragrance/strawberry
