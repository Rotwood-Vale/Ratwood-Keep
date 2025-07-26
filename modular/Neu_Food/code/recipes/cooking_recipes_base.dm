// Subtype of crafting_recipe for cooking

/datum/crafting_recipe/cooking
	abstract_type = /datum/crafting_recipe/cooking
	subtype_reqs = TRUE // Cooking recipes do not require specific subtypes of ingredients.
	skillcraft = /datum/skill/craft/cooking // All cooking recipes use the cooking skill.
	craftdiff = 0 // Default difficulty for cooking recipes.
	req_table = TRUE // Cooking recipes generally require a table to work on.
