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


/*The modification code for hammers
- Call it from other objects with right click
- Currently opens to allow naming
- Will expand eventually.
*/
/obj/item/rogueweapon/hammer/proc/modify_item(obj/item/I, mob/living/user)
	if(I == null)
		return

	//Must be at full health.
	if(I.obj_integrity < I.max_integrity)
		return
	var/choices = list("name item")
	var/action =input(user, "CHOOSE ACTION") as null|anything in choices
	if(pick(action) == "name item")
		var/t = ""
		t = stripped_input(user,"Name this item.", ,"", 40) // So you can make a funny long title but not too insane

		if(!reject_bad_name(t))
			to_chat(user, span_notice("You need to name it properly!"))
			return

		log_admin("[user]([user.ckey]) just named [I]: [t]")
		message_admins("[key_name_admin(user)] just named [I]: [t]")
		I.name = "[t] ([initial(I.name)])"
		playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
		user.say("I dub thee [t]!")
		return


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
			attacked_prosthetic.mend_damage(repair_percent, FALSE)
			if(repair_percent == 0.01) // If an inexperienced repair attempt has been successful
				to_chat(user, span_warning("You fumble your way into slightly repairing [attacked_prosthetic]."))
			else
				user.visible_message(span_info("[user] repairs [attacked_prosthetic]!"))
			blacksmith_mind.add_sleep_experience(attacked_prosthetic.anvilrepair, exp_gained/3) //We gain as much exp as we fix divided by 3
			if(do_after(user, CLICK_CD_MELEE, target = attacked_object))
				attack_obj(attacked_object, user)
			return
		else
			user.visible_message(span_warning("[user] damages [attacked_prosthetic]!"))
			attacked_prosthetic.take_damage(attacked_prosthetic.max_integrity * 0.1, BRUTE, "blunt")
			attacked_prosthetic.brute_dam = (attacked_prosthetic.brute_dam + 0.1 * attacked_prosthetic.max_damage)
			return

	if(isitem(attacked_object) && !user.cmode)
		var/obj/item/attacked_item = attacked_object
		if(!attacked_item.anvilrepair || (attacked_item.obj_integrity >= attacked_item.max_integrity) || !isturf(attacked_item.loc))
			return

		if(!attacked_item.ontable())
			to_chat(user, span_warning("I should put this on a table or an anvil first."))
			return
			

		if(blacksmith_mind.get_skill_level(attacked_item.anvilrepair) <= SKILL_LEVEL_NONE)
			if(prob(30))
				repair_percent = 0.01
			else
				repair_percent = 0
		else
			repair_percent *= blacksmith_mind.get_skill_level(attacked_item.anvilrepair)

		playsound(src,'sound/items/bsmithfail.ogg', 40, FALSE)
		if(repair_percent)
			repair_percent *= attacked_item.max_integrity
			exp_gained = min(attacked_item.obj_integrity + repair_percent, attacked_item.max_integrity) - attacked_item.obj_integrity
			attacked_item.mend_damage(repair_percent, FALSE)
			if(repair_percent == 0.01) // If an inexperienced repair attempt has been successful
				to_chat(user, span_warning("You fumble your way into slightly repairing [attacked_item]."))
			else
				user.visible_message(span_info("[user] repairs [attacked_item]!"))
			if(attacked_item.obj_broken && attacked_item.obj_integrity == attacked_item.max_integrity)
				attacked_item.obj_fix()
			blacksmith_mind.add_sleep_experience(attacked_item.anvilrepair, exp_gained/2) //We gain as much exp as we fix divided by 2
			if(do_after(user, CLICK_CD_MELEE, target = attacked_object))
				attack_obj(attacked_object, user)
			return
		else
			user.visible_message(span_warning("[user] fumbles trying to repair [attacked_item]!"))
			attacked_item.obj_integrity = max(0, attacked_item.obj_integrity - (10 - repair_percent))
			return


	if(isstructure(attacked_object) && !user.cmode)
		var/obj/structure/attacked_structure = attacked_object
		if(!attacked_structure.hammer_repair || !attacked_structure.max_integrity)
			return
		if(blacksmith_mind.get_skill_level(attacked_structure.hammer_repair) <= SKILL_LEVEL_NONE)
			to_chat(user, span_warning("I don't know how to repair this.."))
			return
		repair_percent *= blacksmith_mind.get_skill_level(attacked_structure.hammer_repair) * attacked_structure.max_integrity
		exp_gained = min(attacked_structure.obj_integrity + repair_percent, attacked_structure.max_integrity) - attacked_structure.obj_integrity
		attacked_structure.mend_damage(repair_percent, TRUE)
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
	var/heat_time = 5 SECONDS
	smeltresult = /obj/item/ingot/iron

/obj/item/rogueweapon/tongs/examine(mob/user)
	. = ..()
	if(hott)
		. += span_warning("The tip is hot to the touch.")

/obj/item/rogueweapon/tongs/get_temperature()
	if(hott)
		return 150+T0C
	return ..()

/obj/item/rogueweapon/tongs/proc/has_ingot()
	if(locate(/obj/item/ingot) in src)
		return TRUE
	return FALSE

/obj/item/rogueweapon/tongs/proc/get_ingot()
	if(has_ingot())
		return locate(/obj/item/ingot) in src

/obj/item/rogueweapon/tongs/fire_act(added, maxstacks)
	. = ..()
	hott = world.time
	make_hot(heat_time)

/obj/item/rogueweapon/tongs/update_icon()
	if(length(contents))
		icon_state = "[initial(icon_state)]i0"
		var/obj/item/ingot/I = get_ingot()
		if(I)
			if(I.ishot)
				icon_state = "[initial(icon_state)]i1"
	else
		icon_state = "[initial(icon_state)]"
	. = ..()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_hands()


/obj/item/rogueweapon/tongs/proc/make_hot(heating)
	var/obj/item/ingot/I = get_ingot()
	if(!I)
		return
	var/time_to_heat = heat_time + heating
	I.heat(time_to_heat)
	update_icon()

/obj/item/rogueweapon/tongs/attack_self(mob/user)
	if(length(contents))
		var/obj/item/I = contents[1]
		I.forceMove(get_turf(user))
		playsound(get_turf(src), 'sound/foley/dropsound/gen_drop.ogg', 60)
		update_icon()

/obj/item/rogueweapon/tongs/dropped()
	. = ..()
	for(var/obj/item/I in contents)
		I.forceMove(get_turf(src))
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
	heat_time = 10 SECONDS