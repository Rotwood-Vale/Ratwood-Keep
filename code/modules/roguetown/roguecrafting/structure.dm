
/datum/crafting_recipe/roguetown/structure
	req_table = FALSE
	craftsound = 'sound/foley/Building-01.ogg'

/datum/crafting_recipe/roguetown/structure/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	if(istype(T, /turf/open/water))
		return FALSE
	return ..()

/datum/crafting_recipe/roguetown/structure/pillory
	name = "pillory - (small log, iron ingot; COMPETENT)"
	result = /obj/structure/pillory/double/custom
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/ingot/iron = 1,)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/meathock
	name = "meathook"
	result = /obj/structure/meathook
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/ingot/iron = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/handcart
	name = "handcart - (3 small logs, rope; BEGINNER)"
	result = /obj/structure/handcart
	reqs = list(/obj/item/grown/log/tree/small = 3,
				/obj/item/rope = 1)
	verbage_simple = "construct"
	verbage = "constructs"

/datum/crafting_recipe/roguetown/structure/noose
	name = "noose - (rope; BEGINNER)"
	result = /obj/structure/noose
	reqs = list(/obj/item/rope = 1)
	verbage = "tie"
	craftsound = 'sound/foley/noose_idle.ogg'
	ontile = TRUE

/datum/crafting_recipe/roguetown/structure/noose/TurfCheck(mob/user, turf/T)
	var/turf/checking = get_step_multiz(T, UP)
	if(!checking)
		return FALSE
	if(!isopenturf(checking))
		return FALSE
	if(istype(checking,/turf/open/transparent/openspace))
		return FALSE
	return TRUE

/datum/crafting_recipe/roguetown/structure/psycrss
	name = "cross (wood) - (small log, 3 stakes; BEGINNER)"
	result = /obj/structure/fluff/psycross/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/grown/log/tree/stake = 3)
	verbage_simple = "construct"
	verbage = "constructs"

/datum/crafting_recipe/roguetown/structure/stonepsycrss
	name = "cross (stone) - (2 stones; BEGINNER)"
	result = /obj/structure/fluff/psycross
	reqs = list(/obj/item/natural/stone = 2)
	verbage_simple = "construct"
	verbage = "constructs"

/datum/crafting_recipe/roguetown/structure/swing_door
	name = "swing door - (2 small logs, BEGINNER)"
	result = /obj/structure/mineral_door/swing_door
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/structure/door
	name = "door (wood) - (2 small logs; BEGINNER)"
	result = /obj/structure/mineral_door/wood
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/structure/stonedoor
	name = "door (stone) - (2 stones; BEGINNER)"
	result = /obj/structure/mineral_door/wood/donjon/stone
	reqs = list(/obj/item/natural/stone = 2)
	verbage_simple = "build"
	verbage = "builds"
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/roguetown/structure/doorbolt
	name = "door (deadbolt) - (2 small logs, stick; COMPETENT)"
	result = /obj/structure/mineral_door/wood/deadbolt
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/grown/log/tree/stick = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/fancydoor
	name = "fancy door - (2 small logs; PROFICIENT)"
	result = /obj/structure/mineral_door/wood/fancywood
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 3

/datum/crafting_recipe/roguetown/structure/barrel
	name = "barrel - (small log; BEGINNER)"
	result = /obj/structure/fermenting_barrel
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage_simple = "make"
	verbage = "makes"
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/roguebin
	name = "bin - (2 small lgos; NONE)"
	result = /obj/item/roguebin
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage_simple = "make"
	verbage = "makes"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/chair
	name = "chair (wood) - (small log; COMPETENT)"
	result = /obj/item/chair/rogue
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/fancychair
	name = "fancy chair - (small log, silk; PROFICIENT)"
	result = /obj/item/chair/rogue/fancy
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/silk = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 3

