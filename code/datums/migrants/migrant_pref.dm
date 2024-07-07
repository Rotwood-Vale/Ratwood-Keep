/datum/migrant_pref
	/// Whether the user wants to be a migrant
	var/active = FALSE
	/// Role preferences of the user, the things he clicks on to be preferred to be
	var/list/role_preferences = list()

/datum/migrant_pref/proc/set_active(new_state)
	if(new_state == be_migrant)
		return
	active = new_state
	role_preferences.Cut()

