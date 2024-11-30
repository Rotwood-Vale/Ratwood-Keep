/obj/structure/treating_furnace
	name = "heat treatment furnace"
	desc = "A furnace to case-harden armor, supposedly for protection, but more for style."
	icon = 'icons/roguetown/misc/forge.dmi'
	icon_state = "treatment0"
	density = TRUE
	anchored = TRUE
	max_integrity = 150
	throw_speed = 1
	throw_range = 1
	var/coal_charges = 0
	var/atom/movable/inserted
	var/activecolor = "#FFFFFF"
	var/list/allowed_types = list(
			/obj/item/clothing/head/roguetown/helmet,
			/obj/item/clothing/suit/roguetown/armor/plate,
			/obj/item/clothing/under/roguetown/platelegs,
			/obj/item/clothing/gloves/roguetown/plate,
			/obj/item/clothing/mask/rogue/facemask/steel,
			/obj/item/clothing/neck/roguetown/bervor,
			/obj/item/clothing/wrists/roguetown/bracers,
			/obj/item/clothing/shoes/roguetown/armor/steel
			)
	var/static/list/selectable_colors = list(
  		"Scrape Off Coating" = "#ffffff",
		"Burn With Oil" = "#5f5f5f",
		"Low" = "#f9d083",
		"Medium" = "#6f6398",
		"Medium-Hot" = "#6c7ca8",
		"Hot" = "#7395b5",
		"Scorching" = "#8bb7c4",
		"Close to Melting" = "#b6d2c2"
		)

/obj/structure/treating_furnace/examine(mob/user)
	. = ..()
	if(coal_charges > 0)
		. += span_info("There's some coal inside to case-harden the armor")
	else
		. += span_info("There's no coal inside")

/obj/structure/treating_furnace/update_icon()
	. = ..()
	if(coal_charges > 0)
		icon_state = "treatment1"
	else
		icon_state = "treatment0"

/obj/structure/treating_furnace/Destroy()
	if(inserted)
		inserted.forceMove(drop_location())
	return ..()

/obj/structure/treating_furnace/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/rogueore/coal))
		to_chat(user, span_notice("I toss the coal into the furnace"))
		coal_charges += 1
		update_icon()
		qdel(I)
		return
	if(is_type_in_list(I, allowed_types))
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return
		user.visible_message("<span class='notice'>[user] inserts [I] into the [src].</span>")

		inserted = I
	else
		return ..()

/obj/structure/treating_furnace/AllowDrop()
	return FALSE

/obj/structure/treating_furnace/ui_interact(mob/user)
	var/list/dat = list("<TITLE>heat treatment furnace</TITLE><BR>")
	if(!inserted)
		dat += "Nothing inside."
	else
		dat += "Item inserted: [inserted]<BR>"
		dat += "<A href='?src=\ref[src];eject=1'>Take [inserted] out.</A><BR><BR>"
		if(coal_charges <= 0)
			dat += "No coal inside."
		else
			dat += "<A href='?src=\ref[src];select=1'>Choose a temperature.</A><BR>"
			dat += "Color: <font color='[activecolor]'>&#9899;</font>"
			dat += "<A href='?src=\ref[src];paint=1'>Heat-treat the armor.</A><BR><BR>"
			dat += "<A href='?src=\ref[src];clear=1'>Scrape the case-hardened layer off.</A><BR><BR>"

	var/datum/browser/menu = new(user, "colormate","heat treatment furnace", 400, 400, src)
	menu.set_content(dat.Join(""))
	menu.open()

/obj/structure/treating_furnace/Topic(href, href_list)
	if((. = ..()))
		return

	var/mob/user = usr
	add_fingerprint(usr)

	if(href_list["close"])
		usr << browse(null, "window=colormate")
		return

	if(href_list["select"])
		var/choice = input(usr,"Heat-treat to:","Temperature",null) as null|anything in selectable_colors
		if(!choice)
			return
		activecolor = selectable_colors[choice]
		ui_interact(user)

	if(href_list["paint"])
		if(!inserted)
			return
		if(coal_charges <= 0)
			ui_interact(user)
			return
		playsound(src, 'sound/items/firelight.ogg', 50, FALSE)
		if(!do_after(user, 3 SECONDS, target = src))
			return
		if(coal_charges <= 0)
			return
		inserted.add_atom_colour(activecolor, FIXED_COLOUR_PRIORITY)
		playsound(src, pick('sound/items/quench_barrel1.ogg','sound/items/quench_barrel2.ogg'), 50, FALSE)
		coal_charges--
		update_icon()
		ui_interact(user)

	if(href_list["clear"])
		if(!inserted)
			return
		if(coal_charges <= 0)
			ui_interact(user)
			return
		playsound(src, 'sound/items/firelight.ogg', 50, FALSE)
		if(!do_after(user, 3 SECONDS, target = src))
			return
		if(coal_charges <= 0)
			return
		inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)
		playsound(src, pick('sound/items/quench_barrel1.ogg','sound/items/quench_barrel2.ogg'), 50, FALSE)
		coal_charges--
		update_icon()
		ui_interact(user)

	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(drop_location())
		inserted = null
		ui_interact(user)
