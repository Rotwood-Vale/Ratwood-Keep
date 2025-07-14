// Basic intents swords.

/datum/intent/sword/cut // This usually goes on the first intent (rapier is an exception)
	name = "cut"
	desc = "Cutting and slashing motions making them slightly less accurate than stabs while being slightly more damaging."
	icon_state = "incut"
	attack_verb = list("cuts", "slashes")
	animname = "cut"
	blade_class = BCLASS_CUT
	chargetime = 0
	hitsound = list('sound/combat/hits/bladed/genslash (1).ogg', 'sound/combat/hits/bladed/genslash (2).ogg', 'sound/combat/hits/bladed/genslash (3).ogg')
	swingdelay = 0
	damfactor = 1.1 // It's a wide slash across the body, it's bound to deal more damage in a wider area.
	item_d_type = "slash"
	clickcd = 12 // Was already 12, this is here to clarify that an attack is 1.2 second.
	ican_cdg = FALSE

/datum/intent/sword/cut/onehanded // Shouldn't be used on one-handed swords.
	name = "one-handed cut"
	desc = "Cutting and slashing motions making them slightly less accurate than stabs while being slightly more damaging. (slightly slower due to being one-handed)"
	clickcd = 14 // It isn't much, but it's something.
	/// TODO: Make accuracy slightly worse one-handed. (By 1 or 2%)

/datum/intent/sword/cut/onehanded/long // This should only be used on long cumbersome swords.
	name = "one-handed cut"
	desc = "Cutting and slashing motions making them slightly less accurate than stabs while being slightly more damaging. (slightly slower due to being one-handed)"
	clickcd = 15 // Trying to cut one-handed would be more difficult with a long blade.
	/// TODO: Make the cut accuracy worse for one-handed long. (By 2 to 4%)

/datum/intent/sword/thrust
	name = "stab"
	desc = "Stabbing and thrusting motions making them slightly more accurate than cuts while also having an easier time penetrating armor."
	icon_state = "instab"
	attack_verb = list("stabs")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 20
	chargetime = 0
	swingdelay = 0
	item_d_type = "stab"
	clickcd = 11 // Reduced from 1.2 of a second to 1.1 of a second.
	ican_cdg = TRUE

/datum/intent/sword/thrust/onehanded // Shouldn't be used on one-handed swords.
	name = "one-handed stab"
	desc = "Stabbing and thrusting motions making them slightly more accurate than cuts while also having an easier time penetrating armor. (slightly slower due to being one-handed)"
	clickcd = 13 // It isn't much, but it's something.
	/// TODO: Make accuracy slightly worse one-handed. (By 0.5 or 1%)

/datum/intent/sword/thrust/onehanded/long // This should only be used on long cumbersome swords.
	name = "one-handed stab"
	desc = "Stabbing and thrusting motions making them slightly more accurate than cuts while also having an easier time penetrating armor. (slightly slower due to being one-handed)" // This is here for whenever someone decides to add that it's slightly less accurate due to being one-handed.
	clickcd = 14 // Trying to stab one-handed would be more difficult with a long blade.
	ican_cdg = FALSE // Being able to do this with this cumbersome thing one-handed would be a tad silly.
	/// TODO: Make accuracy slightly worse one-handed. (By 1 to 2%)

/datum/intent/sword/strike // This usually appears on the third intent when gripped.
	name = "pommel strike"
	desc = "Hilt pommeling and striking motions making blunting through armor easier."
	icon_state = "instrike"
	attack_verb = list("pommel strikes", "hilt strikes")
	animname = "strike"
	blade_class = BCLASS_BLUNT
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	chargetime = 0
	penfactor = 20
	swingdelay = 0
	item_d_type = "blunt"
	clickcd = 12
	/// TODO: Up its accuracy by a bit. (By 3%)

/datum/intent/sword/strike/onehanded
	name = "one-handed pommel strike"
	desc = "Hilt pommeling and striking motions making blunting through armor easier. (slightly slower due to being one-handed)"
	clickcd = 14 // Striking things with one-hand is just logically slower.

/datum/intent/sword/strike/onehanded/short // Simply pathed like this to inherit the quirks of the one above.
	name = "lighter one-handed pommel strike"
	desc = "Hilt pommeling and striking motions making blunting through armor easier."
	clickcd = 11 // The weapon is lighter, it shouldn't be as bad.
	damfactor = 0.9 // It lacks the weight to deal full damage.

