/datum/job/roguetown/New()
	if(spawn_positions > 1 || spawn_positions == -1)
		bypass_lastclass = TRUE
	. = ..()
