/*
	Attempts to enable/disable drifter queue
*/
/datum/controller/subsystem/role_class_handler/proc/toggle_drifter_queue()
	if(drifter_queue_enabled == FALSE) // Keep in mind, if we are set to false this will soon be true, so it'd be safer to have the instructions here
		if(!(length(drifter_wave_schedule) > current_wave_number + drifter_wave_schedule_buffer))
			handle_drifter_wave_scheduling()
		if(world.time > next_drifter_mass_release_time)
			next_drifter_mass_release_time = world.time + 5 MINUTES

	drifter_queue_enabled = !drifter_queue_enabled
	can_fire = drifter_queue_enabled

/*
	Attempts to just toggle whether the drifter queue is delayed or not
*/
/datum/controller/subsystem/role_class_handler/proc/delay_drifter_queue()
	drifter_queue_delayed = !drifter_queue_delayed
	rebuild_drifter_time_string()

/*
	Attempts to remove and cleanup drifter queue viewer datum

*/
/datum/controller/subsystem/role_class_handler/proc/remove_drifter_queue_viewer(client/C)
	var/datum/drifter_queue_menu/menu = drifter_queue_menus[C.ckey]
	if(menu)
		if(menu.linked_client)
			menu.ForceCloseMenus()
			menu.linked_client = null
		drifter_queue_menus.Remove(C.ckey)
		qdel(menu)

/*
	Attempts to create a new drifter queue viewer datum and tie the client into it
*/
/datum/controller/subsystem/role_class_handler/proc/add_drifter_queue_viewer(client/C)
	if(!drifter_queue_enabled)
		return

	var/datum/drifter_queue_menu/menu = drifter_queue_menus[C.ckey]
	if(menu)
		if(!menu.linked_client)
			menu.linked_client = C
		menu.first_show_drifter_queue_menu()
	else
		menu = new()
		drifter_queue_menus[C.ckey] = menu
		menu.linked_client = C
		menu.first_show_drifter_queue_menu()

/*
	Attempts to add a client to be queued for processing in the next drifter release
*/
/datum/controller/subsystem/role_class_handler/proc/attempt_to_add_client_to_drifter_queue(client/target_client)
	if(target_client in drifter_queue_joined_clients)
		return FALSE
//	var/datum/drifter_wave/current_wave = drifter_wave_schedule[current_wave_number]
	//if(drifter_wave_joined_clients.len >= current_wave.maximum_playercount)
	//	return FALSE
	if(!check_drifterwave_restrictions(target_client))
		return FALSE
	if(Master.current_runlevel < RUNLEVEL_LOBBY) // No entering during init
		return FALSE
	if(Master.current_runlevel == RUNLEVEL_LOBBY)
		var/mob/dead/new_player/pregame_tard = target_client.mob
		if(pregame_tard.ready == PLAYER_READY_TO_PLAY) // No entering if you are already ready
			return FALSE

	drifter_queue_joined_clients += target_client
	// If the current wave isn't full jus enter us in brother
	if(current_wave.maximum_playercount > drifter_wave_FULLY_entered_clients.len)
		drifter_wave_FULLY_entered_clients += target_client
		rebuild_drifter_html_table()
		queue_table_browser_update = TRUE
	return TRUE


/*
	Attempts to remove a client from the processing list for the next drifter release
*/
/datum/controller/subsystem/role_class_handler/proc/remove_client_from_drifter_queue(client/target_client)
	if(target_client in drifter_queue_joined_clients)
		drifter_queue_joined_clients -= target_client
		if(target_client in drifter_wave_FULLY_entered_clients)
			drifter_wave_FULLY_entered_clients -= target_client
			rebuild_drifter_html_table()
			queue_table_browser_update = TRUE
		return TRUE
	return FALSE

/*
	A haphazard proc that just attempts to cleanup anything related to a client in both the queue and viewer areas
*/
/datum/controller/subsystem/role_class_handler/proc/cleanup_drifter_queue(client/target_client)
	remove_client_from_drifter_queue(target_client)
	remove_drifter_queue_viewer(target_client)

/*
	Just checks the restrictions on the drifter wave datum against the client and tells you if they ain't getting in
	If I build a total string and do every check then... it may get a bit nasty you know?
*/
/datum/controller/subsystem/role_class_handler/proc/check_drifterwave_restrictions(client/target_client)
	if(length(current_wave.allowed_races) && !(target_client.prefs.pref_species.type in current_wave.allowed_races))
		to_chat(target_client, span_warning(" WRONG RACE "))
		return FALSE
	if(length(current_wave.allowed_patrons) && !(target_client.prefs.selected_patron.type in current_wave.allowed_patrons))
		to_chat(target_client, span_warning(" WRONG PATRON "))
		return FALSE

	var/list/local_allowed_sexes = list()
	if(length(current_wave.allowed_sexes))
		local_allowed_sexes |= current_wave.allowed_sexes
	if(!current_wave.immune_to_genderswap && target_client.prefs.pref_species.gender_swapping)
		if(MALE in current_wave.allowed_sexes)
			local_allowed_sexes -= MALE
			local_allowed_sexes += FEMALE
		if(FEMALE in current_wave.allowed_sexes)
			local_allowed_sexes -= FEMALE
			local_allowed_sexes += MALE
	if(length(local_allowed_sexes) && !(target_client.prefs.gender in local_allowed_sexes))
		return JOB_UNAVAILABLE_SEX
	if(length(current_wave.allowed_sexes) && !(target_client.prefs.gender in current_wave.allowed_sexes))
		to_chat(target_client, span_warning(" WRONG GENDER "))
		return FALSE
	if(length(current_wave.allowed_ages) && !(target_client.prefs.age in current_wave.allowed_ages))
		to_chat(target_client, span_warning(" WRONG AGEGROUP "))
		return FALSE
	if(length(current_wave.allowed_skintones) && !(target_client.prefs.skin_tone in current_wave.allowed_skintones))
		to_chat(target_client, span_warning(" WRONG ANCESTRY "))
		return FALSE
	return TRUE

/*
	Just a proc that occurs a smidge before the MC gets its runlevel set to RUNLEVEL_GAME
*/
/datum/controller/subsystem/role_class_handler/proc/RoundStart()
	drifter_queue_delayed = FALSE
	//rebuild_drifter_time_string()

	//for(var/cur_ckey in drifter_queue_menus)
	//	var/datum/drifter_queue_menu/cur_menu = drifter_queue_menus[cur_ckey]
	//	if(!cur_menu.linked_client)
	//		drifter_queue_menus.Remove(cur_ckey)
	//		qdel(cur_menu)
	//		continue

	//	cur_menu.show_drifter_queue_menu()
			
