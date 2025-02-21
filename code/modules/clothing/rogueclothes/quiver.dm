
/obj/item/ammo_holder
	desc = ""
	icon = 'icons/roguetown/weapons/ammo.dmi'
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = NONE
	max_integrity = 0
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	alternate_worn_layer = UNDER_CLOAK_LAYER
	strip_delay = 20
	var/max_storage
	var/list/ammo = list()
	sewrepair = TRUE
	var/list/ammo_type

/obj/item/ammo_holder/quiver
	name = "quiver"
	icon_state = "quiver0"
	item_state = "quiver"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	max_storage = 20
	ammo_type = list (/obj/item/ammo_casing/caseless/rogue/arrow, /obj/item/ammo_casing/caseless/rogue/bolt)

/obj/item/ammo_holder/bullet
	name = "bullet pouch"
	icon_state = "pouch0"
	item_state = "pouch"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	max_storage = 10
	ammo_type = list(/obj/item/ammo_casing) //common denominator type for runelock and arquebus bullets

/obj/item/ammo_holder/mulyeogscab
	name = "plain scabbard"
	icon_state = "simplescabbard0"
	item_state = "simplescabbard1"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	max_storage = 1
	ammo_type = list (/obj/item/rogueweapon/sword/sabre/mulyeog)

/obj/item/ammo_holder/mulyeogscab/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
//this is because i dont have the budget to pay for inhand scabbard sprites - taken from swords.dm 
