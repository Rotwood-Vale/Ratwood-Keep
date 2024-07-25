
/datum/crafting_recipe/roguetown/trapping
	tools = list(/obj/item/rogueweapon/hammer)
	skillcraft = /datum/skill/craft/traps
	verbage_simple = "puts together"
	verbage = "constructs"


/datum/crafting_recipe/roguetown/trapping/mantrap
	name = "mantrap"
	result = list(/obj/item/restraints/legcuffs/beartrap,
				/obj/item/restraints/legcuffs/beartrap)
	reqs = list(/obj/item/natural/fibers = 1,
				/obj/item/natural/thorn = 2,
				/obj/item/ingot/iron = 1)
	craftdiff = 2
