/datum/crafting_recipe/roguetown/trapping
	tools = list(/obj/item/rogueweapon/hammer)
	req_table = TRUE
	skillcraft = /datum/skill/craft/traps
	verbage_simple = "puts together"
	verbage = "puts together"


/datum/crafting_recipe/roguetown/trapping/mantrap
	name = "mantrap"
	result = /obj/item/restraints/legcuffs/beartrap
	reqs = list(/obj/item/natural/fibers = 1,
				/obj/item/natural/thorn = 2,
				/obj/item/ingot/iron = 1)
	craftdiff = 1
