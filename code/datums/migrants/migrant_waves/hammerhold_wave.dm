/datum/migrant_wave/hammerhold
	name = "Hammerhold Sea-Raiders"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/hammerhold
	weight = 15
	downgrade_wave = /datum/migrant_wave/hammerhold_down_one
	roles = list(
		/datum/migrant_role/hammerhold/jarl = 1,
		/datum/migrant_role/hammerhold/karl = 3,
		/datum/migrant_role/hammerhold/thrall = 2
	)
	greet_text = "Having disembarked your longship after a voyage from Hammerhold, the land of Rockhill lies open to you. Under the leadership of your Jarl, here you shall find your fortune or your demise."

/datum/migrant_wave/hammerhold_down_one
	name = "Hammerhold Sea-Raiders"
	shared_wave_type = /datum/migrant_wave/hammerhold
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/hammerhold_down_two
	roles = list(
		/datum/migrant_role/hammerhold/jarl = 1,
		/datum/migrant_role/hammerhold/karl = 3,
		/datum/migrant_role/hammerhold/thrall = 1
	)
	greet_text = "Having disembarked your longship after a voyage from Hammerhold, the land of Rockhill lies open to you. Under the leadership of your Jarl, here you shall find your fortune or your demise."

/datum/migrant_wave/hammerhold_down_two
	name = "Hammerhold Sea-Raiders"
	shared_wave_type = /datum/migrant_wave/hammerhold
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/hammerhold_down_three
	roles = list(
		/datum/migrant_role/hammerhold/jarl = 1,
		/datum/migrant_role/hammerhold/karl = 2,
		/datum/migrant_role/hammerhold/thrall = 1
	)
	greet_text = "Having disembarked your longship after a voyage from Hammerhold, the land of Rockhill lies open to you. Under the leadership of your Jarl, here you shall find your fortune or your demise."

/datum/migrant_wave/hammerhold_down_three
	name = "Hammerhold Sea-Raiders"
	shared_wave_type = /datum/migrant_wave/hammerhold
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/hammerhold/jarl = 1,
		/datum/migrant_role/hammerhold/karl = 2,
	)
	greet_text = "Having disembarked your longship after a voyage from Hammerhold, the land of Rockhill lies open to you. Under the leadership of your Jarl, here you shall find your fortune or your demise."
