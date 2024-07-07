/datum/migrant_wave
	abstract_type = /datum/migrant_wave
	/// Name of the wave
	var/name = "MIGRANT WAVE"
	/// Assoc list of roles types to amount
	var/list/roles = list()

/datum/migrant_wave/test
	name = "Testing"
	roles = list(
		/datum/migrant_role/test = 1,
	)
