// Basic intents axe. // Basic intents axes.

/datum/intent/axe/cut
	name = "cut"
	desc = "Cutting and slashing motions making them slightly more accurate than axe chops."
	icon_state = "incut"
	blade_class = BCLASS_CUT
	attack_verb = list("cuts", "slashes")
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	animname = "cut"
	penfactor = 10
	chargetime = 0
	item_d_type = "slash"
	clickcd = 12 // Was already 12, it's just here to make it clear the cooldown is 1.2 second.

/datum/intent/axe/cut/onehanded
	name = "one-handed cut"
	desc = "Cutting and slashing motions making them slightly more accurate than axe chops. (slightly slower due to being one-handed)"
	clickcd = 14 // One-handed swings are logically slower.

/datum/intent/axe/chop
	name = "chop"
	desc = "Chopping and hacking motions leading to an concentrated blow that makes delimbing easier."
	icon_state = "inchop"
	blade_class = BCLASS_CHOP
	attack_verb = list("chops", "hacks")
	animname = "chop"
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	penfactor = 20
	damfactor = 1.1
	swingdelay = 10
	item_d_type = "slash"

/datum/intent/axe/chop/onehanded
	clickcd = 16 // One-handed chops are logically slower.
	swingdelay = 12 // One-handed chops are logically slower.
	penfactor = 32
	desc = "Chopping and hacking motions leading to an concentrated blow that makes delimbing easier. (slower due to being one-handed as well as slightly slower to land a hit)"

/datum/intent/axe/bash // Adds a worse non-lethal option.
	name = "bash"
	desc = "Blunt-siding strikes, tilting the axe to the blunt sides of it to whack others with."
	icon_state = "inbash"
	attack_verb = list("bashes", "whacks")
	animname = "strike"
	blade_class = BCLASS_BLUNT
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	chargetime = 0
	penfactor = 20
	swingdelay = 5 // Not aerodynamic, mixed with it not outshining blunt weapons.
	damfactor = 1.1
	item_d_type = "blunt"
	clickcd = 12 // Was already 12, it's just here to make it clear the cooldown is 1.2 second.

/datum/intent/axe/bash/onehanded
	clickcd = 14 // One-handed blashes are logically slower.
	swingdelay = 6 // One-handed blashes are logically slower.
	desc = "Blunt-siding strikes, tilting the axe to the blunt sides of it to whack others with."

/datum/intent/axe/bash/pommel // This isn't designed to be a serious combat move, more in the lines of ensure they don't die so, they can be captured move as such they don't require a one-handed version.
	icon_state = "inpunish"
	desc = "Hilt pommeling and striking motions, these ones are held back to ensure the opponent doesn't bleed out due to internal bleeding or humiliating opponents that lose to it."
	attack_verb = list("strike pommels", "hilt pommels")
	hitsound = list('sound/combat/hits/blunt/woodblunt (1).ogg', 'sound/combat/hits/blunt/woodblunt (2).ogg')
	penfactor = 15  // It's the handle.
	damfactor = 0.5 // The whole point of this is to ensure they don't perish from internal bleeding.
	swingdelay = 2

/obj/item/rogueweapon/stoneaxe
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	force = 18
	force_wielded = 20
	possible_item_intents = list(/datum/intent/axe/chop/stone, /datum/intent/axe/bash, /datum/intent/axe/bash/pommel)
	name = "stone axe"
	desc = "A rough stone axe. Badly balanced."
	icon_state = "stoneaxe"
	icon = 'icons/roguetown/weapons/32.dmi'
	item_state = "axe"
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	swingsound = BLADEWOOSH_MED
	associated_skill = /datum/skill/combat/axes
	max_blade_int = 100
	minstr = 8
	wdefense = 1
	w_class = WEIGHT_CLASS_BULKY
	wlength = WLENGTH_SHORT
	pickup_sound = 'sound/foley/equip/rummaging-03.ogg'
	gripped_intents = list(/datum/intent/axe/chop/stone, /datum/intent/axe/bash, /datum/intent/axe/bash/pommel)

