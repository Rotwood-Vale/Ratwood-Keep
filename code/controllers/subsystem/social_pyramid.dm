// Lists the Duke technically manipulates.
GLOBAL_LIST_INIT(dyn_races_respected, list(RACES_RESPECTED))
GLOBAL_LIST_INIT(dyn_races_tolerated, list(RACES_TOLERATED))
GLOBAL_LIST_INIT(dyn_races_shunned, list(RACES_SHUNNED))

// Lists updated by the subsystem as a result of the Duke's actions.
// They are used for job restrictions.
GLOBAL_LIST_INIT(dyn_races_respected_up, RACES_RESPECTED_UP)
GLOBAL_LIST_INIT(dyn_races_tolerated_up, RACES_TOLERATED_UP)
GLOBAL_LIST_INIT(dyn_races_shunned_up, RACES_SHUNNED_UP)

SUBSYSTEM_DEF(social_pyramid)
	name = "Social Pyramid"
	flags = SS_NO_FIRE | SS_NO_INIT

/// Elevates a race from Shunned up to Respected.
/datum/controller/subsystem/social_pyramid/proc/elevate_race(datum/species/S)

	if(S in GLOB.dyn_races_shunned)
		GLOB.dyn_races_shunned -= S
		GLOB.dyn_races_tolerated += S
		update_pyramid()
		return TRUE

	if(S in GLOB.dyn_races_tolerated)
		GLOB.dyn_races_tolerated -= S
		GLOB.dyn_races_respected += S
		update_pyramid()
		return TRUE

	return FALSE

/// Degrades a race from Respected down to Shunned.
/datum/controller/subsystem/social_pyramid/proc/degrade_race(datum/species/S)

	if(S in GLOB.dyn_races_respected)
		GLOB.dyn_races_respected -= S
		GLOB.dyn_races_tolerated += S
		update_pyramid()
		return TRUE

	if(S in GLOB.dyn_races_tolerated)
		GLOB.dyn_races_tolerated -= S
		GLOB.dyn_races_respected += S
		update_pyramid()
		return TRUE

	return FALSE

/// Updates the social pyramid. Called after a succesful change.
/datum/controller/subsystem/social_pyramid/proc/update_pyramid()

	GLOB.dyn_races_respected_up = GLOB.dyn_races_respected
	GLOB.dyn_races_tolerated_up = GLOB.dyn_races_respected_up + GLOB.dyn_races_tolerated
	GLOB.dyn_races_shunned_up = GLOB.dyn_races_tolerated_up + GLOB.dyn_races_shunned


/datum/job
	/// Is the job's allowed_races affected by the social pyramid
	var/in_pyramid = TRUE

/// Checks if the selected race is allowed to play the selected job according to the current social pyramid.
/datum/job/proc/social_pyramid_check(datum/species/pref_species)

	switch(allowed_races)
		if(RACES_SHUNNED_UP)
			if(length(GLOB.dyn_races_shunned_up + special_exceptions) && !(pref_species.type in (GLOB.dyn_races_shunned_up + special_exceptions)))
				return FALSE
		if(RACES_TOLERATED_UP)
			if(length(GLOB.dyn_races_tolerated_up + special_exceptions) && !(pref_species.type in (GLOB.dyn_races_tolerated_up + special_exceptions)))
				return FALSE
		if(RACES_RESPECTED_UP)
			if(length(GLOB.dyn_races_respected_up + special_exceptions) && !(pref_species.type in (GLOB.dyn_races_respected_up + special_exceptions)))
				return FALSE
				
	return TRUE
		


