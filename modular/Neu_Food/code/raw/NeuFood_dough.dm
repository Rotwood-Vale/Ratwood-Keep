/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*	- Basically add water to powder, then more powder
 *		 (Snacks)		*
 *						*
 * * * * * * * * * * * **/



/*	.................   Dough   ................... */
/obj/item/reagent_containers/food/snacks/rogue/dough_base
	name = "unfinished dough"
	desc = "With a little more ambition, you will conquer.(Add powder and knead to make dough)"
	icon_state = "dough_base"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/reagent_containers/food/snacks/rogue/dough
	name = "dough"
	desc = "The triumph of all bakers.(Bake to make bread, add butter to make butterdough, cut to make small dough, add three raisins to make Raisinloaf, roll to make Hardtack)"
	icon_state = "dough"
	slices_num = 2
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/doughslice
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/bread
	cooked_smell = /datum/pollutant/food/bread
	w_class = WEIGHT_CLASS_NORMAL
	slice_sound = TRUE 

/*	.................   Smalldough   ................... */
/obj/item/reagent_containers/food/snacks/rogue/doughslice
	name = "small dough"
	desc = "A smaller piece of dough, normally used on making delicious pastries (Bake to make a bun, add cheese to make a cheesebun, combine with small dough to make big dough)"
	icon_state = "doughslice"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/bun
	cooked_smell = /datum/pollutant/food/bun
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("dough" = 1)

/* ..............   Flat small dough   .............. */
/obj/item/reagent_containers/food/snacks/rogue/flatdoughsmall
	name = "flat dough"
	desc = "A smaller, flatter piece of dough."
	icon_state = "flatdough_small"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/pancake
	cooked_smell = /datum/pollutant/food/pastry
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("dough" = 1)


/*	.................   Butterdough   ................... */
/obj/item/reagent_containers/food/snacks/rogue/butterdough
	name = "butterdough"
	desc = "What is a triumph, to a legacy?(Slice to start making a pie, add cackleberry to make cake dough)"
	icon_state = "butterdough"
	color = "#feffc1"
	slices_num = 2
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/butterdoughslice
	w_class = WEIGHT_CLASS_NORMAL
	slice_sound = TRUE 

/*	.................   Butterdough piece   ................... */
/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice
	name = "butterdough piece"
	desc = "A slice of pedigree, to create lines of history.(Place in oven to make pastry, Roll to make pie dough, Fry to make Frybread, Add raisins to make a biscuit, Slice to make a prezzel)"
	icon_state = "butterdoughslice"
	color = "#feffc1"
	slices_num = 0
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/frybread
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pastry
	cooked_smell = /datum/pollutant/food/pastry
	w_class = WEIGHT_CLASS_NORMAL

/*	.................   Piedough   ................... */
/obj/item/reagent_containers/food/snacks/rogue/piedough
	name = "pie dough"
	desc = "The beginning of greater things to come.(Add mince or berries to make handpie!. Bake to make a pie shell)"
	icon_state = "piedough"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/foodbase/piebottom
	cooked_smell = /datum/pollutant/food/pie_base
	w_class = WEIGHT_CLASS_NORMAL


/*	.................   Hardtack   ................... */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw
	name = "raw hardtack"
	desc = "Doughy, soft, unacceptable."
	icon_state = "raw_tack"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = null

/obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked
	name = "hardtack"
	desc = "Very, very hard and dry."
	icon_state = "tack6"
	list_reagents = list(/datum/reagent/consumable/nutriment = DOUGH_NUTRITION)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("spelt" = 1)
	bitesize = 6
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "tack5"
	if(bitecount == 2)
		icon_state = "tack4"
	if(bitecount == 3)
		icon_state = "tack3"
	if(bitecount == 4)
		icon_state = "tack2"
	if(bitecount == 5)
		icon_state = "tack1"
	else
		icon_state = "tack6"


/*	.................   Bread   ................... */
/obj/item/reagent_containers/food/snacks/rogue/bread
	name = "bread loaf"
	desc = "One of the staple foods of the world, with the decline of magic, the loss of bread-duplication has led to mass famines around Grimoria.(Slice!)"
	icon_state = "loaf6"
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/breadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = DOUGH_NUTRITION)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1)
	slice_batch = FALSE
	slice_sound = TRUE 
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/rogue/bread/update_icon()
	if(slices_num)
		icon_state = "loaf[slices_num]"
	else
		icon_state = "loaf_slice"

