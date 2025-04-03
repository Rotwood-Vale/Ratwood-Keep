//................	Hammers	............... //
/obj/item/rogueweapon/hammer	// The template
	force = 21
	possible_item_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash)
	name = "not a hammer"
	desc = "Just a template. Report to devs."
	icon = 'icons/roguetown/weapons/tools.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	experimental_onback = FALSE
	sharpness = IS_BLUNT
	var/quality = 1
	//dropshrink = 0.8
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_NORMAL
	associated_skill = /datum/skill/combat/maces
	smeltresult = /obj/item/ash

/obj/item/rogueweapon/hammer/attack_obj(obj/attacked_object, mob/living/user)
	if(!isliving(user) || !user.mind)
		return
	var/datum/mind/blacksmith_mind = user.mind
	var/repair_percent = 0.025 // 2.5% Repairing per hammer smack
	/// Repairing is MUCH better with an anvil!
	if(locate(/obj/machinery/anvil) in attacked_object.loc)
		repair_percent *= 2 // Double the repair amount if we're using an anvil
	var/exp_gained = 0

	if(isbodypart(attacked_object) && !user.cmode)
		var/obj/item/bodypart/attacked_prosthetic = attacked_object
		var/total_damage = attacked_prosthetic.brute_dam + attacked_prosthetic.burn_dam
		if(!attacked_prosthetic.anvilrepair || !isturf(attacked_prosthetic.loc))
			return
		if((total_damage <= 0) && (attacked_prosthetic.obj_integrity >= attacked_prosthetic.max_integrity))
			return

		if(blacksmith_mind.get_skill_level(attacked_prosthetic.anvilrepair) <= 0)
			if(prob(30))
				repair_percent = 0.01
			else
				repair_percent = 0
		else
			repair_percent *= blacksmith_mind.get_skill_level(attacked_prosthetic.anvilrepair)

		playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
		if(repair_percent)
			repair_percent *= attacked_prosthetic.max_damage
			exp_gained = min(total_damage + repair_percent, attacked_prosthetic.max_damage) - total_damage
			attacked_prosthetic.brute_dam = max(attacked_prosthetic.brute_dam - repair_percent, 0)
			attacked_prosthetic.burn_dam = max(attacked_prosthetic.burn_dam - repair_percent, 0)
			total_damage = attacked_prosthetic.brute_dam + attacked_prosthetic.burn_dam
			attacked_prosthetic.obj_integrity = min(attacked_prosthetic.obj_integrity + repair_percent, attacked_prosthetic.max_integrity)
			if(repair_percent == 0.01) // If an inexperienced repair attempt has been successful
				to_chat(user, span_warning("You fumble your way into slightly repairing [attacked_prosthetic]."))
			else
				user.visible_message(span_info("[user] repairs [attacked_prosthetic]!"))
			blacksmith_mind.add_sleep_experience(attacked_prosthetic.anvilrepair, exp_gained/3) //We gain as much exp as we fix divided by 3
			return
		else
			user.visible_message(span_warning("[user] damages [attacked_prosthetic]!"))
			attacked_prosthetic.take_damage(attacked_prosthetic.max_integrity * 0.1, BRUTE, "blunt")
			attacked_prosthetic.brute_dam = (attacked_prosthetic.brute_dam + 0.1 * attacked_prosthetic.max_damage)
			return

	if(isitem(attacked_object) && !user.cmode)
		var/obj/item/attacked_item = attacked_object
		if(attacked_item.obj_integrity >= 0)
			if(!attacked_item.anvilrepair || (attacked_item.obj_integrity >= attacked_item.max_integrity) || !isturf(attacked_item.loc))
				return
		if(attacked_item.obj_integrity <= 0)
			if(blacksmith_mind.get_skill_level(attacked_item.anvilrepair) >= 4)
				if(attacked_item.obj_broken && istype(attacked_item, /obj/item/clothing))
					var/obj/item/clothing/clothing = attacked_item
					clothing.obj_fix()
			else
				user.visible_message(span_warning("[attacked_item] is broken! I am not skilled enough to fix it..."))
				return





		if(blacksmith_mind.get_skill_level(attacked_item.anvilrepair) <= 0)
			if(prob(30))
				repair_percent = 0.01
			else
				repair_percent = 0
		else
			repair_percent *= blacksmith_mind.get_skill_level(attacked_item.anvilrepair)

		playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
		if(repair_percent)
			repair_percent *= attacked_item.max_integrity
			exp_gained = min(attacked_item.obj_integrity + repair_percent, attacked_item.max_integrity) - attacked_item.obj_integrity
			attacked_item.obj_integrity = min(attacked_item.obj_integrity + repair_percent, attacked_item.max_integrity)
			if(repair_percent == 0.01) // If an inexperienced repair attempt has been successful
				to_chat(user, span_warning("You fumble your way into slightly repairing [attacked_item]."))
			else
				user.visible_message(span_info("[user] repairs [attacked_item]!"))
			blacksmith_mind.add_sleep_experience(attacked_item.anvilrepair, exp_gained/3) //We gain as much exp as we fix divided by 3
			return
		else
			user.visible_message(span_warning("[user] damages [attacked_item]!"))
			attacked_item.take_damage(attacked_item.max_integrity * 0.1, BRUTE, "blunt")
			return

	if(isstructure(attacked_object) && !user.cmode)
		var/obj/structure/attacked_structure = attacked_object
		if(!attacked_structure.hammer_repair || !attacked_structure.max_integrity)
			return
		if(blacksmith_mind.get_skill_level(attacked_structure.hammer_repair) <= 0)
			to_chat(user, span_warning("I don't know how to repair this.."))
			return
		repair_percent *= blacksmith_mind.get_skill_level(attacked_structure.hammer_repair) * attacked_structure.max_integrity
		exp_gained = min(attacked_structure.obj_integrity + repair_percent, attacked_structure.max_integrity) - attacked_structure.obj_integrity
		attacked_structure.obj_integrity = min(attacked_structure.obj_integrity + repair_percent, attacked_structure.max_integrity)
		blacksmith_mind.add_sleep_experience(attacked_structure.hammer_repair, exp_gained/1.5) //We gain as much exp as we fix
		playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
		user.visible_message(span_info("[user] repairs [attacked_structure]!"))
		return

	. = ..()

