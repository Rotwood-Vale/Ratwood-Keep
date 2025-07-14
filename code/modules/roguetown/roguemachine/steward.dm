#define TAB_MAIN 1
#define TAB_BANK 2
#define TAB_STOCK 3
#define TAB_IMPORT 4
#define TAB_BOUNTIES 5
#define TAB_LOG 6

/obj/structure/roguemachine/steward
	name = "nerve master"
	desc = "The stewards most trusted friend."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "steward_machine"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/keycontrol = "steward"
	var/current_tab = TAB_MAIN
	var/compact = FALSE
	var/created_by_kit = FALSE


/obj/structure/roguemachine/steward/attackby(obj/item/P, mob/user, params)
    if(istype(P, /obj/item/key))
        var/obj/item/key/K = P
        if(K.lockid == keycontrol)
            locked = !locked
            playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
            update_icon()
            return
        else
            to_chat(user, span_warning("Wrong key."))
            return
    if(istype(P, /obj/item/storage/keyring))
        for(var/obj/item/key/KE in P.contents)
            if(KE.lockid == keycontrol)
                locked = !locked
                playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
                update_icon()
                return
        to_chat(user, span_warning("Wrong key."))
        return

    if(istype(P, /obj/item/roguecoin))
        var/obj/item/roguecoin/C = P
        var/amount = C.get_real_price()
        SStreasury.treasury_value += amount
        SStreasury.log_to_steward("+[amount]m deposited by [user.real_name]")
        playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
        to_chat(user, span_notice("You deposit [amount] mammon into the treasury."))
        del(C)
        return

    return ..()