/obj/item/reagent_containers/food/snacks/rogue/bread/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 5
		if(bitecount == 2)
			slices_num = 4
		if(bitecount == 3)
			slices_num = 3
		if(bitecount == 4)
			slices_num = 2
		if(bitecount == 5)
			changefood(slice_path, eater)

/*	.................   Breadslice & Toast   ................... */
/obj/item/reagent_containers/food/snacks/rogue/breadslice
	name = "sliced bread"
	desc = "A bit of comfort to start your dae. (Serve as is or add fried Cackleberry, cheese, butter, salo or salomi slices! Oven to toast it.)"
	icon_state = "loaf_slice"
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/breadslice/toast
	cooked_smell = /datum/pollutant/food/toast
	bitesize = 2
	rotprocess = SHELFLIFE_LONG
	dropshrink = 0.8
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)

//this is a child so we can be used in sammies
/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast
	name = "toast"
	icon_state = "toast"
	tastes = list("crispy bread" = 1)
	cooked_type = null
	bitesize = 2
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast/buttered
	name = "buttered toast"
	icon_state = "toast_butter"
	tastes = list("butter" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR+1)

// -------------- BREAD WITH FOOD ON IT (not american sandwich) -----------------
/obj/item/reagent_containers/food/snacks/rogue/sandwich
	desc = "A delightful piece of heaven, in every slice."
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR+1)
	rotprocess = 30 MINUTES
	bitesize = 2

/obj/item/reagent_containers/food/snacks/rogue/sandwich/salami
	tastes = list("salumoi" = 1,"bread" = 1)
	name = "salumoi bread"
	icon_state = "bread_salami"
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/rogue/sandwich/cheese
	tastes = list("cheese" = 1,"bread" = 1)
	name = "cheese bread"
	icon_state = "bread_cheese"
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/rogue/sandwich/egg
	tastes = list("cheese" = 1,"cackleberry" = 1)
	name = "cackleberry bread"
	icon_state = "bread_egg"
	foodtype = GRAIN | MEAT
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)
	eat_effect = /datum/status_effect/buff/snackbuff

/obj/item/reagent_containers/food/snacks/rogue/sandwich/salo
	tastes = list("salty fat" = 1)
	name = "salo bread"
	icon_state = "bread_salo"
	foodtype = GRAIN | MEAT
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	eat_effect = /datum/status_effect/buff/snackbuff

/*	.................   Bread bun   ................... */
/obj/item/reagent_containers/food/snacks/rogue/bun
	name = "bun"
	desc = "Portable, quaint and entirely consumable (Serve as is or add cooked sausage to make a Dogroll)"
	icon_state = "bun"
	list_reagents = list(/datum/reagent/consumable/nutriment = SMALLDOUGH_NUTRITION)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("bread" = 1)
	bitesize = 2
	rotprocess = SHELFLIFE_EXTREME

/*	.................   Cheese bun   ................... */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesebun_raw
	name = "raw cheese bun"
	desc = "Portable, quaint and entirely consumable"
	icon_state = "cheesebun_raw"
	color = "#ecce61"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/cheesebun
	cooked_smell = /datum/pollutant/food/cheese_bun
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/rogue/cheesebun
	name = "fresh cheese bun"
	desc = "A treat from the Grenzelhoft kitchen."
	icon_state = "cheesebun"
	list_reagents = list(/datum/reagent/consumable/nutriment = SMALLDOUGH_NUTRITION+FRESHCHEESE_NUTRITION)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("crispy bread and cream cheese" = 1)
	foodtype = GRAIN | DAIRY
	bitesize = 3
	rotprocess = SHELFLIFE_DECENT
	eat_effect = /datum/status_effect/buff/greatsnackbuff

/*  ..................   Frybread   ......................*/
/obj/item/reagent_containers/food/snacks/rogue/frybread
	name = "frybread"
	desc = "Flatbread fried at high heat with butter to give it a crispy outside. Staple of the elven kitchen."
	icon_state = "frybread"
	list_reagents = list(/datum/reagent/consumable/nutriment = BUTTERDOUGHSLICE_NUTRITION)
	tastes = list("crispy bread with a soft inside" = 1)
	foodtype = GRAIN | DAIRY | FRIED
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 3
	eat_effect = /datum/status_effect/buff/snackbuff

