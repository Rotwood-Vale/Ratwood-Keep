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

/datum/migrant_wave/pilgrim_test
	name = "Pilgrimage"
	weight = 0
	roles = list(
		/datum/migrant_role/pilgrim = 1,
	)

/datum/migrant_wave/adventurer_test
	name = "Adventure Party"
	weight = 0
	roles = list(
		/datum/migrant_role/adventurer = 1,
	)

/datum/migrant_wave/bandit_test
	name = "Bandits"
	weight = 0
	roles = list(
		/datum/migrant_role/bandit = 1,
	)

/datum/migrant_wave/pilgrim_small
	name = "Small Pilgrimage"
	max_active = 3
	roles = list(
		/datum/migrant_role/pilgrim = 3,
	)

/datum/migrant_wave/adventurer_small
	name = "Meek Adventure Party"
	max_active = 3
	roles = list(
		/datum/migrant_role/adventurer = 3,
	)

/datum/migrant_wave/bandit_small
	name = "Bandits"
	max_active = 3
	weight = 20
	roles = list(
		/datum/migrant_role/bandit = 3,
	)

/datum/migrant_wave/pilgrim
	name = "Pilgrimage"
	min_active = 4
	roles = list(
		/datum/migrant_role/pilgrim = 6,
	)

/datum/migrant_wave/adventurer
	name = "Adventure Party"
	min_active = 4
	roles = list(
		/datum/migrant_role/adventurer = 6,
	)

/datum/migrant_wave/bandit
	name = "Bandit Raid"
	min_active = 4
	weight = 20
	roles = list(
		/datum/migrant_role/bandit = 6,
	)

/datum/migrant_wave/heartfelt
	name = "The Lord's Visit"
	max_spawns = 1
	min_active = 4
	weight = 50
	roles = list(
		/datum/migrant_role/heartfelt_lord = 1,
		/datum/migrant_role/heartfelt_lady = 1,
		/datum/migrant_role/heartfelt_hand = 1,
		/datum/migrant_role/heartfelt_knight = 1,
		/datum/migrant_role/heartfelt_magos = 1,
		/datum/migrant_role/heartfelt_prior = 1,
	)
