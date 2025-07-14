/datum/migrant_wave/adventurer
	name = "Adventure Party"
	weight = 15 //fuck off and stop spawning so many - never raise this above 15 as adventurers are still incredibly broken
	downgrade_wave = /datum/migrant_wave/adventurer_down_one
	max_spawns = 3 // Go away. 
	roles = list(
		/datum/migrant_role/adventurer = 4,
	)
	greet_text = "Together with a party of trusted friends we decided to venture out, seeking thrills, glory and treasure, ending up in the misty and damp bog underneath Rockhill, perhaps getting ourselves into more than what we bargained for."

/datum/migrant_wave/adventurer_down_one
	name = "Adventure Party"
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/adventurer_down_two
	roles = list(
		/datum/migrant_role/adventurer = 3,
	)
	greet_text = "Together with a party of trusted friends we decided to venture out, seeking thrills, glory and treasure, ending up in the misty and damp bog underneath Rockhill, perhaps getting ourselves into more than what we bargained for."

/datum/migrant_wave/adventurer_down_two
	name = "Adventure Party"
	weight = 60
	roles = list(
		/datum/migrant_role/adventurer = 2,
	)
	greet_text = "Together with a party of trusted friends we decided to venture out, seeking thrills, glory and treasure, ending up in the misty and damp bog underneath Rockhill, perhaps getting ourselves into more than what we bargained for."
