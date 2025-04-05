/datum/neufood/recipe
    var/time_to_make = list(0.5, 3)    //IN SECONDS how long your action should take (shortest and longest)
    var/input = list() // all the items you feed into this
    var/output = null   //The object you get
    var/cook_method = null // If it's null assume it's a direct hand combination
    var/required_skill_level = /datum/skill/craft/cooking // Foods can be skill based
    var/craftsound = 'sound/foley/bandage.ogg' 

//This initializes the whole list
var/list/datum/food_combination/available_recipes = init_subtypes(/datum/recipe/)

/*This is Lohikar's code based on what I had.
- Essentially it will qualify for how many of the said item is in the recipe.
  The main difference is again that this system only cares for minimum requirements
  NOT for specifics. Excessive food is lost and that is the trade off

/datum/neufood/recipe/proc/check_items(obj/container)
	var/list/to_check = container.contents + container
	if (LAZYLEN(items))
		var/list/assoc_items = list()
		for (var/item in items)
			assoc_items[item] += 1

		for (var/thing in to_check)
			for (var/itemtype in assoc_items)
				if (istype(thing, itemtype) && assoc_items[itemtype])
					assoc_items[itemtype] -= 1

		for (var/itemtype in assoc_items)
			if (assoc_items[itemtype])
				return FALSE

	return TRUE
*/

/datum/neufood/recipe/proc/check_items_in_list(items = list())
	if (LAZYLEN(items))
		var/list/assoc_items = list()
		for (var/item in items)
			assoc_items[item] += 1

		for (var/thing in to_check)
			for (var/itemtype in assoc_items)
				if (istype(thing, itemtype) && assoc_items[itemtype])
					assoc_items[itemtype] -= 1

		for (var/itemtype in assoc_items)
			if (assoc_items[itemtype])
				return FALSE

	return TRUE



/*
==============================================================================================
WIP: From older code I wrote. Will try to refactor hearths to eventually use this somehow too.
==============================================================================================
/datum/recipe/proc/check_cook_type(var/cooktype)
	if(machine)
		if(!(machine & cooktype))
			return 0
	return 1
*/

/datum/recipe/proc/get_cooking_result()
	if(!result)
		return /obj/item/weapon/reagent_containers/food/burnt
	return result


/*
The recipe list to look through when directly using slap crafting.
*/
/proc/select_interaction_recipe(var/list/datum/recipe/avaiable_recipes, var/list/items , var/cook_method, var/exact = 1)
	var/list/datum/recipe/possible_recipes = new
	var/target = exact ? 1 : 0 
	for (var/datum/recipe/recipe in avaiable_recipes)
		if((recipe.check_reagents(obj.reagents) < target) || (recipe.check_items_in_list(obj) < target))
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
			var/count = ((recipe.items)?(recipe.items.len):0) + ((recipe.reagents)?(recipe.reagents.len):0)
			if (count >= highest_count)
				highest_count = count
				. = recipe
		return .



/*

====
WIP
====
Will be for cooking eventually!!!
====

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