/datum/crafting_recipe/roguetown/structure/stool
	name = "stool (wood) - (small log; BEGINNER)"
	result = /obj/item/chair/stool/bar/rogue
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/carpentry
	verbage_simple = "construct"
	verbage = "constructs"

/datum/crafting_recipe/roguetown/structure/anvil
	name = "anvil - (iron ingot; BEGINNER)"
	result = /obj/machinery/anvil
	reqs = list(/obj/item/ingot/iron = 1)
	skillcraft = /datum/skill/craft/blacksmithing
	xpgain = FALSE
	verbage_simple = "forge"
	verbage = "forges"
	skill_level = 1

/datum/crafting_recipe/roguetown/structure/smelter
	name = "ore furnace - (4 stones, coal; BEGINNER)"
	result = /obj/machinery/light/rogue/smelter
	reqs = list(/obj/item/natural/stone = 4,
			/obj/item/rogueore/coal = 1)
	verbage_simple = "build"
	verbage = "builds"
	craftsound = null

/datum/crafting_recipe/roguetown/structure/greatsmelter
	name = "great furnace - (2 iron ingots, riddle of steel, coal; COMPETENT)"
	result = /obj/machinery/light/rogue/smelter/great
	reqs = list(/obj/item/ingot/iron = 2,
				/obj/item/riddleofsteel = 1,
				/obj/item/rogueore/coal = 1)
	verbage_simple = "build"
	verbage = "builds"
	craftsound = null
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/forge
	name = "forge - (4 stones, coal; BEGINNER)"
	result = /obj/machinery/light/rogue/forge
	reqs = list(/obj/item/natural/stone = 4,
				/obj/item/rogueore/coal = 1)
	skillcraft = /datum/skill/craft/blacksmithing
	xpgain = FALSE
	verbage_simple = "build"
	verbage = "builds"
	craftsound = null
	skill_level = 1

/datum/crafting_recipe/roguetown/structure/treatingfurnace
	name = "heat treatment furnace - (4 stones, 2 steel ingots, coal; COMPETENT)"
	result = /obj/structure/treating_furnace
	reqs = list(/obj/item/natural/stone = 4,
				/obj/item/ingot/steel = 2,
				/obj/item/rogueore/coal = 1)
	skillcraft = /datum/skill/craft/blacksmithing
	xpgain = FALSE
	verbage_simple = "build"
	verbage = "builds"
	craftsound = null
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/sharpwheel
	name = "sharpening wheel - (iron ingot, stone; COMPETENT)"
	result = /obj/structure/fluff/grindwheel
	reqs = list(/obj/item/ingot/iron = 1,
				/obj/item/natural/stone = 1)
	skillcraft = /datum/skill/craft/blacksmithing
	xpgain = FALSE
	verbage_simple = "build"
	verbage = "builds"
	craftsound = null
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/art_table
	name = "artificer table - (plank; BEGINNER)"
	result = /obj/machinery/artificer_table
	reqs = list(/obj/item/natural/wood/plank = 1)
	skillcraft = /datum/skill/craft/engineering
	verbage_simple = "create"
	verbage = "creates"

/datum/crafting_recipe/roguetown/structure/loom
	name = "loom - (2 small logs, 2 sticks, 2 fibers; COMPETENT)"
	result = /obj/machinery/loom
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/grown/log/tree/stick = 2,
				/obj/item/natural/fibers = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/dye_bin
	name = "dye bin - (small log; NONE)"
	result = /obj/structure/dye_bin
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
	)
	verbage_simple = "make"
	verbage = "makes"
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/stairsd
	name = "stairs (wood) (down) - (2 small logs; COMPETENT)"
	result = /obj/structure/stairs/d
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2
	verbage_simple = "construct"
	verbage = "constructs"
	ontile = TRUE