/*	.................   Pastry   ................... */
/obj/item/reagent_containers/food/snacks/rogue/pastry
	name = "pastry"
	desc = "Favored among children and sweetlovers. (Add sugar to make a sweetroll)"
	icon_state = "pastry"
	list_reagents = list(/datum/reagent/consumable/nutriment = BUTTERDOUGHSLICE_NUTRITION)
	tastes = list("crispy butterdough" = 1)
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 3
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = /datum/status_effect/buff/snackbuff
	foodtype = GRAIN | DAIRY

/* ..................   Pancake   .................. */
/obj/item/reagent_containers/food/snacks/rogue/pancake
	name = "pancake"
	desc = "Fluffy, delicious, and simple. An easy treat for all enjoyers of flat cakes."
	icon_state = "pancake"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	foodtype = SUGAR | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_EXTREME

//cake is 40 can feed 8 people okayish... 
/* .............   Pancake stack   ............. */
/obj/item/reagent_containers/food/snacks/rogue/pancake_stack
	name = "pancake stack"
	desc = "A large pile of pancakes."
	icon_state = "pancake_stack"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)
	foodtype = SUGAR | GRAIN
	bitesize = 3
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = /datum/status_effect/buff/snackbuff

/*	.................   Sweetroll   ................... */

/obj/item/reagent_containers/food/snacks/rogue/sweetroll
	name = "sweetroll"
	desc = "A pastry covered with sugar. The sweetlovers favourite."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "sweetroll"
	dropshrink = 0.75
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS + 1)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sugar and crispy dough" = 1)
	foodtype = SUGAR | GRAIN | DAIRY
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = /datum/status_effect/buff/snackbuff
	extra_eat_effect = /datum/status_effect/buff/sweet

/*	.................   Biscuit   ................... */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/biscuit_raw
	name = "uncooked raisin biscuit"
	icon_state = "biscuit_raw"
	color = "#ecce61"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/biscuit
	cooked_smell = /datum/pollutant/food/biscuit
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = null

/obj/item/reagent_containers/food/snacks/rogue/biscuit
	name = "biscuit"
	desc = "A treat made for a wretched dog like you."
	icon_state = "biscuit"
	filling_color = "#F0E68C"
	list_reagents = list(/datum/reagent/consumable/nutriment = BUTTERDOUGHSLICE_NUTRITION+SNACK_POOR)
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 3
	tastes = list("crispy butterdough" = 1, "raisins" = 1)
	foodtype = GRAIN | DAIRY | FRUIT
	eat_effect = /datum/status_effect/buff/greatsnackbuff


/*	.................   Prezzel   ................... */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/prezzel_raw
	name = "uncooked prezzel"
	icon_state = "prezzel_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/prezzel
	cooked_smell = /datum/pollutant/food/prezzel
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = null

/obj/item/reagent_containers/food/snacks/rogue/prezzel
	name = "prezzel"
	desc = "The next best thing since sliced bread, naturally, made by a dwarf."
	icon_state = "prezzel"
	list_reagents = list(/datum/reagent/consumable/nutriment = BUTTERDOUGHSLICE_NUTRITION)
	tastes = list("crispy butterdough" = 1)
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 3
	eat_effect = /datum/status_effect/buff/snackbuff
	foodtype = GRAIN | DAIRY

/*	.................   Raisin bread   ................... */
/obj/item/reagent_containers/food/snacks/rogue/rbread_half
	name = "half-done raisin dough"
	desc = "Add more raisins!"
	icon_state = "dough_raisin"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = 30 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/rbreaduncooked
	name = "loaf of raisins"
	icon_state = "raisinbreaduncooked"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/raisinbread
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = 30 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/raisinbread
	name = "raisin loaf"
	desc = "Bread enhanced with sweet raisins for a perfect addition to any meal."
	icon_state = "raisinbread6"
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/raisinbreadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_AVERAGE)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1,"dried fruit" = 1)
	slice_batch = FALSE
	slice_sound = TRUE 
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = /datum/status_effect/buff/snackbuff

/obj/item/reagent_containers/food/snacks/rogue/raisinbread/update_icon()
	if(slices_num)
		icon_state = "raisinbread[slices_num]"
	else
		icon_state = "raisinbread_slice"

