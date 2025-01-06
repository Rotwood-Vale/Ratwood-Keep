/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*
 *		(Veggies)		*
 *						*
 * * * * * * * * * * * **/

/*	..................   Onion slice   ................... */
/obj/item/reagent_containers/food/snacks/grown/onion/rogue
	desc = "A wonderful vegetable with many layers and broad flavor profile."
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced
	tastes = list("onion" = 1)
	chopping_sound = TRUE
	dropshrink = 0.8
	
/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced
	name = "sliced onion"
	icon_state = "onion_sliced"
	slices_num = 0
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried
	cooked_smell = /datum/pollutant/food/fried_onion

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
	distill_reagent = /datum/reagent/consumable/ethanol/vodka
	distill_amt = 8

/*	..................   Turnip   ................... */
/obj/item/reagent_containers/food/snacks/rogue/veg/turnip_sliced
	name = "cleaned turnip"
	icon_state = "turnip_sliced"


/*	..................   Sunflower seeds   ................... */
/obj/item/reagent_containers/food/snacks/rogue/roastseeds
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("toasted sunflower seeds" = 1)
	name = "roasted seeds"
	desc = "Food for birds, treats for humens."
	icon_state = "cabbage_fried"
	color = "#e5b175"
	foodtype = VEGETABLES
	rotprocess = null
	eat_effect = /datum/status_effect/buff/foodbuff
