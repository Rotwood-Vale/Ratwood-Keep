/obj/item/cooking/pan
	force = 20
	throwforce = 15
	possible_item_intents = list(/datum/intent/mace/strike/pan)
	name = "frypan"
	desc = "Two in one: Cook and smash heads."
	icon_state = "pan"
	wlength = WLENGTH_SHORT
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	can_parry = TRUE
	swingsound = list('sound/combat/wooshes/blunt/shovel_swing.ogg','sound/combat/wooshes/blunt/shovel_swing2.ogg')
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	wdefense = 5
	ingsize = 3

/obj/item/cooking/pan/examine(mob/user)
	. = ..()

/datum/intent/mace/strike/pan
	hitsound = list('sound/combat/hits/blunt/melee_frying_pan_01.ogg', 'sound/combat/hits/blunt/melee_frying_pan_02.ogg', 'sound/combat/hits/blunt/melee_frying_pan_03.ogg', 'sound/combat/hits/blunt/melee_frying_pan_04.ogg')
