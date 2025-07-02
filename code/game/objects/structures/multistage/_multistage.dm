/obj/structure/multistage

	/// Current stage of the multi-stage structure.
	var/stage = 1

	/// List of crafting stages for this structure. THEY NEED TO BE IN ORDER.
	var/list/stages

	/// Reference to the final product of the multi-stage structure. To be spawned when the final stage is completed.
	var/obj/structure/final_product

	/// Base description for the structure. Part that doesn't change between stages.
	var/base_desc = "An unfinished structure. It is missing a few key components."

/datum/crafting_stage

	/// Icon state for this stage. Used to update the icon of the multi-stage structure.
	var/icon_state

	/// Description for this stage. Can contain required items, tools, skills, etc.
	var/description

	/// Recipe associated with this stage. Contains required items, tools, skills, etc.
	var/datum/crafting_recipe/recipe

/datum/crafting_recipe/roguetown/structure/multistage

	// We dont want stages recipes to be shown in crafting menu
	always_available = FALSE


/obj/structure/multistage/Initialize()
	. = ..()
	desc = base_desc + stages[stage].description

/obj/structure/multistage/proc/try_progress_stage(mob/living/carbon/user)

	if(stage < stages.len)
		// Update stage icon and description if successful.
		if(check_constructability(user, stages[stage].recipe))
			icon_state = stages[stage].icon_state
			desc = base_desc + stages[stage+1].description //we want the user to know the next required materials
			stage++
			update_icon()
			return TRUE

	// If we are at the final stage, spawn the final product and delete the unfinished structure.
	if(stage == stages.len)
		if(check_constructability(user, stages[stage].recipe))
			final_product = new final_product(user.loc)
			qdel(src)
			return TRUE

/obj/structure/multistage/attackby(obj/item/I, mob/living/carbon/user)
	try_progress_stage(user)
	..()
