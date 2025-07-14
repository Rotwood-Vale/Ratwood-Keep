/obj/structure/roguemachine/Hoardmaster
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "Hoardmaster"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	layer = ABOVE_MOB_LAYER
	var/subjugating = FALSE
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
		. += "Formerly a covetous creature, this one now shares its Hoard with the Freefolk. Protecting the transactor's Hoard, and trading it for Favor. The dragon is humming with ancient magic, for anyone that comes close to it. (Drag and drop a victim into it, then RMB to ransom them)"
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
	if (has_buckled_mobs())
		for(var/mob/living/L in buckled_mobs)
			user_unbuckle_mob(L, user)

	if(!HAS_TRAIT(user, TRAIT_COMMIE))
		return

	var/datum/antagonist/bandit/B = user.mind.has_antag_datum(/datum/antagonist/bandit)
	if(!ishuman(user) || !B)
		return

	user.changeNext_move(CLICK_CD_MELEE)
	. = ..()
	if(.)
		return

	var/contents = "<center>Wishes for the Free<BR>"
	contents += "<a href='?src=[REF(src)];change=1'>Your favor:</a> [B.favor]<BR>"

	var/list/unlocked_cats = list("Gear", "Consumables", "Clothing")
	var/time_elapsed = world.time - SSticker.round_start_time

	switch(user.advjob)
		if("Brigand")
			unlocked_cats += "Brigand"
			if(time_elapsed >= 27000)
				unlocked_cats += "Brigand first supply pack"
			if(time_elapsed >= 48000)
				unlocked_cats += "Brigand second supply pack"
		if("Foresworn")
			unlocked_cats += "Foresworn"
			if(time_elapsed >= 27000)
				unlocked_cats += "Foresworn first supply pack"
			if(time_elapsed >= 48000)
				unlocked_cats += "Foresworn second supply pack"
		if("Hedge Knight")
			unlocked_cats += "Knight"
			if(time_elapsed >= 27000)
				unlocked_cats += "Knight first supply pack"
			if(time_elapsed >= 48000)
				unlocked_cats += "Knight second supply pack"
		if("Knave")
			unlocked_cats += "Knave"
			if(time_elapsed >= 27000)
				unlocked_cats += "Knave first supply pack"
			if(time_elapsed >= 48000)
				unlocked_cats += "Knave second supply pack"
		if("Rogue Mage")
			unlocked_cats += "Mage"
			if(time_elapsed >= 27000)
				unlocked_cats += "Mage first supply pack"
			if(time_elapsed >= 48000)
				unlocked_cats += "Mage second supply pack"
		if("Sawbones")
			unlocked_cats += "Sawbones"
			if(time_elapsed >= 27000)
				unlocked_cats += "Sawbones first supply pack"
			if(time_elapsed >= 48000)
				unlocked_cats += "Sawbones second supply pack"

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

/obj/structure/roguemachine/Hoardmaster/buckle_mob(mob/living/carbon/human/H, force = FALSE, check_loc = TRUE)
	if (!istype(H, /mob/living/carbon/human))
		to_chat(usr, span_warning("The Hoardmaster is not interested in this."))
		return FALSE

	if(HAS_TRAIT(H, TRAIT_COMMIE))
		to_chat(usr, span_warning("The Hoardmaster does not unleash their magic upon one of its own."))
		return FALSE

	if(HAS_TRAIT(H, TRAIT_MATTHIOS_BRAND) || HAS_TRAIT(H, TRAIT_MATTHIOS_BRAND_OLD))
		to_chat(usr, span_warning("The Hoardmaster has already humiliated this one."))
		return FALSE

	if(!H.mind)
		to_chat(usr, span_warning("The Hoardmaster seeks to subjugate ones that are aware."))
		return FALSE

	return ..(H, force, FALSE)

/obj/structure/roguemachine/Hoardmaster/unbuckle_mob(mob/living/user)
	if(subjugating)
		to_chat(usr, span_warning("The Hoardmaster will not be interrupted."))
		return FALSE
	else
		..()

