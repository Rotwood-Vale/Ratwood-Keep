/obj/item/gun/ballistic/revolver/grenadelauncher/runelock
	name = "runelock pistol"
	desc = "An incredibly deadly weapon, inscribed with runes to render it powderless. All it requires is compatible projectiles."
	icon = 'icons/roguetown/weapons/32.dmi'
	icon_state = "pistol2"
	item_state = "pistol2"
	possible_item_intents = list(/datum/intent/shoot/runelock, /datum/intent/arc/runelock, INTENT_GENERIC)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/musket
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_BULKY
	randomspread = 1
	spread = 0
	can_parry = FALSE
	pin = /obj/item/firing_pin
	force = 10
	var/cocked = FALSE
	cartridge_wording = "rune ball"
	load_sound = 'sound/foley/musketload.ogg'
	fire_sound = 'sound/combat/Ranged/musketfire.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	var/damfactor = 5

/obj/item/gun/ballistic/revolver/grenadelauncher/runelock/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 9,"ny" = -6,"wx" = -6,"wy" = -4,"ex" = 4,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 90,"wturn" = 93,"eturn" = -12,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/gun/ballistic/revolver/grenadelauncher/runelock/shoot_with_empty_chamber()
	if(cocked)
		playsound(src.loc, 'sound/foley/musketcock.ogg', 100, FALSE)
		cocked = FALSE
		icon_state = initial(icon_state)
		update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/runelock/attack_self(mob/living/user)
	if(chambered)
		..()
	else
		if(!cocked)
			to_chat(user, span_info("I ready the runelock to be fired..."))
			if(do_after(user, 100 - user.STASTR, target = user))
				playsound(user, 'sound/foley/musketcock.ogg', 100, FALSE)
				cocked = TRUE
				icon_state = "[icon_state]-1"
		else
			to_chat(user, span_warning("I carefully de-cock the runelock."))
			cocked = FALSE
			icon_state = initial(icon_state)
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/runelock/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		if(cocked)
			if((loc == user) && (user.get_inactive_held_item() != src))
				return
			..()
		else
			to_chat(user, span_warning("I need to cock the runelock first!"))

/obj/item/gun/ballistic/revolver/grenadelauncher/runelock/process_fire/(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(user.client)
		shake_camera(user, 15, 1)
		if(user.client.chargedprog >= 100)
			spread = 100
		else
			spread = 100 - (150 * (user.client.chargedprog / 50))
	else
		spread = 0
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		var/obj/projectile/BB = CB.BB
		BB.damage = BB.damage * damfactor
	cocked = FALSE
	icon_state = initial(icon_state)
	..()

/obj/item/ammo_box/magazine/internal/shot/musket
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet
	caliber = "musketball"
	max_ammo = 1
	start_empty = TRUE

//datums

/datum/intent/shoot/runelock
	chargedrain = 0 //no drain to aim a crossbow

/datum/intent/shoot/runelock/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 18
		//per block
		newtime = newtime + 20
		newtime = newtime - (mastermob.STAPER)
		if(newtime > 0)
			return newtime
		else
			return 0.1
	return chargetime

/datum/intent/arc/runelock
	chargetime = 1
	chargedrain = 0 //no drain to aim a crossbow

/datum/intent/arc/runelock/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 18
		newtime = newtime - (mastermob.mind.get_skill_level(/datum/skill/combat/crossbows) * 3)
		//per block
		newtime = newtime + 20
		newtime = newtime - (mastermob.STAPER)
		if(newtime > 0)
			return newtime
		else
			return 1
	return chargetime