/datum/crafting_recipe/roguetown/structure/stairsd/TurfCheck(mob/user, turf/T)
	var/turf/checking = get_step(T, user.dir)
	if(!checking)
		return FALSE
	if(!istype(checking,/turf/open/transparent/openspace))
		return FALSE
	checking = get_step_multiz(checking, DOWN)
	if(!checking)
		return FALSE
	if(!isopenturf(checking))
		return FALSE
	if(istype(checking,/turf/open/transparent/openspace))
		return FALSE
	for(var/obj/structure/S in checking)
		if(istype(S, /obj/structure/stairs))
			return FALSE
		if(S.density)
			return FALSE
	return TRUE

/datum/crafting_recipe/roguetown/structure/stonestairsd
	name = "stairs (stone) (down) - (2 stones; COMPETENT)"
	result = /obj/structure/stairs/stone/d
	reqs = list(/obj/item/natural/stone = 2)
	skillcraft = /datum/skill/craft/masonry
	skill_level = 2
	verbage_simple = "builds"
	verbage = "builds"
	ontile = TRUE

/datum/crafting_recipe/roguetown/structure/stonestairsd/TurfCheck(mob/user, turf/T)
	var/turf/checking = get_step(T, user.dir)
	if(!checking)
		return FALSE
	if(!istype(checking,/turf/open/transparent/openspace))
		return FALSE
	checking = get_step_multiz(checking, DOWN)
	if(!checking)
		return FALSE
	if(!isopenturf(checking))
		return FALSE
	if(istype(checking,/turf/open/transparent/openspace))
		return FALSE
	for(var/obj/structure/S in checking)
		if(istype(S, /obj/structure/stairs))
			return FALSE
		if(S.density)
			return FALSE
	return TRUE

/datum/crafting_recipe/roguetown/structure/railing
	name = "railing - (2 sticks; BEGINNER)"
	result = /obj/structure/fluff/railing/wood
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	ontile = TRUE
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	buildsame = TRUE

/datum/crafting_recipe/roguetown/structure/fence
	name = "palisade - (2 stakes; BEGINNER)"
	result = /obj/structure/fluff/railing/fence
	reqs = list(/obj/item/grown/log/tree/stake = 2)
	ontile = TRUE
	verbage_simple = "set up"
	verbage = "sets up"
	buildsame = TRUE

/datum/crafting_recipe/roguetown/structure/headstake
	name = "head stake - (head, stake; NONE)"
	result = /obj/structure/fluff/headstake
	reqs = list(/obj/item/grown/log/tree/stake = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/grown/log/tree/stake = 1)
	verbage_simple = "set up"
	verbage = "sets up"
	skill_level = 0


/datum/crafting_recipe/roguetown/structure/fencealt
	name = "palisade - (small log; BEGINNER)"
	result = list(/obj/structure/fluff/railing/fence,
				/obj/item/grown/log/tree/stick)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	ontile = TRUE
	verbage_simple = "set up"
	verbage = "sets up"
	buildsame = TRUE

/datum/crafting_recipe/roguetown/structure/rack
	name = "rack - (3 sticks; NONE)"
	result = /obj/structure/rack/rogue
	reqs = list(/obj/item/grown/log/tree/stick = 3)
	verbage_simple = "construct"
	verbage = "constructs"
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/chest
	name = "chest - (small log, stick; NONE)"
	result = /obj/structure/closet/crate/chest
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/grown/log/tree/stick = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/closet
	name = "closet - (2 small logs; NONE)"
	result = /obj/structure/closet/crate/roguecloset
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/structure/coffin
	name = "coffin/casket - (2 small logs; BEGINNER)"
	result = /obj/structure/closet/crate/coffin
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 1

/datum/crafting_recipe/roguetown/structure/campfire
	name = "campfire - (2 sticks; NONE)"
	result = /obj/machinery/light/rogue/campfire
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	verbage_simple = "build"
	verbage = "builds"
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/densefire
	name = "greater campfire - (2 sticks, 2 stones; BEGINNER)"
	result = /obj/machinery/light/rogue/campfire/densefire
	reqs = list(/obj/item/grown/log/tree/stick = 2,
				/obj/item/natural/stone = 2)
	verbage_simple = "build"
	verbage = "builds"

