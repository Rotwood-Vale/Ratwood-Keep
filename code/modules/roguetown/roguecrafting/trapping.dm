/datum/crafting_recipe/roguetown/trapping
	req_table = TRUE	
	tools = list(/obj/item/rogueweapon/hammer)
	skillcraft = /datum/skill/craft/traps
	subtype_reqs = TRUE


/datum/crafting_recipe/roguetown/trapping/mantrap
	name = "mantrap"
	result = /obj/item/restraints/legcuffs/beartrap
	reqs = list(/obj/item/natural/fibers = 1,/obj/item/natural/thorn = 2,/obj/item/ingot/iron = 1)
	verbage_simple = "puts together"
	verbage = "puts together"
	craftdiff = 1
