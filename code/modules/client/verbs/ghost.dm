GLOBAL_LIST_INIT(ghost_verbs, list(
	/client/proc/ghost_up,
	/client/proc/ghost_down,
	/client/proc/reenter_corpse,
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

/client/proc/reenter_corpse()
	set category = "Spirit"
	set name = "Re-enter corpse"
	if(isobserver(mob))
		var/mob/dead/observer/rogue/veil/ghost = mob
		ghost.reenter_corpse()

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
