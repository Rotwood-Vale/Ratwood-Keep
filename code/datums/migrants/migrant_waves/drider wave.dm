/datum/migrant_wave/drider
	name = "Desert Rider Mercenaries"
	max_spawns = 2
	weight = 80
	downgrade_wave = /datum/migrant_wave/drider_down_one
	roles = list(
		/datum/migrant_role/drider/desert_rider = 3
	)
	greet_text = "Hooded figures clad in red and easily identifiable by their distinctive emblem, the Desert Riders of Shalvistine are a loosely-governed society of mercenaries and refugees hailing from the fringes of the Zybantian Empire. You were riding saigaback before you could even walk, and you likely feel more at ease on four legs than two. Due to political unrest with neighboring Lalvestine, increasingly deadly sandstorms, or merely a sense of adventure, you find yourself with the Mercenaries’ Guild in Rockhill, selling your skills with the blade to those willing to pay."

/datum/migrant_wave/drider_down_one
	name = "Desert Rider Mercenaries"
	shared_wave_type = /datum/migrant_wave/drider
	downgrade_wave = /datum/migrant_wave/drider_last
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/drider/desert_rider = 2
	)
	greet_text = "Hooded figures clad in red and easily identifiable by their distinctive emblem, the Desert Riders of Shalvistine are a loosely-governed society of mercenaries and refugees hailing from the fringes of the Zybantian Empire. You were riding saigaback before you could even walk, and you likely feel more at ease on four legs than two. Due to political unrest with neighboring Lalvestine, increasingly deadly sandstorms, or merely a sense of adventure, you find yourself with the Mercenaries’ Guild in Rockhill, selling your skills with the blade to those willing to pay."

/datum/migrant_wave/drider_last
	name = "Desert Rider Mercenaries"
	shared_wave_type = /datum/migrant_wave/drider
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/drider/desert_rider = 1
	)
	greet_text = "Hooded figures clad in red and easily identifiable by their distinctive emblem, the Desert Riders of Shalvistine are a loosely-governed society of mercenaries and refugees hailing from the fringes of the Zybantian Empire. You were riding saigaback before you could even walk, and you likely feel more at ease on four legs than two. Due to political unrest with neighboring Lalvestine, increasingly deadly sandstorms, or merely a sense of adventure, you find yourself with the Mercenaries’ Guild in Rockhill, selling your skills with the blade to those willing to pay."
