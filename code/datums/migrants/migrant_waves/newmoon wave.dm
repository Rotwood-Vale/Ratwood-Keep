/datum/migrant_wave/newmoon_merc
	name = "New Moon Spellblade"
	max_spawns = 1
	weight = 35
	downgrade_wave = /datum/migrant_wave/newmoon_merc_last
	roles = list(
		/datum/migrant_role/newmoon/newmoon_merc = 2
	)
	greet_text = "The New Moon Spellblades of Zybantia are the remnants of a fallen Nocite monastery in an unknown region of Lalvestine, the last major stronghold of the Ten in the Zybantian Empire. Their monastic lyfestyle and devotion collapsed quickly under the weight of the Rot, and they were forced from a lyfe of devout solitude into that of a common sellsword; Noc’s blessings proving rather useful when slaying monsters and Men alike. For whatever reason, you find yourself in Rockhill with your partner, offering your skills to the highest bidder. Knowledge is power, or so She says."

/datum/migrant_wave/newmoon_merc_last
	name = "New Moon Spellblade"
	shared_wave_type = /datum/migrant_wave/sellsword_merc
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sellsword/sellsword_merc = 1
	)
	greet_text = "The New Moon Spellblades of Zybantia are the remnants of a fallen Nocite monastery in an unknown region of Lalvestine, the last major stronghold of the Ten in the Zybantian Empire. Their monastic lyfestyle and devotion collapsed quickly under the weight of the Rot, and they were forced from a lyfe of devout solitude into that of a common sellsword; Noc’s blessings proving rather useful when slaying monsters and Men alike. For whatever reason, you find yourself in Rockhill, offering your skills to the highest bidder. Knowledge is power, or so She says."

//if you are upset by how rare and small-in-numbers newmoon are, they are, quote, "remnants of a fallen Nocite monastery in an unknown region of Lalvestine", not some common merc guild
