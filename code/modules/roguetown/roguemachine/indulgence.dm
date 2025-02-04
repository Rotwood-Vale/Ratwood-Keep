/obj/structure/roguemachine/Indulgence
	name = "Indulgence"
	desc = ""
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "Indulgence"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	var/upgrade_flags
	var/current_cat = "1"


/obj/structure/roguemachine/Indulgence/Initialize()
	. = ..()
	update_icon()

/obj/structure/roguemachine/Indulgence/examine(mob/user)
	. = ..()
	. += "The might of psydon beams from this device"
	return

/obj/structure/roguemachine/Indulgence/Topic(href, href_list)
	. = ..()
	if(!HAS_TRAIT(usr, TRAIT_PURITAN))
		return
	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	if(!ishuman(usr))
		return
	if(href_list["buy"])
		var/mob/M = usr
		var/datum/antagonist/bandit/B = M.mind.has_antag_datum(/datum/antagonist/bandit)
		var/path = text2path(href_list["buy"])
		if(!ispath(path, /datum/supply_pack/rogue/bandit))
			message_admins("[usr.key] has attempted to purchase [sanitize(href_list["buy"])] with the INDULGENCE. This is likely a HREF exploit attempt!")
			return
		var/datum/supply_pack/PA = SSmerchant.supply_packs[path]
		var/cost = PA.cost
		if(INQsway >= cost)
			INQsway -= cost
			playsound(loc, 'sound/misc/purchase.ogg', 80, FALSE, -1)
		else
			say("The inquisition needs proof of your worth!")
			return
		var/shoplength = PA.contains.len
		var/l
		for(l=1,l<=shoplength,l++)
			var/pathi = pick(PA.contains)
			var/obj/item/I = new pathi(get_turf(M))
			if(shoplength == 1)
				M.put_in_hands(I)
			else
				return
	if(href_list["changecat"])
		current_cat = href_list["changecat"]
	return attack_hand(usr)

/obj/structure/roguemachine/Indulgence/attack_hand(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_PURITAN))
		return
	var/datum/antagonist/bandit/B = usr.mind.has_antag_datum(/datum/antagonist/bandit)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/contents
	contents = "<center>Wishes for the Free<BR>"
	contents += "<a href='?src=[REF(src)];change=1'>Your sway:</a> [I.sway]<BR>"


	var/list/unlocked_cats = list("Inquisition")
	switch(usr.job)
		if("Inquisitor")
			unlocked_cats+="puritan"
		if("Confessor")
			unlocked_cats+="confessor"

	if(current_cat == "1")
		contents += "<center>"
		for(var/X in unlocked_cats)
			contents += "<a href='?src=[REF(src)];changecat=[X]'>[X]</a><BR>"
		contents += "</center>"
	else
		contents += "<center>[current_cat]<BR></center>"
		contents += "<center><a href='?src=[REF(src)];changecat=1'>\[RETURN\]</a><BR><BR></center>"
		var/list/pax = list()
		for(var/pack in SSmerchant.supply_packs)
			var/datum/supply_pack/PA = SSmerchant.supply_packs[pack]
			if(PA.group == current_cat)
				pax += PA
		for(var/datum/supply_pack/PA in sortList(pax))
			contents += "[PA.name] [PA.contains.len > 1?"x[PA.contains.len]":""] - ([PA.cost])<a href='?src=[REF(src)];buy=[PA.type]'>BUY</a><BR>"

	var/datum/browser/popup = new(user, "Indulgence", "", 370, 600)
	popup.set_content(contents)
	popup.open()

