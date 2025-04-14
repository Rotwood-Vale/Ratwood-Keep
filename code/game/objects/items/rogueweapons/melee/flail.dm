/obj/item/rogueweapon/flail
	force = 15
	possible_item_intents = list(/datum/intent/flail/strike, /datum/intent/flail/strike/smash)
	name = "flail"
	desc = "This is a swift, iron flail. Strikes hard and fast."
	icon_state = "iflail"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	associated_skill = /datum/skill/combat/whipsflails
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = BLUNTWOOSH_MED
	throwforce = 5
	wdefense = 0
	minstr = 4

/datum/intent/flail/strike
	name = "strike"
	blade_class = BCLASS_BLUNT
	attack_verb = list("strikes", "hits")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	penfactor = 5
	icon_state = "instrike"
	item_d_type = "slash"

/datum/intent/flail/strikerange //No flail seems to use this intent.
	name = "ranged strike"
	blade_class = BCLASS_BLUNT
	attack_verb = list("strikes", "hits")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 5
	recovery = 15
	penfactor = 5
	reach = 2
	icon_state = "instrike"
	item_d_type = "slash"

/datum/intent/flail/strike/smash
	name = "smash"
	chargetime = 5
	chargedrain = 0.9
	no_early_release = TRUE
	penfactor = 80
	recovery = 10
	damfactor = 1.5
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	icon_state = "insmash"
	blade_class = BCLASS_SMASH
	attack_verb = list("smashes")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	item_d_type = "blunt"

/datum/intent/flail/strike/smashrange //No flail seems to use this intent.
	name = "ranged smash"
	chargetime = 25
	chargedrain = 1
	no_early_release = TRUE
	penfactor = 50
	recovery = 30
	damfactor = 1.5
	reach = 2
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	icon_state = "insmash"
	blade_class = BCLASS_SMASH
	attack_verb = list("smashes")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	item_d_type = "blunt"

/obj/item/rogueweapon/flail/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -3,"nx" = 11,"ny" = -2,"wx" = -7,"wy" = -3,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 22,"sturn" = -23,"wturn" = -23,"eturn" = 29,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/flail/sflail
	force = 21
	icon_state = "flail"
	desc = "This is a swift, steel flail. Strikes hard and fast."
	smeltresult = /obj/item/ingot/steel
	minstr = 5


/datum/intent/whip/lash
	name = "lash"
	blade_class = BCLASS_BLUNT
	attack_verb = list("lashes", "whips")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	recovery = 7
	penfactor = 10
	reach = 2
	icon_state = "inlash"
	item_d_type = "blunt"

/datum/intent/whip/crack
	name = "crack"
	blade_class = BCLASS_BLUNT
	attack_verb = list("cracks") //something something dwarf fotresss
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	recovery = 10
	penfactor = 40
	reach = 3
	icon_state = "incrack"
	item_d_type = "blunt"

/datum/intent/whip/punish
	name = "punish"
	blade_class = BCLASS_BLUNT
	attack_verb = list("punishes")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	recovery = 10
	damfactor = 0.5
	penfactor = 0
	reach = 2
	icon_state = "inpunish"
	item_d_type = "blunt"

/obj/item/rogueweapon/whip
	force = 21
	possible_item_intents = list(/datum/intent/whip/crack, /datum/intent/whip/lash, /datum/intent/whip/punish)
	name = "whip"
	desc = "A leather whip, built to last with an sharp stone for a tip."
	icon_state = "whip"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP //| ITEM_SLOT_BELT (Either someone fixes this, or this remains disabled because it's very bugged)
	associated_skill = /datum/skill/combat/whipsflails
	anvilrepair = /datum/skill/craft/hunting
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = WHIPWOOSH
	throwforce = 5
	wdefense = 0
	minstr = 6

/obj/item/rogueweapon/whip/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -3,"nx" = 11,"ny" = -2,"wx" = -7,"wy" = -3,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 22,"sturn" = -23,"wturn" = -23,"eturn" = 29,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/whip/antique
	force = 29
	name = "Repenta En"
	desc = "An extremely well maintained whip, with a polished steel tip and gilded handle. It clearly needs to see more use."
	minstr = 8
	icon_state = "gwhip"
