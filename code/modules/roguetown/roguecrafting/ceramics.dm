/datum/crafting_recipe/roguetown/ceramics
	skillcraft = /datum/skill/misc/ceramics

/datum/crafting_recipe/roguetown/ceramics/clay
	structurecraft = /obj/structure/fluff/ceramicswheel

/datum/crafting_recipe/roguetown/ceramics/glass
	tools = list(/obj/item/blowRod)

/* 0 diff */

/datum/crafting_recipe/roguetown/ceramics/clay/clayBottle
	name = "clay bottle"
	result = list(/obj/item/natural/clay/clayBottle)
	reqs = list(/obj/item/natural/clay = 1)
	craftdiff = 0

/* 1 diff */

/datum/crafting_recipe/roguetown/ceramics/clay/clayBottle3
	name = "clay bottle 3x"
	result = list(/obj/item/natural/clay/clayBottle, /obj/item/natural/clay/clayBottle, /obj/item/natural/clay/clayBottle)
	reqs = list(/obj/item/natural/clay = 3)
	craftdiff = 1

/datum/crafting_recipe/roguetown/ceramics/clay/clayJug
	name = "clay pitcher"
	result = list(/obj/item/natural/clay/clayJug)
	reqs = list(/obj/item/natural/clay = 2)
	craftdiff = 0

/* 2 diff */

/datum/crafting_recipe/roguetown/ceramics/clay/clayVase
	name = "clay pitcher"
	result = list(/obj/item/natural/clay/clayVase)
	reqs = list(/obj/item/natural/clay = 3)
	craftdiff = 0