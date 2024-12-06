/obj/structure/multistage/onager_unfinished
	name = "Unfinished Onager"
	desc = "An unfinished onager. It is missing a few key components."
	icon = 'icons/obj/structures/siege/onager/onager_unfinished.dmi'
	icon_state = "build_stage_0"
	anchored = TRUE
	density = TRUE

	stages = list(
		/datum/crafting_stage/onager_unfinished_stage_1,
		/datum/crafting_stage/onager_unfinished_stage_2,
		/datum/crafting_stage/onager_unfinished_stage_3
	)

	final_product = /obj/structure/onager

/// STAGES ///

/datum/crafting_stage/onager_unfinished_stage_1
	icon_state = "build_stage_1"
	description = "\n Required materials: 5 iron ingots.\
					\n Required tools: hammer."	
	recipe = /datum/crafting_recipe/roguetown/multistage/onager_unfinished_stage_1

/datum/crafting_stage/onager_unfinished_stage_2
	icon_state = "build_stage_2"
	description = "\n Required materials: 7 ropes, 5 bronze cogs.\
					\n Required tools: hammer."
	recipe = /datum/crafting_recipe/roguetown/multistage/onager_unfinished_stage_2

/datum/crafting_stage/onager_unfinished_stage_3
	icon_state = "build_stage_3"
	description = "\n Required materials: 4 steel ingots.\
					\n Required tools: hammer."	
	recipe = /datum/crafting_recipe/roguetown/multistage/onager_unfinished_stage_3

/// RECIPES ////

/datum/crafting_recipe/roguetown/multistage/onager_unfinished_stage_0

	tools = list(/obj/item/rogueweapon/hammer)
	reqs = list(/obj/item/natural/stone = 10, /obj/item/natural/wood/plank = 10)

	skillcraft = /datum/skill/craft/carpentry
	skill_level = 3
	always_available = TRUE

/datum/crafting_recipe/roguetown/multistage/onager_unfinished_stage_1

	tools = list(/obj/item/rogueweapon/hammer)
	reqs = list(/obj/item/ingot/iron = 5,)

	skillcraft = /datum/skill/craft/carpentry
	skill_level = 4

/datum/crafting_recipe/roguetown/multistage/onager_unfinished_stage_2

	tools = list(/obj/item/rogueweapon/hammer)
	reqs = list(/obj/item/rope = 7, /obj/item/roguegear/bronze= 5)

	skillcraft = /datum/skill/craft/engineering
	skill_level = 4

/datum/crafting_recipe/roguetown/multistage/onager_unfinished_stage_3

	tools = list(/obj/item/rogueweapon/hammer)
	reqs = list(/obj/item/ingot/steel = 4)

	skillcraft = /datum/skill/craft/blacksmithing
	skill_level = 2
