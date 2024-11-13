/////////////////// KEYRING ////////////////////

/obj/item/keyring
	name = "keyring"
	desc = "Will help you organize your keys."
	icon_state = "keyring0"
	icon = 'icons/roguetown/items/keys.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0
	throwforce = 0
	var/list/keys = list()
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_MOUTH|ITEM_SLOT_WRISTS
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/keyring/Initialize()
	. = ..()
	if(keys.len)
		for(var/X in keys)
			addtoring(new X())
			keys -= X
	update_icon()
	update_desc()

/obj/item/keyring/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,
"sx" = -6,
"sy" = -3,
"nx" = 13,
"ny" = -3,
"wx" = -2,
"wy" = -3,
"ex" = 4,
"ey" = -5,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 15,
"sturn" = 0,
"wturn" = 0,
"eturn" = 39,
"nflip" = 8,
"sflip" = 0,
"wflip" = 0,
"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/keyring/proc/addtoring(obj/item/I)
	if(!I || !istype(I))
		return 0
	I.loc = src
	keys += I
	update_icon()
	update_desc()

/obj/item/keyring/proc/removefromring(mob/user)
	if(!keys.len)
		return
	var/obj/item/key/K = keys[keys.len]
	keys -= K
	K.loc = user.loc
	update_icon()
	update_desc()
	return K

/obj/item/keyring/pre_attack(target, user, params)
	. = ..()
	var/used_hash
	if(istype(target, /obj/structure/closet))
		var/obj/structure/closet/C = target
		if(C.masterkey)
			used_hash = C.lockhash
	if(istype(target, /obj/structure/mineral_door))
		var/obj/structure/mineral_door/D = target
		if(D.masterkey)
			used_hash = D.lockhash
	for(var/obj/item/key/K in keys)
		if(istype(K, /obj/item/key/lord))
			K.lockhash = used_hash

/obj/item/keyring/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/key))
		if(keys.len >= 20) //could be made per keyring
			to_chat(user, span_warning("Too many keys."))
			return
		user.dropItemToGround(I)
		addtoring(I)
	else
		return ..()

/obj/item/keyring/attack_right(mob/user)
	if(keys.len)
		to_chat(user, span_notice("I steal a key off the ring."))
		var/obj/item/key/K = removefromring(user)
		user.put_in_active_hand(K)

/obj/item/keyring/update_icon()
	..()
	if(!keys.len)
		icon_state = "keyring0"
		return
	if(keys.len >= 5)
		icon_state = "keyring5"
		return
	switch(keys.len)
		if(1)
			icon_state = "keyring1"
		if(2)
			icon_state = "keyring2"
		if(3)
			icon_state = "keyring3"
		if(4)
			icon_state = "keyring4"

/obj/item/keyring/proc/update_desc()
	if(keys.len)
		desc = span_info("Holds \Roman[keys.len] key\s, including:")
		for(var/obj/item/key/KE in keys)
			desc += span_info("\n- [KE.name ? "A [KE.name]." : "An unknown key."]")
	else
		desc = ""

/obj/item/keyring/marshal
	keys = list(/obj/item/key/town_dungeon, /obj/item/key/town_barracks, /obj/item/key/councillor_rooms, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon, /obj/item/key/manor)

/obj/item/keyring/councillor
	keys = list(/obj/item/key/councillor_rooms, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon,  /obj/item/key/manor)

/obj/item/keyring/bog_guard
	keys = list(/obj/item/key/bog_gatehouse)

/obj/item/keyring/bog_master
	keys = list(/obj/item/key/bog_gatehouse, /obj/item/key/bog_master)

/obj/item/keyring/town_watch
	keys = list(/obj/item/key/town_dungeon, /obj/item/key/town_barracks, /obj/item/key/town_armory)

/obj/item/keyring/sheriff
	keys = list(/obj/item/key/sheriff_office, /obj/item/key/town_armory, /obj/item/key/town_barracks, /obj/item/key/town_dungeon)