/datum/intent/sword/chop
	name = "chop"
	desc = "Chopping and hacking motions leading to an concentrated blow that makes delimbing easier."
	icon_state = "inchop"
	attack_verb = list("chops", "hacks")
	animname = "chop"
	blade_class = BCLASS_CHOP
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	penfactor = 15
	swingdelay = 8
	damfactor = 1.15 // the 15% will make more difference besides a extra point of damage to way stronger characters.
	item_d_type = "slash"

/datum/intent/sword/chop/onehanded
	swingdelay = 10
	desc = "Chopping and hacking motions leading to an concentrated blow that makes delimbing easier. (slightly slower to land due to being one-handed)"

/obj/item/rogueweapon/sword
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	force = 18
	force_wielded = 25
	possible_item_intents = list(/datum/intent/sword/cut/onehanded, /datum/intent/sword/thrust/onehanded, /datum/intent/sword/strike/onehanded)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	name = "sword"
	desc = "A simple steel sword, clean and effective."
	icon_state = "sword1"
	icon = 'icons/roguetown/weapons/32.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_MED
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 100
	max_integrity = 150
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	pickup_sound = 'sound/foley/equip/swordlarge1.ogg'
	sheathe_sound = 'sound/items/wood_sharpen.ogg'
	flags_1 = CONDUCT_1
	throwforce = 10
	thrown_bclass = BCLASS_CUT
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	minstr = 7
	sellprice = 30
	wdefense = 4.5
	var/accuracy_bonus = 20

/obj/item/rogueweapon/sword/attack_right(mob/user)
	if(locate(/obj/machinery/anvil) in (loc))
		return ..()
	if(!overlays.len)
		if(!('icons/roguetown/weapons/swordherald.dmi' in GLOB.IconStates_cache))
			var/icon/J = new('icons/roguetown/weapons/swordherald.dmi')
			var/list/istates = J.IconStates()
			GLOB.IconStates_cache |= icon
			GLOB.IconStates_cache['icons/roguetown/weapons/swordherald.dmi'] = istates

		var/picked_name = input(user, "Choose thy Weapon", "Steel Swords...", name) as null|anything in sortList(GLOB.IconStates_cache['icons/roguetown/weapons/swordherald.dmi'])
		if(!picked_name)
			picked_name = "none"
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/swordherald.dmi', picked_name)
		M.alpha = 255
		alpha = 255
		var/old_bigboy = bigboy
		bigboy = 0
		var/old_gripsprite = gripsprite
		gripsprite = FALSE
		var/old_icon_state = icon_state
		icon_state = picked_name
		icon = 'icons/roguetown/weapons/swordherald.dmi'
		lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
		righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
		if(alert("Are you pleased with your weapon?", "Heraldry", "Yes", "No") != "Yes")
			icon_state = old_icon_state
			gripsprite = old_gripsprite
			bigboy = old_bigboy
	else
		..()

/obj/item/rogueweapon/sword/Initialize()
	. = ..()
	if(icon_state == "sword1")
		icon_state = "sword[rand(1,3)]"

/obj/item/rogueweapon/sword/decorated
	name = "engraved sword"
	desc = "A valuable sword for celebrations and rites."
	icon_state = "decsword1"
	sellprice = 140

/obj/item/rogueweapon/sword/decorated/Initialize()
	. = ..()
	if(icon_state == "decsword1")
		icon_state = "decsword[rand(1,3)]"

/obj/item/rogueweapon/sword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/short
	slot_flags = ITEM_SLOT_HIP
	name = "arming sword"
	desc = "A short arming sword, designed as a knightly sidearm. Best used with a shield or out of desperation."
	icon_state = "shortsword"
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = null /// TODO: Make a iron version of this sword, due to the short iron version having special intents and make this one double-grip.
	swingsound = BLADEWOOSH_SMALL
	minstr = 6
	wdefense = 4.5
	can_cdg = TRUE
	wlength = WLENGTH_SHORT	// Has a accuracy bonus of + 10.

/obj/item/rogueweapon/sword/long
	force = 25
	force_wielded = 30
	possible_item_intents = list(/datum/intent/sword/cut/onehanded/long, /datum/intent/sword/thrust/onehanded/long, /datum/intent/sword/strike/onehanded)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "longsword"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "longsword"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "bastard sword"
	desc = "A bastard sword that can chop with ease."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	smeltresult = /obj/item/ingot/steel
	accuracy_bonus = 5	// Large swords are unwieldy.