/obj/structure/roguemachine/steward/Topic(href, href_list)
	. = ..()
	if(!usr.canUseTopic(src, BE_CLOSE) || locked)
		return
	if(href_list["switchtab"])
		current_tab = text2num(href_list["switchtab"])
	if(href_list["import"])
		var/datum/roguestock/D = locate(href_list["import"]) in SStreasury.stockpile_datums
		if(!D)
			return
		if(SStreasury.treasury_value < D.get_import_price())
			say("Insufficient mammon.")
			return
		var/amt = D.get_import_price()
		SStreasury.treasury_value -= amt
		SStreasury.log_to_steward("-[amt] imported [D.name]")
		if(amt >= 100) //Only announce big spending.
			scom_announce("Rockhill imports [D.name] for [amt] mammon.", )
		D.raise_demand()
		addtimer(CALLBACK(src, PROC_REF(do_import), D.type), 10 SECONDS)
	if(href_list["export"])
		var/datum/roguestock/D = locate(href_list["export"]) in SStreasury.stockpile_datums
		if(!D)
			return
		if((D.held_items[1] + D.held_items[2]) < D.importexport_amt)
			say("Insufficient stock.")
			return
		var/amt = D.get_export_price()

		// Try to export everything from town stockpile
		if(D.held_items[1] >= D.importexport_amt)
			D.held_items[1] -= D.importexport_amt
		// If not possible, first pull form town stockpile, then bog stockpile
		else
			D.held_items[2] -= (D.importexport_amt - D.held_items[1])
			D.held_items[1] = 0

		SStreasury.treasury_value += amt
		SStreasury.log_to_steward("+[amt] exported [D.name]")
		if(amt >= 100) //Only announce big spending.
			scom_announce("Rockhill exports [D.name] for [amt] mammon.")
		D.lower_demand()
	if(href_list["togglewithdraw"])
		var/datum/roguestock/D = locate(href_list["togglewithdraw"]) in SStreasury.stockpile_datums
		if(!D)
			return
		D.withdraw_disabled = !D.withdraw_disabled
	if(href_list["setbounty"])
		var/datum/roguestock/D = locate(href_list["setbounty"]) in SStreasury.stockpile_datums
		if(!D)
			return
		if(!D.percent_bounty)
			var/newtax = input(usr, "Set a new price for [D.name]", src, D.payout_price) as null|num
			if(newtax)
				if(!usr.canUseTopic(src, BE_CLOSE) || locked)
					return
				if(findtext(num2text(newtax), "."))
					return
				newtax = CLAMP(newtax, 0, 999)
				if(newtax > D.payout_price)
					scom_announce("The bounty for [D.name] was increased.")
				D.payout_price = newtax
		else
			var/newtax = input(usr, "Set a new percent for [D.name]", src, D.payout_price) as null|num
			if(newtax)
				if(!usr.canUseTopic(src, BE_CLOSE) || locked)
					return
				if(findtext(num2text(newtax), "."))
					return
				newtax = CLAMP(newtax, 1, 99)
				if(newtax > D.payout_price)
					scom_announce("The bounty for [D.name] was increased.")
				D.payout_price = newtax
	if(href_list["setprice"])
		var/datum/roguestock/D = locate(href_list["setprice"]) in SStreasury.stockpile_datums
		if(!D)
			return
		if(!D.percent_bounty)
			var/newtax = input(usr, "Set a new price to withdraw [D.name]", src, D.withdraw_price) as null|num
			if(newtax)
				if(!usr.canUseTopic(src, BE_CLOSE) || locked)
					return
				if(findtext(num2text(newtax), "."))
					return
				newtax = CLAMP(newtax, 0, 999)
				if(newtax < D.withdraw_price)
					scom_announce("The withdraw price for [D.name] was decreased.")
				D.withdraw_price = newtax
	if(href_list["givemoney"])
		var/X = locate(href_list["givemoney"])
		if(!X)
			return
		for(var/mob/living/A in SStreasury.bank_accounts)
			if(A == X)
				var/newtax = input(usr, "How much to give [X]", src) as null|num
				if(!usr.canUseTopic(src, BE_CLOSE) || locked)
					return
				if(findtext(num2text(newtax), "."))
					return
				if(!newtax)
					return
				if(newtax < 1)
					return
				SStreasury.give_money_account(newtax, A)
				break
	if(href_list["fineaccount"])
		var/X = locate(href_list["fineaccount"])
		if(!X)
			return
		for(var/mob/living/A in SStreasury.bank_accounts)
			if(A == X)
				var/newtax = input(usr, "How much to fine [X]", src) as null|num
				if(!usr.canUseTopic(src, BE_CLOSE) || locked)
					return
				if(findtext(num2text(newtax), "."))
					return
				if(!newtax)
					return
				if(newtax < 1)
					return
				SStreasury.give_money_account(-newtax, A)
				break
	if(href_list["payroll"])
		var/list/L = list(GLOB.noble_positions) + list(GLOB.garrison_positions) + list(GLOB.courtier_positions) + list(GLOB.church_positions) + list(GLOB.yeoman_positions) + list(GLOB.peasant_positions) + list(GLOB.youngfolk_positions)
		var/list/things = list()
		for(var/list/category in L)
			for(var/A in category)
				things += A
		var/job_to_pay = input(usr, "Select a job", src) as null|anything in things
		if(!job_to_pay)
			return
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		var/amount_to_pay = input(usr, "How much to pay every [job_to_pay]", src) as null|num
		if(!amount_to_pay)
			return
		if(amount_to_pay<1)
			return
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		if(findtext(num2text(amount_to_pay), "."))
			return
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H.job == job_to_pay)
				SStreasury.give_money_account(amount_to_pay, H)
	if(href_list["compact"])
		compact = !compact
	if(href_list["withdraw"])
		var/withdraw_amount = input(usr, "How much to withdraw", src) as null|num
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		if(findtext(num2text(withdraw_amount), "."))
			return
		if(!withdraw_amount || !SStreasury.treasury_value)
			return
		if(withdraw_amount < 1)
			return
		// If we try to withdraw more than is in the treasury, set the withdraw amount to the treasury value instead.
		withdraw_amount = min(withdraw_amount, SStreasury.treasury_value)

		SStreasury.remove_money_treasury(withdraw_amount, "direct withdraw")
		budget2change(withdraw_amount, usr)
	return attack_hand(usr)

/obj/structure/roguemachine/steward/proc/do_import(datum/roguestock/D,number)
	if(!D)
		return
	D = new D
	if(number > D.importexport_amt)
		return
	testing("number1 is [number]")
	if(!number)
		number = 1
	var/area/A = GLOB.areas_by_type[/area/rogue/indoors/town/warehouse]
	if(!A)
		return
	var/obj/item/I = new D.item_type()
	var/list/turfs = list()
	for(var/turf/T in A)
		turfs += T
	var/turf/T = pick(turfs)
	I.forceMove(T)
	playsound(T, 'sound/misc/hiss.ogg', 100, FALSE, -1)
	number += 1
	testing("number2 is [number]")
	addtimer(CALLBACK(src, PROC_REF(do_import), D.type, number), 3 SECONDS)

