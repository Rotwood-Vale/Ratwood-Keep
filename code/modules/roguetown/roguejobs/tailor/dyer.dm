/obj/structure/dye_bin
	name = "красильная бочка"
	desc = "Деревянная бочка, наполненная водой для окрашивания тканей."
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
	var/list/allowed_types = list(
			/obj/item/clothing/suit/roguetown/shirt/robe,
			/obj/item/clothing/suit/roguetown/shirt/dress,
			/obj/item/clothing/suit/roguetown/shirt/undershirt,
			/obj/item/clothing/suit/roguetown/shirt/shortshirt,
			/obj/item/clothing/under/roguetown/tights,
			/obj/item/clothing/cloak/raincloak,
			/obj/item/clothing/cloak/cape,
			/obj/item/clothing/cloak/half,
			/obj/item/clothing/cloak/fauld,
			/obj/item/clothing/cloak/fauld/battleskirt,
			/obj/item/clothing/head/roguetown/roguehood,
			/obj/item/clothing/head/roguetown/headband,
			/obj/item/clothing/head/roguetown/armingcap,
			/obj/item/clothing/head/roguetown/chaperon,
			/obj/item/storage/belt/rogue/leather/rope,
			/obj/item/storage/belt/rogue/leather/cloth,
			/obj/item/clothing/shoes/roguetown/simpleshoes,
			/obj/item/clothing/suit/roguetown/armor/gambeson,
			/obj/item/clothing/suit/roguetown/armor/armordress,
			/obj/item/storage,
			/obj/item/bedroll,
			/obj/item/clothing/under/roguetown/loincloth
			)
	var/activecolor = "#FFFFFF"
	var/static/list/selectable_colors = list(
		"Белый" = "#ffffff",
		"Чёрный" = "#414143",
		"Светло-серый" = "#999999",
		"Магический серый" = "#6c6c6c",
		"Магический красный" = "#b8252c",
		"Магический синий" = "#4756d8",
		"Магический жёлтый" = "#c1b144",
		"Магический зелёный" = "#759259",
		"Меловой белый" = "#f4ecde",
		"Вымоченный" = "#bbbbbb",
		"Кремовый" = "#fffdd0",
		"Оранжевый" = "#bd6606",
		"Золотой" = "#f9a602",
		"Тысячелистниковый" = "#f0cb76",
		"Вайдовый жёлтый" = "#f4c430",
		"Охра жёлтая" = "#cb9d06",
		"Болотная желчь" = "#b5b004",
		"Оливковый" = "#98bf64",
		"Зелёный" = "#428138",
		"Тёмно-зелёный" = "#264d26",
		"Бирюзовый" = "#249589",
		"Барвинковый" = "#8f99fb",
		"Вайдовый синий" = "#597fb9",
		"Королевский пурпур" = "#8747b1",
		"Пурпурный" = "#962e5c",
		"Орсельный" = "#66023C",
		"Охра красная" = "#913831",
		"Красный" = "#a32121",
		"Бордовый" = "#550000",
		"Крестьянский бурый" = "#685542",
		"Земляной" = "#7c6d5c",
		"Каштановый" = "#613613",
		"Рыжевато-коричневый" = "#7f461b"
		)

/obj/structure/dye_bin/examine(mob/user)
	. = ..()
	if(berry_charges > 0)
		. += span_info("В бочке плавают разноцветные красители")
	else
		. += span_info("В бочке нет красителей")

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
		to_chat(user, span_notice("Я выжимаю [I] для получения красителя."))
		berry_charges += 5
		update_icon()
		qdel(I)
		return
	if(is_type_in_list(I, allowed_types))
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] невозможно отцепить от руки!</span>")
			return
		user.visible_message("<span class='notice'>[user] опускает [I] в [src].</span>")

		inserted = I
	else
		return ..()

/obj/structure/dye_bin/AllowDrop()
	return FALSE

/obj/structure/dye_bin/ui_interact(mob/user)
	var/list/dat = list("<TITLE>красильная бочка</TITLE><BR>")
	if(!inserted)
		dat += "Внутри пусто."
	else
		dat += "Погружёно: [inserted]<BR>"
		dat += "<A href='?src=\ref[src];eject=1'>Достать [inserted]</A><BR><BR>"
		if(berry_charges <= 0)
			dat += "Нет красителя."
		else
			dat += "<A href='?src=\ref[src];select=1'>Смешать краску.</A><BR>"
			dat += "Цвет: <font color='[activecolor]'>&#9899;</font>"
			dat += "<A href='?src=\ref[src];paint=1'>Окрасить.</A><BR><BR>"
			dat += "<A href='?src=\ref[src];clear=1'>Смыть краску.</A><BR><BR>"

	var/datum/browser/menu = new(user, "красильная бочка","красильная бочка", 400, 400, src)
	menu.set_content(dat.Join(""))
	menu.open()

/obj/structure/dye_bin/Topic(href, href_list)
	if((. = ..()))
		return

	var/mob/user = usr
	add_fingerprint(usr)

	if(href_list["close"])
		usr << browse(null, "window=красильная бочка")
		return

	if(href_list["select"])
		var/choice = input(usr,"Смешать краску:","Dyes",null) as null|anything in selectable_colors
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
