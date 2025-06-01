/datum/migrant_wave/bandit
	name = "Bandit Raid"
	downgrade_wave = /datum/migrant_wave/bandit_down_one
	weight = 8
	spawn_landmark = "Bandit"
	roles = list(
		/datum/migrant_role/bandit = 2,
	)

/datum/migrant_wave/bandit_down_one
	name = "Bandit Raid"
	downgrade_wave = /datum/migrant_wave/bandit_down_two
	can_roll = FALSE
	spawn_landmark = "Bandit"
	roles = list(
		/datum/migrant_role/bandit = 2,
	)

/datum/migrant_wave/bandit_down_two
	name = "Bandit Raid"
	downgrade_wave = /datum/migrant_wave/bandit_down_three
	can_roll = FALSE
	spawn_landmark = "Bandit"
	roles = list(
		/datum/migrant_role/bandit = 2,
	)

/datum/migrant_wave/bandit_down_three
	name = "Bandit Raid"
	downgrade_wave = /datum/migrant_wave/bandit_down_four
	can_roll = FALSE
	spawn_landmark = "Bandit"
	roles = list(
		/datum/migrant_role/bandit = 2,
	)

/datum/migrant_wave/bandit_down_four
	name = "Bandit Raid"
	can_roll = FALSE
	spawn_landmark = "Bandit"
	roles = list(
		/datum/migrant_role/bandit = 1,
	)

