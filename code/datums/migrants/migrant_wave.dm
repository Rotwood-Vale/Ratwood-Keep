/datum/migrant_wave
	abstract_type = /datum/migrant_wave
	/// Name of the wave
	var/name = "MIGRANT WAVE"
	/// Assoc list of roles types to amount
	var/list/roles = list()
	/// If defined, this is the minimum active migrants required to roll the wave
	var/min_active = null
	/// If defined, this is the maximum active migrants required to roll the wave
	var/max_active = null
	/// If defined, this is the minimum population playing the game that is required for wave to roll
	var/min_pop = null
	/// If defined, this is the maximum population playing the game that is required for wave to roll
	var/max_pop = null
	/// If defined, this is the maximum amount of times this wave can spawn
	var/max_spawns = null
	/// The relative probability this wave will be picked, from all available waves
	var/weight = 100
	/// Name of the latejoin spawn landmark for the wave to decide where to spawn
	var/spawn_landmark = "Pilgrim"
	/// Text to greet all players in the wave with
	var/greet_text
	/// How many times this wave successfuly spawned
	var/spawned_amount = 0

/datum/migrant_wave/test
	name = "Testing"
	roles = list(
		/datum/migrant_role/test = 1,
	)
	greet_text = "This is a test, you are in a simulation"
	weight = 0

/datum/migrant_wave/pilgrim
	name = "Pilgrimage"
	roles = list(
		/datum/migrant_role/pilgrim = 1,
	)

