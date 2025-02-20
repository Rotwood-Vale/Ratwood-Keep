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
	tastes = list("onion" = 1)
	chopping_sound = TRUE
	dropshrink = 0.8
	slices_num = 2

/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced
	name = "sliced onion"
	icon_state = "onion_sliced"
	slices_num = 0
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried


/*	..................   Cabbage   ................... */
/obj/item/reagent_containers/food/snacks/grown/cabbage/rogue
	desc = "A dense leafed vegetable, crunchy and ripe. A symbol of prosperity for elves."
	slices_num = 3
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced
	chopping_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced
	name = "shredded cabbage"
	icon_state = "cabbage_sliced"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried


/*	..................   Potato   ................... */
/obj/item/reagent_containers/food/snacks/grown/potato/rogue
	desc = "A spud, dwarven icon of growth."
	eat_effect = null
	slices_num = 2
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked
	tastes = list("potato" = 1)
	chopping_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced
	name = "potato cuts"
	icon_state = "potato_sliced"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried

/obj/item/reagent_containers/food/snacks/grown/apple
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/fruit/apple_sliced
	slices_num = 3
	chopping_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/fruit/apple_sliced
	name = "apple slice"
	icon_state = "apple_sliced"
	desc = "A neatly sliced bit of apple. Nicer to eat. Refined, even."
	faretype = FARE_FINE
	tastes = list("airy apple" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)

/*	..................   Garlick   ................... */
/obj/item/reagent_containers/food/snacks/grown/garlick/rogue
	desc = "Hated by the foule vampyres that lurk in the dark. Garlick."
	eat_effect = null
	slices_num = 5
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/veg/garlick_clove
	tastes = list("pungent umami" = 1)
	chopping_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/veg/garlick_clove
	name = "garlick clove"
	icon_state = "garlic_clove"
	faretype = FARE_POOR
	desc = "A clove of garlick. Don't eat this."
	tastes = list("pungent umami" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)