/obj/item/rogueweapon/sword/long/death
	color = CLOTHING_BLACK

/obj/item/rogueweapon/sword/long/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 6,"sy" = -2,"nx" = -4,"ny" = 2,"wx" = -8,"wy" = -1,"ex" = 8,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = -200,"wturn" = -160,"eturn" = -25,"nflip" = 8,"sflip" = 8,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.6,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/sword/long/heirloom
	force = 20
	force_wielded = 32
	possible_item_intents = list(/datum/intent/sword/cut/onehanded/long, /datum/intent/sword/thrust/onehanded/long, /datum/intent/sword/strike/onehanded)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "heirloom"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "longsword"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "old sword"
	desc = "A old steel sword with a green leather grip."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/long/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 6,"sy" = -2,"nx" = -4,"ny" = 2,"wx" = -8,"wy" = -1,"ex" = 8,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = -200,"wturn" = -160,"eturn" = -25,"nflip" = 8,"sflip" = 8,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/sword/long/judgement
	force = 40
	force_wielded = 55
	possible_item_intents = list(/datum/intent/sword/cut/onehanded/long, /datum/intent/sword/thrust/onehanded/long, /datum/intent/sword/strike/onehanded)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "judgement"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "judgement"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "judgement"
	desc = "A sword with a silver grip, a topaz gem hilt and a steel blade, what more could a noble ask for?"
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	smeltresult = /obj/item/ingot/steel
	sellprice = 363
	static_price = TRUE

/obj/item/rogueweapon/sword/long/judgement/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/vlord
	force = 30
	force_wielded = 38
	possible_item_intents = list(/datum/intent/sword/cut/onehanded/long, /datum/intent/sword/thrust/onehanded/long, /datum/intent/sword/strike/onehanded)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "vlord"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "vlord"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "crimson fang"
	desc = "A strange long sword with a green metal composition."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	max_integrity = 9999
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	smeltresult = /obj/item/ingot/steel
	sellprice = 363
	static_price = TRUE

/obj/item/rogueweapon/sword/long/vlord/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/rider
	force = 26
	force_wielded = 31
	possible_item_intents = list(/datum/intent/sword/cut/onehanded/long, /datum/intent/sword/strike/onehanded)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "tabi"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "tabi"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "kilij scimitar"
	desc = "A scimitar with elegant curves and deadly sharpness."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/long/rider/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/rider/messer
	force = 20
	force_wielded = 30
	possible_item_intents = list(/datum/intent/sword/cut/onehanded/long, /datum/intent/axe/chop, /datum/intent/sword/strike/onehanded)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/axe/chop, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	icon_state = "Kmesser"
	item_state = "Kmesser"
	name = "langesmesser"
	desc = "A lengthened messer, inspired by those from grenzelhoft. It chops and cuts with terrifying efficiency."

/obj/item/rogueweapon/sword/long/marlin
	force = 26
	force_wielded = 31
	possible_item_intents = list(/datum/intent/sword/cut/onehanded/long, /datum/intent/sword/strike/onehanded)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "marlin"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "marlin"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "shalal saber"
	desc = "Lightweight, slender and curved."
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 0
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	minstr = 6
	sellprice = 42
	wdefense = 5.5
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/long/marlin/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/exe
	icon_state = "exe"
	name = "broad executioner"
	force = 22
	force_wielded = 32
	possible_item_intents = list(/datum/intent/sword/strike/exe/onehanded, /datum/intent/axe/chop/exe/onehanded, /datum/intent/sword/strike/exe/blunt_blade_side)
	gripped_intents = list(/datum/intent/sword/strike/exe, /datum/intent/axe/chop/exe, /datum/intent/sword/thrust/exe, /datum/intent/sword/strike/exe/blunt_blade_side) /// TODO: If alt-grip is ever added, /datum/intent/shovelscoop, add that intent when it's coded for this specific weapon proper.
	desc = "A longsword with extra heft and thickness to its blade with a blunted curved tip."
	minstr = 10
	wlength = WLENGTH_GREAT
	slot_flags = ITEM_SLOT_BACK // Barely light enough to fit on the back.
	accuracy_bonus = 12 // A tad hard to miss with a huge wide and thick piece such as this.

