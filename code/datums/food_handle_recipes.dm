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
	
	crafting_message = ""
	result = /obj/item/reagent_containers/food/snacks/rogue/cake_base

/*Cake base elaborate*/
// skips the butterdough step
/datum/food_handle_recipes/cake_base_elaborate
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdough,
		/obj/item/reagent_containers/food/snacks/egg ) 

	result = /obj/item/reagent_containers/food/snacks/rogue/cake_base

/*Cake base full */
// Does the whole thing from a dough base, use butter, egg,
/datum/food_handle_recipes/cake_base_full
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/reagent_containers/food/snacks/butterslice, 
		/obj/item/reagent_containers/food/snacks/egg ) 

	result = /obj/item/reagent_containers/food/snacks/rogue/cake_base

/* Cheese cake */
/datum/food_handle_recipes/cheese_cake
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/cake_base,
		/obj/item/reagent_containers/food/snacks/rogue/cheese )

	result = /obj/item/reagent_containers/food/snacks/rogue/ccakeuncooked

/* Zybantine cake */
/datum/food_handle_recipes/zybantine_cake
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/cake_base,
		/obj/item/reagent_containers/food/snacks/rogue/honey)

	result = /obj/item/reagent_containers/food/snacks/rogue/hcakeuncooked


/*==========
COOKED MEALS
==========*/

/* Frybird and Tato */
/datum/food_handle_recipes/frybirdtato
    items = list(
        /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried,
        /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried )

    result = /obj/item/reagent_containers/food/snacks/rogue/frybirdtato

/* Fried eggs */
/datum/food_handle_recipes/friedeggs
    items = list(
        /obj/item/reagent_containers/food/snacks/rogue/friedegg,
        /obj/item/reagent_containers/food/snacks/rogue/friedegg )

    result = /obj/item/reagent_containers/food/snacks/rogue/friedegg/two

/* Grenzelbun */
/datum/food_handle_recipes/hotdog
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/bun/,
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked )

	result = /obj/item/reagent_containers/food/snacks/rogue/bun_grenz


/* Omelette */
/datum/food_handle_recipes/omelette
    items = list(
        /obj/item/reagent_containers/food/snacks/rogue/friedegg/two, 
        /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge )

    result = /obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian


/* Onionsteak */
/datum/food_handle_recipes/onionsteak
    items = list(
        /obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried,
        /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried )

    result = /obj/item/reagent_containers/food/snacks/rogue/onionsteak

/* Peppersteak */
/datum/food_handle_recipes/peppersteak
    items = list(
        /obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried,
        /obj/item/reagent_containers/peppermill )
        
    result = /obj/item/reagent_containers/food/snacks/rogue/peppersteak

/* Wiener cabbage */
/datum/food_handle_recipes/wienercabbage
    items = list(
        /obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried, 
        /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked )

    result = /obj/item/reagent_containers/food/snacks/rogue/wienercabbage

/* Wiener meal */
/datum/food_handle_recipes/wienermeal
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked,
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked,
		/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried )

	result = /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions

/* Wiener onions */
/datum/food_handle_recipes/wieneronions
    items = list(
        /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried, 
        /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
    )
    result = /obj/item/reagent_containers/food/snacks/rogue/wieneronions

/* Wiener potato */
/datum/food_handle_recipes/wienerpotato
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked,
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked )

	result = /obj/item/reagent_containers/food/snacks/rogue/wienerpotato


/*============
DOUGH RECIPES
============*/

/* Dough */
/datum/food_handle_recipes/dough
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough_base,
		/obj/item/reagent_containers/powder/flour )

	result = /obj/item/reagent_containers/food/snacks/rogue/dough

/* Butterdough */
/datum/food_handle_recipes/butterdough
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/reagent_containers/food/snacks/butterslice )

	result = /obj/item/reagent_containers/food/snacks/rogue/butterdough

/* Raisinbread half */
/datum/food_handle_recipes/rbread_half
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/reagent_containers/food/snacks/rogue/raisins )

	result = /obj/item/reagent_containers/food/snacks/rogue/rbread_half

