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

	var/reserve_water = 0
	for(var/datum/pot_recipe/R in active_recipes)
		reserve_water += R.volume_to_replace
	
	var/amount_of_water = reagents.get_reagent_amount(/datum/reagent/water)
	if(amount_of_water - reserve_water >= recipe.volume_to_replace)
		var/delay = get_skill_delay(user.mind.get_skill_level(/datum/skill/craft/cooking), 0.3, 2)
		if(do_after(user,delay, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(input)
			recipe.start_cooking(src, user)
	else
		to_chat(user, span_warning("There is not enough water in the pot."))


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

/* Start cooking */
/datum/pot_recipe/proc/start_cooking(obj/item/reagent_containers/glass/bucket/pot/P, mob/living/user)
	P.active_recipes.Add(src)
	var/real_cooking_time = cooking_time 
	if(user.mind)
		real_cooking_time /= 1 + (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5)
		real_cooking_time = round(real_cooking_time)
	addtimer(CALLBACK(src, PROC_REF(cook), P), cooking_time)

/* Cook */
/datum/pot_recipe/proc/cook(obj/item/reagent_containers/glass/bucket/pot/pot)
	if(!pot)
		end_cooking()
		return
	if(volume_to_replace <= 0)
		end_cooking()
		return
	if(!pot.reagents) // If we somehow lost all our reagents (either deleted or emptied before we finished)
		end_cooking()
		return
	if(!pot.reagents.has_reagent(/datum/reagent/water, volume_to_replace)) //if we somehow snuck in or some water level changed before we fired just fucking DIE
		end_cooking()
		return

	// One final sanity check in case some lunatic empties some water but still keeps cooking and didn't hit 0 water or null reagents
	var/true_volume_to_remove =  min(volume_to_replace, pot.reagents.get_reagent_amount(/datum/reagent/water))

	var/temp = pot.reagents.chem_temp
	pot.reagents.remove_reagent(/datum/reagent/water, true_volume_to_remove)
	pot.reagents.add_reagent(output, true_volume_to_remove, list(), temp) //last value should stop pot losing temp.

	var/turf/pot_turf = get_turf(pot)
	playsound(pot_turf, "bubbles", 30, TRUE)
	end_cooking(pot) //we just finish for now...

/* End cooking */
//Probably never needs to do more than this but here if you wanna do something special on ending
/datum/pot_recipe/proc/end_cooking(obj/item/reagent_containers/glass/bucket/pot/P)
	P.active_recipes.Remove(src)

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