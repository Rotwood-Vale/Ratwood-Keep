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
	var/list/active_recipes = list() //all current cooking things in the pot.


/obj/item/reagent_containers/glass/bucket/pot/Destroy()
	. = ..()
	active_recipes = null

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


/obj/item/reagent_containers/glass/bucket/pot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/glass/bowl))
		to_chat(user, "<span class='notice'>Filling the bowl...</span>")
		playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 70, FALSE)
		if(do_after(user,2 SECONDS, target = src))
			reagents.trans_to(I, reagents.total_volume)
	return TRUE

/obj/item/reagent_containers/glass/bucket/pot/stone
	name = "stone pot"
	desc = "A pot made out of stone"

/* Handle recipes */
/obj/item/reagent_containers/glass/bucket/pot/proc/check_for_recipe(obj/item/input, mob/living/user)
	var/datum/pot_recipe/recipe = select_pot_recipe(GLOB.pot_recipes, input)
	if(!recipe)
		return FALSE
	if(!recipe.output)
		return FALSE
	qdel(input)
	recipe.start_cooking()

GLOBAL_LIST_INIT(pot_recipes, init_subtypes(/datum/pot_recipe))
/proc/select_pot_recipe(list/datum/recipe/available_recipes, obj/item/I )
	for(var/datum/pot_recipe/R in available_recipes)
		if(istype(R.input, I))
			if(R.check_can_cook())
				return R
	return FALSE

/*========
Pot Recipe
========*/
/datum/pot_recipe
	var/obj/item/reagent_containers/glass/bucket/pot/cooking_pot
	abstract_type = /datum/pot_recipe
	var/input = list()
	var/water_conversion = 1
	var/volume_to_replace = 33 //how much water you remove and put reagents you put in
	var/absorption_rate = 11 // how fast the thing gets absorbed into the pot per tick
	var/datum/reagent/output = null // reagents you get
	var/cooking_time = 5 SECONDS // Does this in sections

/* Check can cook */
// Might only need to exist to do type checks to make sure it's not
// a subtype (e.g. meat versus mince)
/datum/pot_recipe/proc/check_can_cook()
	return TRUE

/* Start cooking */
/datum/pot_recipe/proc/start_cooking(obj/item/reagent_containers/glass/bucket/pot/P, mob/living/user)
	cooking_pot = P
	P.active_recipes += src
	var/real_cooking_time = cooking_time 
	if(user.mind)
		real_cooking_time /= 1 + (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5)
		real_cooking_time = round(real_cooking_time)
	cook()

/* Cook */
/datum/pot_recipe/proc/cook()
	if(!cooking_pot)
		world.log << " I have no pot! Deleting..."
		qdel(src)

	if(volume_to_replace <= 0)
		end_cooking()
	
	var/temp = cooking_pot.reagents.chem_temp
	volume_to_replace = absorption_rate
	cooking_pot.reagents.remove_reagent(/datum/reagent/water, volume_to_replace)
	cooking_pot.reagents.add_reagent(output, volume_to_replace, list(), temp) //last value should stop pot losing temp.

	var/turf/pot_turf = get_turf(cooking_pot)
	world.log << "[src] is cooking"
	playsound(pot_turf, "bubbles", 30, TRUE)

	addtimer(CALLBACK(src, PROC_REF(cook)), cooking_time)

/* End cooking */
//Probably never needs to do more than this but here if you wanna do something special on ending
/datum/pot_recipe/proc/end_cooking()
	cooking_pot.active_recipes -= src
	qdel(src)

/*===========
Stew Variants
===========*/

/*===
Meats
===*/
/datum/pot_recipe/meat_stew
	input = list(/obj/item/reagent_containers/food/snacks/rogue/meat)
	output = /datum/reagent/consumable/soup/stew/meat

/datum/pot_recipe/fish_stew
	input = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish)
	output = /datum/reagent/consumable/soup/stew/fish 

/datum/pot_recipe/chicken_stew
	input = list(/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet)
	output = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet

/datum/pot_recipe/spider_stew
	input = list(/obj/item/reagent_containers/food/snacks/rogue/meat/spider)
	output = /datum/reagent/consumable/soup/stew/yucky

/datum/pot_recipe/fish_stew
	input = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish)
	output = /datum/reagent/consumable/soup/stew/fish 

/*========
Vegetables
========*/
/datum/pot_recipe/potato_stew
	input = list(/obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced)
	output = /datum/reagent/consumable/soup/veggie/potato

/datum/pot_recipe/onion_stew
	input = list( /obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced)
	output = /datum/reagent/consumable/soup/veggie/onion

/datum/pot_recipe/cabbage_stew
	input = list( /obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced)
	output = /datum/reagent/consumable/soup/veggie/cabbage

/datum/pot_recipe/beet_stew
	input = list(/obj/item/reagent_containers/food/snacks/grown/beet)
	output = /datum/reagent/consumable/soup/veggie/beet

/*==
MISC
==*/
/datum/pot_recipe/oatmeal
	input = list( /obj/item/reagent_containers/food/snacks/grown/oat)
	output = /datum/reagent/consumable/soup/oatmeal


			/*
			/obj/item/reagent_containers/food/snacks/grown/oat
				pot.reagents.add_reagent(/datum/reagent/consumable/soup/oatmeal, 50)

			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks/rogue/veg))
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced))
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/veggie/potato, 16)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced))
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/veggie/onion, 16)
					if(istype(W, /obj/item/reagent_containers/food/snacks/grown/beet))
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/veggie/beet, 16)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced))
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/veggie/cabbage, 16)

			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks/rogue/meat))
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish))
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/stew/fish, 18)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/meat/spider))
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/stew/yucky, 18)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet) || istype(W, /obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry))
					else
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/stew/meat, 18)
				*/