/datum/migrant_wave/musketeer
	name = "The Three Musketeers"
	max_spawns = 1
	weight = 60
	downgrade_wave = /datum/migrant_wave/musketeer_down_one
	roles = list(
		/datum/migrant_role/musketeer/musketeer = 3
	)
	greet_text = "A jolly band of three swashbuckling heroes out to save the day and fight for justice! Armed with arquebuses and rapiers, these elite-corps-comrades are formidable to any foe."

/datum/migrant_wave/musketeer_down_one
	name = "The Two Musketeers"
	shared_wave_type = /datum/migrant_wave/musketeer
	downgrade_wave = /datum/migrant_wave/musketeer_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/musketeer/musketeer = 2
	)
	greet_text = "A not-so-jolly band of two swashbuckling heroes, trying to save the day. One of your triad's arquebus exploded in his face, killing him instantly. 'Tis a sad day, but the adventure must go on!"

/datum/migrant_wave/musketeer_down_two
	name = "The One Musketeer"
	shared_wave_type = /datum/migrant_wave/musketeer
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/musketeer/musketeer = 1
	)
	greet_text = "Both of your comrades are dead. One's gun exploded in his face, the other on his cock. You're fucked, someone's going to steal your gun."
