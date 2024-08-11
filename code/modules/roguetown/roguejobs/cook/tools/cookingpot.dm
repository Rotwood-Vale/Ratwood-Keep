/obj/item/cooking/cookingpot
	force = 20
	throwforce = 15
	possible_item_intents = list(/datum/intent/mace/strike/shovel)
	name = "steel cooking pot"
	desc = "Two in one: Cook and smash heads."
	icon_state = "cookingpan"
	icon = 'icons/roguetown/items/cooking.dmi'
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	wlength = WLENGTH_SHORT
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	slot_flags = ITEM_SLOT_HIP
	can_parry = FALSE
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	wdefense = 5
	ingsize = 3

/obj/item/cooking/pan/examine(mob/user)
	. = ..()
