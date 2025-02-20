
/datum/crafting_recipe/roguetown/cooking
	req_table = TRUE
	subtype_reqs = FALSE
	skillcraft = /datum/skill/craft/cooking

/datum/crafting_recipe/roguetown/cooking/hearth_tallow
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
	craftdiff = 0
	craftsound = 'sound/misc/frying.ogg'
	req_table = FALSE
	verbage_simple = "render"
	verbage = "renders"

/datum/crafting_recipe/roguetown/cooking/campfire_tallow
	name = "render tallow over the campfire"
	result = list(
				/obj/item/reagent_containers/food/snacks/tallow,
				/obj/item/reagent_containers/food/snacks/tallow,
				/obj/item/reagent_containers/food/snacks/tallow,
				)
	reqs = list(/obj/item/reagent_containers/food/snacks/fat = 1)
	tools = list(/obj/item/cooking/pan,)
	structurecraft = /obj/machinery/light/rogue/campfire
	craftdiff = 0
	craftsound = 'sound/misc/frying.ogg'
	req_table = FALSE
	verbage_simple = "render"
	verbage = "renders"
