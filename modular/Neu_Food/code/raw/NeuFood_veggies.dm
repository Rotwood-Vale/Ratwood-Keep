/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*
 *		(Veggies)		*
 *						*
 * * * * * * * * * * * **/


/*	..................   Onions   ................... */
/obj/item/reagent_containers/food/snacks/grown/onion/rogue
	desc = "A wonderful vegetable with many layers and broad flavor profile."
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced
	slices_num = 3
	tastes = list("onion" = 1)
	chopping_sound = TRUE
	dropshrink = 0.8

/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced
	name = "sliced onion"
	icon_state = "onion_sliced"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried
	cooked_smell = /datum/pollutant/food/fried_onion
	can_distill = TRUE
	distill_amt = 6

/*	..................   Cabbage   ................... */
/obj/item/reagent_containers/food/snacks/grown/cabbage/rogue
	desc = "A dense leafed vegetable, crunchy and ripe. A symbol of prosperity for elves"
	slices_num = 3
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced
	dropshrink = 0.7
	chopping_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced
	name = "shredded cabbage"
	icon_state = "cabbage_sliced"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried
	cooked_smell = /datum/pollutant/food/fried_cabbage


/*	..................   Potato   ................... */
/obj/item/reagent_containers/food/snacks/grown/potato/rogue
	desc = "A spud, dwarven icon of growth."
	eat_effect = null
	slices_num = 3
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked
	tastes = list("potato" = 1)
	chopping_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced
	name = "potato cuts"
	icon_state = "potato_sliced"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried
	cooked_smell = /datum/pollutant/food/baked_potato
	can_distill = TRUE
	distill_amt = 8

/obj/item/reagent_containers/food/snacks/rogue/veg/scalloped_potatoes
	name = "scalloped potatoes"
	desc = "A cheesey covering of baked potatoes."
	icon_state = "scalloped_potatoes"
	tastes = list("potato" = 1, "cheese" = 1)
	eat_effect = /datum/status_effect/buff/greatsnackbuff
