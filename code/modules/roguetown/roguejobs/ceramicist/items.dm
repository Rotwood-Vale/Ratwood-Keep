/obj/item/rogueweapon/blowRod
	force = 10
	possible_item_intents = list(/datum/intent/mace/strike)
	name = "Blowing Rod"
	desc = "A blowing rod for shaping glass."
	icon_state = "blowJobRod" // sorry not sorry
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	associated_skill = null
	var/obj/item/ingot/hingot = null //TODO: Molten glass
	var/hott = FALSE
	smeltresult = /obj/item/ingot/iron

/obj/item/rogueweapon/blowRod/examine(mob/user) //TODO: Molten glass
	. = ..()
	if(hott)
		. += span_warning("The tip is hot to the touch.")

/obj/item/rogueweapon/blowRod/get_temperature() //TODO: Molten glass
	if(hott)
		return FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	return ..()

/obj/item/rogueweapon/blowRod/fire_act(added, maxstacks) //TODO: Molten glass
	. = ..()
	hott = world.time
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(make_unhot), world.time), 10 SECONDS)

/obj/item/rogueweapon/blowRod/update_icon() //TODO: Sprites
	. = ..()
	if(!hingot)
		icon_state = "blowRod"
	else
		if(hott)
			icon_state = "tongsi1"
		else
			icon_state = "tongsi0"

/obj/item/rogueweapon/blowRod/proc/make_unhot(input)
	if(hott == input)
		hott = FALSE

/obj/item/rogueweapon/blowRod/attack_self(mob/user)
	if(hingot)
		if(isturf(user.loc))
			hingot.forceMove(get_turf(user))
			hingot = null
			hott = FALSE
			update_icon()

/obj/item/rogueweapon/blowRod/dropped() // If dropped, should also drop the molten glass along with it.
	. = ..()
	if(hingot)
		hingot.forceMove(get_turf(src))
		hingot = null
	hott = FALSE
	update_icon()

/obj/item/rogueweapon/blowRod/getonmobprop(tag)
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

/obj/item/ingot/glass
	name = "glass sheet"
	desc = "A marvelous pane of transparent glass."
	icon_state = "ingotiron" //TODO
	smeltresult = /obj/item/ingot/glass
	grind_results = list(/datum/reagent/lye = 15, /datum/reagent/ash = 15,) // Placeholder. 
	sellprice = 30 // This is probably way too much.
    /*
        I was going to add an intermediary, glass blob item that had to be shaped into a pane by a
        potter, but I figured that this would probably be too tedious, so, we are assuming that
        molten glass is poured into a mold for a sheet as soon as it leaves the kiln/furnace.
    */