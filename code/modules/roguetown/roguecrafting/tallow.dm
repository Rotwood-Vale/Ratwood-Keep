// Previously cooking.dm, this is just so that I can include it in subcategories for
// Class where they need tallow (Survival + Leatherworking)
/*
/datum/crafting_recipe/roguetown/tallow
	abstract_type = /datum/crafting_recipe/roguetown/tallow
	subtype_reqs = FALSE
	skillcraft = /datum/skill/craft/cooking

/datum/crafting_recipe/roguetown/tallow/hearth_tallow
	name = "render tallow over the hearth"
	result = list(
				/obj/item/reagent_containers/food/snacks/tallow,
				/obj/item/reagent_containers/food/snacks/tallow,
				/obj/item/reagent_containers/food/snacks/tallow,
				/obj/item/reagent_containers/food/snacks/tallow,
				)
	reqs = list(/obj/item/reagent_containers/food/snacks/fat = 1)
	tools = list(/obj/item/cooking/pan,)
	structurecraft = /obj/machinery/light/rogue/hearth
	skill_level = 0
	craftsound = 'sound/misc/frying.ogg'
	verbage_simple = "render"
	verbage = "renders"

/datum/crafting_recipe/roguetown/tallow/campfire_tallow
	name = "render tallow over the campfire"
	result = list(
				/obj/item/reagent_containers/food/snacks/tallow,
				/obj/item/reagent_containers/food/snacks/tallow,
				/obj/item/reagent_containers/food/snacks/tallow,
				)
	reqs = list(/obj/item/reagent_containers/food/snacks/fat = 1)
	tools = list(/obj/item/cooking/pan,)
	structurecraft = /obj/machinery/light/rogue/campfire
	skill_level = 0
	craftsound = 'sound/misc/frying.ogg'
	verbage_simple = "render"
	verbage = "renders"
*/
