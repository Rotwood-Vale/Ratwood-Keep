/obj/item/gun/ballistic/arquebus_pistol
	name = "arquebus pistol"
	desc = "A small gunpowder weapon that shoots an armor piercing metal ball. While it has the same power as a regular handgonne, it is balanced to be used accurately in a single hand."
	icon = 'icons/roguetown/weapons/32.dmi'
	icon_state = "pistol"
	item_state = "pistol"
	force = 10
	possible_item_intents = list(/datum/intent/shoot/arquebus_pistol, /datum/intent/arc/arquebus_pistol, /datum/intent/mace/strike/wood)
	internal_magazine = TRUE
	mag_type = /obj/item/ammo_box/magazine/internal/arquebus
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	randomspread = 1
	spread = 0
	can_parry = TRUE
	pin = /obj/item/firing_pin
	minstr = 6
	walking_stick = FALSE
	cartridge_wording = "lead ball"
	load_sound = 'sound/foley/musketload.ogg'
	fire_sound = "sound/arquebus/arquefire.ogg"
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	bolt_type = BOLT_TYPE_NO_BOLT
	casing_ejector = FALSE
	//pickup_sound = 'sound/sheath_sounds/draw_from_holster.ogg'
	//sheathe_sound = 'sound/sheath_sounds/put_back_to_holster.ogg'
	slot_flags = ITEM_SLOT_HIP
	damfactor = 2
	var/reloaded = FALSE
	var/load_time = 50
	var/gunpowder = FALSE
	var/obj/item/ramrod/myrod = null
	var/spread_num = 10

/obj/item/gun/ballistic/arquebus_pistol/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 30,"sturn" = -30,"wturn" = -30,"eturn" = 30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/datum/intent/shoot/arquebus_pistol
	chargedrain = 0

/datum/intent/shoot/arquebus_pistol/can_charge()
	if(mastermob)
		return TRUE

/datum/intent/arc/arquebus_pistol
	chargedrain = 0

/datum/intent/arc/arquebus_pistol/can_charge()
	if(mastermob)
		return TRUE

/obj/item/gun/ballistic/arquebus_pistol/Initialize()
	. = ..()
	myrod = new /obj/item/ramrod(src)


/obj/item/gun/ballistic/arquebus_pistol/shoot_live_shot(mob/living/user as mob|obj, pointblank = 0, mob/pbtarget = null, message = 1)
	fire_sound = pick("sound/arquebus/arquefire.ogg", "sound/arquebus/arquefire2.ogg", "sound/arquebus/arquefire3.ogg",
				"sound/arquebus/arquefire4.ogg", "sound/arquebus/arquefire5.ogg")
	. = ..()

/obj/item/gun/ballistic/arquebus_pistol/attack_right(mob/user)
	if(user.get_active_held_item())
		return
	else
		if(myrod)
			playsound(src, "sound/items/sharpen_short1.ogg",  100)
			to_chat(user, span_warning("I draw the ramrod from the [src]!"))
			var/obj/item/ramrod/AM
			for(AM in src)
				user.put_in_hands(AM)
				myrod = null
		else
			to_chat(user, span_warning("There is no rod stowed in the [src]!"))


/obj/item/gun/ballistic/arquebus_pistol/shoot_with_empty_chamber()
	playsound(src.loc, 'sound/foley/musketcock.ogg', 100, FALSE)
	update_icon()

