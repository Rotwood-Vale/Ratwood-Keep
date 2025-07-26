/obj/structure/roguemachine/stockpile
	name = "stockpile"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "stockpile_vendor"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32
	var/stockpile_index = 1
	var/current_category = "Raw Materials"
	var/list/categories = list("Raw Materials", "Foodstuffs", "Fruits")
	var/datum/withdraw_tab/withdraw_tab = null

/obj/structure/roguemachine/stockpile/Initialize()
	. = ..()
	SSroguemachine.stock_machines += src
	withdraw_tab = new(stockpile_index, src)


/obj/structure/roguemachine/stockpile/Destroy()
	SSroguemachine.stock_machines -= src
	return ..()

/obj/structure/roguemachine/stockpile/Topic(href, href_list)
	. = ..()
	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	if(href_list["navigate"])
		return attack_hand(usr, href_list["navigate"])
	if(href_list["stockpilechangecat"])
		current_category = href_list["stockpilechangecat"]
		return attack_hand(usr, "deposit")

	if(withdraw_tab.perform_action(href, href_list))
		if(href_list["remote"])
			playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
		return attack_hand(usr, "withdraw")

	// If we don't get a valid option, default to returning to the directory
	return attack_hand(usr, "directory")


/obj/structure/roguemachine/stockpile/proc/get_directory_contents()
	var/contents = "<center>TOWN STOCKPILE<BR>"
	contents += "--------------<BR>"

	contents += "<a href='?src=[REF(src)];navigate=withdraw'>EXTRACT</a><BR>"
	contents += "<a href='?src=[REF(src)];navigate=deposit'>FEED</a></center><BR><BR>"

	return contents

/obj/structure/roguemachine/stockpile/proc/get_withdraw_contents()
	return withdraw_tab.get_contents("EXTRACT FROM THE STOCKPILE", TRUE)

/obj/structure/roguemachine/stockpile/proc/get_deposit_contents()
	var/contents = "<center>FEED THE STOCKPILE<BR>"
	contents += "<a href='?src=[REF(src)];navigate=directory'>(back)</a><BR>"
	contents += "----------<BR>"
	contents += "</center>"
	var/selection = "Categories: "
	for(var/category in categories)
		if(category == current_category)
			selection += "<b>[current_category]</b> "
		else
			// Force call navigate so the UI actually updates fml
			selection += "<a href='?src=[REF(src)];stockpilechangecat=[category]'>[category]</a> "
	contents += selection + "<BR>"
	contents += "--------------<BR>"

	for(var/datum/roguestock/bounty/R in SStreasury.stockpile_datums)
		contents += "[R.name] - [R.payout_price][R.percent_bounty ? "%" : ""]"
		contents += "<BR>"

	contents += "<BR>"

	for(var/datum/roguestock/stockpile/R in SStreasury.stockpile_datums)
		if(R.category != current_category)
			continue
		contents += "[R.name] - [R.payout_price] - ([R.held_items[stockpile_index]]/[R.stockpile_limit]) - [R.demand2word()]"
		contents += "<BR>"

	return contents

/obj/structure/roguemachine/stockpile/attack_hand(mob/living/user, menu_name)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)

	var/contents
	if(menu_name == "withdraw")
		contents = get_withdraw_contents()
	else if(menu_name == "deposit")
		contents = get_deposit_contents()
	else
		contents = get_directory_contents()

	var/datum/browser/popup = new(user, "VENDORTHING", "", 700, 800)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/stockpile/proc/attemptsell(obj/item/I, mob/H, message = TRUE, sound = TRUE)
	for(var/datum/roguestock/R in SStreasury.stockpile_datums)
		if(istype(I, /obj/item/natural/bundle))
			var/obj/item/natural/bundle/B = I
			if(B.stacktype == R.item_type)
				var/nopay = R.held_items[stockpile_index] >= R.stockpile_limit // Check whether it is overflowed BEFORE nopaying them
				R.held_items[stockpile_index] += B.amount
				if(message == TRUE)
					stock_announce("[B.amount] units of [R.name] has been stockpiled.")
				qdel(B)
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
				if(nopay)
					SStreasury.economic_output += R.export_price * B.amount // Still count
					say("Stockpile is full, no payment.")
				else
					var/amt = R.payout_price * B.amount
					SStreasury.economic_output += R.export_price * B.amount
					if(!SStreasury.give_money_account(amt, H, "+[amt] from [R.name] bounty") && message == TRUE)
						say("No account found. Submit your fingers to a Meister for inspection.")
			continue
		// Bloc to replace old vault mechanics
		else if(istype(I,R.item_type))
			if(!R.check_item(I))
				continue
			var/amt = R.get_payout_price(I)
			var/nopay = !R.mint_item && R.held_items[stockpile_index] >= R.stockpile_limit // Check whether it is overflowed BEFORE nopaying them
			if(!R.mint_item)
				R.held_items[stockpile_index] += 1 //stacked logs need to check for multiple
				qdel(I)
				if(message == TRUE)
					stock_announce("[R.name] has been stockpiled.")
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
			else
				var/mint_amt = round(SStreasury.mint_multiplier * I.get_real_price())
				SStreasury.minted += mint_amt
				SStreasury.give_money_treasury(mint_amt, "Minting - [I.name]", FALSE)
				qdel(I) // Eaten to be minted!
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			var/true_value = I.get_real_price()
			if(nopay)
				SStreasury.economic_output += true_value // Still count as economic output hah
				say("Stockpile is full, no payment.")
			else if(amt)
				SStreasury.economic_output += true_value
				if(!SStreasury.give_money_account(amt, H, "+[amt] from [R.name] bounty") && message == TRUE)
					say("No account found. Submit your fingers to a Meister for inspection.")
			return

/obj/structure/roguemachine/stockpile/attackby(obj/item/P, mob/user, params)
	if(ishuman(user))
		if(istype(P, /obj/item/roguecoin))
			withdraw_tab.insert_coins(P)
			return attack_hand(user)
		else
			attemptsell(P, user, TRUE, TRUE)

/obj/structure/roguemachine/stockpile/attack_right(mob/user)
	if(ishuman(user))
		for(var/obj/I in get_turf(src))
			attemptsell(I, user, FALSE, FALSE)
		say("Bulk selling in progress...")
		playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
		playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)