/obj/item/reagent_containers/food/snacks/rogue/raisinbread/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 5
		if(bitecount == 2)
			slices_num = 4
		if(bitecount == 3)
			slices_num = 3
		if(bitecount == 4)
			slices_num = 2
		if(bitecount == 5)
			changefood(slice_path, eater)

/obj/item/reagent_containers/food/snacks/rogue/raisinbreadslice
	name = "raisin loaf slice"
	icon_state = "raisinbread_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = null
	tastes = list("spelt" = 1,"dried fruit" = 1)
	bitesize = 2
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/snackbuff
	dropshrink = 0.8

/*	.................   Cake   ................... */
/obj/item/reagent_containers/food/snacks/rogue/cake_base
	name = "cake base"
	desc = "With this sweet thing, you shall make them sing.(Add fresh cheese or honeycomb and bake!)"
	icon_state = "cake"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/cake_base_cooked
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/cake_base_cooked
	name = "plain cake"
	desc = "A simple plain cake for any non special occasion."
	icon_state = "cakeplain"
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	slices_num = 8
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cake_base_slice
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	rotprocess = SHELFLIFE_LONG
	slice_batch = TRUE
	slice_sound = TRUE 
	eat_effect = /datum/status_effect/buff/greatsnackbuff 
	bitesize = 16

/obj/item/reagent_containers/food/snacks/rogue/cake_base_slice
	name = "plaine cake slice"
	icon_state = "cakeplain_slice"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT-1)
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = null
	foodtype = GRAIN | DAIRY
	bitesize = 3
	eat_effect = /datum/status_effect/buff/greatsnackbuff 
	rotprocess = SHELFLIFE_LONG


/*	.................   Fruit Cake   ................... */
/obj/item/reagent_containers/food/snacks/rogue/cake_fruit
	name = "unbaked fruit cake"
	desc = "A cake of Valorian origin featuring a number of fruits."
	icon_state = "fruitcakeuncook"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fruit_cake_cooked
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | FRUIT
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/fruit_cake_cooked
	name = "fruit cake"
	desc = "A cake of Valoria origin featuring a number of fruits."
	icon_state = "fruitcake"
	list_reagents = list(/datum/reagent/consumable/nutriment = 40)
	tastes = list("cake"=1, "various fruits"=1)
	slices_num = 8
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/fruit_cake_slice
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | FRUIT
	rotprocess = SHELFLIFE_LONG
	slice_batch = TRUE
	slice_sound = TRUE 
	eat_effect = /datum/status_effect/buff/greatsnackbuff 
	bitesize = 16

/obj/item/reagent_containers/food/snacks/rogue/fruit_cake_slice
	name = "fruit cake slice"
	icon_state = "fruitcake_slice"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT-1)
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = null
	foodtype = GRAIN | DAIRY | FRUIT
	bitesize = 3
	eat_effect = /datum/status_effect/buff/greatsnackbuff 
	rotprocess = SHELFLIFE_LONG

/* Iced cake */
/obj/item/reagent_containers/food/snacks/rogue/icedcake
	name = "unbaked iced cake"
	desc = "A Lanternshore favorite. The cake is covered in a smooth layer of icing."
	icon_state = "icedcakeuncook"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/icedcake_cooked
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | SUGAR
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/icedcake_cooked
	name = "iced cake"
	desc = "A Lanternshore favorite. The cake is covered in a smooth layer of icing."
	icon_state = "icedcake"
	list_reagents = list(/datum/reagent/consumable/nutriment = 40)
	slices_num = 8
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/icedcake_slice
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "sugar"=1)
	foodtype = GRAIN | DAIRY | SUGAR
	rotprocess = SHELFLIFE_LONG
	slice_batch = TRUE
	slice_sound = TRUE 
	eat_effect = /datum/status_effect/buff/greatsnackbuff 
	bitesize = 16

/obj/item/reagent_containers/food/snacks/rogue/icedcake_slice
	name = "iced cake slice"
	icon_state = "icedcake_slice"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT-1)
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = null
	foodtype = GRAIN | DAIRY | SUGAR
	bitesize = 3
	eat_effect = /datum/status_effect/buff/greatsnackbuff 
	extra_eat_effect = /datum/status_effect/buff/sweet
	rotprocess = SHELFLIFE_LONG



