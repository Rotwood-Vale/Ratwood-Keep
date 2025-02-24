#define DRUGRADE_MONEYA				(1<<0)
#define DRUGRADE_MONEYB 	      	(1<<1)
#define DRUGRADE_WINE 	          	(1<<2)
#define DRUGRADE_WEAPONS 	      	(1<<3)
#define DRUGRADE_CLOTHES 	      	(1<<4)
#define DRUGRADE_NOTAX				(1<<5)

/obj/structure/roguemachine/mulyeogdrug
	name = "LOVE"
	desc = "You care for yourself."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "streetvendor1"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/list/held_items = list()
	locked = FALSE
	var/budget = 0
	var/secret_budget = 0
	var/recent_payments = 0
	var/last_payout = 0
	var/drugrade_flags

/obj/structure/roguemachine/mulyeogdrug/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/key))
		var/obj/item/key/K = P
		if(K.lockid == "nightman")
			locked = !locked
			playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
			update_icon()
			return attack_hand(user)
		else
			to_chat(user, span_warning("Wrong key."))
			return
	if(istype(P, /obj/item/storage/keyring))
		var/obj/item/storage/keyring/K = P
		for(var/obj/item/key/KE in K.contents)
			if(KE.lockid == "mentor")
				locked = !locked
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
				update_icon()
				return attack_hand(user)
	if(istype(P, /obj/item/roguecoin))
		budget += P.get_real_price()
		qdel(P)
		update_icon()
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		return attack_hand(user)
	..()

/obj/structure/roguemachine/mulyeogdrug/process()
	if(recent_payments)
		if(world.time > last_payout + rand(6 MINUTES,8 MINUTES))
			var/amt = recent_payments * 0.10
			if(drugrade_flags & DRUGRADE_MONEYA)
				amt = recent_payments * 0.25
			if(drugrade_flags & DRUGRADE_MONEYB)
				amt = recent_payments * 0.50
			recent_payments = 0
			send_ooc_note("<b>Income from LOVE:</b> [amt]", job = "Mentor")
			secret_budget += amt

/obj/structure/roguemachine/mulyeogdrug/Topic(href, href_list)
	. = ..()
	if(!ishuman(usr))
		return
	if(href_list["buy"])
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		var/mob/M = usr
		var/O = text2path(href_list["buy"])
		if(held_items[O]["PRICE"])
			var/tax_amt = round(SStreasury.tax_value * held_items[O]["PRICE"])
			var/full_price = held_items[O]["PRICE"] + tax_amt
			if(drugrade_flags & DRUGRADE_NOTAX)
				full_price = held_items[O]["PRICE"]
			if(budget >= full_price)
				budget -= full_price
				recent_payments += held_items[O]["PRICE"]
				if(!(drugrade_flags & DRUGRADE_NOTAX))
					SStreasury.give_money_treasury(tax_amt, "purity import tax")
			else
				say("Not enough!")
				return
		var/obj/item/I = new O(get_turf(src))
		M.put_in_hands(I)
	if(href_list["change"])
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		if(budget > 0)
			budget2change(budget, usr)
			budget = 0
	if(href_list["secrets"])
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		var/list/options = list()
		options += "Withdraw Cut"
		if(drugrade_flags & DRUGRADE_NOTAX)
			options += "Enable Paying Taxes"
		else
			options += "Stop Paying Taxes"
		if(!(drugrade_flags & DRUGRADE_MONEYA))
			options += "Unlock 25% Cut (30)"
		else
			if(!(drugrade_flags & DRUGRADE_MONEYB))
				options += "Unlock 50% Cut (105)"
		var/select = input(usr, "Please select an option.", "", null) as null|anything in options
		if(!select)
			return
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		switch(select)
			if("Withdraw Cut")
				options = list("To Bank", "Direct")
				select = input(usr, "Please select an option.", "", null) as null|anything in options
				if(!select)
					return
				if(!usr.canUseTopic(src, BE_CLOSE) || locked)
					return
				switch(select)
					if("To Bank")
						var/mob/living/carbon/human/H = usr
						SStreasury.generate_money_account(secret_budget, H)
						secret_budget = 0
					if("Direct")
						if(secret_budget > 0)
							budget2change(secret_budget, usr)
							secret_budget = 0
			if("Enable Paying Taxes")
				drugrade_flags &= ~DRUGRADE_NOTAX
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
			if("Stop Paying Taxes")
				drugrade_flags |= DRUGRADE_NOTAX
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
			if("Unlock 25% Cut (30)")
				if(drugrade_flags & DRUGRADE_MONEYA)
					return
				if(budget < 30)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 30
				drugrade_flags |= DRUGRADE_MONEYA
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
			if("Unlock 50% Cut (105)")
				if(drugrade_flags & DRUGRADE_MONEYB)
					return
				if(budget < 105)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 105
				drugrade_flags |= DRUGRADE_MONEYB
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	return attack_hand(usr)

