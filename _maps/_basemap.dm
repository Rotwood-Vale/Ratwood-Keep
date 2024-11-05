//#define LOWMEMORYMODE //uncomment this to load centcom alongside the debug map and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Roguetown\roguetown.dmm"
		#include "map_files\Rogueworld\Rogueworld.dmm"

		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif