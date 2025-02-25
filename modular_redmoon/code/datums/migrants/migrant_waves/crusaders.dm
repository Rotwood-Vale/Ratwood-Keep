/datum/migrant_wave/templars
	name = "The Three Templars"
	max_spawns = 1
	weight = 60
	downgrade_wave = /datum/migrant_wave/templar_down_one
	roles = list(
		/datum/migrant_role/templar = 3
	)
	greet_text = "The merry band of three saints."

/datum/migrant_wave/templar_down_one
	name = "The Two Templars"
	shared_wave_type = /datum/migrant_wave/templar
	downgrade_wave = /datum/migrant_wave/templar_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/templar = 2
	)
	greet_text = "The merry band of two saints."

/datum/migrant_wave/templar_down_two
	name = "The One Templar"
	shared_wave_type = /datum/migrant_wave/templar
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/templar = 1
	)
	greet_text = "The merry band of... one saint."
