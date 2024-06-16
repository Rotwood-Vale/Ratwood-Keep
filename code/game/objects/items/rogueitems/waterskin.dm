/obj/item/reagent_containers/glass/bottle/waterskin
	name = "waterskin"
	desc = "A leather waterskin."
	icon_state = "waterskin"
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(3,6,9)
	volume = 64
	dropshrink = 0.5
	sellprice = 5
	closed = FALSE
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	obj_flags = CAN_BE_HIT
	reagent_flags = OPENCONTAINER
	w_class =  WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	sewrepair = TRUE

