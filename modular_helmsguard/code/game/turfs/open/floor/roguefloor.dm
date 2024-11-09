// This file is to modularize alternative turf icons for existing turfs.
// If you wish to change a turf's icon, direct it to its version in either \modular_helmsguard\icons\turf\roguefloor.dmi.
// If you are making a new turf, make a new .dm to define it and make a new .dmi file exclusively for what you need.
//
// This will free future contributors to make turf changes and minimize merge conflicts.


//Adding subtype for random dir and nosmooth, used for mapping.

/turf/open/floor/rogue/ruinedwood/nosmooth
	icon_state = "wooden_floor"
	smooth = SMOOTH_FALSE
	canSmoothWith = null
	neighborlay = null

/turf/open/floor/rogue/ruinedwood/nosmooth/Initialize()
//	dir = pick(GLOB.cardinals)
//	. = ..()

/turf/open/floor/rogue/ruinedwood/nosmooth/turned
	icon_state = "wooden_floort"

/turf/open/floor/rogue/ruinedwood/nosmooth/spiral
	icon_state = "weird1"
/turf/open/floor/rogue/ruinedwood/nosmooth/chevron
	icon_state = "weird2"

// Subtypes with the lighter shades since these aren't giving me trouble.


/turf/open/floor/rogue/ruinedwood/nosmooth/herringbone2
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
	icon_state = "herringbonewood2"

/turf/open/floor/rogue/ruinedwood/nosmooth/wooden_floor2
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
	icon_state = "wooden_floor2"

/turf/open/floor/rogue/ruinedwood/nosmooth/wooden_floor2turned
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
	icon_state = "wooden_floor2t"

/turf/open/floor/rogue/twig/nospin
	icon_state = "twig"

/turf/open/floor/rogue/twig/nospin/Initialize()
//	dir = pick(GLOB.cardinals)			Replaces the initialize in the parent.
//	. = ..()

/turf/open/floor/rogue/wood/nosmooth //Somehow the nosmooth children in the base .dm... smoothed.
	icon_state = "wooden_floor"
	smooth = SMOOTH_FALSE
	canSmoothWith = null

/turf/open/floor/rogue/woodturned/nosmooth
	icon_state = "wooden_floort"
	smooth = SMOOTH_FALSE
	canSmoothWith = null









// The following are resprites in modular_helmsguard.

/obj/effect/decal/wood/
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "wooden_floor2edge"	Keeping this noted for reference.

/obj/effect/decal/wood/turnd
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "wooden_floor2tedge"

/obj/effect/decal/wood/ruinedwood
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "wooden_flooredge"

/obj/effect/decal/wood/ruinedwood/turned
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "wooden_floortedge"



//floors

/turf/open/floor/rogue/cobble
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "cobblestone1"

// These use otherwise unused icons. Rotated to NW highlights.

/turf/open/floor/rogue/cobble2
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
	icon_state = "cobblestone2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "cobbleedge"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)

/turf/open/floor/rogue/cobble3
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
	icon_state = "cobblestone3"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "cobbleedge"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)

/turf/open/floor/rogue/cobble/mossy
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "mossystone1"

/turf/open/floor/rogue/cobble/mossy2
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
	icon_state = "mossystone2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "cobbleedge"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)

/turf/open/floor/rogue/cobble/mossy3
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
	icon_state = "mossystone3"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "cobbleedge"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)

/turf/open/floor/rogue/blocks/stonered/nosmooth
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "stoneredlarge"

/turf/open/floor/rogue/blocks/stonered/tiny/nosmooth
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "stoneredtiny"

/turf/open/floor/rogue/blocks/newstone/nosmooth
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "newstone2"

/turf/open/floor/rogue/blocks/newstone/alt/nosmooth
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "bluestone"

/turf/open/floor/rogue/blocks/stone/nosmooth
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "stone1"

/turf/open/floor/rogue/blocks/stone/stonepattern2
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "stone2"

/turf/open/floor/rogue/blocks/stone/stonepattern3
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
//	icon_state = "stone3"


// Nosmooth Stone Blocks

/turf/open/floor/rogue/blocks/nosmooth
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'
	icon_state = "blocks"
	smooth = SMOOTH_FALSE
	canSmoothWith = null
/turf/open/floor/rogue/blocks/nosmooth/Initialize()

/turf/open/floor/rogue/hexstone/nosmooth
	smooth = SMOOTH_FALSE
	canSmoothWith = null

/turf/open/floor/rogue/hexstone/nosmooth/Initialize()


//Church floors

/turf/open/floor/rogue/churchmarble/nosmooth
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'	// Flipped so highlights are from NW

/turf/open/floor/rogue/church
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'	// Flipped so highlights are from NW


// These try to fix the need for nosmooth / norand turfs.

/turf/open/floor/rogue/church/nosmooth
	smooth = null											// Disable smoothing

/turf/open/floor/rogue/church/nosmooth/Initialize()			// Remove random dir initialize() in parent object.

/turf/open/floor/rogue/churchbrick
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'	// Flipped so highlights are from NW

/turf/open/floor/rogue/churchbrick/nosmooth
	smooth = null											// Disable smoothing

/turf/open/floor/rogue/churchbrick/nosmooth/Initialize()	// Remove random dir initialize() in parent object.

/turf/open/floor/rogue/churchrough
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'	// Generated alternate stone directions

/turf/open/floor/rogue/churchrough/nosmooth
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'	// Generated alternate stone directions

/turf/open/floor/rogue/churchrough/nosmooth/Initialize()	// Remove random dir initialize() in parent object.


// End of attempted nosmooth / norand turfs.



// Rooftops

/turf/open/floor/rogue/rooftop
	icon = 'modular_helmsguard/icons/turf/roguefloor.dmi'	// Previously tiles did not slope correctly.

/*	icon_state = "roof-arw"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/rogue/rooftop/Initialize()
	. = ..()
	icon_state = "roof"

/turf/open/floor/rogue/rooftop/green
	icon_state = "roofg-arw"

/turf/open/floor/rogue/rooftop/green/Initialize()
	. = ..()
	icon_state = "roofg"

/turf/open/floor/rogue/rooftop/green/corner1
	icon_state = "roofgc1-arw"

/turf/open/floor/rogue/rooftop/green/corner1/Initialize()
	. = ..()
	icon_state = "roofgc1"

All this might be redundant or might not, if it works, remove contents of this comment. Or never do.
*/