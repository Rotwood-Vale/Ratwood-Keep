/// BOOOOOOOOOOOOOOOOOOG MERCHANT ///


/obj/structure/roguemachine/merchant_bog
	name = "Contraband Beacon"
	desc = "An illicit merchant beacon stolen from the Guild. It imposes harsh tariffs and is used outside official channels."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "ballooner"
	density = TRUE
	blade_dulling = DULLING_BASH
	anchored = TRUE
	var/next_airlift = 0
	max_integrity = 0

/obj/structure/roguemachine/balloon_pad_bog
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = ""
	density = FALSE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE

/obj/structure/roguemachine/merchant_bog/attack_hand(mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)

	var/contents = ""
	contents += "<center>TARIFF BEACON<BR>"
	contents += "-----------------<BR>"
	contents += "Fixed Tariff: 50%<BR>"
	contents += "Next Balloon: [time2text((next_airlift - world.time), "mm:ss")]</center><BR>"

	var/datum/browser/popup = new(user, "TAXNAV", "", 370, 300)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/merchant_bog/update_icon()
	set_light(2, 2, "#d14747")

/obj/structure/roguemachine/merchant_bog/Initialize()
	. = ..()
	START_PROCESSING(SSroguemachine, src)
	update_icon()
	for(var/X in GLOB.alldirs)
		var/T = get_step(src, X)
		if(T)
			new /obj/structure/roguemachine/balloon_pad_bog(T)

/obj/structure/roguemachine/merchant_bog/Destroy()
	STOP_PROCESSING(SSroguemachine, src)
	set_light(0)
	return ..()

/obj/structure/roguemachine/merchant_bog/process()
	if(world.time > next_airlift)
		next_airlift = world.time + rand(2 MINUTES, 3 MINUTES)
#ifdef TESTSERVER
		next_airlift = world.time + 5 SECONDS
#endif

		var/play_sound = FALSE
		for(var/D in GLOB.alldirs)
			var/budgie = 0
			var/turf/T = get_step(src, D)
			if(!T) continue

			var/obj/structure/roguemachine/balloon_pad_bog/E = locate() in T
			if(!E) continue

			for(var/obj/I in T)
				if(I.anchored || !isturf(I.loc) || istype(I, /obj/item/roguecoin))
					continue

				var/prize = I.get_real_price()
				var/final_price = round(prize * 0.5)
				if(final_price >= 1)
					play_sound = TRUE
					budgie += final_price
					I.visible_message(span_warning("[I] is sucked into the sky with a bureaucratic whistle!"))
					qdel(I)

			budgie = round(budgie)
			if(budgie > 0)
				E.budget2change(budgie)

		if(play_sound)
			playsound(src.loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)

/obj/structure/roguemachine/merchantvend_bog
	name = "Independent Vendor"
	desc = "A fully autonomous vendor. No gods. No masters. Only taxes."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "streetvendor1"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/fixed_markup = 2.0
	var/upgrade_flags
	var/current_cat = "1"
	var/budget = 0

/obj/structure/roguemachine/merchantvend_bog/attack_hand(mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)

	var/contents = "<center>INDEPENDENT VENDOR<br><br>"
	contents += "Funds: [budget]<br><br>"

	if(current_cat == "1")
		contents += "<a href='?src=[REF(src)];changecat=Apparel'>Apparel</a><br>"
		contents += "<a href='?src=[REF(src)];changecat=Tools'>Tools</a><br>"
		contents += "<a href='?src=[REF(src)];changecat=Seeds'>Seeds</a><br>"
		contents += "<a href='?src=[REF(src)];changecat=Luxury'>Luxury</a><br>"
		if(upgrade_flags & UPGRADE_ARMOR) contents += "<a href='?src=[REF(src)];changecat=Armor'>Armor</a><br>"
		if(upgrade_flags & UPGRADE_WEAPONS) contents += "<a href='?src=[REF(src)];changecat=Weapons'>Weapons</a><br>"
		if(upgrade_flags & UPGRADE_FOOD) contents += "<a href='?src=[REF(src)];changecat=Consumable'>Consumable</a><br>"
		if(upgrade_flags & UPGRADE_WARDROBE) contents += "<a href='?src=[REF(src)];changecat=Wardrobe'>Wardrobe</a><br>"
		contents += "<br><a href='?src=[REF(src)];secrets=1'>Buy Licenses</a><br>"
	else
		contents += "<b>[current_cat]</b><br><br>"
		for(var/pack in SSmerchant.supply_packs)
			var/datum/supply_pack/PA = SSmerchant.supply_packs[pack]
			if(PA.group != current_cat) continue
			var/cost = round(PA.cost * fixed_markup)
			contents += "[PA.name] [PA.contains.len > 1 ? "x[PA.contains.len]" : ""] - ([cost]) <a href='?src=[REF(src)];buy=[PA.type]'>BUY</a><br>"
		contents += "<br><a href='?src=[REF(src)];changecat=1'>Return</a><br>"

	var/datum/browser/popup = new(user, "INDVENDOR", "", 360, 400)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/merchantvend_bog/attackby(obj/item/P, mob/user)
	if(istype(P, /obj/item/roguecoin))
		var/obj/item/roguecoin/C = P
		budget += C.get_real_price()
		qdel(C)
		update_icon()
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		return attack_hand(user)
	..()

/obj/structure/roguemachine/merchantvend_bog/Topic(href, href_list)
	. = ..()
	var/mob/user = usr

	if(href_list["changecat"])
		current_cat = href_list["changecat"]
		return attack_hand(user)

	if(href_list["buy"])
		var/path = text2path(href_list["buy"])
		if(!ispath(path, /datum/supply_pack))
			return
		var/datum/supply_pack/PA = new path
		var/cost = round(PA.cost * fixed_markup)

		if(budget < cost)
			to_chat(user, span_warning("Not enough funds!"))
			qdel(PA)
			return

		budget -= cost

		for(var/type in PA.contains)
			var/obj/item/I = new type(get_turf(src))
			user.put_in_hands(I)
		qdel(PA)

		playsound(src, 'sound/misc/beep.ogg', 100, FALSE, -1)
		to_chat(user, span_notice("Purchased [PA.name]."))
		return

	if(href_list["secrets"])
		var/select = input(user, "Buy License") as null|anything in list(
			(upgrade_flags & UPGRADE_ARMOR ? null : "Armor License (300)"),
			(upgrade_flags & UPGRADE_WEAPONS ? null : "Weapons License (220)"),
			(upgrade_flags & UPGRADE_FOOD ? null : "Pantry License (100)"),
			(upgrade_flags & UPGRADE_WARDROBE ? null : "Wardrobe License (100)")
		)
		if(!select)
			return

		var/cost = 0
		if(select == "Armor License (300)") {
			cost = 300
			upgrade_flags |= UPGRADE_ARMOR
		}
		else if(select == "Weapons License (220)") {
			cost = 220
			upgrade_flags |= UPGRADE_WEAPONS
		}
		else if(select == "Pantry License (100)") {
			cost = 100
			upgrade_flags |= UPGRADE_FOOD
		}
		else if(select == "Wardrobe License (100)") {
			cost = 100
			upgrade_flags |= UPGRADE_WARDROBE
		}

		if(budget < cost) {
			to_chat(user, span_warning("Insufficient funds."))
			return
		}

		budget -= cost
		playsound(src, 'sound/misc/beep.ogg', 100, FALSE, -1)
		to_chat(user, span_notice("License purchased: [select]"))
		return