/datum/crafting_recipe/roguetown/structure/cookpit
	name = "hearth - (stick, 3 stones; BEGINNER)"
	result = /obj/machinery/light/rogue/hearth
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 3)
	verbage_simple = "build"
	verbage = "builds"

/datum/crafting_recipe/roguetown/structure/brazier
	name = "brazier - (small log, coal; BEGINNER)"
	result = /obj/machinery/light/rogue/firebowl/stump
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/rogueore/coal = 1)
	verbage_simple = "assembles"
	verbage = "assembles"

/datum/crafting_recipe/roguetown/structure/standing
	name = "standing fire - (stone, coal; BEGINNER)"
	result = /obj/machinery/light/rogue/firebowl/standing
	reqs = list(/obj/item/natural/stone = 1,
				/obj/item/rogueore/coal = 1)
	verbage_simple = "construct"
	verbage = "constructs"

/datum/crafting_recipe/roguetown/structure/oven
	name = "oven - (small log, 3 stones; BEGINNER)"
	result = /obj/machinery/light/rogue/oven
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/stone = 3)
	verbage_simple = "build"
	verbage = "builds"
	skillcraft = /datum/skill/craft/masonry
	wallcraft = TRUE

/datum/crafting_recipe/roguetown/structure/dryingrack
	name = "drying rack - (3 sticks; BEGINNER)"
	result = /obj/machinery/tanningrack
	reqs = list(/obj/item/grown/log/tree/stick = 3)
	verbage_simple = "construct"
	verbage = "constructs"

/datum/crafting_recipe/roguetown/structure/bed
	name = "bed - (small log, fiber; BEGINNER)"
	result = /obj/structure/bed/rogue/shit
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 1)
	verbage_simple = "construct"
	verbage = "constructs"

