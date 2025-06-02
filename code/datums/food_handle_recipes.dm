// ================================================= // 
// SEE: NeuFood_recipes.dm for the layout of this datum
// ================================================= //

/*===
CAKES
===*/

/*Cake base*/
/datum/food_handle_recipes/cake_base
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdough,
		/obj/item/reagent_containers/food/snacks/egg ) 
	
	crafting_message = "You start making a cake base..."
	craft_sound = 'modular/Neu_Food/sound/eggbreak.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/cake_base

/*Cake base full */
// Does the whole thing from a dough,  butter, egg,
/datum/food_handle_recipes/cake_base_full
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/reagent_containers/food/snacks/butterslice, 
		/obj/item/reagent_containers/food/snacks/egg ) 

	crafting_message = "You start making a cake base..."
	craft_sound = 'modular/Neu_Food/sound/eggbreak.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/cake_base

/* Cheese cake */
/datum/food_handle_recipes/cheese_cake
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/cake_base,
		/obj/item/reagent_containers/food/snacks/rogue/cheese )
	crafting_message = "You start making a cheesecake..."
	craft_sound = 'sound/foley/dropsound/food_drop.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/ccakeuncooked


/* Fruit cake */
/datum/food_handle_recipes/fruit_cake
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/cake_base,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue,
		/obj/item/reagent_containers/food/snacks/grown/apple )
	crafting_message = "You start making a fruitcake..."
	craft_sound = 'sound/foley/dropsound/food_drop.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/cake_fruit

/* Iced cake */
/datum/food_handle_recipes/iced_cake
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/cake_base,
		/obj/item/reagent_containers/powder/sugar)
	crafting_message = "You start making an iced cake..."
	craft_sound = 'sound/foley/dropsound/food_drop.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/icedcake


/* Pancake stack*/
/datum/food_handle_recipes/pancake_stack
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/pancake,
		/obj/item/reagent_containers/food/snacks/rogue/pancake)
	crafting_message = "You start making a pancake stack..."
	craft_sound = 'sound/foley/dropsound/food_drop.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/pancake_stack



/* Venus cake */
/datum/food_handle_recipes/venus_cake
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/cake_base,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue)
	crafting_message = "You start making a Venus cake..."
	craft_sound = 'sound/foley/dropsound/food_drop.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/venuscake



/* Zybantine cake */
/datum/food_handle_recipes/zybantine_cake
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/cake_base,
		/obj/item/reagent_containers/food/snacks/rogue/honey)
	crafting_message = "You start making a honey cake..."
	craft_sound = 'sound/foley/dropsound/food_drop.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/hcakeuncooked


/*==========
COOKED MEALS
==========*/

/* Frybird and Tato */
/datum/food_handle_recipes/frybirdtato
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried,
		/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried )	
	crafting_message = "You start making frybird and tato..."
	result = /obj/item/reagent_containers/food/snacks/rogue/frybirdtato

/* Fried eggs */
/datum/food_handle_recipes/friedeggs
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/friedegg,
		/obj/item/reagent_containers/food/snacks/rogue/friedegg )
	crafting_message = "You start combining the eggs..."
	result = /obj/item/reagent_containers/food/snacks/rogue/friedegg/two

/datum/food_handle_recipes/friedeggs/pre_check(user, to_check)
	for(var/obj/I in to_check)
		if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/friedegg/two))
			return FALSE
	return TRUE

/* Grenzelbun */
/datum/food_handle_recipes/hotdog
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/bun/,
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked )
	crafting_message = "You start putting the sausage into the bun..."
	result = /obj/item/reagent_containers/food/snacks/rogue/bun_grenz

/* Meatballs */
/datum/food_handle_recipes/meatballs
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince, 
		/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced)
	crafting_message = "You start making forming meatballs..."
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/meatballs_raw

/* Omelette */
/datum/food_handle_recipes/omelette
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/friedegg/two, 
		/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge )
	crafting_message = "You start making an omelette..."
	result = /obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian


/* Onionsteak */
/datum/food_handle_recipes/onionsteak
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried,
		/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried )
	crafting_message = "You start combining the onion and steak..."
	result = /obj/item/reagent_containers/food/snacks/rogue/onionsteak

/* Peppersteak */
/datum/food_handle_recipes/peppersteak
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried,
		/obj/item/reagent_containers/peppermill )
	crafting_message = "You start making a peppersteak..."
	result = /obj/item/reagent_containers/food/snacks/rogue/peppersteak

/datum/food_handle_recipes/peppersteak/pre_check(user, to_check)
	for(var/obj/item/reagent_containers/peppermill/P in to_check)
		if(!P.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			return FALSE
	return TRUE

/datum/food_handle_recipes/peppersteak/post_handle(user, to_check)
	for(var/obj/item/reagent_containers/peppermill/P in to_check)
		P.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)


