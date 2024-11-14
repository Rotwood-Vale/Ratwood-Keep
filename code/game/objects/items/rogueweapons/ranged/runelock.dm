/obj/item/gun/ballistic/revolver/grenadelauncher/runelock
	name = "runelock pistol"
	desc = "An incredibly deadly weapon, inscribed with runes to render it powderless. All it requires is compatible projectiles."
	icon = 'icons/roguetown/weapons/32.dmi'
	icon_state = "pistol2"
	var/icon_state_ready = "pistol2-1"
	item_state = "pistol2"
	possible_item_intents = list(/datum/intent/shoot/runelock, /datum/intent/arc/runelock, INTENT_GENERIC)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/runelock
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_BULKY
	spread = 10
	recoil = 3
	associated_skill = /datum/skill/craft/hunting
	pin = /obj/item/firing_pin
	force = 10
	var/cocked = FALSE
	cartridge_wording = "iron sphere"
	load_sound = 'sound/foley/musketload.ogg'
	fire_sound = 'sound/combat/Ranged/musketfire2.ogg'
	vary_fire_sound = TRUE
	fire_sound_volume = 200
	anvilrepair = /datum/skill/craft/engineering
	smeltresult = /obj/item/ingot/steel
	/// Chance for the weapon to misfire
	var/misfire_chance = 0
	/// Reload time, in SECONDS
	var/reload_time = 10
	weapon_embed_chance = 100 //this was here to make a weaker version of the gun, didn't do it, still keeping this here to be used
	damfactor = 5

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
			if(user.mind)
				var/skill = user.mind.get_skill_level(/datum/skill/craft/hunting)
				if(skill)
					reload_time = reload_time / skill
			if(move_after(user, reload_time SECONDS, target = user))
				playsound(user, 'sound/foley/musketcock.ogg', 100, FALSE)
				cocked = TRUE
				if(icon_state_ready)
					icon_state = icon_state_ready
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
	if(user.mind)
		var/skill = user.mind.get_skill_level(/datum/skill/craft/hunting)
		if(skill)
			misfire_chance = max(0, misfire_chance - (skill * 2))
			spread = max(3, spread / skill)
	if(prob(misfire_chance))
		to_chat(user, span_warning("The [name] misfires!"))
		explosion(src, light_impact_range = 2, heavy_impact_range = 1, smoke = TRUE, soundin = 'sound/misc/explode/bomb.ogg')
		qdel(src)
		return
	cocked = FALSE
	icon_state = initial(icon_state)
	var/dir = get_dir(src, target)
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(1, get_step(src, dir))
	smoke.start()
	..()

/obj/item/ammo_box/magazine/internal/shot/runelock
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet
	caliber = "small_sphere"
	max_ammo = 1
	start_empty = TRUE

/datum/intent/shoot/runelock
	chargetime = 0
	charging_slowdown = 0

/datum/intent/arc/runelock
	chargetime = 1
	chargedrain = 0