/obj/structure/roguemachine/Hoardmaster/attack_right(mob/living/carbon/human/user)
	set waitfor = FALSE

	if(!user || !ishuman(user))
		return

	if(!HAS_TRAIT(user, TRAIT_COMMIE))
		to_chat(user, span_notice("The Hoardmaster does not acknowledge you."))
		return

	var/mob/living/carbon/human/H = null
	for(var/l in buckled_mobs)
		H = l
	if(!H)
		to_chat(user, span_notice("The Hoardmaster await its sacrifice."))
		return
	if(!H.buckled)
		to_chat(user, span_notice("The Deposed is not secure."))
		return
	if(H.stat == DEAD)
		to_chat(user, span_notice("The Deposed is defunct."))
		return

    // You cannot offer the player if they have missing ears, eyes or tongue or any body part. This says a lot about our society. Sometimes its too much freedom for players so things like this must be added.
	var/list/missing_organs = list(
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_TONGUE
	)

	for(var/slot in missing_organs)
		var/obj/item/organ/O = H.getorganslot(slot)
		if(!O)
			var/organ_name = "[slot]"
			switch(slot)
				if(ORGAN_SLOT_EARS) organ_name = "ears"
				if(ORGAN_SLOT_EYES) organ_name = "eyes"
				if(ORGAN_SLOT_TONGUE) organ_name = "tongue"
			to_chat(usr, span_warning("The [organ_name] are missing. The Hoardmaster demands wholeness."))
			return FALSE

	var/obj/item/bodypart/target_head = H.get_bodypart(BODY_ZONE_HEAD)
	var/obj/item/bodypart/target_larm = H.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/target_rarm = H.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/target_lleg = H.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/target_rleg = H.get_bodypart(BODY_ZONE_R_LEG)

	if(!target_head)
		to_chat(usr, span_warning("This offering is headless. Hoardmaster wants them alive."))
		return FALSE
	if(!target_larm)
		to_chat(usr, span_warning("The left arm is missing. The Hoardmaster demands wholeness."))
		return FALSE
	if(!target_rarm)
		to_chat(usr, span_warning("The right arm is gone. The Hoardmaster turns away."))
		return FALSE
	if(!target_lleg)
		to_chat(usr, span_warning("The left leg is gone. This one cannot stand before the Hoardmaster."))
		return FALSE
	if(!target_rleg)
		to_chat(usr, span_warning("The right leg is missing. Incomplete offerings are rejected."))
		return FALSE

	if(!do_after(user, 40 SECONDS, TRUE, H))
		return

	playsound(src.loc, 'sound/items/pickgood1.ogg', 100, TRUE, -1)
	H.Paralyze(20 SECONDS)

	subjugating = TRUE
	say("AN ACCEPTABLE OFFERING.")

	var/payout = 400

	sleep(2 SECONDS)

	playsound(src.loc, 'sound/items/beartrap.ogg', 100, TRUE, -1)
	visible_message(span_warning("The Hoardmaster's invisible coils of sorcery tighten around [H]'s mind!"))

	sleep(2 SECONDS)

	visible_message(span_warning("Runes of binding ignite on [H]'s temples, each sigil a searing brand of agony!"))
	H.emote("scream")
	H.reagents.add_reagent(/datum/reagent/medicine/healthpot, 90) //two health potion worth
	if(HAS_TRAIT(H, TRAIT_NOBLE))
		say("NOW YOU WILL KNOW TRUE SUBJUGATION.")
		payout = 800
	else
		say("A MARK OF SHAME.")
	ADD_TRAIT(H, TRAIT_MATTHIOS_BRAND, TRAIT_GENERIC)
	H.apply_status_effect(/datum/status_effect/matthiosbrand)

	sleep(3 SECONDS)

	visible_message(span_warning("Ancient power floods forth at the Hoardmaster's command. An inexorable curse engulfs [H]'s very essence!"))
	H.flash_fullscreen("whiteflash3")
	H.Unconscious(15 SECONDS)

	sleep(3 SECONDS)

	unbuckle_all_mobs()
	var/turf/destination
	if(SSjob.latejoin_trackers.len)
		destination = pick(SSjob.latejoin_trackers)
		H.forceMove(destination)
		to_chat(H, span_warning("The Dragon's shadow envelops you completely, drawing your soul into an abyss... For a while. As you are whisked away elsewhere... changed. Your forehead itches from ancient magic."))

	var/list/bandits_to_benefit = list()
	for(var/mob/player in GLOB.player_list)
		if(player.mind && player.stat != DEAD) //You better be alive if you actually want your cut.
			if(player.mind.has_antag_datum(/datum/antagonist/bandit))
				bandits_to_benefit += player.mind.has_antag_datum(/datum/antagonist/bandit)
	if(isemptylist(bandits_to_benefit))
		to_chat(user, span_warning("Something is wrong."))
		subjugating = FALSE
		return
	playsound(loc,'sound/items/carvty.ogg', 50, TRUE)
	var/to_distribute = round(payout/bandits_to_benefit.len, 0.1)
	for(var/datum/antagonist/bandit/bandit_player in bandits_to_benefit)
		bandit_player.favor += to_distribute
		bandit_player.totaldonated += payout
		to_chat(bandit_player.owner, ("<font color='yellow'>A servant of Tyranny has been subjugated! Your reward is [to_distribute] favor and now have <b>[bandit_player.favor]</b> in total.</font>"))

	subjugating = FALSE

/obj/structure/roguemachine/hoardbarrier //Blocks sprite locations
	name = ""
	desc = "Formerly a covetous creature, this one now shares its Hoard with the Freefolk. Protecting the transactor's Hoard, and trading it for Favor."
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"
	density = TRUE
	anchored = TRUE
