/datum/migrant_wave/bandit
	name = "Bandit Raid"
	downgrade_wave = /datum/migrant_wave/bandit_down_one
	weight = 8
	max_spawns = 2 //No. No I don't think I like seeing 9 bandits spawn with only 30 players. 
	spawn_landmark = "Bandit"
	roles = list(
		/datum/migrant_role/bandit = 2,
	)

/datum/migrant_wave/bandit_down_one
	name = "Bandit Raid"
	can_roll = FALSE
	max_spawns = 3 //No. No I don't think I like seeing 9 bandits spawn with only 30 players. 
	spawn_landmark = "Bandit"
	roles = list(
		/datum/migrant_role/bandit = 1,
	)