/obj/structure/roguemachine/steward/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(locked)
		to_chat(user, span_warning("It's locked. Of course."))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)
	var/canread = user.can_read(src, TRUE)
	var/contents
	switch(current_tab)
		if(TAB_MAIN)
			contents += "<center>NERVE MASTER<BR>"
			contents += "--------------<BR>"
			contents += "<a href='?src=\ref[src];switchtab=[TAB_BANK]'>\[Bank\]</a><BR>"
			if(!src.created_by_kit)
				contents += "<a href='?src=\ref[src];switchtab=[TAB_STOCK]'>\[Stockpile\]</a><BR>"
			contents += "<a href='?src=\ref[src];switchtab=[TAB_IMPORT]'>\[Import\]</a><BR>"
			contents += "<a href='?src=\ref[src];switchtab=[TAB_BOUNTIES]'>\[Bounties\]</a><BR>"
			contents += "<a href='?src=\ref[src];switchtab=[TAB_LOG]'>\[Log\]</a><BR>"
			contents += "</center>"
		if(TAB_BANK)
			contents += "<a href='?src=\ref[src];switchtab=[TAB_MAIN]'>\[Return\]</a>"
			contents += " <a href='?src=\ref[src];compact=1'>\[Compact: [compact? "ENABLED" : "DISABLED"]\]</a><BR>"
			contents += "<center>Bank<BR>"
			contents += "--------------<BR>"
			contents += "Treasury: [SStreasury.treasury_value]m<BR>"
			contents += "<a href='?src=\ref[src];withdraw=1'>\[Withdraw\]</a></center><BR>"
			contents += "<a href='?src=\ref[src];payroll=1'>\[Pay by Class\]</a><BR><BR>"

			for(var/mob/living/carbon/human/A in SStreasury.bank_accounts)
				if(ishuman(A))
					var/mob/living/carbon/human/tmp = A
					var/name_to_display = tmp.real_name
					var/job_to_display = tmp.advjob ? tmp.advjob : tmp.job

					var/datum/job/roguetown/job
					if (iswerewolf(A))
						// We want to display 
						name_to_display = A.stored_mob?.real_name
						if (!name_to_display)
							name_to_display = "UNKNOWN" // Should hopefully never happen, tell Zoni if you see this in-game
						job = SSjob.GetJob(A.stored_mob?.job)
					else
						job = SSjob.GetJob(tmp.job)
						
					if (job && job.should_anonymise_job())
						job_to_display = "FOREIGNER"
					else if (!job)
						job_to_display = "UNKNOWN" // Should hopefully never happen

					contents += "[name_to_display] ([job_to_display]) - [SStreasury.bank_accounts[A]]m"
				else
					// Not a human mob, so just show real name and account
					contents += "[A.real_name] - [SStreasury.bank_accounts[A]]m"
					
				if (compact)
					contents += " / <a href='?src=\ref[src];givemoney=\ref[A]'>\[PAY\]</a> <a href='?src=\ref[src];fineaccount=\ref[A]'>\[FINE\]</a><BR><BR>"
				else
					contents += "<BR>"
					contents += "<a href='?src=\ref[src];givemoney=\ref[A]'>\[Give Money\]</a> <a href='?src=\ref[src];fineaccount=\ref[A]'>\[Fine Account\]</a><BR><BR>"
		if(TAB_STOCK)
			contents += "<a href='?src=\ref[src];switchtab=[TAB_MAIN]'>\[Return\]</a>"
			contents += " <a href='?src=\ref[src];compact=1'>\[Compact: [compact? "ENABLED" : "DISABLED"]\]</a><BR>"
			contents += "<center>Stockpile<BR>"
			contents += "--------------<BR>"
			if(compact)
				contents += "Treasury: [SStreasury.treasury_value]m"
				contents += " / Lord's Tax: [SStreasury.tax_value*100]%"
				contents += " / Guild's Tax: [SStreasury.queens_tax*100]%</center><BR>"
				for(var/datum/roguestock/stockpile/A in SStreasury.stockpile_datums)
					contents += "<b>[A.name]:</b>"
					contents += " [A.held_items[1] + A.held_items[2]]"
					contents += " | SELL: <a href='?src=\ref[src];setbounty=\ref[A]'>[A.payout_price]m</a>"
					contents += " / BUY: <a href='?src=\ref[src];setprice=\ref[A]'>[A.withdraw_price]m</a>"
					if(A.importexport_amt)
						contents += " <a href='?src=\ref[src];import=\ref[A]'>\[IMP [A.importexport_amt] ([A.get_import_price()])\]</a> <a href='?src=\ref[src];export=\ref[A]'>\[EXP [A.importexport_amt] ([A.get_export_price()])\]</a> <BR>"
			else
				contents += "Treasury: [SStreasury.treasury_value]m<BR>"
				contents += "Lord's Tax: [SStreasury.tax_value*100]%<BR>"
				contents += "Guild's Tax: [SStreasury.queens_tax*100]%</center><BR>"
				for(var/datum/roguestock/stockpile/A in SStreasury.stockpile_datums)
					contents += "[A.name]<BR>"
					contents += "[A.desc]<BR>"
					contents += "Stockpiled Amount: [A.held_items[1] + A.held_items[2]]<BR>"
					contents += "Bounty Price: <a href='?src=\ref[src];setbounty=\ref[A]'>[A.payout_price]</a><BR>"
					contents += "Withdraw Price: <a href='?src=\ref[src];setprice=\ref[A]'>[A.withdraw_price]</a><BR>"
					contents += "Demand: [A.demand2word()]<BR>"
					if(A.importexport_amt)
						contents += "<a href='?src=\ref[src];import=\ref[A]'>\[Import [A.importexport_amt] ([A.get_import_price()])\]</a> <a href='?src=\ref[src];export=\ref[A]'>\[Export [A.importexport_amt] ([A.get_export_price()])\]</a> <BR>"
					contents += "<a href='?src=\ref[src];togglewithdraw=\ref[A]'>\[[A.withdraw_disabled ? "Enable" : "Disable"] Withdrawing\]</a><BR><BR>"
		if(TAB_IMPORT)
			contents += "<a href='?src=\ref[src];switchtab=[TAB_MAIN]'>\[Return\]</a>"
			contents += " <a href='?src=\ref[src];compact=1'>\[Compact: [compact? "ENABLED" : "DISABLED"]\]</a><BR>"
			contents += "<center>Imports<BR>"
			contents += "--------------<BR>"
			if(compact)
				contents += "Treasury: [SStreasury.treasury_value]m"
				contents += " / Lord's Tax: [SStreasury.tax_value*100]%"
				contents += " / Guild's Tax: [SStreasury.queens_tax*100]%</center><BR>"
				for(var/datum/roguestock/import/A in SStreasury.stockpile_datums)
					contents += "<b>[A.name]:</b>"
					contents += " <a href='?src=\ref[src];import=\ref[A]'>\[Import [A.importexport_amt] ([A.get_import_price()])\]</a><BR><BR>"
			else
				contents += "Treasury: [SStreasury.treasury_value]m<BR>"
				contents += "Lord's Tax: [SStreasury.tax_value*100]%<BR>"
				contents += "Guild's Tax: [SStreasury.queens_tax*100]%</center><BR>"
				for(var/datum/roguestock/import/A in SStreasury.stockpile_datums)
					contents += "[A.name]<BR>"
					contents += "[A.desc]<BR>"
					if(!A.stable_price)
						contents += "Demand: [A.demand2word()]<BR>"
					contents += "<a href='?src=\ref[src];import=\ref[A]'>\[Import [A.importexport_amt] ([A.get_import_price()])\]</a><BR><BR>"
		if(TAB_BOUNTIES)
			contents += "<a href='?src=\ref[src];switchtab=[TAB_MAIN]'>\[Return\]</a>"
			contents += "<center>Bounties<BR>"
			contents += "--------------<BR>"
			contents += "Treasury: [SStreasury.treasury_value]m<BR>"
			contents += "Duke's Tax: [SStreasury.tax_value*100]%</center><BR>"
			for(var/datum/roguestock/bounty/A in SStreasury.stockpile_datums)
				contents += "[A.name]<BR>"
				contents += "[A.desc]<BR>"
				contents += "Total Collected: [A.held_items[1] + A.held_items[2]]<BR>"
				if(A.percent_bounty)
					contents += "Bounty Price: <a href='?src=\ref[src];setbounty=\ref[A]'>[A.payout_price]%</a><BR><BR>"
				else
					contents += "Bounty Price: <a href='?src=\ref[src];setbounty=\ref[A]'>[A.payout_price]</a><BR><BR>"
		if(TAB_LOG)
			contents += "<a href='?src=\ref[src];switchtab=[TAB_MAIN]'>\[Return\]</a><BR>"
			contents += "<center>Log<BR>"
			contents += "--------------</center><BR><BR>"
			for(var/i = SStreasury.log_entries.len to 1 step -1)
				contents += "<span class='info'>[SStreasury.log_entries[i]]</span><BR>"

	if(!canread)
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 500, 800)
	popup.set_content(contents)
	popup.open()

