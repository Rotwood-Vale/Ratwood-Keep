/*-----------\
|  Thresher  |
\-----------*/

/obj/item/rogueweapon/thresher
	name = "thresher"
	desc = "Crushes grain, or skulls."
	icon_state = "thresher"
	item_state = "thresher"
	icon = 'icons/roguetown/weapons/tools.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onback = FALSE
	experimental_onhip = FALSE
	gripsprite = TRUE
	gripspriteonmob = TRUE
	slot_flags = ITEM_SLOT_BACK
	sharpness = IS_BLUNT
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	minstr = 6
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	smeltresult = null
	associated_skill = /datum/skill/combat/whipsflails
	possible_item_intents = list(MACE_STRIKE)
	gripped_intents = list(/datum/intent/flailthresh,MACE_STRIKE)

	force = 10
	force_wielded = 14
	wdefense = 2
	wbalance = -2
	wlength = 66

/obj/item/rogueweapon/thresher/wflail
	name = "war flail"
	desc = "A peasants thresher turned into a weapon of war."
	icon_state = "wflail"
	item_state = "wflail"
	minstr = 9
	possible_item_intents = list(/datum/intent/flail/strike)
	gripped_intents = list(/datum/intent/flail/strike, /datum/intent/flail/strike/smash, /datum/intent/flailthresh)

	force = 12
	force_wielded = 25

/datum/intent/flailthresh
	name = "thresh"
	icon_state = "inthresh"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0
	no_attack = TRUE

/obj/item/rogueweapon/thresher/afterattack(obj/target, mob/user, proximity)
	if(user.used_intent.type == /datum/intent/flailthresh)
		if(isturf(target.loc))
			var/turf/T = target.loc
			var/found = FALSE
			for(var/obj/item/natural/chaff/C in T)
				found = TRUE
				C.thresh()
			if(found)
				playsound(loc,"plantcross", 90, FALSE)
				playsound(loc,"smashlimb", 35, FALSE)
				apply_farming_fatigue(user, 10)
				user.visible_message("<span class='notice'>[user] threshes the stalks!</span>", \
									"<span class='notice'>I thresh the stalks.</span>")
			return
	..()


/*---------\
|  Sickle  |
\---------*/

/obj/item/rogueweapon/sickle
	name = "sickle"
	desc = "Rusted blade, worn handle, symbol of toil."
	icon_state = "sickle1"
	item_state = "sickle"
	icon = 'icons/roguetown/weapons/tools.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onback = FALSE
	experimental_onhip = FALSE
	sharpness = IS_SHARP
	slot_flags = ITEM_SLOT_HIP
	thrown_bclass = BCLASS_CUT
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	max_blade_int = 50
	smeltresult = /obj/item/ingot/iron
	possible_item_intents = list(DAGGER_CUT)
	associated_skill = /datum/skill/combat/knives
	force = 11
	wdefense = 0
	wlength = 10
/obj/item/rogueweapon/sickle/New()
	. = ..()
	icon_state = "sickle[rand(1,3)]"


/*------\
|  Hoe  |
\------*/

/obj/item/rogueweapon/hoe
	name = "hoe"
	desc = ""
	icon_state = "hoe"
	item_state = "hoe"
	icon = 'icons/roguetown/weapons/tools.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onback = FALSE
	experimental_onhip = FALSE
	gripspriteonmob = TRUE
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	minstr = 5
	sharpness = IS_BLUNT
	walking_stick = TRUE
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	smeltresult = /obj/item/ingot/iron
	possible_item_intents = list(/datum/intent/pick)
	gripped_intents = list(TILL_INTENT,/datum/intent/pick,SPEAR_BASH)
	associated_skill = /datum/skill/combat/polearms
	force = 5
	force_wielded = 10
	wdefense = 2
	wlength = 66
/obj/item/rogueweapon/hoe/New()
	. = ..()
	icon_state = "hoe[rand(1,3)]"

/obj/item/rogueweapon/hoe/attack_turf(turf/T, mob/living/user)
	if(user.used_intent.type == /datum/intent/till)
		user.changeNext_move(CLICK_CD_MELEE)
		if(istype(T, /turf/open/floor/rogue/grass))
			playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
			if (do_after(user, 3 SECONDS, target = src))
				apply_farming_fatigue(user, 10)
				T.ChangeTurf(/turf/open/floor/rogue/dirt/npoor, flags = CHANGETURF_INHERIT_AIR)
				playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
			return

		if(istype(T, /turf/open/floor/rogue/dirt))
			playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
			if(do_after(user, 2 SECONDS, target = src))
				playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
				var/obj/structure/soil/soil = get_soil_on_turf(T)

				if(soil)
					soil.user_till_soil(user)
				else
					var/turf/open/floor/rogue/dirt/dirtturf = T
					var/soil_type = dirtturf.soil_plot_type
					apply_farming_fatigue(user, 8)
					new soil_type(T)
			return
	. = ..()

/datum/intent/till
	name = "hoe"
	icon_state = "inhoe"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0


/*------------\
|  Pitchfork  |
\------------*/

/obj/item/rogueweapon/pitchfork
	name = "pitchfork"
	desc = "Compost, chaff, hay, it matters not."
	icon_state = "pitchfork"
	item_state = "pitchfork"
	icon = 'icons/roguetown/weapons/tools.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onback = FALSE
	experimental_onhip = FALSE
	gripspriteonmob = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	minstr = 6
	var/list/forked = list()
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	possible_item_intents = list(SPEAR_BASH)
	gripped_intents = list(DUMP_INTENT,SPEAR_BASH,SPEAR_THRUST)
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/polearms
	thrown_bclass = BCLASS_STAB
	throwforce = 15

	force = 10
	force_wielded = 22
	wdefense = 1
	wlength = WLENGTH_LONG

/datum/intent/pforkdump
	name = "scoop"
	icon_state = "inscoop"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0
	no_attack = TRUE

/obj/item/rogueweapon/pitchfork/afterattack(obj/target, mob/user, proximity)
	if((!proximity) || (!wielded))
		return ..()
	testing("fuck")
	if(isopenturf(target))
		if(forked.len)
			for(var/obj/item/I in forked)
				I.forceMove(target)
				forked -= I
			to_chat(user, span_warning("I dump the stalks."))
		update_icon()
		playsound(loc,"plantcross", 80, FALSE)
		return
	..()

/obj/item/rogueweapon/pitchfork/ungrip(mob/living/carbon/user, show_message = TRUE)
	if(forked.len)
		var/turf/T = get_turf(user)
		for(var/obj/item/I in forked)
			I.forceMove(T)
			forked -= I
		update_icon()
	..()

/obj/item/rogueweapon/pitchfork/update_icon()
	if(forked.len)
		icon_state = "pitchforkstuff"
		item_state = "pitchforkstuff"	// onmob itemstate does not update, TO DO
	else
		icon_state = initial(icon_state)
		item_state = "pitchfork1"
	..()
