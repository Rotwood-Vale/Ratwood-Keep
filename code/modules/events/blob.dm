/datum/round_event_control/blob
	name = "Fleshmass"
	typepath = /datum/round_event/ghost_role/blob
	weight = 10
	max_occurrences = 1
	min_players = 20

/datum/round_event/ghost_role/blob/spawn_role()
	if(!GLOB.blobstart.len)
		return MAP_ERROR
	var/list/candidates = get_candidates(ROLE_BLOB, null, ROLE_BLOB)
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS
	var/mob/dead/observer/new_blob = pick(candidates)
	var/mob/camera/blob/BC = new_blob.become_overmind()
	spawned_mobs += BC
	message_admins("[ADMIN_LOOKUPFLW(BC)] has been made into a fleshmass overmind.")
	log_game("[key_name(BC)] was spawned as a fleshmass overmind.")
	return SUCCESSFUL_SPAWN
