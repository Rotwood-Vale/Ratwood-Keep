/*
	Drifter Queue Shit, role_class_handler subsystem except hopefully most to all of the drifter queue shit is in here
*/
/datum/controller/subsystem/role_class_handler
/*
	assc list of ckeys linked to drifter queue menus if they got one which have client refs on them
	ex: drifter_queue_menuss[ckey] = /datum/drifter_queue_menu
	contents: drifter_queue_menus = list("ckey" = /datum/drifter_queue_menu, "ckey2" = /datum/drifter_queue_menu,... etc)
*/
	var/list/drifter_queue_menus = list()
	
	// Set this to false manually to stop the system, if you want to start the system call toggle_drifter_queue()
	var/drifter_queue_enabled = FALSE
	// Whether we are currently delayed, which stops the actual wave handling segment from firing
	var/drifter_queue_delayed = TRUE

/*
	WORKING VARS
*/
	// How many drifters have entered into the round over the entire course of it
	var/total_amount_of_drifters_entered_into_round = 0
	// ref to the current wave
	var/datum/drifter_wave/current_wave
	// Schedule of drifter waves
	var/list/drifter_wave_schedule = list()
	// List of clients who are currently queued
	var/list/drifter_queue_joined_clients = list()
	// List of clients who are set to be sent out with the wave
	var/list/drifter_wave_FULLY_entered_clients = list()
	// Number of waves we keep scheduled past the current one
	var/drifter_wave_schedule_buffer = 2
	// Next time we attempt to process a wave/joined clients
	var/next_drifter_mass_release_time = 0
	// Current wave number we are on
	var/current_wave_number = 1

	// Whether its time for a total refresh (sorry I don't feel like updating the damn table itself)
	var/queue_total_browser_update = FALSE
	// Whether its time to update the browser table
	var/next_queue_table_browser_update_time
	var/queue_table_browser_update = FALSE
	// String vars for display menus
	var/drifter_queue_player_tbl_string = ""
	var/time_left_until_next_wave_string = "DISABLED"
	// List of menu datums that we are currently processing in the fire() var on this subsystem
	var/list/currentrun = list() 

/*
	Hey we got somethin to keep track of now, which is drifter queue
	haha
*/
/datum/controller/subsystem/role_class_handler/fire(resumed = 0)
	if(!drifter_queue_enabled)
		can_fire = FALSE
		return

	if(!resumed)
		src.currentrun = drifter_queue_menus.Copy()

	// Rebuild the timer string
	rebuild_drifter_time_string()
/*
	LOOP SEGMENT
	Here is where we handle a majority of the normal menu updates
*/
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	while(currentrun.len)
		var/current_ckey = currentrun[currentrun.len]
		var/datum/drifter_queue_menu/current_menu = currentrun[current_ckey]
		currentrun.len--
		
		// If the datum has no linked client just remove it
		if(!current_menu.linked_client)
			drifter_queue_menus.Remove(current_ckey)
			qdel(current_menu)
			continue

		var/client/target_client = current_menu.linked_client
		// Refresh timer
		target_client << output(url_encode(time_left_until_next_wave_string), "drifter_queue.browser:update_timer")
		
		// Whether its time to refresh the webpage for someone
		if(queue_total_browser_update)
			current_menu.show_drifter_queue_menu()

		// Whether its time to update the player table and playercount for the waves
		if(queue_table_browser_update)
			// This function wants the lefthand current wave player number and then the current table html
			target_client << output(list2params(list("[drifter_wave_FULLY_entered_clients.len]", drifter_queue_player_tbl_string)), "drifter_queue.browser:update_playersegments")

		if(MC_TICK_CHECK)
			return

	// Make sure to set the table/browser refresh to off after we are done
	if(queue_total_browser_update)
		queue_total_browser_update = FALSE
	if(queue_table_browser_update)
		queue_table_browser_update = FALSE

/*
	PREGAME CUCKSTOPPER
	Aka we don't want people to join queue and then click ready and stay in queue
*/
	// You will not be in drifter queue and adversely also join regular queue dickhead
	if(Master.current_runlevel == RUNLEVEL_LOBBY)
		for(var/client/target_client in drifter_queue_joined_clients)
			var/mob/dead/new_player/pregame_retard = target_client.mob
			if(pregame_retard.ready == PLAYER_READY_TO_PLAY)
				drifter_queue_joined_clients -= target_client

				rebuild_drifter_html_table()

				for(var/itr_ckeys in drifter_queue_menus)
					if(itr_ckeys != target_client.ckey)
						continue
					var/datum/drifter_queue_menu/fuckyou = drifter_queue_menus[itr_ckeys]
					fuckyou.show_drifter_queue_menu()

	// If we are delayed just stop here
	if(drifter_queue_delayed)
		return

