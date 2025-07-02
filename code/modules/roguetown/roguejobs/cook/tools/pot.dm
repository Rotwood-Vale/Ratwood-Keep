/obj/item/reagent_containers/glass/bucket/pot
	force = 10
	name = "pot"
	desc = "A pot made out of iron"
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "pote"
	sharpness = IS_BLUNT
	slot_flags = null
	item_state = "pot"
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	sharpness = IS_BLUNT
	w_class = WEIGHT_CLASS_BULKY
	reagent_flags = OPENCONTAINER
	throwforce = 10
	//volume is same as buckets now, 198. (66oz) (whoever changed this to 300 before caused a lot of headaches)
	smeltresult = null
	var/active = FALSE // for the timer looping
	var/list/item_times = list() // items in the pot and their associated time
	var/datum/looping_sound/boilloop/boilloop // the pot boils now!

/obj/item/reagent_containers/glass/bucket/pot/stone
	name = "stone pot"
	desc = "A pot made out of stone"

/*
/obj/item/reagent_containers/glass/bucket/pot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/glass/bowl))
		var/obj/item/reagent_containers/glass/bowl/B = I 
		to_chat(user, "<span class='notice'>Filling the bowl...</span>")
		playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 70, FALSE)
		if(do_after(user,2 SECONDS, target = src))
			reagents.trans_to(B, reagents.total_volume)
			B.reagents.chem_temp = T20C // sloppy quick way to make it so any stew isn't boiling, will fix later
		return TRUE

	if(istype(I, /obj/item/reagent_containers/glass)) //ignore these for now I'll have to figure out something later
		return FALSE
	. = ..()
*/

/* Process */
obj/item/reagent_containers/glass/bucket/pot/proc/start_boiling()
	if(!active)
		active = TRUE
		boil()

/* Component Initialize */
obj/item/reagent_containers/glass/bucket/pot/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = AddComponent(/datum/component/storage/concrete/pot)
	STR.set_holdable(null, STR.cant_hold)
	boilloop = new(src, FALSE)

/* Destroy */
/obj/item/reagent_containers/glass/bucket/pot/Destroy()
	//active_recipes = null
	QDEL_NULL(boilloop)
	. = ..()
	item_times = list()

/obj/item/reagent_containers/glass/bucket/pot/update_icon()
	cut_overlays()
	if(reagents.total_volume > 0)
		if(reagents.total_volume <= 50)
			var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "pote_half")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			add_overlay(filling)

		if(reagents.total_volume > 50)
			var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "pote_full")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			add_overlay(filling)


/* Boil */
obj/item/reagent_containers/glass/bucket/pot/proc/boil()
	// We only get a timer if we have a boil
	// proc called, so don't do anything if called while one is active.
	if(!active)
		return 

	//If there's no reagents in the pot. 
	if(!reagents.get_reagents()) 
		boilloop.stop()
	
	//cools down if not on hearth
	if(!istype(loc, /obj/machinery/light/rogue/hearth))
		reagents.expose_temperature(T20C,  0.033) 

	if(reagents.chem_temp <= T20C)
		active = FALSE
		return

	// still process down to room temp even if no longer cooking
	if(reagents.chem_temp < T100C)
		boilloop.stop()

	// boiling code starts
	if(reagents.chem_temp >= T100C)
		boilloop.start()
		var/datum/component/storage/STR = GetComponent(/datum/component/storage)
		if(STR)
			var/list/things = STR.contents()

			for(var/obj/item/I in things)
				var/datum/pot_recipe/R = select_pot_recipe(GLOB.pot_recipes, I)
				if(!R)
					// For items with reagents we can render down but did not have a recipe.
					// Might need work if there's any fickle things added inside to a pot.
					if(!I.reagents)
						continue

					if(I.reagents.total_volume > 0)
						item_times[I] += 1
						var/render_time = I.reagents.total_volume * 5 // 3 is now 15 seconds etc...
						if(item_times[I] >= render_time) 
							var/true_volume_to_remove =  min(I.reagents.total_volume, reagents.get_reagent_amount(/datum/reagent/water))

							if(true_volume_to_remove > 0) //better place for this
								var/temp = reagents.chem_temp
								reagents.remove_reagent(/datum/reagent/water, true_volume_to_remove)
								reagents.add_reagent(I.reagents.get_reagents(), true_volume_to_remove, reagtemp = temp)

								I.reagents.trans_to(src, true_volume_to_remove)
								item_times -= I
								playsound(get_turf(src), "bubbles", 30, TRUE)
								qdel(I)
					continue

				if(R.output)
					item_times[I] += 1
				else
					continue

			for(var/J in item_times)
				var/datum/pot_recipe/R = select_pot_recipe(GLOB.pot_recipes, J)
				if(R)
					var/cooking_limit = R.cooking_time/10
					if(item_times[J] >= cooking_limit) //remove 10 for deciseconds
						STR.remove_from_storage(J)
						item_times -= J
						R.cook(src) 
						qdel(J)

	addtimer(CALLBACK(src, PROC_REF(boil)), 1 SECONDS)


// TO DO: Find a better place for this stuff eventually
GLOBAL_LIST_INIT(pot_recipes, init_subtypes(/datum/pot_recipe))

/* Select pot recipe */ //probably doesn't need to be a global proc but it's here if it's ever needed for other things.
/proc/select_pot_recipe(list/datum/recipe/available_recipes, obj/item/I )
	for(var/datum/pot_recipe/R in available_recipes)
		if(istype(I, R.input))
			if(R.check_can_cook())
				return R
	return FALSE