/* sausage roll */
/datum/food_handle_recipes/sausageroll
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/doughslice,
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince )
	crafting_message = "You start making a sausage roll..."       
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/sausageroll_raw

/* Scallped potatoes */
/datum/food_handle_recipes/scallped_potatoes
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried,
		/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge,)
	crafting_message = "You start making scalloped potatoes..."       
	result = /obj/item/reagent_containers/food/snacks/rogue/veg/scalloped_potatoes

/* Spicy bird */
/datum/food_handle_recipes/spicybird
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/,
		/obj/item/reagent_containers/peppermill )
	crafting_message = "You start making a spicy bird..."
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/spiced

/datum/food_handle_recipes/spicybird/pre_check(user, to_check)
	for(var/obj/item/reagent_containers/peppermill/P in to_check)
		if(!P.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			return FALSE
	return TRUE

/datum/food_handle_recipes/spicybird/post_handle(user, to_check)
	for(var/obj/item/reagent_containers/peppermill/P in to_check)
		P.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)


/* Wiener cabbage */
/datum/food_handle_recipes/wienercabbage
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried, 
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked )
	crafting_message = "You start combining the sausage and cabbage..."
	result = /obj/item/reagent_containers/food/snacks/rogue/wienercabbage

/* Wiener meal */
/datum/food_handle_recipes/wienermeal
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked,
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked,
		/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried )
	crafting_message = "You start making a wiener meal..."
	result = /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions

/* Wiener onions */
/datum/food_handle_recipes/wieneronions
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried, 
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked 
		)
	crafting_message = "You start combining the sausage and onions..."	
	result = /obj/item/reagent_containers/food/snacks/rogue/wieneronions

/* Wiener onions to meal */
/datum/food_handle_recipes/wieneronionstomeal
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/wieneronions, 
		/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked 
		)
	crafting_message = "You start making a wiener meal..."
	result = /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions

/* Wiener potato */
/datum/food_handle_recipes/wienerpotato
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked,
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked )
	crafting_message = "You start combining the sausage with the potato..."
	result = /obj/item/reagent_containers/food/snacks/rogue/wienerpotato

/* Wiener potato to meal */
/datum/food_handle_recipes/wienerpotatotomeal
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/wienerpotato,
		/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried )
	crafting_message = "You start making a wiener meal..."
	result = /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions

/*============
DOUGH RECIPES
============*/

/* Wet Dough */
// This was the most insane use case
// On one end I'm mad, on the other end this
// Probably solved any and all edge cases
// Thank you crazy person who made dough the way it is. - Fridge
/datum/food_handle_recipes/dough_wet
	items = list(
		/obj/item/reagent_containers/powder/flour,
		/obj/item/reagent_containers )
	crafting_message = "You wetting the dough..."
	result = null
	craft_sound = 'modular/Neu_Food/sound/splishy.ogg'

/datum/food_handle_recipes/dough_wet/pre_check(user, to_check)
	var/wet = 0
	var/water = 0
	for(var/obj/item/reagent_containers/R in to_check)
		if(istype(R, /obj/item/reagent_containers/powder/flour))
			var/obj/item/reagent_containers/powder/flour/F = R
			if(F.water_added)
				wet = 1
		if(!istype(R, /obj/item/reagent_containers/powder/flour))
			if((R.reagents.has_reagent(/datum/reagent/water, 10)))
				water = 1
	if(wet)
		return FALSE // There might be a better way to do this but it should work
	if(water)
		return TRUE
	return FALSE

/datum/food_handle_recipes/dough_wet/post_handle(user, to_check)
	for(var/obj/item/reagent_containers/powder/flour/F in to_check)
		F.name = "wet powder"
		F.desc = "Destined for greatness, at your hands."
		F.water_added = TRUE
		F.color = "#d9d0cb"	

	for(var/obj/item/reagent_containers/R in to_check)
		if(!istype(R, /obj/item/reagent_containers/powder/flour))
			R.reagents.remove_reagent(/datum/reagent/water, 10)
			break
	..()

// Specific code again to show overriding
// This dough code has been the gold standard.
// Please consult this when understanding how to deal with special cases.
/datum/food_handle_recipes/dough_wet/clear_items(list/itemlist)
	return


/* Dough base */
/datum/food_handle_recipes/dough_base
	items = list(
		/obj/item/reagent_containers/powder/flour, )
	interaction_type = FOOD_INTERACTION_HAND //uses attackhand
	crafting_message = "You start shaping the dough..."
	result = /obj/item/reagent_containers/food/snacks/rogue/dough_base
	craft_sound = 'modular/Neu_Food/sound/kneading.ogg'

