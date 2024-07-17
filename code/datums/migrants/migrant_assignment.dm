/datum/migrant_assignment
	var/client/client = null
	var/role_type = null
	var/atom/spawn_location = null

/datum/migrant_assignment/New(role)
	. = ..()
	role_type = role