/obj/item/carpet_bundle
    name = "Vault Carpet"
    desc = "A tightly wrapped bundle of priceless red carpet. It marks where this settlement will keep its most valuable possessions."
    icon = 'icons/roguetown/items/natural.dmi'
    icon_state = "clothroll2"
    w_class = 3
    force = 2
    var/uses = 16
    color = "#f02011"

    examine(mob/user)
        . = ..()
        if(uses > 1)
            . += "<br>There are [uses] uses left in the bundle."
        else
            . += "<br>There is [uses] use left in the bundle."
        return .

    attack_self(mob/user, params)
        if(src.uses <= 0)
            to_chat(user, "<span class='warning'>The bundle is empty.</span>")
            return
        var/turf/T = get_turf(user)
        if(!isfloorturf(T))
            to_chat(user, "<span class='warning'>I need ground to lay this on!</span>")
            return
        for(var/obj/A in T)
            if(istype(A, /obj/structure))
                to_chat(user, "<span class='warning'>I need some free space to lay a carpet here!</span>")
                return
            if(A.density && !(A.flags_1 & ON_BORDER_1))
                to_chat(user, "<span class='warning'>There is already something here!</span>")
                return
        user.visible_message("<span class='notice'>[user] begins unrolling a velvet carpet bundle.</span>")
        if(do_after(user, 15 SECONDS, TRUE, src))
            new /turf/open/floor/carpet/inn(T)
            if(!istype(T.loc, /area/rogue/indoors/town/vault))
                new /area/rogue/indoors/town/vault(T)
            src.uses--
            to_chat(user, "<span class='notice'>You finish unrolling the carpet, revealing a plush red floor!</span>")
            if(src.uses <= 0)
                to_chat(user, "<span class='warning'>You used the last of the carpet.</span>")
                del(src)

