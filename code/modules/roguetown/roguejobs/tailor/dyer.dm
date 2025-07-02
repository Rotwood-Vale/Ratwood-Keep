/obj/structure/dye_bin
	name = "dye bin"
	desc = "A bin with water."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dye_bin_full"
	density = TRUE
	anchored = FALSE
	max_integrity = 150
	drag_slowdown = 2
	throw_speed = 1
	throw_range = 1
	var/atom/movable/inserted
	var/list/allowed_types = list(
			/obj/item/clothing,
			/obj/item/storage,
			/obj/item/bedroll,
			)

	var/list/used_colors
	var/activecolor = "#FFFFFF"
	var/static/list/selectable_colors = list(
	"Royal White" = "#ffffff",
		"Black" = "#414143",
		"Royal Black"="#2b292e",
		"Light Grey" = "#999999",
		"Dark Grey" = "#505050",
		"Mage Grey" = "#6c6c6c",
		"Mage Red" = "#b8252c",
		"Mage Blue" = "#4756d8",
		"Mage Yellow" = "#c1b144",
		"Mage Green" = "#759259",
		"Chalk White" = "#f4ecde",
		"Dunked in Water" = "#bbbbbb",
		"Cream" = "#fffdd0",
		"Orange" = "#bd6606",
		"Royal Orange"="#df8405",
		"Gold" = "#f9a602",
		"Yarrow" = "#f0cb76",
		"Yellow Weld" = "#f4c430",
		"Yellow Ochre" = "#cb9d06",
		"Royal Yellow"="#ffcd43",
		"Baby Puke" = "#b5b004",
		"Olive" = "#98bf64",
		"Green" = "#428138",
		"Royal Green"="#264d26",
		"Dark Green" = "#264d26",
		"Royal Teal" = "#249589",
		"Periwinkle Blue" = "#8f99fb",
		"Woad Blue" = "#597fb9",
		"Royal Blue"="#173266",
		"Royal Azure"="#007fff",
		"Royal Purple" = "#8747b1",
		"Magenta" = "#962e5c",
		"Orchil" = "#66023C",
		"Red Ochre" = "#913831",
		"Red" = "#a32121",
		"Royal Red"="#8b2323",
		"Maroon" = "#550000",
		"Royal Majenta"="#962e5c",
		"Peasant Brown" = "#685542",
		"Dirt" = "#7c6d5c",
		"Chestnut" = "#613613",
		"Russet" = "#7f461b",
		"Royal Brown"="#61462c")

/obj/structure/dye_bin/examine(mob/user)
	. = ..()

/obj/structure/dye_bin/update_icon()
	. = ..()
	icon_state = "dye_bin_full"

/obj/structure/dye_bin/Destroy()
	inserted.forceMove(drop_location())
	return ..()

/obj/structure/dye_bin/attackby(obj/item/I, mob/living/user)
	if(is_type_in_list(I, allowed_types))
		if(contents.len)
			to_chat(user, "<span class='warning'>Something is in \the [name]!</span>")
			return
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return
		user.visible_message("<span class='notice'>[user] inserts [I] into the [src].</span>")

		inserted = I
		ui_interact(user)
	else
		return ..()

/obj/structure/dye_bin/attack_hand(mob/living/user)
	ui_interact(user)


/obj/structure/dye_bin/AllowDrop()
	return FALSE

/obj/structure/dye_bin/ui_interact(mob/user)
	var/list/dat = list("<center>")
	if(!inserted)
		dat += "<font color='#D25050'>Nothing is inside the bin.</font>"
	else
		dat += "<font color='#777777'> Item inserted:</font> <i><font color='#C3C3C3'<i>[inserted.name]</i></font> "
		dat += "<A href='?src=\ref[src];eject=1'>(Remove)</A><BR><BR>"

		dat += "<b> <font color='[activecolor]'>&#10070 ACTIVE COLOR &#10070</font></b><BR>"
		dat += "<A href='?src=\ref[src];select=1'>(Mix a color)</A> -- "
		dat += "<A href='?src=\ref[src];paint=1'>(Rub the dyes in)</A>--"
		dat += "<font color='#EFEFEF'><A href='?src=\ref[src];clear=1'>(Bleach it)</A></font>"
	dat += "</center>"
	var/datum/browser/menu = new(user, "colormate","<center> Dye Bucket</center>", 400, 170, src)
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
		var/choice
		if(alert(usr, "Input Choice", "Primary Dye", "Color Wheel", "Color Preset") != "Color Wheel")
			choice = input(usr, "Choose your dye:", "Dyes", null) as null|anything in selectable_colors
			if(!choice)
				return
			activecolor = selectable_colors[choice]
		else
			activecolor = sanitize_hexcolor(color_pick_sanitized(usr, "Choose your dye:", "Dyes", choice ? choice : activecolor), 6, TRUE)
			if(activecolor == "#000000")
				activecolor = "#FFFFFF"
		ui_interact(user)

	if(href_list["paint"])
		if(!inserted)
			return

		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		inserted.add_atom_colour(activecolor, FIXED_COLOUR_PRIORITY)
		update_icon()
		ui_interact(user)

	if(href_list["clear"])
		if(!inserted)
			return
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)
		update_icon()
		ui_interact(user)

	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(drop_location())
		inserted = null
		ui_interact(user)


/proc/color_pick_sanitized(mob/user, description, title, default_value, min_tag = 0.07, max_tag = 0.80)
	var/color = input(user, description, title, default_value) as color|null
	var/good = TRUE
	if(!color)
		return
	color = sanitize_hexcolor(color)
	var/list/hsl = rgb2hsl(hex2num(copytext(color,1,3)),hex2num(copytext(color,3,5)),hex2num(copytext(color,5,7)))
	if(hsl[3] < min_tag)
		to_chat(user, span_warning("The picked color is too dark! Raising Luminosity to minimum 20%."))
		hsl[3] = min_tag
		good = FALSE
	if(hsl[2] > max_tag)
		to_chat(user, span_warning("The picked color is too bright! Lowering Saturation to maximum 80%."))
		hsl[2] = max_tag
		good = FALSE
	if(!good)
		var/list/rgb = hsl2rgb(arglist(hsl))
		color = sanitize_hexcolor("[num2hex(rgb[1])][num2hex(rgb[2])][num2hex(rgb[3])]")

	return color
