// Deleted the flavorful desc from Vanderlin until I can think of a better desc. 
/obj/item/recipe_book/leatherworking
	name = "The Tanned Hide Tome: Mastery of Leather and Craft"
	icon_state = "book8_0"
	base_icon_state = "book8"

	types = list(
	///datum/crafting_recipe/roguetown/tallow,
	/datum/crafting_recipe/roguetown/leather, 		
	)

/obj/item/recipe_book/sewing
	name = "Threads of Destiny: A Tailor's Codex"
	icon_state = "book7_0"
	base_icon_state = "book7"

	types = list(
		/datum/crafting_recipe/roguetown/survival/cloth, // Screw it just in case
		/datum/crafting_recipe/roguetown/survival/cloth5x,
		/datum/crafting_recipe/roguetown/sewing,
		)

/obj/item/recipe_book/blacksmithing
	name = "The Smith’s Legacy"
	icon_state = "book3_0"
	base_icon_state = "book3"

	types = list(/datum/anvil_recipe)

/obj/item/recipe_book/engineering
	name = "The Artificer's Handbook"
	icon_state = "book4_0"
	base_icon_state = "book4"

	types = list(/datum/crafting_recipe/roguetown/engineering)

// I gave up I will make better names later lol
// Was gonna do a carpenter + masonry handbook but 
// Both are under structures so I will just make them one and add categories
// Later 
/obj/item/recipe_book/builder
	name = "The Builder's Handbook - For Carpenters and Masons"
	icon_state = "book5_0"
	base_icon_state = "book5"

	types = list(
		/datum/crafting_recipe/roguetown/structure
		)
/*
/obj/item/recipe_book/ceramics
	name = "The Potter's Handbook"
	icon_state = "book5_0"
	base_icon_state = "book5"

	types = list(
		///datum/crafting_recipe/roguetown/structure/ceramicswheel,
		///datum/crafting_recipe/roguetown/ceramics
		)
*/
// This book should be widely given to everyone
/obj/item/recipe_book/survival
	name = "The Survival Handbook"
	icon_state = "book6_0"
	base_icon_state = "book6"

	types = list(
		/datum/crafting_recipe/roguetown/survival,
		///datum/crafting_recipe/roguetown/tallow,
		)
/*
// TBD - Cauldron Recipes
/obj/item/recipe_book/alchemy
	name = "Secrets of Alchemy"
	icon_state = "book3_0"
	base_icon_state = "book3"

	types = list(
		/datum/crafting_recipe/roguetown/structure/alch,
		/datum/crafting_recipe/roguetown/structure/cauldronalchemy,
		/datum/crafting_recipe/roguetown/survival/mortar,
		/datum/crafting_recipe/roguetown/survival/pestle,
		/datum/crafting_recipe/roguetown/alchemy,
		/datum/alch_grind_recipe,
		/datum/alch_cauldron_recipe
		)
 */
