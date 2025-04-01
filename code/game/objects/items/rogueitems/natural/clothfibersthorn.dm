/obj/item/natural/fibers
	name = "fibers"
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	desc = "Plant fibers. The peasants make their living making these into clothing."
	force = 0
	throwforce = 0
	color = "#534d3e"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/fibers

/obj/item/natural/fibers/attack_right(mob/user)
	if(user.get_active_held_item())
		return
	to_chat(user, span_warning("I start to collect [src]..."))
	if(move_after(user, bundling_time, target = src))
		var/fibercount = 0
		for(var/obj/item/natural/fibers/F in get_turf(src))
			fibercount++
		while(fibercount > 0)
			if(fibercount == 1)
				new /obj/item/natural/fibers(get_turf(user))
				fibercount--
			else if(fibercount >= 2)
				var/obj/item/natural/bundle/fibers/B = new(get_turf(user))
				B.amount = clamp(fibercount, 2, 6)
				B.update_bundle()
				fibercount -= clamp(fibercount, 2, 6)
				user.put_in_hands(B)
		for(var/obj/item/natural/fibers/F in get_turf(src))
			qdel(F)

/obj/item/natural/silk
	name = "silk"
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	desc = "Silken strands. Their usage in clothing is exotic in all places save the underdark"
	force = 0
	throwforce = 0
	color = "#e6e3db"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/silk

/obj/item/natural/silk/attack_right(mob/user)
	if(user.get_active_held_item())
		return
	to_chat(user, span_warning("I start to collect [src]..."))
	if(move_after(user, bundling_time, target = src))
		var/silkcount = 0
		for(var/obj/item/natural/silk/F in get_turf(src))
			silkcount++
		while(silkcount > 0)
			if(silkcount == 1)
				new /obj/item/natural/silk(get_turf(user))
				silkcount--
			else if(silkcount >= 2)
				var/obj/item/natural/bundle/silk/B = new(get_turf(user))
				B.amount = clamp(silkcount, 2, 6)
				B.update_bundle()
				silkcount -= clamp(silkcount, 2, 6)
				user.put_in_hands(B)
		for(var/obj/item/natural/silk/F in get_turf(src))
			qdel(F)

#ifdef TESTSERVER

/client/verb/bloodnda()
	set category = "DEBUGTEST"
	set name = "bloodnda"
	set desc = ""

	var/obj/item/I
	I = mob.get_active_held_item()
	if(I)
		if(I.return_blood_DNA())
			testing("yep")
		else
			testing("nope")

#endif

/obj/item/natural/cloth
	name = "cloth"
	icon_state = "cloth"
	possible_item_intents = list(/datum/intent/use)
	desc = "This piece of fabric is ready to be worked, or used."
	force = 0
	throwforce = 0
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_MASK
	body_parts_covered = null
	experimental_onhip = TRUE
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/cloth
	var/wet = 0
	/// Effectiveness when used as a bandage, how much bloodloss we can tampon
	var/bandage_effectiveness = 0.9

/obj/item/natural/cloth/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_WEAR_MASK)
		user.become_blind("blindfold_[REF(src)]")

/obj/item/natural/cloth/dropped(mob/living/carbon/human/user)
	..()
	user.cure_blind("blindfold_[REF(src)]")

/obj/item/natural/cloth/attack_right(mob/user)
	if(user.get_active_held_item())
		return
	to_chat(user, span_warning("I start to collect [src]..."))
	if(move_after(user, bundling_time, target = src))
		var/clothcount = 0
		for(var/obj/item/natural/cloth/F in get_turf(src))
			clothcount++
		while(clothcount > 0)
			if(clothcount == 1)
				new /obj/item/natural/cloth(get_turf(user))
				clothcount--
			else if(clothcount >= 2)
				var/obj/item/natural/bundle/cloth/B = new(get_turf(user))
				B.amount = clamp(clothcount, 2, 10)
				B.update_bundle()
				clothcount -= clamp(clothcount, 2, 10)
				user.put_in_hands(B)
		for(var/obj/item/natural/cloth/F in get_turf(src))
			playsound(user, "rustle", 70, FALSE, -4)
			qdel(F)

/obj/item/natural/cloth/examine(mob/user)
	. = ..()
	if(wet)
		. += span_notice("It's wet!")


/obj/item/natural/cloth/bandage //technically goes under cloth
	name = "bandage"
	desc = "A simple bandage used to bind wounds. takes longer to apply but is more effective than just cloth. Slowly heals wounds and binded fractures."
	icon_state = "bandageroll"
	icon = 'icons/roguetown/items/surgery.dmi'
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH | ITEM_SLOT_HIP
	body_parts_covered = null
	experimental_onhip = TRUE
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/cloth/bandage
	bandage_effectiveness = 1