/datum/intent/sword/strike/exe/onehanded
	clickcd = 18

/datum/intent/sword/strike/exe
	clickcd = 14
	damfactor = 1.1

/datum/intent/axe/chop/exe // It's a pretty long one.
	misscost = 15 // Do not miss or get dodged.
	clickcd = 15
	reach = 2

/datum/intent/axe/chop/exe/onehanded
	misscost = 20 // Definitely do not miss or get dodged.
	clickcd = 20

/datum/intent/sword/thrust/exe
	clickcd = 16 	// Thrusting this heavy thing is straining.
	swingdelay = 8	// Think of it as a one two motion.
	penfactor = 40
	misscost = 10
	attack_verb = list("blunty thrusts", "bluntly stabs")
	hitsound = list('sound/combat/hits/blunt/shovel_hit3.ogg')
	blade_class = BCLASS_BLUNT
	item_d_type = "blunt"
	reach = 2

/datum/intent/sword/strike/exe/blunt_blade_side
	attack_verb = list("smack across")
	swingdelay = 10
	penfactor = 25
	hitsound = list('sound/combat/hits/blunt/shovel_hit3.ogg')
	damfactor = 0.3
	misscost = 2
	icon_state = "inpunish"
	reach = 2

/obj/item/rogueweapon/sword/long/exe/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/exe/cloth
	icon_state = "terminusest"
	name = "Terminus Est"

/obj/item/rogueweapon/sword/long/exe/cloth/rmb_self(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(user, "clothwipe", 100, TRUE)
	SEND_SIGNAL(src, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRONG)
	user.visible_message(span_warning("[user] wipes [src] down with its cloth."),span_notice("I wipe [src] down with its cloth."))
	return

/obj/item/rogueweapon/sword/iron
	name = "sword"
	desc = "A simple iron sword, the most classical war weapon."
	icon_state = "isword"
	minstr = 6
	smeltresult = /obj/item/ingot/iron
	max_integrity = 100
	sellprice = 10
	can_cdg = TRUE

/obj/item/rogueweapon/sword/iron/attack_right(mob/user)
	if(locate(/obj/machinery/anvil) in (loc))
		return ..()
	if(!overlays.len)
		if(!('icons/roguetown/weapons/iswordherald.dmi' in GLOB.IconStates_cache))
			var/icon/J = new('icons/roguetown/weapons/iswordherald.dmi')
			var/list/istates = J.IconStates()
			GLOB.IconStates_cache |= icon
			GLOB.IconStates_cache['icons/roguetown/weapons/iswordherald.dmi'] = istates

		var/picked_name = input(user, "Choose thy Weapon", "Iron Swords...", name) as null|anything in sortList(GLOB.IconStates_cache['icons/roguetown/weapons/iswordherald.dmi'])
		if(!picked_name)
			picked_name = "none"
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/iswordherald.dmi', picked_name)
		M.alpha = 255
		alpha = 255
		var/old_icon_state = icon_state
		icon_state = picked_name
		icon = 'icons/roguetown/weapons/iswordherald.dmi'
		lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
		righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
		if(alert("Are you pleased with your weapon?", "Heraldry", "Yes", "No") != "Yes")
			icon_state = old_icon_state
	else
		..()

/obj/item/rogueweapon/sword/iron/short
	name = "short sword"
	desc = "An archaic iron sword."
	icon_state = "iswordshort"
	possible_item_intents = list(/datum/intent/sword/cut/short, /datum/intent/sword/thrust/short, /datum/intent/sword/strike/onehanded/short)
	gripped_intents = null
	minstr = 4
	wdefense = 3.5
	wlength = WLENGTH_SHORT	// It's more accurate due to being short.

/obj/item/rogueweapon/sword/iron/short/chipped
	force = 17
	desc = "An ancient-looking iron sword."
	icon_state = "iswordshort_d"
	max_integrity = 75

/datum/intent/sword/cut/short
	clickcd = 10

/datum/intent/sword/thrust/short
	clickcd = 10
	damfactor = 1.1

/obj/item/rogueweapon/sword/iron/messer
	name = "iron messer"
	desc = "A single edged blade to slice and chop with."
	icon_state = "imesser"
	max_integrity = 125
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/axe/chop)
	gripped_intents = null
	minstr = 4
	wdefense = 2.5
	can_cdg = FALSE // For clarity sake.

