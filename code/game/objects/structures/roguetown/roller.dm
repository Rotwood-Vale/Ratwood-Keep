/datum/crafting_recipe/roguetown/structure/roller
	name = "roller"
	result = /obj/structure/roller
	reqs = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/rope/chain = 1,
		)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry

/obj/structure/roller
	name = "roller"
	desc = "A sturdy wooden board on wheels, with chains allowing it to be pulled or attached to other rollers. \nIt could pull crates or barrels on top of it."
	icon = 'icons/obj/structures/roller.dmi'
	icon_state = "roller"
	density = FALSE
	max_integrity = 600
	anchored = FALSE
	facepull = FALSE
	throw_range = 1
	layer = BELOW_OPEN_DOOR_LAYER
	drag_slowdown = 2
	var/list/linked_rollers = list()

/obj/structure/roller/Destroy()
	for(var/obj/structure/roller/roller as anything in linked_rollers)
		unlink_roller(roller)
	. = ..()

/obj/structure/roller/proc/try_autolink()
	for(var/direction in GLOB.cardinals)
		var/obj/structure/roller/roller = locate(/obj/structure/roller, get_step(src, direction))
		if(!roller)
			continue
		link_roller(roller)

/obj/structure/roller/update_icon()
	. = ..()
	update_overlays()

/obj/structure/roller/update_overlays()
	. = ..()
	for(var/obj/structure/roller/roller as anything in linked_rollers)
		var/to_dir = get_dir(src, roller)
		var/mutable_appearance/ma = mutable_appearance(icon, "chain[to_dir]", layer-0.01)
		. += ma

/obj/structure/roller/proc/link_roller(obj/structure/roller/roller)
	if(get_all_linked_rollers().len + roller.get_all_linked_rollers().len > 4)
		return FALSE
	if(src in roller.linked_rollers)
		return FALSE
	if(roller in linked_rollers)
		return FALSE
	if(linked_rollers.len >= 2)
		return FALSE
	if(roller.linked_rollers.len >= 2)
		return FALSE
	linked_rollers += roller
	roller.linked_rollers += src
	update_roller_state()
	roller.update_roller_state()
	return TRUE

/obj/structure/roller/proc/unlink_roller(obj/structure/roller/roller)
	if(!(src in roller.linked_rollers))
		return FALSE
	if(!(roller in linked_rollers))
		return FALSE
	linked_rollers -= roller
	roller.linked_rollers -= src
	update_roller_state()
	roller.update_roller_state()
	return TRUE

/obj/structure/roller/MouseDrop_T(atom/movable/O, mob/user)
	. = ..()
	if(!Adjacent(user) || !user.Adjacent(O))
		return
	if(!istype(O, /obj/structure/roller))
		return
	var/obj/structure/roller/dragged_roller = O
	if(dragged_roller in linked_rollers)
		if(unlink_roller(dragged_roller))
			to_chat(user, span_notice("I unlink the rollers."))
		else
			to_chat(user, span_notice("I fail to unlink the rollers."))
	else
		if(link_roller(dragged_roller))
			to_chat(user, span_notice("I link the rollers together."))
		else
			to_chat(user, span_notice("I fail to link the rollers."))

/obj/structure/roller/proc/get_all_linked_rollers()
	var/list/total_rollers = list()
	var/list/rollers_to_check = list(src)
	while(rollers_to_check.len > 0)
		var/obj/structure/roller/roller = rollers_to_check[1]
		for(var/obj/structure/roller/linked_roller as anything in roller.linked_rollers)
			if(linked_roller in total_rollers)
				continue
			rollers_to_check |= linked_roller
		total_rollers |= roller
		rollers_to_check -= roller
	return total_rollers

/obj/structure/roller/proc/total_eligible_objects_on_rollers()
	var/objects_on_top = 0
	var/list/all_rollers = get_all_linked_rollers()
	for(var/obj/structure/roller/roller as anything in all_rollers)
		if(!roller.get_pull_eligible_object_on_top())
			continue
		objects_on_top += 1
	return objects_on_top

/obj/structure/roller/proc/get_pull_eligible_object_on_top()
	for(var/atom/movable/movable in loc)
		if(!is_pull_eligible_object(movable))
			continue
		return movable
	return null

/obj/structure/roller/doMove(atom/destination)
	var/old_turf = loc
	var/previous_puller = pulledby
	. = ..()
	var/target_destination = loc
	if(!previous_puller)
		return
	if(linked_rollers.len >= 2)
		return
	if(old_turf == target_destination)
		return
	user_pull_from_to(old_turf, previous_puller)

/obj/structure/roller/Moved(atom/old_turf, Dir)
	. = ..()
	var/turf/destination = loc
	// Z check bypasses pull check due to how pulling things through stairs works
	if(!pulledby)
		return
	if(linked_rollers.len >= 2)
		return
	if(old_turf == destination)
		return
	user_pull_from_to(old_turf, pulledby)

/obj/structure/roller/proc/user_pull_from_to(turf/old_turf, mob/living/user)
	// Pull linked rolled into old location
	var/turf/pull_destination = old_turf

	// Try move crates and barrels onto itself from old location
	pull_structures_from_old_turf(old_turf)

	for(var/obj/structure/roller/roller as anything in linked_rollers)
		roller.be_pulled_by_roller(src, pull_destination)
	update_icon()

	var/stamina_drain = total_eligible_objects_on_rollers() * 0.1
	if(HAS_TRAIT(user, TRAIT_CARGOHAULER))
		stamina_drain *= 0.5
	user.rogfat_add(stamina_drain)

/obj/structure/roller/proc/be_pulled_by_roller(obj/structure/roller/pulling, turf/destination)
	var/turf/old_turf = loc
	// Pull linked rolled into old location
	var/turf/pull_destination = old_turf
	// OR onto itself if we ended up on a different Z level
	if(destination == old_turf)
		return
	forceMove(destination)
	pull_structures_from_old_turf(old_turf)
	for(var/obj/structure/roller/roller as anything in linked_rollers)
		if(roller == pulling)
			continue
		roller.be_pulled_by_roller(src, pull_destination)
	update_icon()

/obj/structure/roller/proc/pull_structures_from_old_turf(turf/old_turf)
	var/turf/destination = loc
	// Pull maximum one eligible structure
	for(var/atom/movable/movable in old_turf)
		if(!is_pull_eligible_object(movable))
			continue
		movable.forceMove(destination)
		return

/obj/structure/roller/proc/is_pull_eligible_object(atom/movable/movable)
	if(!istype(movable, /obj/structure))
		return FALSE
	var/obj/structure/pulled_structure = movable
	if(pulled_structure.anchored)
		return FALSE
	// Allow crates
	if(istype(pulled_structure, /obj/structure/closet/crate))
		return TRUE
	// Allow barrels
	if(istype(pulled_structure,/obj/structure/fermenting_barrel))
		return TRUE
	return FALSE

/obj/structure/roller/proc/update_roller_state()
	// If it's linked to 2 rollers, it cannot be pulled by players
	if(linked_rollers.len == 2)
		anchored = TRUE
	else
		anchored = FALSE
	update_icon()

/obj/structure/roller/autolink

/obj/structure/roller/autolink/Initialize()
	. = ..()
	try_autolink()