/*========
Pot Recipe
========*/
/datum/pot_recipe
	abstract_type = /datum/pot_recipe
	var/input = null
	var/water_conversion = 1
	var/volume_to_replace = 33 // How many regents you get from it (1/6th of a pot, 6 items makes 6 bowls of stew)
	var/datum/reagent/output = null // reagents you get
	var/cooking_time = 60 SECONDS //for the callback delay

/* Check can cook */
// Might only need to exist to do subtype checks (e.g. meat/mince versus meat/mince/fish)
/datum/pot_recipe/proc/check_can_cook()
	return TRUE

/* Cook */
/datum/pot_recipe/proc/cook(obj/item/reagent_containers/glass/bucket/pot/pot)
	if(!pot)
		return
	if(volume_to_replace <= 0)
		return
	if(!pot.reagents) // If we somehow lost all our reagents (either deleted or emptied before we finished)
		return

	// One final sanity check in case some lunatic empties some water but still keeps cooking and didn't hit 0 water or null reagents
	var/true_volume_to_remove =  min(volume_to_replace, pot.reagents.get_reagent_amount(/datum/reagent/water))

	if(true_volume_to_remove <= 0) //better place for this
		return
	var/temp = pot.reagents.chem_temp
	pot.reagents.remove_reagent(/datum/reagent/water, true_volume_to_remove)
	pot.reagents.add_reagent(output, true_volume_to_remove, reagtemp = temp)

	var/turf/pot_turf = get_turf(pot)
	playsound(pot_turf, "bubbles", 30, TRUE)

/* End cooking */
//Probably never needs to do more than this but here if you wanna do something special on ending
/datum/pot_recipe/proc/end_cooking(obj/item/reagent_containers/glass/bucket/pot/P)
	return

/*===========
Stew Variants
===========*/

/*===
Meats
===*/
/datum/pot_recipe/meat_stew
	input = /obj/item/reagent_containers/food/snacks/rogue/meat/mince
	output = /datum/reagent/consumable/soup/stew/meat
	cooking_time = 90 SECONDS

// So subtypes don't fire this... kind of annoying but oh well.
/datum/pot_recipe/meat_stew/check_can_cook(obj/item/I)
	var/list/dont_use = list(
		 /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet,
		 /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish,
		 /obj/item/reagent_containers/food/snacks/rogue/meat/spider )

	for(var/obj/item/reagent_containers/food/snacks/rogue/meat/M in dont_use)
		if(istype(I, M))
			return FALSE
	return TRUE

//uses whole meat slab
/datum/pot_recipe/meat_stew_slab
	input = /obj/item/reagent_containers/food/snacks/rogue/meat/steak
	volume_to_replace = 99 // 3 mince equivalent
	output = /datum/reagent/consumable/soup/stew/meat
	cooking_time = 120 SECONDS

//sausage variant
/datum/pot_recipe/meat_stew_sausage
	input = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage
	volume_to_replace = 66 // 2 mince equivalent
	output = /datum/reagent/consumable/soup/stew/meat
	cooking_time = 90 SECONDS

/datum/pot_recipe/fish_stew
	input = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	output = /datum/reagent/consumable/soup/stew/fish 
	cooking_time = 90 SECONDS

/datum/pot_recipe/chicken_stew
	input = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet
	output =  /datum/reagent/consumable/soup/stew/chicken
	cooking_time = 90 SECONDS

/datum/pot_recipe/spider_stew
	input = /obj/item/reagent_containers/food/snacks/rogue/meat/spider
	output = /datum/reagent/consumable/soup/stew/yucky
	cooking_time = 100 SECONDS

/*========
Vegetables
========*/
/datum/pot_recipe/potato_stew
	input = /obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced
	output = /datum/reagent/consumable/soup/veggie/potato
	cooking_time = 80 SECONDS

/datum/pot_recipe/onion_stew
	input =  /obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced
	output = /datum/reagent/consumable/soup/veggie/onion

/datum/pot_recipe/cabbage_stew
	input =  /obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced
	output = /datum/reagent/consumable/soup/veggie/cabbage
	cooking_time = 70 SECONDS

/datum/pot_recipe/beet_stew
	input = /obj/item/reagent_containers/food/snacks/grown/beet
	output = /datum/reagent/consumable/soup/veggie/beet

/*==
MISC
==*/
/datum/pot_recipe/oatmeal
	input =  /obj/item/reagent_containers/food/snacks/grown/oat
	output = /datum/reagent/consumable/soup/oatmeal
	cooking_time = 40 SECONDS

/datum/pot_recipe/porridge
	input =  /obj/item/reagent_containers/food/snacks/grown/wheat
	output = /datum/reagent/consumable/soup/porridge
	cooking_time = 40 SECONDS

/datum/pot_recipe/poo
	input =  /obj/item/natural/poo
	output = /datum/reagent/consumable/soup/poo


/*
new reagent groups
- I put them here just so there's no potential conflicts
- TO DO: move these somewhere better perhaps
*/

/datum/reagent/consumable/soup/poo
	name = "Shit"
	color = "#5e3534"
	taste_description = "something disgusting"
	nutriment_factor = 0

//Like murky water but slightly stronger
/datum/reagent/consumable/soup/poo/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(2)
	M.add_nausea(80)
	return ..()