/* Hardtack raw*/
/datum/food_handle_recipes/hardtack_raw
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/kitchen/rollingpin ) //This could be a bit iffy...

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw

/* Cheese bun raw */
/datum/food_handle_recipes/cheesebun_raw
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/dough,
		/obj/item/reagent_containers/food/snacks/rogue/cheese ) 

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesebun_raw

/*Dough slice combination*/
/datum/food_handle_recipes/dough_slice_combine
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/doughslice,
		/obj/item/reagent_containers/food/snacks/rogue/doughslice ) 

	result = /obj/item/reagent_containers/food/snacks/rogue/dough

/*Crabcake raw*/
/datum/food_handle_recipes/crabcakeraw
	items = list(
		/obj/item/reagent_containers/food/snacks/fish/crab,
		/obj/item/reagent_containers/food/snacks/rogue/doughslice ) 

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/crabcakeraw

/datum/food_handle_recipes/pie_dough
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdough,
		/obj/item/reagent_containers/food/snacks/egg ) 

	result = /obj/item/reagent_containers/food/snacks/rogue/piedough

/datum/food_handle_recipes/pie_dough
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice,
		/obj/item/kitchen/rollingpin ) 

	result = /obj/item/reagent_containers/food/snacks/rogue/piedough

/datum/food_handle_recipes/raisin_biscuit_raw
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice,
		 /obj/item/reagent_containers/food/snacks/rogue/raisins ) 

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/biscuit_raw


//if(I.get_sharpness())
/datum/food_handle_recipes/pretzel
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice)

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/prezzel_raw




/datum/food_handle_recipes/rasinbread
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/rbread_half,
		/obj/item/reagent_containers/food/snacks/rogue/raisins )

	result = /obj/item/reagent_containers/food/snacks/rogue/rbreaduncooked

/datum/food_handle_recipes/rasinbread
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/rbread_half,
		/obj/item/reagent_containers/food/snacks/rogue/raisins )

	result = /obj/item/reagent_containers/food/snacks/rogue/rbreaduncooked



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
/datum/food_handle_recipes/handpie_meat
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/piedough,
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince )

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/mince

/datum/food_handle_recipes/handpie_berries
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/piedough,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue )

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/berry

/datum/food_handle_recipes/handpie_berries_poison
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/piedough,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison )

	result = /obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/poison

/*======
PASTRIES
======*/
/datum/food_handle_recipes/sweetroll
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/pastry/,
		/obj/item/reagent_containers/powder/sugar )

	result = /obj/item/reagent_containers/food/snacks/rogue/sweetroll

/*=====
SAMMICH
=====*/
/datum/food_handle_recipes/sammich_salami
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice,
		/obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice )

	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich/salami

/datum/food_handle_recipes/sammich_cheese
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice,
		/obj/item/reagent_containers/food/snacks/rogue/cheddarslice )

	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich/cheese

/datum/food_handle_recipes/sammich_egg
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice,
		/obj/item/reagent_containers/food/snacks/rogue/friedegg )

	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich/egg

/datum/food_handle_recipes/sammich_salo
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice,
		/obj/item/reagent_containers/food/snacks/fat/salo/slice )

	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich/salo


/datum/food_handle_recipes/sammich
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast,
		/obj/item/reagent_containers/food/snacks/butterslice )

	result = /obj/item/reagent_containers/food/snacks/rogue/breadslice/toast/buttered

/*======
SEA FOOD
======*/
/* Lobster meal */
/datum/food_handle_recipes/lobster_meal
	items = list(
		/obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster,
		/obj/item/reagent_containers/food/snacks/butterslice )

	result = /obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster/meal


/*
/obj/item/reagent_containers/food/snacks/rogue/meat/mince/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/mince))
		if(isturf(loc)&& (found_table))
			to_chat(user, "<span class='notice'>Stuffing a wiener...</span>")
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,long_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/meat/sausage(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/fat))
		if(isturf(loc)&& (found_table))
			to_chat(user, "<span class='notice'>Stuffing a wiener...</span>")
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,long_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/meat/sausage(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	else
		return ..()
*/