/obj/structure/roguemachine/mulyeogdrug/attack_hand(mob/living/user)
    . = ..()
    if(.)
        return
    if(!ishuman(user))
        return
    if(locked)
        return
    user.changeNext_move(CLICK_CD_MELEE)
    playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
    var/canread = user.can_read(src, TRUE)
    var/contents
    if(canread)
        contents = "<center>LOVE - Let's have fun.<BR>"
        contents += "<a href='?src=[REF(src)];change=1'>MAMMON LOADED:</a> [budget]<BR>"
    else
        contents = "<center>[stars("LOVE - Let's have fun.")]<BR>"
        contents += "<a href='?src=[REF(src)];change=1'>[stars("MAMMON LOADED:")]</a> [budget]<BR>"

    var/mob/living/carbon/human/H = user
    if(H.job == "Mentor") //kinda crashes the game if it's a Mentor - i've learned
        if(canread)
            contents += "<a href='?src=[REF(src)];secrets=1'>Secrets</a><BR>"
        else
            contents += "<a href='?src=[REF(src)];secrets=1'>[stars("Secrets")]</a><BR>"

    // Dynamically generate item prices based on tax flag
    for(var/I in held_items)
        var/price = held_items[I]["PRICE"]
        var/tax_amt = round(SStreasury.tax_value * price)
        var/full_price = price + tax_amt
        var/namer = held_items[I]["NAME"]

        // Apply tax exemption if the flag is set
        if(drugrade_flags & DRUGRADE_NOTAX)
            full_price = price

        if(!namer)
            held_items[I]["NAME"] = "thing"
            namer = "thing"

        if(canread)
            contents += "[namer] + [full_price] <a href='?src=[REF(src)];buy=[I]'>BUY</a><BR>"
        else
            contents += "[stars(namer)] + [stars(full_price)] <a href='?src=[REF(src)];buy=[I]'>[stars("BUY")]</a><BR>"

    var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 400)
    popup.set_content(contents)
    popup.open()

/obj/structure/roguemachine/mulyeogdrug/obj_break(damage_flag)
	..()
	budget2change(budget)
	set_light(0)
	update_icon()
	icon_state = "streetvendor0"

/obj/structure/roguemachine/mulyeogdrug/update_icon()
	cut_overlays()
	if(obj_broken)
		set_light(0)
		return
	set_light(1, 1, "#1b7bf1")
	add_overlay(mutable_appearance(icon, "vendor-drug"))


/obj/structure/roguemachine/mulyeogdrug/Destroy()
	set_light(0)
	STOP_PROCESSING(SSroguemachine, src)
	return ..()

/obj/structure/roguemachine/mulyeogdrug/Initialize()
	. = ..()
	START_PROCESSING(SSroguemachine, src)
	update_icon()
	held_items[/obj/item/reagent_containers/hypospray/medipen/sty/snekbt] = list("PRICE" = rand(25,30),"NAME" = "snake bite")
	held_items[/obj/item/reagent_containers/powder/spice] = list("PRICE" = rand(20,25),"NAME" = "spice")
	held_items[/obj/item/reagent_containers/powder/ozium] = list("PRICE" = rand(5,10),"NAME" = "ozium")
	held_items[/obj/item/reagent_containers/powder/moondust] = list("PRICE" = rand(25,30),"NAME" = "moondust")
	held_items[/obj/item/clothing/mask/cigarette/rollie/cannabis] = list("PRICE" = rand(3,6),"NAME" = "swampweed zig")
	held_items[/obj/item/reagent_containers/hypospray/medipen/sty/nourish] = list("PRICE" = rand(30,35),"NAME" = "NOURISH")
	held_items[/obj/item/storage/fancy/shhig] = list("PRICE" = rand(30,50),"NAME" = "box of ssssigs")
	held_items[/obj/item/storage/box/matches] = list("PRICE" = rand(5,15),"NAME" = "tinderbox")
	held_items[/obj/item/reagent_containers/hypospray/medipen/sty/detox] = list("PRICE" = rand(20,25),"NAME" = "DETOX")
	held_items[/obj/item/reagent_containers/glass/alembic] = list("PRICE" = rand(20,25),"NAME" = "alembic")
	held_items[/obj/item/storage/fancy/pilltin/wake] = list("PRICE" = rand(25,30),"NAME" = "pep pills tin")
	held_items[/obj/item/reagent_containers/hypospray/medipen/sealbottle/purify] = list("PRICE" = rand(15,20),"NAME" = "PURIFY")
	held_items[/obj/item/natural/bundle/cloth/bandage/full] = list("PRICE" = rand(5,10),"NAME" = "roll of bandages")
	held_items[/obj/item/reagent_containers/powder/paralysis] = list("PRICE" = rand(20,25),"NAME" = "stundust")
	held_items[/obj/item/reagent_containers/powder/witness] = list("PRICE" = rand(20,25),"NAME" = "WITNESS")
	held_items[/obj/item/reagent_containers/powder/hardballz] = list("PRICE" = rand(15,20),"NAME" = "hardballz")
	held_items[/obj/item/reagent_containers/powder/hawkeyes] = list("PRICE" = rand(15,20),"NAME" = "hawkeyes")
	held_items[/obj/item/reagent_containers/powder/stoneskin] = list("PRICE" = rand(25,30),"NAME" = "stoneskin")
	held_items[/obj/item/reagent_containers/powder/salvation] = list("PRICE" = rand(40,45),"NAME" = "salvation")
#undef DRUGRADE_MONEYA
#undef DRUGRADE_MONEYB
#undef DRUGRADE_WINE
#undef DRUGRADE_WEAPONS
#undef DRUGRADE_CLOTHES
#undef DRUGRADE_NOTAX