/obj/item/rogueweapon/sword/iron/messer/steel // A steel version didn't originally exist.
	name = "steel messer"
	desc = "A single edged blade to slice and chop with. This one is made of sturdy steel."
	icon_state = "smesser"
	smeltresult = /obj/item/ingot/steel
	max_integrity = 175 // A stout blade that will last a long time before breakage.

/obj/item/rogueweapon/sword/sabre
	name = "sabre"
	desc = "A swift sabre. Parries realiantly and strikes swiftly"
	icon_state = "saber"
	max_integrity = 230
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/sword/strike/onehanded/short)
	gripped_intents = null
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	minstr = 5
	wdefense = 6.5
	wbalance = 1
	accuracy_bonus = 10

/datum/intent/sword/cut/sabre
	clickcd = 10
	damfactor = 1.15 // The 15% is only one point in damage difference however, this will benefit stronger characters.

/obj/item/rogueweapon/sword/sabre/dec
	icon_state = "decsaber"
	sellprice = 140

/obj/item/rogueweapon/sword/rapier
	name = "rapier"
	desc = "A duelist's weapon derived from western battlefield instruments, it features a tapered \
	blade with a specialized stabbing tip."
	icon = 'icons/roguetown/weapons/64.dmi'
	icon_state = "rapier"
	max_integrity = 215
	bigboy = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	possible_item_intents = list(/datum/intent/sword/thrust/rapier, /datum/intent/sword/cut/rapier, /datum/intent/sword/strike/rapier)
	gripped_intents = null
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	minstr = 6
	wdefense = 7.5
	wbalance = 1
	accuracy_bonus = 5	// Wobbly tip.

/datum/intent/sword/cut/rapier
	clickcd = 10
	damfactor = 0.7

/datum/intent/sword/thrust/rapier
	clickcd = 8
	damfactor = 1.15 // The 5% bonus rounds up for a extra point of damage, this will add up further on way stronger characters.
	penfactor = 30

/datum/intent/sword/strike/rapier
	damfactor = 0.8 // It lacks much of a blade to give it mass force transfer.
	clickcd = 11 	// It lacks much of a blade to slow it down.

/obj/item/rogueweapon/sword/rapier/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list(
				"shrink" = 0.5,
				"sx" = -14,
				"sy" = -8,
				"nx" = 15,
				"ny" = -7,
				"wx" = -10,
				"wy" = -5,
				"ex" = 7,
				"ey" = -6,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				"nturn" = -13,
				"sturn" = 110,
				"wturn" = -60,
				"eturn" = -30,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 8,
				"eflip" = 1,
				)
			if("onback") return list(
				"shrink" = 0.5,
				"sx" = -1,
				"sy" = 2,
				"nx" = 0,
				"ny" = 2,
				"wx" = 2,
				"wy" = 1,
				"ex" = 0,
				"ey" = 1,
				"nturn" = 0,
				"sturn" = 0,
				"wturn" = 70,
				"eturn" = 15,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 1,
				"eflip" = 1,
				"northabove" = 1,
				"southabove" = 0,
				"eastabove" = 0,
				"westabove" = 0,
				)
			if("onbelt") return list(
				"shrink" = 0.4,
				"sx" = -4,
				"sy" = -6,
				"nx" = 5,
				"ny" = -6,
				"wx" = 0,
				"wy" = -6,
				"ex" = -1,
				"ey" = -6,
				"nturn" = 100,
				"sturn" = 156,
				"wturn" = 90,
				"eturn" = 180,
				"nflip" = 0,
				"sflip" = 0,
				"wflip" = 0,
				"eflip" = 0,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				)

/obj/item/rogueweapon/sword/rapier/dec
	desc = "A fine duelist's instrument with a tapered thrusting blade. Its hilt is gilt in gold and inlaid, \
	and its blade bears twin inscriptions on either side. One reads, 'CAST IN THE NAME OF GODS' while the \
	obverse reads, 'YE NOT GUILTY'."
	icon_state = "decrapier"
	sellprice = 140

/obj/item/rogueweapon/sword/rapier/lord
	force = 20
	name = "sword of the Mad Duke"
	desc = "A noble heirloom whose spiraling basket hilt is inlaid with fine cut gems. It bears the burnish of \
	time, where once sharply defined features have been worn down by so many hands. An old rumor ties this implement \
	to the siege that smashed the Mad Duke's keep to rubble, and burnt the Duke himself to cinders."
	icon_state = "lordrap"
	sellprice = 300
	max_integrity = 300
	max_blade_int = 300
	wdefense = 7.5

