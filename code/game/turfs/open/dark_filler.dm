// Like basic space but doesn't have the space plane.
/turf/open/dark_filler
	name = "\proper nothing"
	icon = 'icons/turf/space.dmi'
	icon_state = "black"

/turf/open/dark_filler/New()	//Do not convert to Initialize
	//This is used to optimize the map loader
	return
