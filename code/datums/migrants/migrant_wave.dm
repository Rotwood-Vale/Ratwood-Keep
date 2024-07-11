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
	/// Whether this wave can roll at all. If not, it can still be forced to be ran, or used as "downgrade" wave
	var/can_roll = TRUE
	/// What type of wave to downgrade to on failure
	var/downgrade_wave
	/// If defined, this will be the wave type to increment for purposes of checking `max_spawns`
	var/shared_wave_type = null


/datum/migrant_wave/pilgrim
	name = "Pilgrimage"
	downgrade_wave = /datum/migrant_wave/pilgrim_down_one
	roles = list(
		/datum/migrant_role/pilgrim = 4,
	)
	greet_text = "Fleeing from misfortune and hardship, you and a handful of survivors get closer to Rockhill, looking for refuge and work, finally almost being there, almost..."

/datum/migrant_wave/pilgrim_down_one
	name = "Pilgrimage"
	downgrade_wave = /datum/migrant_wave/pilgrim_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/pilgrim = 3,
	)
	greet_text = "Fleeing from misfortune and hardship, you and a handful of survivors get closer to Rockhill, looking for refuge and work, finally almost being there, almost..."

/datum/migrant_wave/pilgrim_down_two
	name = "Pilgrimage"
	downgrade_wave = /datum/migrant_wave/pilgrim_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/pilgrim = 2,
	)
	greet_text = "Fleeing from misfortune and hardship, you and a handful of survivors get closer to Rockhill, looking for refuge and work, finally almost being there, almost..."

/datum/migrant_wave/pilgrim_down_three
	name = "Pilgrimage"
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/pilgrim = 1,
	)
	greet_text = "Fleeing from misfortune and hardship, you and a handful of survivors get closer to Rockhill, looking for refuge and work, finally almost being there, almost..."

/datum/migrant_wave/adventurer
	name = "Adventure Party"
	downgrade_wave = /datum/migrant_wave/adventurer_down_one
	roles = list(
		/datum/migrant_role/adventurer = 4,
	)
	greet_text = "Together with a party of trusted friends we decided to venture out, seeking thrills, glory and treasure, ending up in the misty and damp bog underneath Rockhill, perhaps getting ourselves into more than what we bargained for."

/datum/migrant_wave/adventurer_down_one
	name = "Adventure Party"
	downgrade_wave = /datum/migrant_wave/adventurer_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/adventurer = 3,
	)
	greet_text = "Together with a party of trusted friends we decided to venture out, seeking thrills, glory and treasure, ending up in the misty and damp bog underneath Rockhill, perhaps getting ourselves into more than what we bargained for."

/datum/migrant_wave/adventurer_down_two
	name = "Adventure Party"
	downgrade_wave = /datum/migrant_wave/adventurer_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/adventurer = 2,
	)
	greet_text = "Together with a party of trusted friends we decided to venture out, seeking thrills, glory and treasure, ending up in the misty and damp bog underneath Rockhill, perhaps getting ourselves into more than what we bargained for."

/datum/migrant_wave/adventurer_down_three
	name = "Adventure Party"
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/adventurer = 1,
	)
	greet_text = "Together with a party of trusted friends we decided to venture out, seeking thrills, glory and treasure, ending up in the misty and damp bog underneath Rockhill, perhaps getting ourselves into more than what we bargained for."


/datum/migrant_wave/bandit
	name = "Bandit Raid"
	downgrade_wave = /datum/migrant_wave/bandit_down_one
	weight = 5
	roles = list(
		/datum/migrant_role/bandit = 4,
	)

/datum/migrant_wave/bandit_down_one
	name = "Bandit Raid"
	downgrade_wave = /datum/migrant_wave/bandit_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/bandit = 3,
	)

/datum/migrant_wave/bandit_down_two
	name = "Bandit Raid"
	downgrade_wave = /datum/migrant_wave/bandit_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/bandit = 2,
	)

/datum/migrant_wave/bandit_down_three
	name = "Bandit Raid"
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/bandit = 1,
	)