/obj/item/natural/cloth/bandage/attack(mob/living/carbon/human/M, mob/user)
	if (!M.can_inject(user, TRUE)) return
	if (!ishuman(M)) return
	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if (!affecting) return
	if (affecting.bandage)
		to_chat(user, "There is already a bandage.")
		return
	var/used_time = 100
	if (H.mind)
		used_time -= (H.mind.get_skill_level(/datum/skill/misc/treatment) * 10)
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	if (!do_mob(user, M, used_time)) return
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	user.dropItemToGround(src)
	affecting.try_bandage(src)
	H.update_damage_overlays()

	// Heal the specific body part every second while bandaged and manage wound pain and disabling effects
	addtimer(CALLBACK(src, /proc/heal_and_manage_pain_disabling, H, affecting), 10, 1, TRUE)
	if (M == user)
		user.visible_message("You bandage your [affecting].")
	else
		user.visible_message("You bandage [M]'s [affecting].")

/proc/heal_and_manage_pain_disabling(var/mob/living/carbon/human/H, var/obj/item/bodypart/affecting)
	if (!affecting) return
	affecting.heal_wounds(0.5)
	for (var/datum/wound/W in affecting.wounds)
		if (W.woundpain > 30)
			W.woundpain = 30

/obj/item/natural/bundle/cloth/bandage 
	name = "roll of bandages"
	desc = "A bundle of bandages used to bind wounds. More effective than just cloth."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "bandageroll1"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	maxamount = 3
	firefuel = 15 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	stacktype = /obj/item/natural/cloth/bandage
	stackname = "bandages"
	icon1 = "bandageroll1"
	icon1step = 2
	icon2 = "bandageroll2"
	icon2step = 3



/obj/item/natural/bundle/cloth/bandage/full
	icon_state = "bandageroll2"
	amount = 3
	firefuel = 60 MINUTES

// CLEANING

/obj/item/natural/cloth/attack_obj(obj/O, mob/living/user)
	testing("attackobj")
	if(user.client && ((O in user.client.screen) && !user.is_holding(O)))
		to_chat(user, span_warning("I need to take that [O.name] off before cleaning it!"))
		return
	if(istype(O, /obj/effect/decal/cleanable))
		var/cleanme = TRUE
		if(istype(O, /obj/effect/decal/cleanable/blood))
			if(!wet)
				cleanme = FALSE
			add_blood_DNA(O.return_blood_DNA())
		if(prob(33 + (wet*10)) && cleanme)
			wet = max(wet-1, 0)
			qdel(O)
		to_chat(user, span_info("I wipe \the [O.name] with [src]."))
		playsound(user, "clothwipe", 100, TRUE)
	else
		if(prob(30 + (wet*10)))
			if(O.return_blood_DNA())
				add_blood_DNA(O.return_blood_DNA())
			for(var/obj/effect/decal/cleanable/C in O)
				qdel(C)
			if(!wet)
				SEND_SIGNAL(O, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
			else
				SEND_SIGNAL(O, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRONG)
			wet = max(wet-1, 0)
		to_chat(user, span_info("I wipe \the [O.name] with [src]."))
		playsound(user, "clothwipe", 100, TRUE)

/obj/item/natural/cloth/attack_turf(turf/T, mob/living/user)
	if(istype(T, /turf/open/water))
		return ..()
	if(wet)
		for(var/obj/effect/decal/cleanable/C in T)
			qdel(C)
		wet = max(wet-1, 0)

		to_chat(user, span_info("I wipe \the [T.name] with [src]."))
		playsound(user, "clothwipe", 100, TRUE)
	else
		to_chat(user, span_warning("\The [name] is dry!"))


// BANDAGING
/obj/item/natural/cloth/attack(mob/living/M, mob/user)
	testing("attack")
	bandage(M, user)

/obj/item/natural/cloth/wash_act()
	. = ..()
	wet = 5

/obj/item/natural/cloth/proc/bandage(mob/living/M, mob/user)
	if(!M.can_inject(user, TRUE))
		return
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(!affecting)
		return
	if(affecting.bandage)
		to_chat(user, span_warning("There is already a bandage."))
		return
	var/used_time = 70
	if(H.mind)
		used_time -= (H.mind.get_skill_level(/datum/skill/misc/treatment) * 10)
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	if(!do_mob(user, M, used_time))
		return
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)

	user.dropItemToGround(src)
	affecting.try_bandage(src)
	H.update_damage_overlays()

	if(M == user)
		user.visible_message(span_notice("[user] bandages [user.p_their()] [affecting]."), span_notice("I bandage my [affecting]."))
	else
		user.visible_message(span_notice("[user] bandages [M]'s [affecting]."), span_notice("I bandage [M]'s [affecting]."))

/obj/item/natural/thorn
	name = "thorn"
	icon_state = "thorn"
	desc = "This bog-grown thorn is sharp and resistant like a needle."
	force = 10
	throwforce = 0
	possible_item_intents = list(/datum/intent/stab)
	firefuel = 5 MINUTES
	embedding = list("embedded_unsafe_removal_time" = 20, "embedded_pain_chance" = 10, "embedded_pain_multiplier" = 1, "embed_chance" = 35, "embedded_fall_chance" = 0)
	resistance_flags = FLAMMABLE
	max_integrity = 20
/obj/item/natural/thorn/attack_self(mob/living/user)
	user.visible_message(span_warning("[user] snaps [src]."))
	playsound(user,'sound/items/seedextract.ogg', 100, FALSE)
	qdel(src)

