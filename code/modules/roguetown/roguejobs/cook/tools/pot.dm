/obj/item/reagent_containers/glass/pot
	force = 10
	throwforce = 15
	possible_item_intents = list(INTENT_GENERIC)
	name = "glass pot"
	desc = "A delicate glass pot."
	icon_state = "pot"
	icon = 'icons/roguetown/items/cooking.dmi'
	item_state = "rods"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	sharpness = IS_BLUNT
	w_class = WEIGHT_CLASS_BULKY
	amount_per_transfer_from_this = 9 //hard to transfer
	possible_transfer_amounts = list(9)
	volume = 99
	reagent_flags = OPENCONTAINER|REFILLABLE
	spillable = TRUE
	possible_item_intents = list(INTENT_GENERIC, /datum/intent/fill, INTENT_POUR, INTENT_SPLASH)
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	slot_flags = null

/obj/item/reagent_containers/glass/pot/stone
	//for stone crafting.
	name = "stone pot"
	desc = "A rough stone pot."

/obj/item/reagent_containers/glass/pot/iron
	//for stone crafting.
	name = "iron pot"
	desc = "A smooth iron pot."