/*
	WAVE DEPLOYMENT SEGMENT
	Aka we are trying to deploy all the sick cunts in the wave
*/
	if(world.time >= next_drifter_mass_release_time)
		//to_chat(world, "Release Drifters")

		if(!current_wave)
			return

		if(drifter_wave_schedule.len >= current_wave_number+1)
			var/datum/drifter_wave/next_wave = drifter_wave_schedule[current_wave_number+1]
			next_drifter_mass_release_time = world.time + next_wave.wave_delay_time
		else
			next_drifter_mass_release_time = world.time + current_wave.wave_delay_time

		if(drifter_wave_FULLY_entered_clients.len)
			current_wave.build_dropzone()
			if(!current_wave.drifter_dropzone_targets)
				message_admins("DRIFTER QUEUE TRIED TO FIRE WAVE WITH NO DROPZONE")
				return

			var/list/temp_dropoff_refs = current_wave.drifter_dropzone_targets.Copy()
			for(var/client/target_client in drifter_wave_FULLY_entered_clients)
				if(!check_drifterwave_restrictions(target_client)) // Alas, I be feelin lazy fuck you ppl
					continue
				var/mob/living/character = process_drifter_wave_client(target_client)
				if(character) // plz do not runtime here ok
					var/turf/picked_turf
					// Do our best to make sure our guys don't spawn ontop of each other
					if(temp_dropoff_refs)
						picked_turf = pick(temp_dropoff_refs)
						temp_dropoff_refs -= picked_turf
					else // And if we can't we will just do it neways ok
						picked_turf = current_wave.drifter_dropzone_targets

					character.forceMove(picked_turf)
					current_wave.post_character_handling(character)
				// We do some tracking for funsies
				total_amount_of_drifters_entered_into_round++

			drifter_wave_FULLY_entered_clients.Cut()

		queue_total_browser_update = TRUE

		handle_drifter_wave_scheduling()
		current_wave_number++




// It would be my hope that anything going through here starts off as a /mob/dead/new_player
// Otherwise I will have to copypaste a ton of shit
// Also as you can see I already copy and pasted a ton of shit located on mob/dead/new_player/AttemptLateSpawn()
/datum/controller/subsystem/role_class_handler/proc/process_drifter_wave_client(client/target_client)
	var/mob/dead/new_player/ourguy = target_client.mob
	if(!ourguy)
		message_admins("DRIFTER QUEUE HAS BROKEN AND WE GOT SOME GUY WHO AIN'T ON CHAR SETUP! SHIIIET")
		return

	// you could technically have a wave of any fuckin job if you wanted ironically
	var/rank = current_wave.job_rank 

	// The important segments of SSjob's AssignRole, the only thing we are missing is incrementing the jobcount which we will not do for immigrants
	ourguy.mind.assigned_role = rank
	SSjob.unassigned -= ourguy

	// This one is fine
	var/mob/living/character = ourguy.create_character(TRUE)	//creates the human and transfers vars and mind
	character.islatejoin = TRUE

	// In the offchance you want a way to just force some specific clown azz outfits onto people and not deal in job datums.
	if(current_wave.bypass_job_and_force_this_outfit_on)
		var/mob/living/carbon/human/HEH = character
		if(HEH)
			HEH.equipOutfit(current_wave.bypass_job_and_force_this_outfit_on)
	else
		var/equip = SSjob.EquipRank(character, rank, TRUE)
		//Theres many ways to go about it, but if you want to turn someone into some other shit, and decide to look at cyborg.dm
		//You can just return a mob in the job's equip datum, and this will help it.
		if(isliving(equip))	
			character = equip

	var/atom/movable/screen/splash/Spl = new(character.client, TRUE)
	Spl.Fade(TRUE)
	character.update_parallax_teleport()

	SSticker.minds += character.mind
	GLOB.joined_player_list += character.ckey

	var/fakekey = character.ckey
	if(target_client.ckey in GLOB.anonymize)
		fakekey = get_fake_key(character.ckey)

	GLOB.character_list[character.mobid] = "[fakekey] was [character.real_name] ([rank])<BR>"
	GLOB.character_ckey_list[character.real_name] = character.ckey
	log_character("[character.ckey] ([fakekey]) - [character.real_name] - [rank]")

	if(GLOB.respawncounts[character.ckey])
		var/AN = GLOB.respawncounts[character.ckey]
		AN++
		GLOB.respawncounts[character.ckey] = AN
	else
		GLOB.respawncounts[character.ckey] = 1

	return character
	log_manifest(character.mind.key, character.mind, character, latejoin = TRUE)


