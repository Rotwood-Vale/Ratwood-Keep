/*
===================
Food Handle Recipes
===================
 - The base datums for the food interactions you can do with food.
 - Uses cooking skill. We could add location based cusine but it seems
   like it would make more sense to base it all off skill levels for now.
*/

/datum/food_handle_recipes
	var/time_to_make = list(0.5, 4)    //IN SECONDS how long your action should take (shortest and longest)
	var/list/reagents // example: = list(/datum/reagent/drink/juice/berry = 5) // do not list same reagent twice
	var/list/items    // example: = list(/obj/item/weapon/crowbar, /obj/item/weapon/welder) // place /foo/bar before /foo
	var/list/items_used // The items that actually get used when the recipe succeeds (Empty, adds on success)
	var/result = null // example: = /obj/item/weapon/reagent_containers/food/snacks/donut/normal
	var/required_skill_level = 0 // Skill for attempting recipe
	var/interaction_type = FALSE // Checking for interaction types? I guess his only counts for items that need sharpnes
	var/slices = 0 //How many slices this interaction returns if any.
	var/craftsound = 'sound/foley/bandage.ogg'
	var/crafting_message = "Test message (report this)" // example: "I start rolling the flour into the dough..."

//This initializes the whole list of food combination
// I forgot what it does exactly, but it's important!
var/list/datum/food_combinations = init_subtypes(/datum/food_handle_recipes/)


// By this point you KNOW you have all the items exist and will finish this loop
// This for loop should never break... if it does something terrible happened.
datum/food_handle_recipes/proc/clear_items(list/itemlist)
	var/I = 1
	if(!items.len)
		return
	if(!itemlist.len)
		return
	while(I < items.len)
		for(var/obj/item/J in itemlist)
			if(istype(J, items[I]))
				if(istype(J, /obj/item/reagent_containers/food/snacks/rogue))
					world.log << "deleting the [J]"
					qdel(J) //only food items should delete
					I += 1 // This means that and interactions via knives has to be something else it can't be listed...
					//check for required item (sharpness) in the uh 
			if(I > items.len)
				break
		

/datum/food_handle_recipes/proc/check_items_in_list(to_check = list())
	if (LAZYLEN(items)) //the datum's items
		var/list/assoc_items = list()
		for (var/item in items)
			assoc_items[item] += 1

		// iterates through your items
		// Checks if they're in the list
		for (var/thing in to_check) 
			for (var/itemtype in assoc_items)
				if (istype(thing, itemtype) && assoc_items[itemtype])
					assoc_items[itemtype] -= 1

		for (var/itemtype in assoc_items)
			if (assoc_items[itemtype])
				return FALSE

	return TRUE

/*
The recipe list to look through when directly using slap crafting.
NOTE! This is a global level proc: you can call it from anything if you need. You can
expand this to be more generic for other crafting methods in future if you want
but for now I'm mostly just checking food.
*/
/proc/select_interaction_recipe(list/datum/recipe/avaiable_recipes, list/items, exact = 1)
	// List of recipes to check.
	var/list/datum/food_handle_recipes/possible_recipes = new
	var/target = exact ? 1 : 0 
	// Checks through all possible recipes in the daturm
	for (var/datum/food_handle_recipes/recipe in avaiable_recipes)
		// A couple recipe functions to see if they return true to meet recipe requirements
		// (recipe.check_reagents(obj.reagents) < target) || 
		if((recipe.check_items_in_list(items) < target))
			continue
		// Shorthand for adding to list
		possible_recipes |= recipe
	if (possible_recipes.len==0)
		return null
	else if (possible_recipes.len==1)
		return possible_recipes[1]
	else //okay, let's select the most complicated recipe
		var/highest_count = 0
		. = possible_recipes[1]
		for (var/datum/food_handle_recipes/recipe in possible_recipes)
			var/count = ((recipe.items)?(recipe.items.len):0)
			if (count >= highest_count)
				highest_count = count

				. = recipe
		return .



/*
Everything below here will be for future expansion into dealing with the hearth and maybe pot
==============================================================================================
WIP: From older code I wrote. Will try to refactor hearths to eventually use this somehow too.
==============================================================================================
/datum/recipe/proc/check_cook_type(var/cooktype)
	if(machine)
		if(!(machine & cooktype))
			return 0
	return 1

=====================================
WILL BE USED WHEN HEARTH IS DATUMIZED
=====================================
/datum/recipe/proc/get_cooking_result()
	if(!result)
		return /obj/item/weapon/reagent_containers/food/burnt
	return result


====
WIP
====
Will be for cooking eventually!!!

/proc/select_recipe(var/list/datum/recipe/avaiable_recipes, var/list/items , var/cook_method, var/exact)
	var/list/datum/recipe/possible_recipes = new
	var/target = exact ? 1 : 0 
	for (var/datum/recipe/recipe in avaiable_recipes)
		if((recipe.check_reagents(obj.reagents) < target) || (recipe.check_items(obj) < target) || (recipe.check_cook_type(cooktype) < target) || (recipe.check_fruit(obj) < target))
			continue
		possible_recipes |= recipe
	if (possible_recipes.len==0)
		return null
	else if (possible_recipes.len==1)
		return possible_recipes[1]
	else //okay, let's select the most complicated recipe
		var/highest_count = 0
		. = possible_recipes[1]
		for (var/datum/recipe/recipe in possible_recipes)
			var/count = ((recipe.items)?(recipe.items.len):0) + ((recipe.reagents)?(recipe.reagents.len):0) + ((recipe.fruit)?(recipe.fruit.len):0)
			if (count >= highest_count)
				highest_count = count
				. = recipe
		return .
*/
