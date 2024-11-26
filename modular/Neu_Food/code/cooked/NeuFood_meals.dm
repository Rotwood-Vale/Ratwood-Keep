/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*	- Defined as edible food that can be plated and usually needs rare tools or ingridients. Typically based on a snack but not necessarily
 *		 (Meals)		*
 *						*
 * * * * * * * * * * * **/



/*	..................   Pepper steak   ................... */
/obj/item/reagent_containers/food/snacks/rogue/peppersteak
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	tastes = list("steak" = 1, "pepper" = 1)
	name = "peppersteak"
	desc = "Roasted flesh flanked with a generous coating of ground pepper for intense flavor."
	faretype = FARE_FINE
	portable = FALSE
	icon_state = "peppersteak"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = SHELFLIFE_DECENT
	eat_effect = /datum/status_effect/buff/foodbuff
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/peppersteak/plated
	icon_state = "peppersteak_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_LAVISH
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG


/*	..................   Onion steak   ................... */
/obj/item/reagent_containers/food/snacks/rogue/onionsteak
	name = "onion steak"
	desc = "Roasted flesh garnished with tender fried onions. Fragrant and slathered with juices of both ingredients to a perfect mouth-watering sauce."
	icon_state = "onionsteak"
	tastes = list("steak" = 1, "onions" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)
	foodtype = MEAT
	faretype = FARE_NEUTRAL
	portable = FALSE
	warming = 5 MINUTES
	rotprocess = SHELFLIFE_DECENT
	eat_effect = /datum/status_effect/buff/foodbuff
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/onionsteak/plated
	icon_state = "onionsteak_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess =  SHELFLIFE_LONG


/*	.................   Wiener Cabbage   ................... */
/obj/item/reagent_containers/food/snacks/rogue/wienercabbage
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	tastes = list("savory sausage" = 1, "cabbage" = 1)
	name = "wiener on cabbage"
	desc = "A rich and heavy meal, a perfect ration for a soldier on the march."
	faretype = FARE_NEUTRAL
	portable = FALSE
	icon_state = "wienercabbage"
	foodtype = VEGETABLES | MEAT
	warming = 3 MINUTES
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/wienercabbage/plated
	icon_state = "wienercabbage_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_EXTREME


