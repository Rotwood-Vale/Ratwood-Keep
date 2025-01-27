
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
	name = "floor (crude wood)"
	result = /turf/open/floor/rogue/ruinedwood
	reqs = list(/obj/item/natural/wood/plank = 1)

/datum/crafting_recipe/roguetown/turfs/wood/floor
	name = "floor (wood)"
	result = /turf/open/floor/rogue/wood
	reqs = list(/obj/item/natural/wood/plank = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/wood/woodplatform
	name = "platform (wood)"
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
	name = "wall (log)"
	result = /turf/closed/wall/mineral/rogue/wood
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skill_level = 2
/datum/crafting_recipe/roguetown/turfs/wood/wall/alt
	reqs = list(/obj/item/natural/wood/plank = 2)

/datum/crafting_recipe/roguetown/turfs/wood/fancy
	name = "wall (fancy wood)"
	result = /turf/closed/wall/mineral/rogue/decowood
	reqs = list(/obj/item/natural/wood/plank = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/wood/murderhole
	name = "murder hole (wood)"
	result = /turf/closed/wall/mineral/rogue/wood/window
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skill_level = 2
/datum/crafting_recipe/roguetown/turfs/wood/murderhole/alt
	reqs = list(/obj/item/natural/wood/plank = 2)



/// STONE

/datum/crafting_recipe/roguetown/turfs/stone
	reqs = list(/obj/item/natural/stoneblock = 1)
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
	name = "road (cobblerock)"
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
	name = "floor (cobblestone)"
	result = /turf/open/floor/rogue/cobble
	reqs = list(/obj/item/natural/stone = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/turfs/stone/block
	name = "floor (stoneblock)"
	result = /turf/open/floor/rogue/blocks
	skill_level = 1

/datum/crafting_recipe/roguetown/turfs/stone/newstone
	name = "floor (newstone)"
	result = /turf/open/floor/rogue/blocks/newstone/alt
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/stone/herringbone
	name = "floor (herringbone)"
	result = /turf/open/floor/rogue/herringbone
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/hexstone
	name = "floor (hexstone)"
	result = /turf/open/floor/rogue/hexstone
	skill_level = 4

/datum/crafting_recipe/roguetown/turfs/stone/platform
	name = "platform (stone)"
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
	name = "wall (stone)"
	result = /turf/closed/wall/mineral/rogue/stone
	reqs = list(/obj/item/natural/stone = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/stone/brick
	name = "wall (stonebrick)"
	result = /turf/closed/wall/mineral/rogue/stonebrick
	reqs = list(/obj/item/natural/stoneblock = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/decorated
	name = "wall (decorated stone)"
	result = /turf/closed/wall/mineral/rogue/decostone
	reqs = list(/obj/item/natural/stoneblock = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/turfs/stone/craft
	name = "wall (craftstone)"
	result = /turf/closed/wall/mineral/rogue/craftstone
	reqs = list(/obj/item/natural/stoneblock = 3)
	skillcraft = /datum/skill/craft/masonry
	verbage_simple = "build"
	verbage = "builds"
	skill_level = 4

/datum/crafting_recipe/roguetown/turfs/stone/window
	name = "murder hole (stone)"
	result = /turf/closed/wall/mineral/rogue/stone/window
	reqs = list(/obj/item/natural/stoneblock = 2)
	skill_level = 2


/// TWIG AND TENT

/datum/crafting_recipe/roguetown/turfs/twig
	name = "twig floor"
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
	name = "twig platform"
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
	name = "tent wall"
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
	name = "tent door"
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
	name = "soil plot"
	result = /turf/open/floor/rogue/dirt/nrich
	reqs = list(/obj/item/ash = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/dirtclod = 2)
	skillcraft = /datum/skill/labor/farming
	verbage_simple = "set up"
	verbage = "sets up"
	skill_level = 2

/datum/crafting_recipe/roguetown/turfs/nrich/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

