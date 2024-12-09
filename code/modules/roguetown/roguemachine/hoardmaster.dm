/obj/structure/roguemachine/Hoardmaster
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "Hoardmaster"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	var/upgrade_flags
	var/current_cat = "1"


/obj/structure/roguemachine/Hoardmaster/Initialize()
	. = ..()
	update_icon()
	var/namechance = rand(1,6)
	switch(namechance)
		if(1)
			name = "Hoardmaster Draconis Vex"
		if(2)
			name = "Hoardmaster Serpentus Ignis"
		if(3)
			name = "Hoardmaster Wyrmwind"
		if(4)
			name = "Hoardmaster Leviathan's Shadow"
		if(5)
			name = "Hoardmaster Slyph"
		if(6)
			name = "Hoardmaster Stormcaller"

/obj/structure/roguemachine/Hoardmaster/examine(mob/user)
	. = ..()
	if(user.mind?.has_antag_datum(/datum/antagonist/bandit))
		. += "Formerly a covetous creature, this one now shares its Hoard with the Freefolk. Protecting the transactor's Hoard, and trading it for Favor."
		return
	else
		. += "Some mean looking statue of a dragon. Something about it makes me uneasy, like its eyes are following me."
		return

/obj/structure/roguemachine/Hoardmaster/Topic(href, href_list)
	. = ..()
	if(!HAS_TRAIT(usr, TRAIT_COMMIE))
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
			message_admins("[usr.key] has attempted to purchase [sanitize(href_list["buy"])] with the HOARDMASTER. This is likely a HREF exploit attempt!")
			return
		var/datum/supply_pack/PA = SSmerchant.supply_packs[path]
		var/cost = PA.cost
		if(B.favor >= cost)
			B.favor -= cost
			playsound(loc, 'sound/misc/hoardmasterpurchase.ogg', 80, FALSE, -1)
		else
			say("Earn your keep first!")
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

/obj/structure/roguemachine/Hoardmaster/attack_hand(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_COMMIE))
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
	contents += "<a href='?src=[REF(src)];change=1'>Your favor:</a> [B.favor]<BR>"


	var/list/unlocked_cats = list("Things", "Stuff")
	switch(usr.advjob)
		if("Brigand")
			unlocked_cats+="Brigand"
		if("Foresworn")
			unlocked_cats+="foresworn"
		if("Hedge Knight")
			unlocked_cats+="Knight"
		if("Knave")
			unlocked_cats+="Knave"
		if("Rogue Mage")
			unlocked_cats+="Mage"
		if("Sawbones")
			unlocked_cats+="Sawbones"

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

	var/datum/browser/popup = new(user, "HOARDMASTER", "", 370, 600)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/hoardbarrier //Blocks sprite locations
	name = ""
	desc = "Formerly a covetous creature, this one now shares its Hoard with the Freefolk. Protecting the transactor's Hoard, and trading it for Favor."
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"
	density = TRUE
	anchored = TRUE
