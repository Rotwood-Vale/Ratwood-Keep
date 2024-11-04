/datum/crafting_recipe/roguetown/alchemy
	req_table = FALSE
	tools = list(/obj/item/reagent_containers/glass/alembic)
	verbage_simple = "mix"
	skillcraft = /datum/skill/misc/treatment
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/alchemy/thermometer
	name = "Thermoscope"
	result = list(/obj/item/thermometer)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /datum/reagent/mercury = 5)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "Bottle bomb"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 2, /obj/item/rogueore/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

