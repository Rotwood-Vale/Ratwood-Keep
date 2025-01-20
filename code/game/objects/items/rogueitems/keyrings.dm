/////////////////// KEYRING ////////////////////

/obj/item/storage/keyring
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
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/storage/keyring/Initialize()
    . = ..()
    if(keys.len)
        for(var/X in keys)
            new X(src)
            keys -= X
    update_icon()
    update_desc()

/obj/item/storage/keyring/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 20
		STR.max_w_class = WEIGHT_CLASS_SMALL
		STR.max_items = 9
		STR.attack_hand_interact = FALSE
		STR.click_gather = TRUE
		STR.allow_dump_out = TRUE
		STR.rustle_sound = FALSE
		STR.set_holdable(list(
			/obj/item/key,
		))

/obj/item/storage/keyring/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE

/obj/item/storage/keyring/update_icon()
    ..()
    switch(contents.len)
        if(0)
            icon_state = "keyring0"
        if(1)
            icon_state = "keyring1"
        if(2)
            icon_state = "keyring2"
        if(3)
            icon_state = "keyring3"
        if(4)
            icon_state = "keyring4"
        else
            icon_state = "keyring5"

/obj/item/storage/keyring/proc/update_desc()
	if(contents.len)
		desc = span_info("Holds \Roman[contents.len] key\s, including:")
		for(var/obj/item/key/KE in contents)
			desc += span_info("\n- [KE.name ? "A [KE.name]." : "	An unknown key."]")
	else
		desc = ""

/obj/item/storage/keyring/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
    . = ..()
    playsound(src, "sound/items/gems (1).ogg", 100, FALSE)
    update_desc()

/obj/item/storage/keyring/Exited(atom/movable/gone, direction)
    . = ..()

/obj/item/storage/keyring/getonmobprop(tag)
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

/obj/item/storage/keyring/marshal
	keys = list(/obj/item/key/town_dungeon, /obj/item/key/town_barracks, /obj/item/key/councillor_rooms, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon, /obj/item/key/manor)

/obj/item/storage/keyring/councillor
	keys = list(/obj/item/key/councillor_rooms, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon,  /obj/item/key/manor)

/obj/item/storage/keyring/bog_guard
	keys = list(/obj/item/key/bog_gatehouse)

/obj/item/storage/keyring/bog_master
	keys = list(/obj/item/key/bog_gatehouse, /obj/item/key/bog_master)

/obj/item/storage/keyring/town_watch
	keys = list(/obj/item/key/town_dungeon, /obj/item/key/town_barracks, /obj/item/key/town_armory)

/obj/item/storage/keyring/sheriff
	keys = list(/obj/item/key/sheriff_office, /obj/item/key/town_armory, /obj/item/key/town_barracks, /obj/item/key/town_dungeon)

