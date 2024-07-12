/datum/drifter_wave/bandits
	// Name of the wave to be shown where relevant
	wave_type_name = "Bandits"
	// Maximum playercount of wave
	maximum_playercount = 6
	// Tooltip when moused over on wave
	wave_type_tooltip = "One of many wandering tropes in service to the god Matthios."
	// Title of the job related to the job subsystem thats being made/equipped towards for the wave
	job_rank = "Drifter"

	drifter_wave_categories = list(DTAG_BANDITS, DTAG_ANTAGS)
	wave_delay_time = 2 MINUTES

	forced_class_additions = list(/datum/advclass/bandit)
	
	// BUILD THE LIST!
	drifter_dropzone_targets = list()

// Bandits have a special spawn
/datum/drifter_wave/bandits/build_dropzone()
	// This will be full of turfs
	//drifter_dropzone_targets = GLOB.bandit_starts

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

// Idk might as well put them into the list
/datum/drifter_wave/bandits/post_character_handling(mob/living/character)
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(character && character.mind)
		C.bandits += character.mind