/obj/item/nervemaster_kit
    name = "Nerve Master Kit"
    desc = "A heavy crate containing the parts to assemble a Nerve Master with ease. How handy! (Right-Click to disassemble.)"
    icon = 'icons/roguetown/misc/structure.dmi'
    icon_state = "woodchest"
    w_class = 4
    color = "#5e0808" 

    attack_self(mob/user)
        var/turf/target = get_step(get_turf(user), user.dir)
        if(!isturf(target))
            to_chat(user, span_warning("You can't place a Nerve Master there!"))
            return
        if(!isfloorturf(target))
            to_chat(user, span_warning("You can't place a Nerve Master there!"))
            return
        if(locate(/obj/structure/roguemachine/steward) in target)
            to_chat(user, span_warning("There is already a Nerve Master here!"))
            return
        user.visible_message(span_notice("[user] begins assembling a Nerve Master."))
        if(do_after(user, 20 SECONDS, TRUE, src))
            var/obj/structure/roguemachine/steward/S = new /obj/structure/roguemachine/steward(target)
            S.created_by_kit = TRUE
            to_chat(user, span_notice("You finish assembling the Nerve Master!"))
            del(src)

/obj/structure/roguemachine/steward/attack_right(mob/user)
    if(!created_by_kit)
        return
    user.visible_message("<span class='notice'>[user] begins packing up the Nerve Master into a kit.</span>")
    if(do_after(user, 50 SECONDS, TRUE, src))
        new /obj/item/nervemaster_kit(get_turf(src))
        to_chat(user, "<span class='notice'>You finish packing up the Nerve Master!</span>")
        del(src)
#undef TAB_MAIN
#undef TAB_BANK
#undef TAB_STOCK
#undef TAB_IMPORT
#undef TAB_BOUNTIES
#undef TAB_LOG