/obj/item/rogueweapon/sword/cutlass
	name = "cutlass"
	desc = "Used by pirates and deckhands."
	icon_state = "cutlass"
	max_integrity = 220
	possible_item_intents = list(/datum/intent/sword/cut/cutlass, /datum/intent/sword/cut/cutlassflow, /datum/intent/sword/strike, /datum/intent/sword/chop)
	gripped_intents = null
	wdefense = 7 // Thick yet light blade.

/datum/intent/sword/cut/cutlass
	name = "direct cut"
	desc = "A firmly gripped direct cut that deals a slightly better blow in-exchange of being unable to make rapid consecutive hits."
	clickcd = 16
	damfactor = 1.2

/datum/intent/sword/cut/cutlassflow
	name = "flowing cuts"
	desc = "Loose grip and wrist motions that allow smoother cuts across which in turn open up rapid consecutive hits."
	clickcd = 10
	swingdelay = 3

/obj/item/rogueweapon/sword/sabre/elf
	force = 25
	name = "elvish saber"
	desc = "This finely crafted saber is of elven design."
	icon_state = "esaber"
	item_state = "esaber"
	smeltresult = /obj/item/ingot/silver
	max_integrity = 205
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	var/last_used = 0

/obj/item/rogueweapon/sword/sabre/elf/Initialize()
	.=..()
	var/datum/magic_item/mundane/silver/effect = new
	AddComponent(/datum/component/magic_item, effect)

/obj/item/rogueweapon/sword/sabre_freeze
	name = "Freezing Saber"
	desc = "A fragile sabre adorned with a bright blue freezing mist. Holding the blade feels like it might give you frostbite."
	icon_state = "saber"
	max_integrity = 150
	possible_item_intents = list(/datum/intent/sword/cut/sabre/freeze, /datum/intent/sword/thrust/freeze)
	gripped_intents = null
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	minstr = 5
	wdefense = 6
	wbalance = 1
	damtype = BRUTE
	light_color = LIGHT_COLOR_BLUE
	var/on = FALSE

/datum/intent/sword/freeze
	name = "freeze"
	icon_state = "instrike"
	attack_verb = list("freezes")
	animname = "chop"
	hitsound = list('sound/combat/hits/pick/genpick (1).ogg')
	penfactor = 20
	swingdelay = 6
	damfactor = 1.2
	blade_class = BCLASS_BURN

/datum/intent/sword/cut/sabre/freeze
	clickcd = 10
	damfactor = 1

/datum/intent/sword/thrust/freeze
	clickcd = 10
	damfactor = 1

/obj/item/rogueweapon/sword/sabre_freeze/update_icon()
	if(on)
		icon_state = "saber_freeze"
	else
		icon_state = "saber"
/obj/item/rogueweapon/sword/sabre_freeze/attack_self(mob/user)
	if(on)
		on = FALSE
		damtype = BRUTE
		possible_item_intents = list(/datum/intent/sword/cut/sabre/freeze, /datum/intent/sword/thrust/freeze)
	else
		user.visible_message(span_warning("[user]'s blade lights up with a blue flame."))
		on = TRUE
		damtype = BURN
		possible_item_intents = list(/datum/intent/sword/cut/sabre/freeze, /datum/intent/sword/thrust/freeze, /datum/intent/sword/freeze)
	playsound(user, pick('sound/magic/magic_nulled.ogg'), 100, TRUE)
	if(user.a_intent)
		var/datum/intent/I = user.a_intent
		if(istype(I))
			I.afterchange()
	update_icon()

// BRONZE SWORDS
// Design goal: Bronze on par with Iron integrity wise, with low defense. However, it has high penfactor.

/obj/item/rogueweapon/sword/gladius
	force = 22
	name = "Gladius"
	desc = "An artificed bronze short sword with no guard. Meant to slash through armor, compliments a shield."
	icon_state = "gladius"
	possible_item_intents = list(/datum/intent/sword/cut/bronze, /datum/intent/sword/thrust)
	gripped_intents = null
	smeltresult = /obj/item/ingot/bronze
	max_blade_int = 100
	max_integrity = 150
	dropshrink = 0.80
	wdefense = 2.5

/datum/intent/sword/cut/bronze
	penfactor = 60
