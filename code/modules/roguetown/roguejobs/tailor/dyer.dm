/obj/machinery/gear_painter
	name = "Dye Station"
	desc = "A station to give your apparel a fresh new color! Recommended to use with white items for best results."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dyestation"
	density = TRUE
	anchored = TRUE
	var/atom/movable/inserted
	var/activecolor = "#FFFFFF"
	/// Allow holder'd mobs
	var/allow_mobs = TRUE
	/// Minimum lightness for normal mode out of 255
	var/minimum_normal_lightness = 50
	/// Max saturation for normal mode out of 255
	var/maximum_normal_saturation = 256
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

/obj/machinery/gear_painter/Destroy()
	inserted.forceMove(drop_location())
	return ..()

/obj/machinery/gear_painter/attackby(obj/item/I, mob/living/user)
	if(allow_mobs && istype(I, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/H = I
		var/mob/victim = H.held_mob
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return
		if(!QDELETED(H))
			H.release()
		insert_mob(victim, user)

	if(is_type_in_list(I, allowed_types) && is_operational())
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return
		user.visible_message("<span class='notice'>[user] inserts [I] into [src]'s receptable.</span>")

		inserted = I
	else
		return ..()

/obj/machinery/gear_painter/proc/insert_mob(mob/victim, mob/user)
	if(inserted)
		return
	if(user)
		visible_message("<span class='warning'>[user] stuffs [victim] into [src]!</span>")
	inserted = victim
	inserted.forceMove(src)

/obj/machinery/gear_painter/AllowDrop()
	return FALSE

/obj/machinery/gear_painter/AltClick(mob/user)
	. = ..()
	if(!user.CanReach(src))
		return
	if(!inserted)
		return
	to_chat(user, "<span class='notice'>You remove [inserted] from [src]")
	inserted.forceMove(drop_location())
	inserted = null
	updateUsrDialog()

/obj/machinery/gear_painter/ui_interact(mob/user)
	if(!is_operational())
		return
	user.set_machine(src)
	var/list/dat = list("<TITLE>Dye Station Control Panel</TITLE><BR>")
	if(!inserted)
		dat += "No item inserted."
	else
		dat += "Item inserted: [inserted]<HR>"
		dat += "<A href='?src=\ref[src];select=1'>Select new color.</A><BR>"
		dat += "Color: <font color='[activecolor]'>&#9899;</font>"
		dat += "<A href='?src=\ref[src];paint=1'>Apply new color.</A><BR><BR>"
		dat += "<A href='?src=\ref[src];clear=1'>Remove paintjob.</A><BR><BR>"
		dat += "<A href='?src=\ref[src];eject=1'>Eject item.</A><BR><BR>"

	var/datum/browser/menu = new(user, "colormate","Dye Station Control Panel", 800, 600, src)
	menu.set_content(dat.Join(""))
	menu.open()

/obj/machinery/gear_painter/Topic(href, href_list)
	if((. = ..()))
		return

	add_fingerprint(usr)

	if(href_list["close"])
		usr << browse(null, "window=colormate")
		return

	if(href_list["select"])
		var/newcolor = input(usr, "Choose a color.", "", activecolor) as color|null
		if(newcolor)
			activecolor = newcolor
		updateUsrDialog()

	if(href_list["paint"])
		if(!inserted)
			return
		if(!check_valid_color(activecolor, usr))
			return
		inserted.add_atom_colour(activecolor, FIXED_COLOUR_PRIORITY)
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["clear"])
		if(!inserted)
			return
		inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(drop_location())
		inserted = null
		updateUsrDialog()

/obj/machinery/gear_painter/proc/check_valid_color(list/cm, mob/user)
	if(!islist(cm))		// normal
		var/list/HSV = ReadHSV(RGBtoHSV(cm))
		if(HSV[3] < minimum_normal_lightness)
			to_chat(user, "<span class='warning'>[cm] is far too dark (min lightness [minimum_normal_lightness]!</span>")
			return FALSE
		if(HSV[2] > maximum_normal_saturation)
			to_chat(user, "<span class='warning'>[cm] is far too gaudy (max saturation [maximum_normal_saturation]!</span>")
			return FALSE
		return TRUE
