#define BERRYCOLORS	list("#6a6699", "#9b6464", "#58a75c", "#5658a9", "#669799")
GLOBAL_LIST_EMPTY(berrycolors)

GLOBAL_LIST_INIT(plant_defs, build_plant_defs())

/proc/build_plant_defs()
	. = list()
	for(var/path in subtypesof(/datum/plant_def))
		.[path] = new path()
