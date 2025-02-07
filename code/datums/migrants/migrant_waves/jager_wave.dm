/datum/migrant_wave/grenzelhoft_detachment
	name = "Grenzelhoft Expeditionär"
	roles = list(
		/datum/migrant_role/grenzelhoft/grenzelhoft_kommandant	= 1,
		/datum/migrant_role/grenzelhoft/grenzelhoft_jager 		= 1,
		/datum/migrant_role/grenzelhoft/grenzelhoft_foot		= 2,
	)
	min_active = 2
	min_pop = 50 // an entire squad of super juiced mercenaries with blacksteel gear? we'll want activity for them
	max_spawns = 1
	spawn_landmark = "Refugee"
	downgrade_wave = /datum/migrant_wave/grenzelhoft_trailblazers
	greet_text = "A detachment of elite Grenzelhoft mercenaries have arrived on the Isle of Enigma, seeking profit in the notoriously\
	perilous lands of the Duchy. They are well-equipped and well-trained, and are assuredly a force to be reckoned with."

/datum/migrant_wave/grenzelhoft_trailblazers
	name = "Grenzelhoft Erkunden Paar"
	roles = list(
		/datum/migrant_role/grenzelhoft/grenzelhoft_jager = 2
	)
	can_roll = FALSE //will only be switched to if not enough are available for the detachment
	greet_text = "The Grenzelhoft mercenary company has sent out a pair of heavily-armed, highly-trained Jagers to get the lay of\
	the Duchy and to report back on the potential for profit. Rockhill will be glad for their company... if they can afford them."
	downgrade_wave = /datum/migrant_wave/grenzelhoft_outrider

/datum/migrant_wave/grenzelhoft_outrider
	name = "Grenzelhoft der Vorreiter"
	roles = list(
		/datum/migrant_role/grenzelhoft/grenzelhoft_jager/outrider = 1
	)
	can_roll = FALSE
	greet_text = "The Grenzelhoft Company's outriders are a whispered rumor among the Duchy's populace, an endless source of\
	curiosity and controversy. They say the outriders are the best of the best, but for reasons unknown, they are almost never\
	promoted to Kommandant. What type of person do you need to be, to hurl yourself into the unknowns of the Terrorbog and the frontiers\
	of the rot's devasatation, again and again without support? If the Grenzelhoft Company knows, they aren't telling. Not without a price."
