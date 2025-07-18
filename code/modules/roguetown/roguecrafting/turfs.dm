
/// WOOD

/datum/crafting_recipe/roguetown/turfs/wood
	skillcraft = /datum/skill/craft/carpentry
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 0

/datum/crafting_recipe/roguetown/turfs/wood/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/wood/floor
	name = "floor (crude wood) - (plank; NONE)"
	result = /turf/open/floor/rogue/ruinedwood
	reqs = list(/obj/item/natural/wood/plank = 1)

/datum/crafting_recipe/roguetown/turfs/wood/floor
	name = "floor (wood) - (plank; COMPETENT)"
	result = /turf/open/floor/rogue/wood
	reqs = list(/obj/item/natural/wood/plank = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/wood/woodplatform
	name = "platform (wood) - (2 planks; PROFICIENT)"
	result = /turf/open/floor/rogue/ruinedwood/platform
	reqs = list(/obj/item/natural/wood/plank = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/wood/woodplatform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/wood/wall
	name = "wall (log) - (2 small logs / 2 planks; COMPETENT)"
	result = /turf/closed/wall/mineral/rogue/wood
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/wood/wall/alt
	reqs = list(/obj/item/natural/wood/plank = 2)

/datum/crafting_recipe/roguetown/turfs/wood/fancy
	name = "wall (fancy wood) - (2 planks; PROFICIENT)"
	result = /turf/closed/wall/mineral/rogue/decowood
	reqs = list(/obj/item/natural/wood/plank = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/wood/murderhole
	name = "murder hole (wood) - (2 small logs / 2 planks; COMPETENT)"
	result = /turf/closed/wall/mineral/rogue/wood/window
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/wood/murderhole/alt
	reqs = list(/obj/item/natural/wood/plank = 2)



/// STONE

/datum/crafting_recipe/roguetown/turfs/stone
	skillcraft = /datum/skill/craft/masonry
	verbage_simple = "build"
	verbage = "builds"

/datum/crafting_recipe/roguetown/turfs/stone/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stone/cobblerock
	name = "road (cobblerock) - (stone; NONE)"
	result = /turf/open/floor/rogue/cobblerock
	reqs = list(/obj/item/natural/stone = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/turfs/stone/cobblerock/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue/dirt))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stone/cobble
	name = "floor (cobblestone) - (stone; BEGINNER)"
	result = /turf/open/floor/rogue/cobble
	reqs = list(/obj/item/natural/stone = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/turfs/stone/block
	name = "floor (stoneblock) - (stone block; BEGINNER)"
	result = /turf/open/floor/rogue/blocks
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/turfs/stone/newstone
	name = "floor (newstone) - (stone block; COMPETENT)"
	result = /turf/open/floor/rogue/blocks/newstone/alt
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/stone/herringbone
	name = "floor (herringbone) - (stone block; PROFICIENT)"
	result = /turf/open/floor/rogue/herringbone
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/hexstone
	name = "floor (hexstone) - (stone block; EXPERT)"
	result = /turf/open/floor/rogue/hexstone
	reqs = list(/obj/item/natural/stoneblock = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/turfs/stone/platform
	name = "platform (stone) - (2 stone blocks; PROFICIENT)"
	result = /turf/open/floor/rogue/blocks/platform
	reqs = list(/obj/item/natural/stoneblock = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/platform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stone/wall
	name = "wall (stone) - (2 stones; COMPETENT)"
	result = /turf/closed/wall/mineral/rogue/stone
	reqs = list(/obj/item/natural/stone = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/stone/brick
	name = "wall (stonebrick) - (2 stone blocks; PROFICIENT)"
	result = /turf/closed/wall/mineral/rogue/stonebrick
	reqs = list(/obj/item/natural/stoneblock = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/decorated
	name = "wall (decorated stone) - (2 stone blocks; PROFICIENT)"
	result = /turf/closed/wall/mineral/rogue/decostone
	reqs = list(/obj/item/natural/stoneblock = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/craft
	name = "wall (craftstone) - (3 stone blocks; EXPERT)"
	result = /turf/closed/wall/mineral/rogue/craftstone
	reqs = list(/obj/item/natural/stoneblock = 3)
	skill_level = 4

/datum/crafting_recipe/roguetown/turfs/stone/window
	name = "murder hole (stone) - (2 stone blocks; COMPETENT)"
	result = /turf/closed/wall/mineral/rogue/stone/window
	reqs = list(/obj/item/natural/stoneblock = 2)
	skill_level = 2


/// TWIG AND TENT

/datum/crafting_recipe/roguetown/turfs/twig
	name = "twig floor - (2 sticks; NONE)"
	result = /turf/open/floor/rogue/twig
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "assemble"
	verbage = "assembles"
	skill_level = 0

/datum/crafting_recipe/roguetown/turfs/twig/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue/dirt))
		if(!istype(T, /turf/open/floor/rogue/grass))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/twigplatform
	name = "twig platform - (3 sticks, rope; COMPETENT)"
	result = /turf/open/floor/rogue/twig/platform
	reqs = list(/obj/item/grown/log/tree/stick = 3,
				/obj/item/rope = 1)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "assemble"
	verbage = "assembles"
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/twigplatform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/tentwall
	name = "tent wall - (stick, cloth; BEGINNER)"
	result = /turf/closed/wall/mineral/rogue/tent
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/cloth = 1)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "set up"
	verbage = "sets up"
	skill_level = 1

/datum/crafting_recipe/roguetown/turfs/tentwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/tentdoor
	name = "tent door - (stick, cloth; BEGINNER)"
	result = /obj/structure/roguetent
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/cloth = 1)
	skillcraft = /datum/skill/craft/crafting
	verbage_simple = "set up"
	verbage = "sets up"
	skill_level = 1

/datum/crafting_recipe/roguetown/turfs/tentdoor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return ..()


/// DURT
/datum/crafting_recipe/roguetown/turfs/nrich
	name = "soil plot - (ash, fiber, dirt clod; COMPETENT)"
	result = /turf/open/floor/rogue/dirt/nrich
	reqs = list(/obj/item/ash = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/dirtclod = 2)
	skillcraft = /datum/skill/labor/farming
	verbage_simple = "set up"
	verbage = "sets up"
	skill_level = 5

/datum/crafting_recipe/roguetown/turfs/nrich/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/npoor
	name = "poor soil"
	result = /turf/open/floor/rogue/dirt/npoor
	reqs = list(/obj/item/natural/dirtclod = 2)
	skillcraft = /datum/skill/labor/farming
	verbage_simple = "set up"
	verbage = "sets up"
	skill_level = 1

/datum/crafting_recipe/roguetown/turfs/npoor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/dirt
	name = "decent dirt"
	result = /turf/open/floor/rogue/dirt
	reqs = list(/obj/item/ash = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/dirtclod = 2)
	skillcraft = /datum/skill/labor/farming
	verbage_simple = "set up"
	verbage = "sets up"
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/dirt/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE
