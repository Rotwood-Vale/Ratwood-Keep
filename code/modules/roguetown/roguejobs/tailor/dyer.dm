/obj/structure/dye_bin
	name = "dye bin"
	desc = "A bin with water."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dye_bin"
	density = TRUE
	anchored = FALSE
	max_integrity = 150
	drag_slowdown = 2
	throw_speed = 1
	throw_range = 1
	var/berry_charges = 0
	var/atom/movable/inserted
	var/activecolor = "#FFFFFF"
	var/list/allowed_types = list(
			/obj/item/clothing/suit/roguetown/shirt/robe,
			/obj/item/clothing/suit/roguetown/shirt/dress,
			/obj/item/clothing/suit/roguetown/shirt/undershirt,
			/obj/item/clothing/suit/roguetown/shirt/shortshirt,
			/obj/item/clothing/under/roguetown/tights,
			/obj/item/clothing/cloak/raincloak,
			/obj/item/clothing/cloak/cape,
			/obj/item/clothing/cloak/half,
			/obj/item/clothing/head/roguetown/roguehood,
			/obj/item/clothing/head/roguetown/headband,
			/obj/item/clothing/head/roguetown/armingcap,
			/obj/item/clothing/head/roguetown/chaperon,
			/obj/item/storage/belt/rogue/leather/rope,
			/obj/item/storage/belt/rogue/leather/cloth,
			/obj/item/clothing/shoes/roguetown/simpleshoes,
			/obj/item/clothing/suit/roguetown/armor/gambeson
			)
	var/static/list/selectable_colors = list(
  		"White" = "#ffffff",
		"Black" = "#414143",
		"Light Grey" = "#999999",
		"Mage Grey" = "#6c6c6c",
		"Mage Red" = "#b8252c",
		"Mage Blue" = "#4756d8",
		"Mage Yellow" = "#c1b144",
		"Mage Green" = "#759259",
		"Chalk White" = "#f4ecde",
		"Dunked in Water" = "#bbbbbb",
		"Cream" = "#fffdd0",
		"Orange" = "#bd6606",
		"Gold" = "#f9a602",
		"Yarrow" = "#f0cb76",
		"Yellow Weld" = "#f4c430",
		"Yellow Ochre" = "#cb9d06",
		"Baby Puke" = "#b5b004",
		"Olive" = "#98bf64",
		"Green" = "#428138",
		"Dark Green" = "#264d26",
		"Teal" = "#249589",
		"Periwinkle Blue" = "#8f99fb",
		"Woad Blue" = "#597fb9",
		"Royal Purple" = "#8747b1",
		"Magenta" = "#962e5c",
		"Orchil" = "#66023C",
		"Red Ochre" = "#913831",
		"Red" = "#a32121",
		"Maroon" = "#550000",
		"Peasant Brown" = "#685542",
		"Dirt" = "#7c6d5c",
		"Chestnut" = "#613613",
		"Russet" = "#7f461b"
		)

/obj/structure/dye_bin/examine(mob/user)
	. = ..()
	if(berry_charges > 0)
		. += span_info("There's some colorful dyes floating inside")
	else
		. += span_info("There's no dyes inside")

/obj/structure/dye_bin/update_icon()
	. = ..()
	if(berry_charges > 0)
		icon_state = "dye_bin_full"
	else
		icon_state = "dye_bin"

/obj/structure/dye_bin/Destroy()
	inserted.forceMove(drop_location())
	return ..()

/obj/structure/dye_bin/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/grown/berries/rogue))
		to_chat(user, span_notice("I squeeze \the berries into some colorful dye"))
		berry_charges += 3
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

/obj/structure/dye_bin/AllowDrop()
	return FALSE

/obj/structure/dye_bin/ui_interact(mob/user)
	var/list/dat = list("<TITLE>dye bucket</TITLE><BR>")
	if(!inserted)
		dat += "Nothing inside."
	else
		dat += "Item inserted: [inserted]<BR>"
		dat += "<A href='?src=\ref[src];eject=1'>Take [inserted] out.</A><BR><BR>"
		if(berry_charges <= 0)
			dat += "No dye inside."
		else
			dat += "<A href='?src=\ref[src];select=1'>Mix a color.</A><BR>"
			dat += "Color: <font color='[activecolor]'>&#9899;</font>"
			dat += "<A href='?src=\ref[src];paint=1'>Rub the dyes in.</A><BR><BR>"
			dat += "<A href='?src=\ref[src];clear=1'>Bleach it.</A><BR><BR>"

	var/datum/browser/menu = new(user, "colormate","dye bucket", 400, 400, src)
	menu.set_content(dat.Join(""))
	menu.open()

/obj/structure/dye_bin/Topic(href, href_list)
	if((. = ..()))
		return

	var/mob/user = usr
	add_fingerprint(usr)

	if(href_list["close"])
		usr << browse(null, "window=colormate")
		return

	if(href_list["select"])
		var/choice = input(usr,"Mix a color:","Dyes",null) as null|anything in selectable_colors
		if(!choice)
			return
		activecolor = selectable_colors[choice]
		ui_interact(user)

	if(href_list["paint"])
		if(!inserted)
			return
		if(berry_charges <= 0)
			ui_interact(user)
			return
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		if(!do_after(user, 3 SECONDS, target = src))
			return
		if(berry_charges <= 0)
			return
		inserted.add_atom_colour(activecolor, FIXED_COLOUR_PRIORITY)
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		berry_charges--
		update_icon()
		ui_interact(user)

	if(href_list["clear"])
		if(!inserted)
			return
		if(berry_charges <= 0)
			ui_interact(user)
			return
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		if(!do_after(user, 3 SECONDS, target = src))
			return
		if(berry_charges <= 0)
			return
		inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		berry_charges--
		update_icon()
		ui_interact(user)

	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(drop_location())
		inserted = null
		ui_interact(user)
