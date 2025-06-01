//DO NOT ADD WAVE TYPES TO THIS FILE. 
//CREATE A NEW FILE FOR EACH NEW TYPE OF WAVE IN THE WAVES FOLDER. 
// YOU ARE RESPONSIBLE FOR YOUR CODE \\
//-Yawet

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
	var/spawn_landmark = "Refugee"
	/// Text to greet all players in the wave with
	var/greet_text
	/// Whether this wave can roll at all. If not, it can still be forced to be ran, or used as "downgrade" wave
	var/can_roll = TRUE
	/// What type of wave to downgrade to on failure
	var/downgrade_wave
	/// If defined, this will be the wave type to increment for purposes of checking `max_spawns`
	var/shared_wave_type = null
	/// Whether we want to spawn people on the rolled location, this may not be desired for bandits or other things that set the location
	var/spawn_on_location = TRUE

/datum/migrant_wave/proc/get_roles_amount()
	var/amount = 0
	for(var/role_type in roles)
		amount += roles[role_type]
	return amount
