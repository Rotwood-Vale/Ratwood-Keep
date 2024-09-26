/* Tools for using with Pottery */

/* Items made from Pottery */

// Uncooked items -- Still need to be brought to a kiln
// Those are all children of natural/clay so that they can inherit the Glaze method.

/obj/item/natural/clay/clayBottle
	name = "unglazed clay bottle"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claybottleraw"
	desc = "A bottle fashioned from clay. Still needs to be glazed to be useful."
	cooked_type = /obj/item/reagent_containers/glass/bottle/clayBottle

/obj/item/reagent_containers/glass/bottle/clayBottle
	name = "clay vessel"
	desc = "A small bottle fashioned from clay."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claybottlecook"
	amount_per_transfer_from_this = 3
	possible_transfer_amounts = list(3)
	volume = 45 // Same as a glass bottle
	dropshrink = 0.5
	sellprice = 5
	closed = FALSE
	obj_flags = CAN_BE_HIT
	reagent_flags = OPENCONTAINER
	w_class =  WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')