/datum/crafting_recipe/roguetown/structure/nicebed
	name = "nice bed - (2 small logs, cloth; NEEDLE; COMPETENT)"
	result = /obj/structure/bed/rogue/inn
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/doublebed
	name = "double bed - (4 small logs, 2 cloths, fiber; NEEDLE; PROFICIENT)"
	result = /obj/structure/bed/rogue/inn/wooldouble
	reqs = list(/obj/item/grown/log/tree/small = 4,
				/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 3

/datum/crafting_recipe/roguetown/structure/nicedoublebed
	name = "nice double bed - (4 small logs, 2 cloths, silk; NEEDLE, HAMMER; EXPERT)"
	result = /obj/structure/bed/rogue/inn/double
	reqs = list(/obj/item/grown/log/tree/small = 4,
				/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2)
	tools = list(/obj/item/needle, /obj/item/rogueweapon/hammer)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 4

/datum/crafting_recipe/roguetown/structure/table
	name = "table (wood) - (small log; BEGINNER)"
	result = /obj/structure/table/wood/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/structure/stonetable
	name = "table (stone) - (stone; BEGINNER)"
	result = /obj/structure/table/church
	reqs = list(/obj/item/natural/stone = 1)
	verbage_simple = "build"
	verbage = "builds"
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/roguetown/structure/millstone
	name = "millstone - (3 stones; NONE)"
	result = /obj/structure/fluff/millstone
	reqs = list(/obj/item/natural/stone = 3)
	verbage = "assembles"
	craftsound = null
	wallcraft = TRUE
	skillcraft = /datum/skill/craft/masonry
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/grindstone
	name = "grindstone - (3 stones; NONE)"
	result = /obj/structure/fluff/grindstone
	reqs = list(/obj/item/natural/stone = 3)
	verbage = "assembles"
	craftsound = null
	wallcraft = TRUE
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/roguetown/structure/lever
	name = "lever - (cog; BEGINNER)"
	result = /obj/structure/lever
	reqs = list(/obj/item/roguegear/bronze = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/structure/trapdoor
	name = "floorhatch - (small log, cog; COMPETENT)"
	result = /obj/structure/floordoor
	reqs = list(/obj/item/grown/log/tree/small = 1,
					/obj/item/roguegear/bronze = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/trapdoor/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return TRUE
	if(istype(T,/turf/open/lava))
		return FALSE
	return ..()

/datum/crafting_recipe/roguetown/structure/sign
	name = "custom sign - (small log; BEGINNER)"
	result = /obj/structure/fluff/customsign
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 1

/datum/crafting_recipe/roguetown/structure/dummy
	name = "training dummy - (small log, stick, fiber; BEGINNER)"
	result = /obj/structure/fluff/statue/tdummy
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/fibers = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 1

/datum/crafting_recipe/roguetown/structure/display_stand
	name = "display stand - (small log, stick; COMPETENT)"
	result = /obj/structure/mannequin
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/grown/log/tree/stick = 3)
	verbage = "construct"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/mannequin
	name = "mannequin - (small log, cloth, iron ingot; COMPETENT)"
	result = /obj/structure/mannequin/male
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/cloth = 1,
				/obj/item/ingot/iron = 1)
	verbage = "construct"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/mannequin_f
	name = "feminine mannequin - (small log, cloth, iron ingot; COMPETENT)"
	result = /obj/structure/mannequin/male/female
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/cloth = 1,
				/obj/item/ingot/iron = 1)
	verbage = "construct"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/carpentry
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/passage
	name = "passage - (iron ingot, cog; COMPETENT)"
	result = /obj/structure/bars/passage
	reqs = list(/obj/item/ingot/iron = 1,
					/obj/item/roguegear/bronze = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/passage/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	if(istype(T,/turf/open/lava))
		return FALSE
	if(istype(T,/turf/open/water))
		return FALSE
	return ..()

/datum/crafting_recipe/roguetown/structure/coolingtable
	name = "Cooling Table - (small log, iron ingot, cog; PROFICIENT)"
	result = /obj/structure/table/cooling
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/ingot/iron = 1,
				/obj/item/roguegear/bronze = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	skill_level = 3

/datum/crafting_recipe/roguetown/structure/wallladder
	name = "wall ladder - (small log; COMPETENT)"
	result = /obj/structure/wallladder
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage_simple = "construct"
	verbage = "constructs"
	skillcraft = /datum/skill/craft/carpentry
	wallcraft = TRUE
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/torchholder
	name = "sconce - (2 stones; NONE)"
	result = /obj/machinery/light/rogue/torchholder
	reqs = list(/obj/item/natural/stone = 2)
	verbage_simple = "build"
	verbage = "builds"
	skillcraft = /datum/skill/craft/masonry
	wallcraft = TRUE
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/wallcandle
	name = "wall candles - (stone, candle; NONE)"
	result = /obj/machinery/light/rogue/wallfire/candle
	reqs = list(/obj/item/natural/stone = 1, /obj/item/candle/yellow = 1)
	verbage_simple = "build"
	verbage = "builds"
	skillcraft = /datum/skill/craft/masonry
	wallcraft = TRUE
	skill_level = 0

/datum/crafting_recipe/roguetown/structure/stonewalldeco
	name = "wall decoration (stone) - (stone; COMPETENT)"
	result = /obj/structure/fluff/walldeco/stone
	reqs = list(/obj/item/natural/stone = 1)
	verbage_simple = "build"
	verbage = "builds"
	skillcraft = /datum/skill/craft/masonry
	wallcraft = TRUE
	skill_level = 2

/datum/crafting_recipe/roguetown/structure/statue
	name = "statue - (3 stones; PROFICIENT)"
	result = /obj/structure/fluff/statue/femalestatue //TODO: Add sculpting
	reqs = list(/obj/item/natural/stone = 3)
	verbage_simple = "build"
	verbage = "builds"
	skillcraft = /datum/skill/craft/masonry
	skill_level = 3
