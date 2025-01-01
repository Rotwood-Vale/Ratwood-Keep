/datum/migrant_wave/sellsword_merc
	name = "Sellswords"
	max_spawns = 1
	weight = 110
	downgrade_wave = /datum/migrant_wave/sellsword_merc_down_one
	roles = list(
		/datum/migrant_role/sellsword/sellsword_merc = 3
	)
	greet_text = "You are a common sellsword, regarded as scum by many. You travelled the isle working as a bodyguard, mercenary or a cutthroat. You're loyal to your own well being and the sounds mammons make in your pouch."

/datum/migrant_wave/sellsword_merc_down_one
	name = "Sellswords"
	shared_wave_type = /datum/migrant_wave/sellsword_merc
	downgrade_wave = /datum/migrant_wave/sellsword_merc_last
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sellsword/sellsword_merc = 2
	)
	greet_text = "You are a common sellsword, regarded as scum by many. You travelled the isle working as a bodyguard, mercenary or a cutthroat. You're loyal to your own well being and the sounds mammons make in your pouch."

/datum/migrant_wave/sellsword_merc_last
	name = "Sellswords"
	shared_wave_type = /datum/migrant_wave/sellsword_merc
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sellsword/sellsword_merc = 1
	)
	greet_text = "You are a common sellsword, regarded as scum by many. You travelled the isle working as a bodyguard, mercenary or a cutthroat. You're loyal to your own well being and the sounds mammons make in your pouch."