/obj/item/keyring/man_at_arms
	keys = list(/obj/item/key/keep_gatehouse, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/keyring/captain
	keys = list(/obj/item/key/councillor_rooms, /obj/item/key/keep_gatehouse, /obj/item/key/keep_armory, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/keyring/dungeoneer
	keys = list(/obj/item/key/keep_dungeon, /obj/item/key/keep_dungeon_torture, /obj/item/key/town_dungeon, /obj/item/key/bog_gatehouse, /obj/item/key/manor, /obj/item/key/keep_barracks)

/obj/item/keyring/veteran
	keys = list(/obj/item/key/keep_barracks, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/keyring/knight
	keys = list(/obj/item/key/councillor_rooms, /obj/item/key/keep_gatehouse, /obj/item/key/keep_armory, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/keyring/velder
	keys = list(/obj/item/key/velder, /obj/item/key/blacksmith/town, /obj/item/key/farm, /obj/item/key/butcher)

/obj/item/keyring/Butcher
	keys = list(/obj/item/key/farm, /obj/item/key/butcher)

/obj/item/keyring/vtavern
	keys = list(/obj/item/key/tavern/village, /obj/item/key/roomvi/village, /obj/item/key/roomv/village, /obj/item/key/roomiv/village, /obj/item/key/roomiii/village, /obj/item/key/roomii/village, /obj/item/key/roomi/village)

/obj/item/keyring/gatemaster
	keys = list(/obj/item/key/keep_gatehouse, /obj/item/key/keep_barracks, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/keyring/merchant
	keys = list(/obj/item/key/shop, /obj/item/key/merchant)

/obj/item/keyring/shophand
	keys = list(/obj/item/key/shop)

/obj/item/keyring/mage
	keys = list(/obj/item/key/manor, /obj/item/key/tower, /obj/item/key/mage)

/obj/item/keyring/innkeep
	keys = list(/obj/item/key/tavern, /obj/item/key/fancyroomiii, /obj/item/key/fancyroomii, /obj/item/key/fancyroomi, /obj/item/key/roomvi, /obj/item/key/roomv, /obj/item/key/roomiv, /obj/item/key/roomiii, /obj/item/key/roomii, /obj/item/key/roomi)

/obj/item/keyring/priest
	keys = list(/obj/item/key/priest, /obj/item/key/confession, /obj/item/key/church, /obj/item/key/graveyard)

/obj/item/keyring/puritan
	keys = list(/obj/item/key/puritan, /obj/item/key/manor, /obj/item/key/confession, /obj/item/key/church)

/obj/item/keyring/shepherd
	keys = list(/obj/item/key/confession, /obj/item/key/church)

/obj/item/keyring/nightman
	keys = list(/obj/item/key/nightman, /obj/item/key/nightmaiden)

/obj/item/keyring/hand
	keys = list(/obj/item/key/keep_armory, /obj/item/key/steward, /obj/item/key/town_dungeon, /obj/item/key/town_barracks, /obj/item/key/keep_gatehouse, /obj/item/key/councillor_rooms, /obj/item/key/hand, /obj/item/key/walls, /obj/item/key/keep_dungeon, /obj/item/key/keep_barracks, /obj/item/key/manor)

/obj/item/keyring/steward
	keys = list(/obj/item/key/steward, /obj/item/key/walls, /obj/item/key/manor)

/obj/item/keyring/clerk
	keys = list(/obj/item/key/walls, /obj/item/key/manor)

/obj/item/keyring/servant
	keys = list(/obj/item/key/manor, /obj/item/key/keep_barracks)

/obj/item/keyring/archivist
	keys = list(/obj/item/key/manor, /obj/item/key/archive)

/obj/item/keyring/physician
	keys = list(/obj/item/key/manor, /obj/item/key/keep_barracks, /obj/item/key/physician, /obj/item/key/keep_dungeon_torture)

/obj/item/keyring/royal
	keys = list(/obj/item/key/councillor_rooms, /obj/item/key/prince_rooms, /obj/item/key/manor, /obj/item/key/royal)

/obj/item/keyring/gravedigger
	keys = list(/obj/item/key/graveyard, /obj/item/key/church)

/obj/item/keyring/mercenary
	keys = list(/obj/item/key/mercenary)

/obj/item/keyring/mercenary_boss
	keys = list(/obj/item/key/mercenary, /obj/item/key/mercenary_boss)