/obj/item/gun/ballistic/arquebus_pistol/attackby(obj/item/A, mob/user, params)

	var/firearm_skill = (user?.mind ? user.mind.get_skill_level(/datum/skill/combat/firearms) : 1)
	var/load_time_skill = load_time - (firearm_skill*2)
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		if(chambered)
			to_chat(user, span_warning("There is already a [chambered] in the [src]!"))
			return
		if(!gunpowder)
			to_chat(user, span_warning("You must fill the [src] with gunpowder first!"))
			return
		if((loc == user) && (user.get_inactive_held_item() != src))
			return
		playsound(src, "sound/arquebus/insert.ogg",  100)
		user.visible_message(span_notice("[user] forces a [A] down the barrel of the [src]."))
		..()

	if(istype(A, /obj/item/powderflask))
		if(gunpowder)
			user.visible_message(span_notice("The [src] is already filled with gunpowder!"))
			return
		else
			playsound(src, "sound/arquebus/pour_powder.ogg",  100)
			if(do_after(user, load_time_skill, src))
				user.visible_message(span_notice("[user] fills the [src] with gunpowder."))
				gunpowder = TRUE
			return
	if(istype(A, /obj/item/ramrod))
		var/obj/item/ramrod/R=A
		if(!reloaded)
			if(chambered)
				user.visible_message(span_notice("[user] begins ramming the [R.name] down the barrel of the [src] ."))
				playsound(src, "sound/arquebus/ramrod.ogg",  100)
				if(do_after(user, load_time_skill, src))
					user.visible_message(span_notice("[user] has finished reloading the [src]."))
					reloaded = TRUE
				return
		if(reloaded && !myrod)
			user.transferItemToLoc(R, src)
			myrod = R
			playsound(src, "sound/foley/musketload.ogg",  100)
			user.visible_message(span_notice("[user] stows the [R.name] under the barrel of the [src]."))
		if(!chambered && !myrod)
			user.transferItemToLoc(R, src)
			myrod = R
			playsound(src, "sound/foley/musketload.ogg",  100)
			user.visible_message(span_notice("[user] stows the [R.name] under the barrel of the [src] without chambering it."))
		if(!myrod == null)
			to_chat(user, span_warning("There's already a [R.name] inside of the [name]."))
			return


/obj/item/gun/ballistic/arquebus_pistol/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)

	var/accident_chance = 0
	var/firearm_skill = (user?.mind ? user.mind.get_skill_level(/datum/skill/combat/firearms) : 1)
	var/turf/knockback = get_ranged_target_turf(user, turn(user.dir, 180), rand(1,2))
	spread = (spread_num - firearm_skill)
	if(firearm_skill < 1)
		accident_chance =80

	if(firearm_skill < 2)
		accident_chance =50
	if(firearm_skill >= 2 && firearm_skill <= 5)
		accident_chance =10
	if(firearm_skill >= 5)
		accident_chance =0
	if(user.client)
		if(user.client.chargedprog >= 100)
			spread = 0
			//adjust_experience(user, /datum/skill/combat/crossbows, user.STAINT * 4)
		else
			spread = 150 - (150 * (user.client.chargedprog / 100))
	else
		spread = 0
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		var/obj/projectile/BB = CB.BB
		BB.damage = BB.damage * damfactor
		if(HAS_TRAIT(user, TRAIT_TINY))
			BB.damage = (BB.damage * 0.3)
	gunpowder = FALSE
	reloaded = FALSE
	spark_act()

	..()
	spawn (5)
		new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 1))
	spawn (10)
		new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 2))
	spawn (16)
		new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 1))
	for(var/mob/M in range(5, user))
		if(!M.stat)
			shake_camera(M, 3, 1)


	if(prob(accident_chance))
		user.flash_fullscreen("whiteflash")
		user.apply_damage(rand(5,15), BURN, pick(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_NOSE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND))
		user.visible_message(span_danger("[user] accidentally burnt themselves while firing the [src]."))
		user.emote("painscream")
		if(prob(60))
			user.dropItemToGround(src)
			user.Knockdown(rand(15,30))
			user.Immobilize(30)
	if(prob(accident_chance))
		user.visible_message(span_danger("[user] is knocked back by the recoil!"))
		user.throw_at(knockback, rand(1,2), 7)
		if(prob(accident_chance))
			user.dropItemToGround(src)
			user.Knockdown(rand(15,30))
			user.Immobilize(30)

/obj/item/gun/ballistic/arquebus_pistol/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()

/obj/item/gun/ballistic/arquebus_pistol/can_shoot()
	if (!reloaded)
		return FALSE
	return ..()