/* ----- Venus Cake ----- */
/obj/item/reagent_containers/food/snacks/rogue/venuscake
	name = "unbaked venus cake"
	icon_state = "venuscakeuncook"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/venuscake_cooked
	cooked_smell = /datum/pollutant/food/honey_cake
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | FRUIT
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/venuscake_cooked
	name = "Venus cake"
	desc = "A berries covered cake."
	icon_state = "venuscake"
	slices_num = 8
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/venuscake_slice
	list_reagents = list(/datum/reagent/consumable/nutriment = 40)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "berries"=1)
	foodtype = GRAIN | DAIRY | FRUIT
	slice_batch = TRUE
	slice_sound = TRUE 
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/greatsnackbuff
	extra_eat_effect = /datum/status_effect/buff/sweet
	bitesize = 16

/obj/item/reagent_containers/food/snacks/rogue/venuscake_slice
	name = "Venus cake slice"
	icon_state = "venuscake_slice"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT-1)
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = null
	foodtype = GRAIN | DAIRY | FRUIT
	bitesize = 3
	eat_effect = /datum/status_effect/buff/greatsnackbuff 
	extra_eat_effect = /datum/status_effect/buff/sweet
	rotprocess = SHELFLIFE_LONG

// -------------- SPIDER-HONEY CAKE (Zybantu) -----------------
/obj/item/reagent_containers/food/snacks/rogue/hcakeuncooked
	name = "unbaked cake"
	icon_state = "honeycakeuncook"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/hcake
	cooked_smell = /datum/pollutant/food/honey_cake
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | SUGAR
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/hcake
	name = "zybantine cake"
	desc = "Cake glazed with honey, in the famous Zybantu fashion, a delicious sweet treat."
	icon_state = "honeycake"
	slices_num = 8
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/hcakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 40)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "delicious honeyfrosting"=1)
	foodtype = GRAIN | DAIRY | SUGAR
	slice_batch = TRUE
	slice_sound = TRUE 
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/greatsnackbuff
	extra_eat_effect = /datum/status_effect/buff/sweet
	bitesize = 16

/obj/item/reagent_containers/food/snacks/rogue/hcakeslice
	name = "zybantine cake slice"
	icon_state = "honeycakeslice"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT-1)
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = null
	foodtype = GRAIN | DAIRY | SUGAR
	bitesize = 3
	eat_effect = /datum/status_effect/buff/greatsnackbuff 
	extra_eat_effect = /datum/status_effect/buff/sweet
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/hcakeslice/plated
	icon_state = "honeycakeslice_plated"
	rotprocess = SHELFLIFE_EXTREME
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	trash = /obj/item/cooking/platter

// -------------- CHEESECAKE -----------------

/obj/item/reagent_containers/food/snacks/rogue/ccakeuncooked
	name = "unbaked cake of cheese"
	icon_state = "cheesecakeuncook"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/ccake
	cooked_smell = /datum/pollutant/food/cheese_cake
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	foodtype = GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/ccake
	name = "cheesecake"
	desc = "Humenity's favored creation."
	icon_state = "cheesecake"
	slices_num = 8
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/ccakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 40)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "creamy cheese"=1)
	foodtype = GRAIN | DAIRY | SUGAR
	slice_batch = TRUE
	slice_sound = TRUE 
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/snackbuff 
	extra_eat_effect = /datum/status_effect/buff/sweet
	bitesize = 16

/obj/item/reagent_containers/food/snacks/rogue/ccakeslice
	name = "cheesecake slice"
	icon_state = "cheesecake_slice"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT-1)
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = null
	foodtype = GRAIN | DAIRY | SUGAR
	bitesize = 2
	eat_effect = /datum/status_effect/buff/snackbuff 
	extra_eat_effect = /datum/status_effect/buff/sweet
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/ccakeslice/plated
	icon_state = "cheesecake_slice_plated"
	rotprocess = SHELFLIFE_EXTREME
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	trash = /obj/item/cooking/platter

/* maybe split up spider honey cake WIP
	desc = "A cake glazed with spider-honey, a favorite dish among the Dark Elf nobility in Grimoria. Symbol of authority, a delicious residue covers the sweet cake which causes playful stinging and numbness in the mouth."
*/
