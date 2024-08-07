/* Tools for using with Pottery */

/* Items made from Pottery */

// Uncooked items -- Still need to be brought to a kiln
// Those are all children of natural/clay so that they can inherit the Glaze method.

/obj/item/natural/clay/clayBottle
	name = "unglazed clay bottle"
	icon_state = "stone1" // TODO
	desc = "A bottle fashioned from clay. Still needs to be glazed to be useful."
    glazed_result = /obj/item/reagent_containers/glass/bottle/clayBottle

/obj/item/natural/clay/clayJug
	name = "unglazed clay jug"
	icon_state = "stone1" // TODO
	desc = "A jug fashioned from clay. Still needs to be glazed to be useful."
    w_class =  WEIGHT_CLASS_BULKY
    glazed_result = /obj/item/reagent_containers/glass/bottle/clayBottle/clayJug

/obj/item/natural/clay/clayVase
	name = "unglazed clay vase"
	icon_state = "stone1" // TODO
	desc = "A very big vase made from clay. Still needs to be glazed to be useful."
    w_class =  WEIGHT_CLASS_HUGE
    glazed_result = /obj/item/reagent_containers/glass/bottle/clayBottle/clayVase



// Clay bottles are like glass bottles, but they don't have corks.
/obj/item/reagent_containers/glass/bottle/clayBottle
	name = "clay vessel"
	desc = "A small bottle fashioned from clay."
	icon_state = "" // TODO
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

// Basically a high-end bucket. 
/obj/item/reagent_containers/glass/bottle/clayBottle/clayJug
	name = "clay galloon jug"
	desc = "A sizeable jug made from clay. Keeps your beverages cool and refreshing."
	icon_state = "" // TODO
	amount_per_transfer_from_this = 20 // Easy to pour out of.
	possible_transfer_amounts = list(20)
	volume = 150 // 1.5x Bigger than a bucket
	sellprice = 10
    slot_flags = ITEM_SLOT_HIP
    w_class =  WEIGHT_CLASS_BULKY
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')

// High-end clay recipe, something like a portable bin.
/obj/item/reagent_containers/glass/bottle/clayBottle/clayVase
	name = "clay vase"
	desc = "A really big clay bottle."
	icon_state = "" // TODO
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(20)
	volume = 300
	sellprice = 20
	w_class =  WEIGHT_CLASS_HUGE
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