/datum/food_handle_recipes/dough_base/pre_check(user, to_check)
	for(var/obj/item/reagent_containers/powder/flour/F in to_check)
		if(!F.water_added)
			return FALSE
	return TRUE

/datum/food_handle_recipes/dough_base/post_handle(user, to_check)
	for(var/obj/I in to_check)
		qdel(I)

/* Dough */
/datum/food_handle_recipes/dough
	items = list(
		/obj/item/reagent_containers/powder/flour,
		/obj/item/reagent_containers/food/snacks/rogue/dough_base ) 
	crafting_message = "You begin to finish the dough..."
	result = /obj/item/reagent_containers/food/snacks/rogue/dough
	craft_sound = 'modular/Neu_Food/sound/kneading.ogg'


/* Butterdough */
/datum/food_handle_recipes/butterdough
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/reagent_containers/food/snacks/butterslice )
	crafting_message = "You start working the butter into the dough..."
	craft_sound = 'modular/Neu_Food/sound/kneading_alt.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/butterdough

/* Butterdough reassemble */
/datum/food_handle_recipes/butterdough_reassemble
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice,
		/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice )
	crafting_message = "You start putting the butterdough back together..."
	craft_sound = 'modular/Neu_Food/sound/kneading.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/butterdough

/* Raisinbread half */
/datum/food_handle_recipes/rbread_half
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/reagent_containers/food/snacks/rogue/raisins )
	crafting_message = "You start working some raisins into the dough..."
	craft_sound = 'modular/Neu_Food/sound/kneading.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/rbread_half

/* Raisinbread full */
/datum/food_handle_recipes/rbread_full
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/rbread_half,
		/obj/item/reagent_containers/food/snacks/rogue/raisins )
	crafting_message = "You start finishing the raisin bread..."
	craft_sound = 'modular/Neu_Food/sound/kneading.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/rbreaduncooked


/* Hardtack raw*/
/datum/food_handle_recipes/hardtack_raw
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/kitchen/rollingpin )
	crafting_message = "You begin making some hardtack..."
	craft_sound = 'modular/Neu_Food/sound/rollingpin.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw

/* Cheese bun raw */
/datum/food_handle_recipes/cheesebun_raw
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/doughslice,
		/obj/item/reagent_containers/food/snacks/rogue/cheese ) 
	crafting_message = "You start making a cheesebun..."
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesebun_raw

// Good example below of the utility of this sytem (however I suppose it could be better with multiple lists?)

/* Dough slice combination */
/datum/food_handle_recipes/dough_slice_combine
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/doughslice,
		/obj/item/reagent_containers/food/snacks/rogue/doughslice ) 
	crafting_message = "You merge the dough back together..."
	result = /obj/item/reagent_containers/food/snacks/rogue/dough

/* Dough slice + flat combination */
/datum/food_handle_recipes/dough_slice_flat_combine
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/flatdoughsmall,
		/obj/item/reagent_containers/food/snacks/rogue/doughslice ) 
	crafting_message = "You merge the dough back together..."
	result = /obj/item/reagent_containers/food/snacks/rogue/dough

/* Dough flat + flat combination */
/datum/food_handle_recipes/dough_flat_flat_combine
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/flatdoughsmall,
		/obj/item/reagent_containers/food/snacks/rogue/flatdoughsmall ) 
	crafting_message = "You merge the dough back together..."
	result = /obj/item/reagent_containers/food/snacks/rogue/dough


/* Crabcake raw */
/datum/food_handle_recipes/crabcakeraw
	items = list(
		/obj/item/reagent_containers/food/snacks/fish/crab,
		/obj/item/reagent_containers/food/snacks/rogue/doughslice ) 
	crafting_message = "You roll the crab around into the dough..."
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/crabcakeraw

/* Pie dough */
/datum/food_handle_recipes/pie_dough
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice,
		/obj/item/kitchen/rollingpin ) 
	crafting_message = "You start flattening the butterdough out..."
	craft_sound = 'modular/Neu_Food/sound/rollingpin.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/piedough

/* small flat dough */
/datum/food_handle_recipes/small_flat_dough
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/doughslice,
		/obj/item/kitchen/rollingpin ) 
	crafting_message = "You start to flatten the dough out..."
	craft_sound = 'modular/Neu_Food/sound/rollingpin.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/flatdoughsmall


/* Raw biscuit */
/datum/food_handle_recipes/raisin_biscuit_raw
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice,
			/obj/item/reagent_containers/food/snacks/rogue/raisins ) 
	crafting_message = "You start making a biscuit..."
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/biscuit_raw

