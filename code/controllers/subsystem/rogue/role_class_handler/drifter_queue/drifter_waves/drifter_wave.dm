/datum/drifter_wave/drifters
	// Name of the wave to be shown where relevant
	wave_type_name = "Drifters"
	// Maximum playercount of wave
	maximum_playercount = 6
	// Tooltip when moused over on wave
	wave_type_tooltip = "Adventurers and pilgrims together, a band of immigrants searching for fame and fortune."
	// Title of the job related to the job subsystem thats being made/equipped towards for the wave
	job_rank = "Drifter"
	drifter_wave_categories = list(DTAG_FILLERS)
	advclass_cat_rolls = list(CTAG_PILGRIM = 10, CTAG_ADVENTURER = 5)
	class_cat_plusboost_attempts = list(CTAG_PILGRIM = 3) // Here you go buddy, have a 3 on pilgrims

	wave_delay_time = 2 MINUTES

	// BUILD THE LIST!
	drifter_dropzone_targets = list()
	
/datum/drifter_wave/drifters/build_dropzone()
	// This will be full of turfs
	var/list/potential_target_dropzones = list()

	for(var/obj/effect/landmark/cur_landmark in GLOB.landmarks_list)
		if(istype(cur_landmark, /obj/effect/landmark/start/adventurerlate))
			potential_target_dropzones += cur_landmark

	if(!potential_target_dropzones.len)
		if(SSjob.latejoin_trackers.len)
			potential_target_dropzones += pick(SSjob.latejoin_trackers)

	var/atom/TITS = pick(potential_target_dropzones) // Well we got our thing

	// we try our best to deploy each guy into his own turf ok this def needs to be less retarded but the map landmarks can be retarded
	var/rows_2_make = ceil(maximum_playercount/2)
	for(var/turf/T in block(TITS.x-1, TITS.y-2, TITS.z, TITS.x+rows_2_make, TITS.y+1, TITS.z))
		if(isopenturf(T))
			drifter_dropzone_targets += T