/datum/intent/axe/chop/stone
	penfactor = 10

/obj/item/rogueweapon/stoneaxe/getonmobprop(tag)
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
			if("wielded")
				return list("shrink" = 0.6,
"sx" = -15,
"sy" = -1,
"nx" = 10,
"ny" = 0,
"wx" = -13,
"wy" = -1,
"ex" = 2,
"ey" = -1,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 0,
"sturn" = 0,
"wturn" = 0,
"eturn" = 0,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

/obj/item/rogueweapon/stoneaxe/battle
	force = 23
	force_wielded = 30
	possible_item_intents = list(/datum/intent/axe/cut/battle/onehanded, /datum/intent/axe/chop/battle/onehanded, /datum/intent/axe/bash/onehanded, /datum/intent/axe/bash/pommel)
	name = "battle axe"
	desc = "A steel battleaxe of war. Has a wicked edge."
	icon_state = "battleaxe"
	max_blade_int = 300
	smeltresult = /obj/item/ingot/steel
	gripped_intents = list(/datum/intent/axe/cut/battle, /datum/intent/axe/chop/battle, /datum/intent/axe/bash, /datum/intent/axe/bash/pommel)
	minstr = 12
	wdefense = 4

/datum/intent/axe/cut/battle
	penfactor = 30
	desc = "Cutting and slashing motions making them slightly more accurate than axe chops."

/datum/intent/axe/cut/battle/onehanded
	name = "one-handed cut"
	clickcd = 16 // One-handed swings are logically slower, especially for the battleaxe.
	desc = "Cutting and slashing motions making them slightly more accurate than axe chops. (slower due to being one-handed)"

/datum/intent/axe/chop/battle
	penfactor = 70
	damfactor = 1.2 // 36 on battleaxe.
	desc = "Chopping and hacking motions leading to an concentrated blow that makes delimbing easier."

/datum/intent/axe/chop/battle/onehanded
	clickcd = 16 // One-handed chops are logically slower, especially for the battleaxe.
	swingdelay = 12 // One-handed chops are logically slower, especially for the battleaxe.
	desc = "Chopping and hacking motions leading to an concentrated blow that makes delimbing easier. (slower to land due to being one-handed)"

/obj/item/rogueweapon/stoneaxe/battle/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = -7,"nx" = -6,"ny" = -3,"wx" = 3,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = 47,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

/obj/item/rogueweapon/stoneaxe/woodcut
	name = "axe"
	force = 20
	force_wielded = 26
	possible_item_intents = list(/datum/intent/axe/cut/onehanded, /datum/intent/axe/chop/onehanded, /datum/intent/axe/bash/onehanded, /datum/intent/axe/bash/pommel)
	desc = "A regular iron woodcutting axe."
	icon_state = "axe"
	max_blade_int = 400
	smeltresult = /obj/item/ingot/iron
	gripped_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop, /datum/intent/axe/bash, /datum/intent/axe/bash/pommel)
	wdefense = 2

/obj/item/rogueweapon/stoneaxe/handaxe
	force = 19
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop, /datum/intent/axe/bash, /datum/intent/axe/bash/pommel)
	name = "hatchet"
	desc = "An iron hand axe."
	icon_state = "hatchet"
	minstr = 1
	max_blade_int = 400
	smeltresult = /obj/item/ingot/iron
	gripped_intents = null
	wdefense = 2

/obj/item/rogueweapon/stoneaxe/woodcut/steel
	icon_state = "saxe"
	force = 22
	force_wielded = 28
	desc = "A steel woodcutting axe. Performs much better than its iron counterpart."
	force = 26
	max_blade_int = 500
	smeltresult = /obj/item/ingot/steel
	wdefense = 3

/obj/item/rogueweapon/stoneaxe/woodcut/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 2,"sy" = -8,"nx" = -6,"ny" = -3,"wx" = 3,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = 47,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
