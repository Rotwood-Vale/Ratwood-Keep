/*
	Schedule next drifter queue wave
	To note here where relevant logic would be
	For now its gonna be slopped
*/
/datum/controller/subsystem/role_class_handler
/*
	List of drifter wave datums, created and crammed up this lists ass in the initialize for this subsystem
	ex: sorted_drifter_wave_categories[CTAG_ANTAG] += /datum/drifter_wave/turbo_killa
	contents: sorted_drifter_wave_categories = list(CTAG_ANTAG = list(/datum/drifter_wave/antag1), CTAG_RETARDS = list(/datum/drifter_wave/retardz2) ... etc)
	snowflake lists: CTAG_ALLWAVES - Every wave, CTAG_DISABLED - Its supposed to be disabled
*/
	var/list/sorted_drifter_wave_categories = list()

/*
	WORKING VARS
*/
// Gets set on the mode if bandits are in the round
	var/bandits_in_round = FALSE

/*
	THE RETARDED PROC FOR TRYING TO SCHEDULE ANOTHER WAVE
*/
/datum/controller/subsystem/role_class_handler/proc/handle_drifter_wave_scheduling()
	
	var/target_wave_addition = drifter_wave_schedule_buffer - (drifter_wave_schedule.len - current_wave_number)
	if(target_wave_addition <= 0) // target wave additions will enter negatives if we are way past buffer too
		return

	// Filler code for any complex logic rn
	for(var/i in 1 to target_wave_addition)
		var/datum/drifter_wave/BIGMAN

		if(bandits_in_round && prob(35))
			BIGMAN = pick(sorted_drifter_wave_categories[DTAG_BANDITS])
		else
			BIGMAN = pick(sorted_drifter_wave_categories[DTAG_FILLERS])
		var/datum/drifter_wave/LITTLEMAN = new BIGMAN.type
		drifter_wave_schedule += LITTLEMAN



	// Run post run for old wave
	if(current_wave) 
		current_wave.post_drifter_wave()
	// Set a new wave
	current_wave = drifter_wave_schedule[current_wave_number]
	// Run setup for new wave
	current_wave.pre_drifter_wave()
	
	//See if theres anyone already in queue for us to pick, If so they get auto joined into the next wave
	if(drifter_queue_joined_clients.len)
		var/end_num = current_wave.maximum_playercount
		if(end_num > drifter_queue_joined_clients.len)
			end_num = drifter_queue_joined_clients.len
		for(var/i in 1 to end_num)
			var/client/q_client = drifter_queue_joined_clients[i]
			drifter_wave_FULLY_entered_clients += q_client
		rebuild_drifter_html_table()
		queue_table_browser_update = TRUE


