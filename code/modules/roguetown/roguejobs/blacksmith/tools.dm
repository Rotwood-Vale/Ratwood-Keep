
/obj/item/rogueweapon/hammer
	force = 21
	possible_item_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash)
	name = "hammer"
	desc = "Each strikes reverberate loudly chanting war!"
	icon_state = "hammer"
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_NORMAL
	associated_skill = /datum/skill/combat/maces
	smeltresult = /obj/item/ingot/iron

/obj/item/rogueweapon/hammer/attack_obj(obj/attacked_object, mob/living/user)
	if(!isliving(user) || !user.mind)
		return
	var/datum/mind/blacksmith_mind = user.mind
	var/repair_percent = 0.025 // 2.5% Repairing per hammer smack
	/// Repairing is MUCH better with an anvil!
	if(locate(/obj/machinery/anvil) in attacked_object.loc)
		repair_percent *= 2 // Double the repair amount if we're using an anvil
	var/exp_gained = 0
	if(isitem(attacked_object) && !user.cmode)
		var/obj/item/attacked_item = attacked_object
		if(!attacked_item.anvilrepair || (attacked_item.obj_integrity >= attacked_item.max_integrity) || !isturf(attacked_item.loc))
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
				if(attacked_item.obj_broken == TRUE)
					attacked_item.obj_broken = FALSE
			blacksmith_mind.adjust_experience(attacked_item.anvilrepair, exp_gained/2) //We gain as much exp as we fix divided by 2
			return
		else
			user.visible_message(span_warning("[user] damages [attacked_item]!"))
			attacked_item.take_damage(5, BRUTE, "blunt")
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
		blacksmith_mind.adjust_experience(attacked_structure.hammer_repair, exp_gained) //We gain as much exp as we fix
		playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
		user.visible_message(span_info("[user] repairs [attacked_structure]!"))
		return

	. = ..()

/obj/item/rogueweapon/hammer/stone
	name = "stone hammer"
	icon_state = "stonehammer"
	force = 16
	smeltresult = null
	max_integrity = 15

/obj/item/rogueweapon/hammer/claw
	icon_state = "clawh"

/*
/obj/item/rogueweapon/hammer/claw/attack_turf(turf/T, mob/living/user)
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

/obj/item/rogueweapon/hammer/getonmobprop(tag)
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
		return FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	return ..()

/obj/item/rogueweapon/tongs/fire_act(added, maxstacks)
	. = ..()
	hott = world.time
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(make_unhot), world.time), 10 SECONDS)

/obj/item/rogueweapon/tongs/update_icon()
	. = ..()
	if(!hingot)
		icon_state = "tongs"
	else
		if(hott)
			icon_state = "tongsi1"
		else
			icon_state = "tongsi0"

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

/obj/item/rogueweapon/tongs/stone
	name = "stone tongs"
	icon_state = "stonetongs"
	force = 5
	smeltresult = null
	max_integrity = 15

/obj/item/rogueweapon/tongs/stone/update_icon()
	. = ..()
	if(!hingot)
		icon_state = "stonetongs"
	else
		if(hott)
			icon_state = "stonetongsi1"
		else
			icon_state = "stonetongsi0"
