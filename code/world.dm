//This file is just for the necessary /world definition
//Try looking in game/world.dm

/**
  * # WorldR
  *
  * Two possibilities exist: either we are alone in the Universe or we are not. Both are equally terrifying. ~ Arthur C. Clarke
  *
  * The byond world object stores some basic byond level config, and has a few hub specific procs for managing hub visiblity
  *
  * The world /New() is the root of where a round itself begins
  */
/world
	mob = /mob/dead/new_player
	// DO NOT set this to any turf type that has ANY on-new or on-initialize functionality
	// doing that breaks hotloading zlevels!
	turf = /turf/open/dark_filler
	// Similarly, world.area MUST be outdoors or else things will
	area = /area/rogue/outdoors
	view = "15x15"
	hub = "Exadv1.spacestation13"
	name = "Rotwood Vale"
	fps = 20
#ifdef FIND_REF_NO_CHECK_TICK
	loop_checks = FALSE
#endif