/obj/item/rogueweapon/hammer/iron	// iron hammer
	name = "hammer"
	desc = "Each strikes reverberate loudly chanting war!"
	icon_state = "hammer_i"
	item_state = "hammer_i"
	smeltresult = /obj/item/ingot/iron

/obj/item/rogueweapon/hammer/steel	// steel hammer
	name = "claw hammer"
	desc = "Steel to drive the iron nail without mercy."
	icon_state = "hammer_s"
	item_state = "hammer_s"
	smeltresult = /obj/item/ingot/steel

/*
/obj/item/rogueweapon/hammer/steel/attack_turf(turf/T, mob/living/user)
	if(!user.cmode)
		if(T.hammer_repair && T.max_integrity && !T.obj_broken)
			var/repair_percent = 0.05
			if(user.mind)
				if(user.mind.get_skill_level(I.hammer_repair) <= 0)
					to_chat(user, span_warning("I don't know how to repair this.."))
					return
				repair_percent = max(user.mind.get_skill_level(I.hammer_repair) * 0.05, 0.05)
			repair_percent = repair_percent * I.max_integrity
			I.obj_integrity = min(obj_integrity+repair_percent, I.max_integrity)
			playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
			user.visible_message(span_info("[user] repairs [I]!"))
			return
	..()
*/
/obj/item/rogueweapon/hammer/blacksteel
	force = 25
	name = "blacksteel hammer"
	desc = "BlackSteel to drive even the hardest metal into submission."
	icon = 'icons/roguetown/weapons/tools.dmi'
	icon_state = "bs_masterhammer"
	item_state = "bs_masterhammer"
	quality = 2
	smeltresult = /obj/item/ingot/blacksteel

/obj/item/rogueweapon/hammer/wood
	name = "wooden mallet"
	desc = "A wooden mallet is an artificers second best friend! But it may also come in handy to a smith..."
	icon_state = "hammer_w"
	item_state = "hammer_w"
	force = 16
	metalizer_result = /obj/item/rogueweapon/hammer/iron

//................	Tongs	............... //
/obj/item/rogueweapon/tongs
	force = 10
	possible_item_intents = list(/datum/intent/mace/strike)
	name = "tongs"
	desc = "A pair of iron jaws used to carry hot ingots."
	icon_state = "tongs"
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	associated_skill = null
	var/obj/item/ingot/hingot = null
	var/hott = FALSE
	smeltresult = /obj/item/ingot/iron

/obj/item/rogueweapon/tongs/examine(mob/user)
	. = ..()
	if(hott)
		. += span_warning("The tip is hot to the touch.")

/obj/item/rogueweapon/tongs/get_temperature()
	if(hott)
		return 150+T0C
	return ..()

/obj/item/rogueweapon/tongs/fire_act(added, maxstacks)
	. = ..()
	hott = world.time
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(make_unhot), world.time), 10 SECONDS)

/obj/item/rogueweapon/tongs/update_icon()
	. = ..()
	if(!hingot)
		icon_state = "[initial(icon_state)]"
	else
		if(hott)
			icon_state = "[initial(icon_state)]i1"
		else
			icon_state = "[initial(icon_state)]i0"

/obj/item/rogueweapon/tongs/proc/make_unhot(input)
	if(hott == input)
		hott = FALSE

/obj/item/rogueweapon/tongs/attack_self(mob/user)
	if(hingot)
		if(isturf(user.loc))
			hingot.forceMove(get_turf(user))
			hingot = null
			hott = FALSE
			update_icon()

/obj/item/rogueweapon/tongs/dropped()
	. = ..()
	if(hingot)
		hingot.forceMove(get_turf(src))
		hingot = null
	hott = FALSE
	update_icon()

/obj/item/rogueweapon/tongs/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,
"sx" = -15,
"sy" = -12,
"nx" = 9,
"ny" = -11,
"wx" = -11,
"wy" = -11,
"ex" = 1,
"ey" = -12,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 90,
"sturn" = -90,
"wturn" = -90,
"eturn" = 90,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/tongs/blacksteel
	name = "blacksteel tongs"
	desc = "A pair of blacksteel jaws almost certainly used as a sign of prestige."
	icon_state = "bs_tongs"
	wdefense = 2
	icon = 'icons/roguetown/weapons/tools.dmi'
	smeltresult = /obj/item/ingot/blacksteel
