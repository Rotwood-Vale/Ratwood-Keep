/datum/migrant_wave/forlorn
	name = "Forlorn Hope Mercenary"
	max_spawns = 1
	weight = 40
	downgrade_wave = /datum/migrant_wave/forlorn_down_one
	roles = list(
		/datum/migrant_wave/forlorn/forlorn_merc = 3
	)
	greet_text = "The Order of the Forlorn Hope, a holy order founded in the name of Noc and the banishment of the rot. Now it is riddled with the wounded, the veterans and the landless of the Vakran civil war. Take up the banner and fight again in the name of the Ten, or use the pretense of faith and zealotry to make ends meet by any means necessary."

/datum/migrant_wave/forlorn_down_one
	name = "Forlorn Hope Mercenary"
	shared_wave_type = /datum/migrant_wave/forlorn
	downgrade_wave = /datum/migrant_wave/forlorn_final
	can_roll = FALSE
	roles = list(
		/datum/migrant_wave/forlorn/forlorn_merc = 2
	)
	greet_text = "The Order of the Forlorn Hope, a holy order founded in the name of Noc and the banishment of the rot. Now it is riddled with the wounded, the veterans and the landless of the Vakran civil war. Take up the banner and fight again in the name of the Ten, or use the pretense of faith and zealotry to make ends meet by any means necessary."
	
/datum/migrant_wave/forlorn_final
	name = "Forlorn Hope Mercenary"
	shared_wave_type = /datum/migrant_wave/forlorn
	can_roll = FALSE
	roles = list(
		/datum/migrant_wave/forlorn/forlorn_merc = 1
	)
	greet_text = "The Order of the Forlorn Hope, a holy order founded in the name of Noc and the banishment of the rot. Now it is riddled with the wounded, the veterans and the landless of the Vakran civil war. Take up the banner and fight again in the name of the Ten, or use the pretense of faith and zealotry to make ends meet by any means necessary."
