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
	description = "\n Required materials: 3 iron ingots.\
					\n Required tools: hammer.\
					\n Required skills: carpentry."	
	recipe = /datum/crafting_recipe/roguetown/structure/multistage/onager_unfinished_stage_1

/datum/crafting_stage/onager_unfinished_stage_2
	icon_state = "build_stage_2"
	description = "\n Required materials: 5 ropes, 3 bronze cogs.\
					\n Required tools: hammer.\
					\n Required skills: engineering."	
	recipe = /datum/crafting_recipe/roguetown/structure/multistage/onager_unfinished_stage_2

/datum/crafting_stage/onager_unfinished_stage_3
	icon_state = "build_stage_3"
	description = "\n Required materials: 2 steel ingots.\
					\n Required tools: hammer.\
					\n Required skills: blacksmithing."	
	recipe = /datum/crafting_recipe/roguetown/structure/multistage/onager_unfinished_stage_3

/// RECIPES ////

/datum/crafting_recipe/roguetown/structure/onager_unfinished_stage_0

	name = "Unfinished Onager - (10 stones, 10 planks; HAMMER; COMPETENT)"
	tools = list(/obj/item/rogueweapon/hammer = 1)
	reqs = list(/obj/item/natural/stone = 10, /obj/item/natural/wood/plank = 10)
	result = /obj/structure/multistage/onager_unfinished

	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2
	always_available = TRUE

/datum/crafting_recipe/roguetown/structure/multistage/onager_unfinished_stage_1
	name = "Unfinished Onager - (3 iron ingots; HAMMER; PROFICIENT)"

	tools = list(/obj/item/rogueweapon/hammer = 1)
	reqs = list(/obj/item/ingot/iron = 3)

	skillcraft = /datum/skill/craft/carpentry
	skill_level = 3

/datum/crafting_recipe/roguetown/structure/multistage/onager_unfinished_stage_2
	name = "Unfinished Onager - (5 ropes, 3 bronze ingots; HAMMER; PROFICIENT)"

	tools = list(/obj/item/rogueweapon/hammer = 1)
	reqs = list(/obj/item/rope = 5, /obj/item/roguegear/bronze= 3)

	skillcraft = /datum/skill/craft/engineering
	skill_level = 3

/datum/crafting_recipe/roguetown/structure/multistage/onager_unfinished_stage_3
	name = "Unfinished Onager - (2 steel ingots; HAMMER; PROFICIENT)"

	tools = list(/obj/item/rogueweapon/hammer = 1)
	reqs = list(/obj/item/ingot/steel = 2)

	skillcraft = /datum/skill/craft/blacksmithing
	skill_level = 3
