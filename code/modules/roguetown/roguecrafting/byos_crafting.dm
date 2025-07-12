proc/register_byos_recipes()
	// Remove all default recipes that have a /byos replacement
	for(var/path in typesof(/datum/crafting_recipe))
		if(copytext("[path]", length("[path]")-4, 0) == "/byos")
			// Remove all recipes of the parent type (the type path minus /byos)
			var/parent_path = text2path(copytext("[path]", 1, length("[path]")-4))
			for(var/datum/crafting_recipe/R in GLOB.crafting_recipes)
				if(istype(R, parent_path))
					GLOB.crafting_recipes -= R
			// Add the BYOS recipe
			GLOB.crafting_recipes += new path

// Wood
/datum/crafting_recipe/roguetown/turfs/wood/wall/byos
	name = "wall (log) - (small log / plank; COMPETENT)"
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/turfs/wood/wall/byos/alt
	reqs = list(/obj/item/natural/wood/plank = 1)

/datum/crafting_recipe/roguetown/turfs/wood/woodplatform/byos
	name = "platform (wood) - (plank; PROFICIENT)"
	result = /turf/open/floor/rogue/ruinedwood/platform
	reqs = list(/obj/item/natural/wood/plank = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/wood/woodplatform/byos/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE



// Stone
/datum/crafting_recipe/roguetown/turfs/stone/platform/byos
	name = "platform (stone) - (stone block; PROFICIENT)"
	result = /turf/open/floor/rogue/blocks/platform
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 3


/datum/crafting_recipe/roguetown/turfs/stone/platform/byos/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stone/wall/byos
	name = "wall (stone) - (stone; COMPETENT)"
	result = /turf/closed/wall/mineral/rogue/stone
	reqs = list(/obj/item/natural/stone = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/stone/brick/byos
	name = "wall (stonebrick) - (stone block; PROFICIENT)"
	result = /turf/closed/wall/mineral/rogue/stonebrick
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/decorated/byos
	name = "wall (decorated stone) - (stone block; PROFICIENT)"
	result = /turf/closed/wall/mineral/rogue/decostone
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/craft/byos
	name = "wall (craftstone) - (stone block; EXPERT)"
	result = /turf/closed/wall/mineral/rogue/craftstone
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/turfs/stone/window
	name = "murder hole (stone) - (stone block; COMPETENT)"
	result = /turf/closed/wall/mineral/rogue/stone/window
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 2

//Twig
/datum/crafting_recipe/roguetown/turfs/twigplatform/byos
	name = "twig platform - (3 sticks; COMPETENT)"
	result = /turf/open/floor/rogue/twig/platform
	reqs = list(/obj/item/grown/log/tree/stick = 3)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "assemble"
	verbage = "assembles"
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/twigplatform/byos/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		return
	return TRUE

//NEW
/datum/crafting_recipe/roguetown/turfs/wood/dark_floor/byos
	name = "floor (dark wood) - (plank; PROFICIENT)"
	result = /turf/open/floor/rogue/ruinedwood/spiral
	reqs = list(/obj/item/natural/wood/plank = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/church_marble/byos
	name = "floor (church marble) - (stone block; EXPERT)"
	result = /turf/open/floor/rogue/churchmarble
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/turfs/stone/church_tile/byos
	name = "floor (church tile) - (stone block; EXPERT)"
	result = /turf/open/floor/rogue/church
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 4
	
/datum/crafting_recipe/roguetown/turfs/wood/dark_wall/byos
	name = "wall (dark wood) - (2 small logs / 2 planks; COMPETENT)"
	result = /turf/closed/wall/mineral/rogue/wooddark/vertical
	reqs = list(/obj/item/natural/wood/plank = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/flag/byos
	name = "rockhill flag - (2 cloths, fiber; NONE)"
	result = /obj/structure/fluff/walldeco/customflag
	reqs = list(/obj/item/natural/cloth = 2, /obj/item/natural/fibers)
	wallcraft = TRUE
	skill_level = 0



/datum/crafting_recipe/roguetown/structure/scomm/byos
	name = "SCOMM - (rat, iron ingot, cog; EXPERT)"
	result = /obj/structure/roguemachine/scomm/byos
	reqs = list(/obj/item/reagent_containers/food/snacks/smallrat = 1,
				/obj/item/ingot/iron = 1,
				/obj/item/roguegear/bronze = 1)
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	offset = TRUE
	wallcraft = TRUE
	skill_level = 4



