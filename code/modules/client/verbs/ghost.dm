GLOBAL_LIST_INIT(ghost_verbs, list(
	/client/proc/ghost_up,
	/client/proc/ghost_down,
	/client/proc/descend,
	/client/proc/returntobody
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

/client/proc/returntobody()
	set name = "Return to body"
	set category = "Spirit"
	if(isobserver(mob))
		mob.grab_ghost(force = TRUE)

/client/proc/descend()
	set name = "Journey to the Underworld"
	set category = "Spirit"

	switch(alert("Descend to the Underworld?",,"Yes","No"))
		if("Yes")
			if(istype(mob, /mob/living/carbon/spirit))
				//HONEYPOT CODE, REMOVE LATER
				message_admins("RETARDED MOTHERFUCKER [key] IS TRYING TO CRASH THE SERVER BY SPAWNING 3 GORILLION SPIRITS!")
				return

			if(istype(mob, /mob/living/carbon/human))
				var/mob/living/carbon/human/D = mob
				if(D.buried && D.funeral)
					D.returntolobby()
					return

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
				SSdroning.area_entered(get_area(O), O.client)
				break
			verbs -= GLOB.ghost_verbs
		if("No")
			usr << "You have second thoughts."	

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
