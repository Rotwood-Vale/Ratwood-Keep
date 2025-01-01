/datum/migrant_wave/grenzelhoft
	name = "Grenzelhoft Mercs"
	max_spawns = 1
	weight = 30
	downgrade_wave = /datum/migrant_wave/grenzelhoft_down_two
	roles = list(
		/datum/migrant_wave/grenzelhoft/grenzelhoft_kommandant = 1,
		/datum/migrant_wave/grenzelhoft/grenzelhoft_mercenary = 4
	)
	greet_text = "Experts, Professionals, Expensive. Those are the first words that come to mind when the emperiate Grenzelhoft mercenary guild is mentioned. While you may work for coin like any common sellsword, maintaining the prestige of the guild will be of utmost priority."

/datum/migrant_wave/grenzelhoft_down_two
	name = "Grenzelhoft Mercs"
	shared_wave_type = /datum/migrant_wave/grenzelhoft
	downgrade_wave = /datum/migrant_wave/grenzelhoft_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_wave/grenzelhoft/grenzelhoft_kommandant = 1,
		/datum/migrant_wave/grenzelhoft/grenzelhoft_mercenary = 2
	)
	greet_text = "Experts, Professionals, Expensive. Those are the first words that come to mind when the emperiate Grenzelhoft mercenary guild is mentioned. While you may work for coin like any common sellsword, maintaining the prestige of the guild will be of utmost priority."


/datum/migrant_wave/grenzelhoft_down_three
	name = "Grenzelhoft Mercs"
	shared_wave_type = /datum/migrant_wave/grenzelhoft
	downgrade_wave = /datum/migrant_wave/grenzelhoft_last
	can_roll = FALSE
	roles = list(
		/datum/migrant_wave/grenzelhoft/grenzelhoft_kommandant = 1,
		/datum/migrant_wave/grenzelhoft/grenzelhoft_mercenary = 1
	)
	greet_text = "Experts, Professionals, Expensive. Those are the first words that come to mind when the emperiate Grenzelhoft mercenary guild is mentioned. While you may work for coin like any common sellsword, maintaining the prestige of the guild will be of utmost priority."

/datum/migrant_wave/grenzelhoft_last
	name = "Grenzelhoft Mercs"
	shared_wave_type = /datum/migrant_wave/grenzelhoft
	can_roll = FALSE
	roles = list(
		/datum/migrant_wave/grenzelhoft/grenzelhoft_mercenary = 1
	)
	greet_text = "Experts, Professionals, Expensive. Those are the first words that come to mind when the emperiate Grenzelhoft mercenary guild is mentioned. While you may work for coin like any common sellsword, maintaining the prestige of the guild will be of utmost priority. However, you have seperated from your group and are now rogue in these dangerous isles.."
