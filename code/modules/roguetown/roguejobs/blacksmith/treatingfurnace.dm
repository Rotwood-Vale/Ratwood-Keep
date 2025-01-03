/obj/structure/treating_furnace
	name = "печь для термообработки"
	desc = "Печь для цементации брони, предположительно для защиты, но больше для стиля."
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
		"Соскоблить покрытие" = "#ffffff",
		"Обжечь маслом" = "#5f5f5f",
		"Низкий" = "#f9d083",
		"Средний" = "#6f6398",
		"Средне-горячий" = "#6c7ca8",
		"Горячий" = "#7395b5",
		"Обжигающий" = "#8bb7c4",
		"Близко к плавлению" = "#b6d2c2"
		)

/obj/structure/treating_furnace/examine(mob/user)
	. = ..()
	if(coal_charges > 0)
		. += span_info("Внутри есть немного угля для укрепления брони")
	else
		. += span_info("Внутри нет угля")

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
		to_chat(user, span_notice("Я бросаю уголь в печь"))
		coal_charges += 1
		update_icon()
		qdel(I)
		return
	if(is_type_in_list(I, allowed_types))
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] прилип к вашей руке!</span>")
			return
		user.visible_message("<span class='notice'>[user] вставляет [I] в [src].</span>")

		inserted = I
	else
		return ..()

/obj/structure/treating_furnace/AllowDrop()
	return FALSE

/obj/structure/treating_furnace/ui_interact(mob/user)
	var/list/dat = list("<TITLE>печь для термообработки</TITLE><BR>")
	if(!inserted)
		dat += "Внутри ничего нет."
	else
		dat += "Вставленный предмет: [inserted]<BR>"
		dat += "<A href='?src=\ref[src];eject=1'>Вынуть [inserted].</A><BR><BR>"
		if(coal_charges <= 0)
			dat += "Внутри нет угля."
		else
			dat += "<A href='?src=\ref[src];select=1'>Выбрать температуру.</A><BR>"
			dat += "Цвет: <font color='[activecolor]'>&#9899;</font>"
			dat += "<A href='?src=\ref[src];paint=1'>Термообработать броню.</A><BR><BR>"
			dat += "<A href='?src=\ref[src];clear=1'>Снять слой укрепления.</A><BR><BR>"

	var/datum/browser/menu = new(user, "colormate","печь для термообработки", 400, 400, src)
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
		var/choice = input(usr,"Термообработать до:","Температура",null) as null|anything in selectable_colors
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