/* Prezzel */
/datum/food_handle_recipes/prezzel
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice)
	crafting_message = "You start slicing the dough into strips to make a prezzel..."
	craft_sound = 'sound/foley/dropsound/food_drop.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/prezzel_raw

/datum/food_handle_recipes/prezzel/pre_check(user, to_check)
	for(var/obj/item/I in to_check)
		if(I.get_sharpness())
			return TRUE
	return FALSE
	

/*=======
HAND PIES
=======*/

//Doesn't currently exist?
/*
/datum/food_handle_recipes/handpie_mushroom
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/piedough,
		/obj/item/reagent_containers/food/snacks/rogue/truffles )

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/mushroom
*/

/* Handpie meat */
/datum/food_handle_recipes/handpie_meat
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/piedough,
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince )
	crafting_message = "You stuff the meat into the dough..."
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/mince

/* Handpie berries */
/datum/food_handle_recipes/handpie_berries
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/piedough,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue )
	crafting_message = "You stuff the berries into the dough..."
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/berry

/* Handpie poison */
/datum/food_handle_recipes/handpie_berries_poison
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/piedough,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison )
	crafting_message = "You stuff the berries into the dough..."
	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/poison

/*==
MISC
==*/
// If enough show up for a category, set it.


/* Candy base */
/datum/food_handle_recipes/candy_base
	items = list(
		/obj/item/reagent_containers/powder/sugar )
	interaction_type = FOOD_INTERACTION_HAND //uses attackhand
	crafting_message = "You start working the sugar..."
	craft_sound = 'modular/Neu_Food/sound/kneading.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/candybase

/datum/food_handle_recipes/candy_base/pre_check(user, to_check)
	for(var/obj/item/reagent_containers/powder/flour/F in to_check)
		if(!F.water_added)
			return FALSE
	return TRUE

/* Candy apple */
/datum/food_handle_recipes/candy_apple
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/candybase,
		/obj/item/reagent_containers/food/snacks/grown/apple )
	crafting_message = "You massage the apple into the candy..."
	craft_sound = 'modular/Neu_Food/sound/kneading.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/applecandy

/* Candy berry */
/datum/food_handle_recipes/candy_berry
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/candybase,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue )
	crafting_message = "You massage the berries into the candy..."
	craft_sound = 'modular/Neu_Food/sound/kneading.ogg'
	result = /obj/item/reagent_containers/food/snacks/rogue/berrycandy

/*======
PASTRIES
======*/
/* Sweet roll */
/datum/food_handle_recipes/sweetroll
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/pastry/,
		/obj/item/reagent_containers/powder/sugar )
	crafting_message = "You start to cover the pastry in sugar..."
	result = /obj/item/reagent_containers/food/snacks/rogue/sweetroll

/*========
RAW COMBOS
========*/

/* Sausage */
/datum/food_handle_recipes/sausage
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince,
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince )
	crafting_message = "You start forming a susage..."
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage

/* Sausage fat */
/datum/food_handle_recipes/sausage_fat
	items = list(
		/obj/item/reagent_containers/food/snacks/fat/,
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince )
	crafting_message = "You start forming a susage..."
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage

/* Sausage fish */
/datum/food_handle_recipes/sausage_fish
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish,
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish )
	crafting_message = "You start forming a susage..."
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage

/*=====
SAMMICH
=====*/
/* Sammich salami */
/datum/food_handle_recipes/sammich_salami
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice,
		/obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice )
	crafting_message = "You start making salumoi bread..."
	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich/salami

/* Sammich cheese */
/datum/food_handle_recipes/sammich_cheese
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice,
		/obj/item/reagent_containers/food/snacks/rogue/cheddarslice )
	crafting_message = "You start making cheese bread..."
	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich/cheese

/* Sammich egg */
/datum/food_handle_recipes/sammich_egg
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice,
		/obj/item/reagent_containers/food/snacks/rogue/friedegg )
	crafting_message = "You start making egg bread..."
	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich/egg

/* Sammich salo */
/datum/food_handle_recipes/sammich_salo
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice,
		/obj/item/reagent_containers/food/snacks/fat/salo/slice )
	crafting_message = "You start making salo bread..."
	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich/salo

/* Sammich buttered toast */
/datum/food_handle_recipes/sammich
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast,
		/obj/item/reagent_containers/food/snacks/butterslice )
	crafting_message = "You start making buttered bread..."
	result = /obj/item/reagent_containers/food/snacks/rogue/breadslice/toast/buttered

/*======
SEA FOOD
======*/

/* Lobster meal */
/datum/food_handle_recipes/lobster_meal
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster,
		/obj/item/reagent_containers/food/snacks/butterslice )
	crafting_message = "You start making a lobster meal..."
	result = /obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster/meal