/*	.................   Wiener & Fried potato   ................... */
/obj/item/reagent_containers/food/snacks/rogue/wienerpotato
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	tastes = list("savory sausage" = 1, "potato" = 1)
	name = "wiener on tato"
	desc = "Stout and nourishing."
	faretype = FARE_NEUTRAL
	portable = FALSE
	icon_state = "wienerpotato"
	foodtype = VEGETABLES | MEAT
	warming = 3 MINUTES
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/wienerpotato/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(!experimental_inhand)
		return
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/wienerpotato/plated
	icon_state = "wienerpotato_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/rogue/wienerpotato/plated/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(!experimental_inhand)
		return
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions/plated(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/*	.................   Wiener & Fried onions   ................... */
/obj/item/reagent_containers/food/snacks/rogue/wieneronions
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	tastes = list("savory sausage" = 1, "fried onions" = 1)
	name = "wiener and onions"
	desc = "Stout and flavourful."
	faretype = FARE_NEUTRAL
	portable = FALSE
	icon_state = "wieneronion"
	foodtype = VEGETABLES | MEAT
	warming = 3 MINUTES
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/wieneronions/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(!experimental_inhand)
		return
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/wieneronions/plated
	icon_state = "wieneronion_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/rogue/wieneronions/plated/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(!experimental_inhand)
		return
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions/plated(loc)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.................   Wiener & potato & onions   ................... */
/obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	tastes = list("savory sausage" = 1, "potato" = 1)
	name = "wiener meal"
	desc = "Stout and nourishing."
	faretype = FARE_NEUTRAL
	portable = FALSE
	icon_state = "wpotonion"
	foodtype = VEGETABLES | MEAT
	warming = 3 MINUTES
	rotprocess = SHELFLIFE_DECENT
	eat_effect = /datum/status_effect/buff/foodbuff
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions/plated
	icon_state = "wpotonion_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG

/*	.................   Frybird & Tato   ................... */
/obj/item/reagent_containers/food/snacks/rogue/frybirdtato
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	tastes = list("frybird" = 1, "tato" = 1)
	name = "frybird with a tato"
	desc = "Hearty, comforting and rich - Alleged favorite dish of Ravox."
	faretype = FARE_FINE
	portable = FALSE
	icon_state = "frybirdtato"
	foodtype = VEGETABLES | MEAT
	warming = 3 MINUTES
	rotprocess = SHELFLIFE_DECENT
	eat_effect = /datum/status_effect/buff/foodbuff
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/frybirdtato/plated
	icon_state = "frybirdtato_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_LAVISH
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG


/*	.................   Valerian Omelette   ................... */
/obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	tastes = list("fried cackleberries" = 1, "cheese" = 1)
	name = "valerian omelette"
	desc = "Fried cackleberries on a bed of half-melted cheese, a dish from distant lands."
	faretype = FARE_FINE
	portable = FALSE
	icon_state = "omelette"
	eat_effect = /datum/status_effect/buff/foodbuff
	rotprocess = SHELFLIFE_DECENT
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian/plated
	icon_state = "omelette_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG

/*	.................   Plated fryfish   ................... */
/obj/item/reagent_containers/food/snacks/rogue/fryfish/carp/plated
	icon = 'modular/Neu_Food/icons/food.dmi'
	desc = "Abyssor's bounty, make sure to eat the eyes!"
	icon_state = "carpcooked_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_POOR // carp sucks
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish/plated
	icon = 'modular/Neu_Food/icons/food.dmi'
	desc = "Abyssor's bounty, make sure to eat the eyes!"
	icon_state = "clownfishcooked_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/fryfish/angler/plated
	icon = 'modular/Neu_Food/icons/food.dmi'
	desc = "Abyssor's bounty, make sure to eat the eyes!"
	icon_state = "anglercooked_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_NEUTRAL
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/fryfish/eel/plated
	icon = 'modular/Neu_Food/icons/food.dmi'
	desc = "Abyssor's bounty, make sure to eat the eyes!"
	icon_state = "eelcooked_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE // eel's pretty tasty
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG


/*	.................   Chicken roast   ................... */
/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked
	desc = "A plump bird, roasted to a perfect temperature and bears a crispy skin."
	eat_effect = null
	slices_num = 0
	name = "roast bird"
	icon_state = "roastchicken"
	faretype = FARE_FINE
	portable = FALSE
	tastes = list("tasty birdmeat" = 1)
	cooked_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	rotprocess = SHELFLIFE_DECENT
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/attackby(obj/item/I, mob/user, params)
	var/obj/item/reagent_containers/peppermill/mill = I
	if(istype(mill))
		if (!isturf(src.loc) || \
			!(locate(/obj/structure/table) in src.loc) && \
			!(locate(/obj/structure/table/optable) in src.loc) && \
			!(locate(/obj/item/storage/bag/tray) in src.loc))
			to_chat(user, span_warning("I need to use a table."))
			return FALSE

		if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			to_chat(user, "There's not enough black pepper to make anything with.")
			return FALSE

		mill.icon_state = "peppermill_grind"
		to_chat(user, "You start rubbing the bird roast with black pepper.")
		playsound(get_turf(user), 'modular/Neu_Food/sound/peppermill.ogg', 100, TRUE, -1)
		if(do_after(user,3 SECONDS, target = src))
			mill.icon_state = "peppermill"
			if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
				to_chat(user, "There's not enough black pepper to make anything with.")
				return FALSE

			mill.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)
			if (istype(src, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/plated))
				new /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/spiced/plated(loc)
			else new /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/spiced(loc)
			qdel(src)
		else
			mill.icon_state = "peppermill"
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/spiced
	desc = "A plump bird, roasted perfection, spiced to taste divine."
	eat_effect = /datum/status_effect/buff/foodbuff
	name = "spiced bird-roast"
	faretype = FARE_LAVISH
	portable = FALSE
	color = "#ffc0c0"
	tastes = list("spicy birdmeat" = 1)
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/plated
	icon_state = "roastchicken_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_LAVISH
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/spiced/plated
	icon_state = "roastchicken_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_LAVISH
	portable = FALSE
	color = "#ffc0c0"
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG


/*	.................   Cooked rat   ................... */
/obj/item/reagent_containers/food/snacks/rogue/friedrat/plated
	icon = 'modular/Neu_Food/icons/food.dmi'
	desc = "The beggar's feast."
	icon_state = "cookedrat_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_IMPOVERISHED
	portable = FALSE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_LONG

