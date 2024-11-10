GLOBAL_LIST_INIT(ghost_verbs, list(
	/client/proc/ghost_up,
	/client/proc/ghost_down,
	/client/proc/descend
	))

/client/proc/ghost_up()
	set category = "Spirit"
	set name = "GhostUp"
	if(isobserver(mob))
		mob.ghost_up()

/client/proc/ghost_down()
	set category = "Spirit"
	set name = "GhostDown"
	if(isobserver(mob))
		mob.ghost_down()

/client/proc/descend()
	set name = "Journey to the Underworld"
	set category = "Spirit"

	var/descend_text = "Descend to the Underworld?"

	if(isrogueobserver(mob) || isliving(mob))
		if(mob.mind?.funeral)
			descend_text = "Your body has been buried.\n\
							Are you ready to be judged?"

	switch(alert(descend_text, "", "Yes", "No"))
		if("Yes")
			try_descend()
		if("No")
			usr << "You have second thoughts."	

/client/proc/try_descend()
	if(istype(mob, /mob/living/carbon/spirit))
		//HONEYPOT CODE, REMOVE LATER
		message_admins("STUPID MOTHERFUCKER [key] IS TRYING TO CRASH THE SERVER BY SPAWNING 3 GORILLION SPIRITS!")
		return

	var/datum/mind/prevmind // for tracking mind-based respawns w/ spirit
	if(!isadminobserver(mob) && !isnewplayer(mob)) // auto-respawning aghosts that become spirits might not be great
		prevmind = mob.mind

	if(isrogueobserver(mob) && mob.mind) // adminghosts are unaffected, base observer type
		if(mob.mind.funeral == TRUE)
			var/mob/dead/observer/rogue/rogueghost = mob
			to_chat(rogueghost, span_rose("With my body buried in creation, my soul passes on in peace..."))
			burial_rite_return_ghost_to_lobby(rogueghost)
			return

	if(isliving(mob))
		var/mob/living/D = mob
		if(D.mind && D.mind.funeral)
			var/ghost = burial_rite_make_ghost(D)
			if(ghost)
				to_chat(ghost, span_rose("With my body buried in creation, my soul passes on in peace..."))
				burial_rite_return_ghost_to_lobby(ghost)
				return
			else
				message_admins("[key_name(mob)] was funeralized, but failed to turn into ghost when using Journey to the Underworld verb. Might need admin intervention.")
				mob.log_message("was funeralized, but failed to turn into ghost when using Journey to the Underworld verb.", LOG_GAME)

		// Check if the player's job is hiv+
		var/datum/job/target_job = SSjob.GetJob(D.mind.assigned_role)
		if(target_job)
			if(target_job.job_reopens_slots_on_death)
				target_job.current_positions = max(0, target_job.current_positions - 1)
			if(target_job.same_job_respawn_delay)
				// Store the current time for the player
				GLOB.job_respawn_delays[src.ckey] = world.time + target_job.same_job_respawn_delay

	for(var/obj/effect/landmark/underworld/A in shuffle(GLOB.landmarks_list))
		var/mob/living/carbon/spirit/O = new /mob/living/carbon/spirit(A.loc)
		O.livingname = mob.name
		O.ckey = ckey
		O.set_patron(prefs.selected_patron)
		O.prevmind = prevmind // for if we get buried later
		SSdroning.area_entered(get_area(O), O.client)
		break
	verbs -= GLOB.ghost_verbs

/mob/verb/returntolobby()
	set name = "{RETURN TO LOBBY}"
	set category = "Options"
	set hidden = 1
	
	if(key)
		GLOB.respawntimes[key] = world.time

	log_game("[key_name(usr)] respawned from underworld")

	to_chat(src, span_info("Returned to lobby successfully."))

	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		return
	client.screen.Cut()
	client.screen += client.void
//	stop_all_loops()
	SSdroning.kill_rain(src.client)
	SSdroning.kill_loop(src.client)
	SSdroning.kill_droning(src.client)
	remove_client_colour(/datum/client_colour/monochrome)
	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		return

	var/mob/dead/new_player/M = new /mob/dead/new_player()
	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		qdel(M)
		return

	client?.verbs -= GLOB.ghost_verbs
	M.key = key
	qdel(src)
	return