/obj/item/natural/thorn/Crossed(mob/living/L)
	. = ..()
	if(istype(L))
		var/prob2break = 33
		if(L.m_intent == MOVE_INTENT_SNEAK)
			prob2break = 0
		if(L.m_intent == MOVE_INTENT_RUN)
			prob2break = 100
		if(prob(prob2break))
			playsound(src,'sound/items/seedextract.ogg', 100, FALSE)
			qdel(src)
			if (L.alpha == 0 && L.rogue_sneaking) // not anymore you're not
				L.update_sneak_invis(TRUE)
			L.consider_ambush()

/obj/item/natural/bundle/fibers
	name = "fiber bundle"
	icon_state = "fibersroll1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Fibers, bundled together."
	force = 0
	throwforce = 0
	maxamount = 6
	color = "#534d3e"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/fibers
	icon1step = 3
	icon2step = 6

/obj/item/natural/bundle/fibers/full
	icon_state = "fibersroll2"
	amount = 6
	firefuel = 30 MINUTES

/obj/item/natural/bundle/silk
	name = "silken weave"
	icon_state = "fibersroll1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Silk neatly woven together."
	force = 0
	throwforce = 0
	maxamount = 6
	color = "#e6e3db"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/silk
	icon1step = 3
	icon2step = 6

/obj/item/natural/bundle/cloth
	name = "bundle of cloth"
	icon_state = "clothroll1"
	possible_item_intents = list(/datum/intent/use)
	desc = "A cloth roll of several pieces of fabric."
	force = 0
	throwforce = 0
	maxamount = 10
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/cloth
	stackname = "cloth"
	icon1 = "clothroll1"
	icon1step = 5
	icon2 = "clothroll2"
	icon2step = 10

/obj/item/natural/bundle/stick
	name = "bundle of sticks"
	icon_state = "stickbundle1"
	item_state = "stickbundle"
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	possible_item_intents = list(/datum/intent/use)
	desc = "Stick alone.. Weak. Stick together.. Strong."
	maxamount = 6
	force = 0
	throwforce = 0
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/grown/log/tree/stick
	stackname = "sticks"
	icon1 = "stickbundle1"
	icon1step = 4
	icon2 = "stickbundle2"
	icon2step = 6
	icon3 = "stickbundle3"

/obj/item/natural/bundle/stick/attackby(obj/item/W, mob/living/user)
	. = ..()
	user.changeNext_move(CLICK_CD_MELEE)
	if(user.used_intent?.blade_class == BCLASS_CUT)
		playsound(get_turf(src.loc), 'sound/items/wood_sharpen.ogg', 100)
		user.visible_message(span_info("[user] starts sharpening the sticks in [src]..."), span_info("I start sharpening the sticks in [src]...."))
		for(var/i in 1 to (amount - 1))
			if(!do_after(user, 20))
				break
			var/turf/T = get_turf(user.loc)
			var/obj/item/grown/log/tree/stake/S = new /obj/item/grown/log/tree/stake(T)
			amount--
			// If there's only one stick left in the bundle...
			if (amount == 1)
				// Replace the bundle with a single stick
				var/obj/item/ST = new stacktype(T)
				if(user.is_holding(src))
					user.doUnEquip(src, TRUE, T, silent = TRUE)
				qdel(src)
				var/holding = user.put_in_hands(ST)
				// And automatically have us try and carve the last new stick, assuming we're still holding it!
				if(!do_after(user, 20))
					break
				S = new /obj/item/grown/log/tree/stake(T)
				if(holding)
					user.doUnEquip(ST, TRUE, T, silent = TRUE)
				qdel(ST)
			else
				update_bundle()
			user.put_in_hands(S)
			S.pixel_x = rand(-3, 3)
			S.pixel_y = rand(-3, 3)
		return

/obj/item/natural/bowstring
	name = "fibre bowstring"
	desc = "A simple cord of bowstring."
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	color = COLOR_BEIGE
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE

/obj/item/natural/bundle/worms
	name = "worms"
	desc = "Multiple wriggly worms."
	color = "#964B00"
	maxamount = 12
	icon_state = "worm2"
	icon1 = "worm2"
	icon1step = 4
	icon2 = "worm4"
	icon2step = 6
	icon3 = "worm6"
	stacktype = /obj/item/natural/worms
	stackname = "worms"

/obj/item/natural/worms/attack_right(mob/user)
	if(user.get_active_held_item())
		return
	to_chat(user, span_warning("I start to collect [src]..."))
	if(move_after(user, bundling_time, target = src))
		var/wormcount = 0
		for(var/obj/item/natural/worms/F in get_turf(src))
			wormcount++
		while(wormcount > 0)
			if(wormcount == 1)
				new /obj/item/natural/worms(user.drop_location())
				wormcount--
			else if(wormcount >= 2)
				var/obj/item/natural/bundle/worms/B = new(user.drop_location())
				B.amount = clamp(wormcount, 2, 12)
				B.update_bundle()
				wormcount -= clamp(wormcount, 2, 12)
				user.put_in_hands(B)
		for(var/obj/item/natural/worms/F in get_turf(src))
			qdel(F)