/obj/item/storage/keyring/man_at_arms
	keys = list(/obj/item/key/keep_gatehouse, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/storage/keyring/captain
	keys = list(/obj/item/key/councillor_rooms, /obj/item/key/keep_gatehouse, /obj/item/key/keep_armory, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/storage/keyring/dungeoneer
	keys = list(/obj/item/key/keep_dungeon, /obj/item/key/keep_dungeon_torture, /obj/item/key/town_dungeon, /obj/item/key/town_barracks, /obj/item/key/bog_gatehouse, /obj/item/key/manor, /obj/item/key/keep_barracks)

/obj/item/storage/keyring/veteran
	keys = list(/obj/item/key/keep_barracks, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/storage/keyring/knight
	keys = list(/obj/item/key/councillor_rooms, /obj/item/key/keep_gatehouse, /obj/item/key/keep_armory, /obj/item/key/keep_barracks, /obj/item/key/keep_dungeon, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/storage/keyring/mayor
	keys = list(/obj/item/key/mayor, /obj/item/key/blacksmith/town, /obj/item/key/farm, /obj/item/key/butcher)

/obj/item/storage/keyring/Butcher
	keys = list(/obj/item/key/farm, /obj/item/key/butcher)

/obj/item/storage/keyring/vtavern
	keys = list(/obj/item/key/tavern/village, /obj/item/key/roomvi/village, /obj/item/key/roomv/village, /obj/item/key/roomiv/village, /obj/item/key/roomiii/village, /obj/item/key/roomii/village, /obj/item/key/roomi/village)

/obj/item/storage/keyring/gatemaster
	keys = list(/obj/item/key/keep_gatehouse, /obj/item/key/keep_barracks, /obj/item/key/manor, /obj/item/key/walls)

/obj/item/storage/keyring/merchant
	keys = list(/obj/item/key/shop, /obj/item/key/merchant)

/obj/item/storage/keyring/shophand
	keys = list(/obj/item/key/shop)

/obj/item/storage/keyring/mage
	keys = list(/obj/item/key/manor, /obj/item/key/tower, /obj/item/key/mage)

/obj/item/storage/keyring/innkeep
	keys = list(/obj/item/key/tavern, /obj/item/key/fancyroomiii, /obj/item/key/fancyroomii, /obj/item/key/fancyroomi, /obj/item/key/roomvi, /obj/item/key/roomv, /obj/item/key/roomiv, /obj/item/key/roomiii, /obj/item/key/roomii, /obj/item/key/roomi)

/obj/item/storage/keyring/priest
	keys = list(/obj/item/key/priest, /obj/item/key/confession, /obj/item/key/church, /obj/item/key/graveyard)

/obj/item/storage/keyring/puritan
	keys = list(/obj/item/key/puritan, /obj/item/key/manor, /obj/item/key/confession, /obj/item/key/church)

/obj/item/storage/keyring/shepherd
	keys = list(/obj/item/key/confession, /obj/item/key/church)

/obj/item/storage/keyring/nightman
	keys = list(/obj/item/key/nightman)

/obj/item/storage/keyring/hand
	keys = list(/obj/item/key/keep_armory, /obj/item/key/steward, /obj/item/key/town_dungeon, /obj/item/key/town_barracks, /obj/item/key/keep_gatehouse, /obj/item/key/councillor_rooms, /obj/item/key/hand, /obj/item/key/walls, /obj/item/key/keep_dungeon, /obj/item/key/keep_barracks, /obj/item/key/manor)

/obj/item/storage/keyring/steward
	keys = list(/obj/item/key/steward, /obj/item/key/walls, /obj/item/key/manor)

/obj/item/storage/keyring/servant
	keys = list(/obj/item/key/manor, /obj/item/key/keep_barracks)

/obj/item/storage/keyring/archivist
	keys = list(/obj/item/key/manor, /obj/item/key/archive)

/obj/item/storage/keyring/architect
	keys = list(/obj/item/key/blacksmith)

/obj/item/storage/keyring/physician
	keys = list(/obj/item/key/manor, /obj/item/key/keep_barracks, /obj/item/key/physician, /obj/item/key/keep_dungeon_torture)

/obj/item/storage/keyring/royal
	keys = list(/obj/item/key/councillor_rooms, /obj/item/key/prince_rooms, /obj/item/key/manor, /obj/item/key/royal)

/obj/item/storage/keyring/gravedigger
	keys = list(/obj/item/key/graveyard, /obj/item/key/church)

/obj/item/storage/keyring/mercenary
	keys = list(/obj/item/key/mercenary)

/obj/item/storage/keyring/mercenary_boss
	keys = list(/obj/item/key/mercenary, /obj/item/key/mercenary_boss)

/obj/item/storage/keyring/goblin
	keys = list(/obj/item/key/goblin)

/obj/item/storage/keyring/goblinguard
	keys = list(/obj/item/key/goblin, /obj/item/key/goblinguard)

/obj/item/storage/keyring/goblinchief
	keys = list(/obj/item/key/goblin, /obj/item/key/goblinguard, /obj/item/key/goblinchief)

/obj/item/storage/keyring/harbormaster
	keys = list(/obj/item/key/harbor, /obj/item/key/ship)


/obj/item/lockpickring
	name = "lockpickring"
	desc = "A piece of bent wire to store lockpicking tools. Too bulky for fine work."
	icon_state = "pickring0"
	icon = 'icons/roguetown/items/keys.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0
	throwforce = 0
	var/list/picks = list()
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_MOUTH|ITEM_SLOT_WRISTS
	experimental_inhand = FALSE
	dropshrink = 0.7

/obj/item/lockpickring/Initialize()
	. = ..()
	if(picks.len)
		for(var/X in picks)
			addtoring(new X())
			picks -= X
	update_icon()

/obj/item/lockpickring/getonmobprop(tag)
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

/obj/item/lockpickring/proc/addtoring(obj/item/I)
	if(!I || !istype(I))
		return 0
	I.loc = src
	picks += I
	update_icon()
	update_desc()

/obj/item/lockpickring/proc/removefromring(mob/user)
	if(!picks.len)
		return
	var/obj/item/lockpick/K = picks[picks.len]
	picks -= K
	K.loc = user.loc
	update_icon()
	update_desc()
	return K

/obj/item/lockpickring/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/lockpick))
		if(picks.len >= 3)
			to_chat(user, "<span class='warning'>Too many lockpicks.</span>")
			return
		user.dropItemToGround(I)
		addtoring(I)
	else
		return ..()

/obj/item/lockpickring/attack_right(mob/user)
	if(picks.len)
		to_chat(user, "<span class='notice'>I steal a pick off the ring.</span>")
		var/obj/item/lockpick/K = removefromring(user)
		user.put_in_active_hand(K)

/obj/item/lockpickring/update_icon()
	..()
	if(!picks.len)
		icon_state = "pickring0"
		return
	if(picks.len >= 3)
		icon_state = "pickring3"
		return
	switch(picks.len)
		if(1)
			icon_state = "pickring1"
		if(2)
			icon_state = "pickring2"
		if(3)
			icon_state = "pickring3"

/obj/item/lockpickring/proc/update_desc()
	if(picks.len)
		desc = "<span class='info'>\Roman [picks.len] lockpicks.</span>"
	else
		desc = ""

/obj/item/lockpickring/mundane
	picks = list(/obj/item/lockpick, /obj/item/lockpick, /obj/item/lockpick)
