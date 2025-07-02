/datum/migrant_wave/gronn
	name = "Gronn Raiding Party"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/gronn
	weight = 5
	downgrade_wave = /datum/migrant_wave/gronn_down_one
	roles = list(
		/datum/migrant_role/gronn/chieftain = 1,
		/datum/migrant_role/gronn/shaman = 1,
		/datum/migrant_role/gronn/warrior = 2,
		/datum/migrant_role/gronn/tribal = 4,
		/datum/migrant_role/gronn/slave = 2
	)
	greet_text = "You're a scouting party sent directly from the steppes of Gronn itself. Without the main support of your warband, in this odd Kingdom, could you hope to survive, and, perhaps, thrive?"

/datum/migrant_wave/gronn_down_one
	name = "Gronn Raiding Party"
	shared_wave_type = /datum/migrant_wave/gronn
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/gronn_down_two
	roles = list(
		/datum/migrant_role/gronn/chieftain = 1,
		/datum/migrant_role/gronn/shaman = 1,
		/datum/migrant_role/gronn/warrior = 1,
		/datum/migrant_role/gronn/tribal = 2,
		/datum/migrant_role/gronn/slave = 1
	)
	greet_text = "You're a scouting party sent directly from the steppes of Gronn itself. Without the main support of your warband, in this odd Kingdom, you've lost a handful of men. Things are starting to look sour."

/datum/migrant_wave/gronn_down_two
	name = "Gronn Raiding Party"
	shared_wave_type = /datum/migrant_wave/gronn
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/gronn_down_three
	roles = list(
		/datum/migrant_role/gronn/chieftain = 1,
		/datum/migrant_role/gronn/shaman = 1,
		/datum/migrant_role/gronn/warrior = 1,
		/datum/migrant_role/gronn/tribal = 1,
		/datum/migrant_role/gronn/slave = 1
	)
	greet_text = "You're a scouting party sent directly from the steppes of Gronn itself. Without the main support of your warband, in this odd Kingdom, you've lost many. Could you hope to survive?"

/datum/migrant_wave/gronn_down_three
	name = "Gronn Raiding Party"
	shared_wave_type = /datum/migrant_wave/gronn
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/gronn_down_four
	roles = list(
		/datum/migrant_role/gronn/chieftain = 1,
		/datum/migrant_role/gronn/shaman = 1,
		/datum/migrant_role/gronn/warrior = 1,
		/datum/migrant_role/gronn/slave = 1
	)
	greet_text = "You're a scouting party sent directly from the steppes of Gronn itself. Without the main support of your warband, in this odd Kingdom, you've lost most of your party. What chance do you have?"

/datum/migrant_wave/gronn_down_four
	name = "Gronn Raiding Party"
	shared_wave_type = /datum/migrant_wave/gronn
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/gronn_down_five
	roles = list(
		/datum/migrant_role/gronn/chieftain = 1,
		/datum/migrant_role/gronn/shaman = 1,
		/datum/migrant_role/gronn/warrior = 1
	)
	greet_text = "You're a scouting party sent directly from the steppes of Gronn itself. Without the main support of your warband, in this odd Kingdom, you've lost most of your party. Now, it's just the three of you."

/datum/migrant_wave/gronn_down_five
	name = "Gronn Raiding Party"
	shared_wave_type = /datum/migrant_wave/gronn
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/gronn_down_six
	roles = list(
		/datum/migrant_role/gronn/chieftain = 1,
		/datum/migrant_role/gronn/shaman = 1
	)
	greet_text = "You're a scouting party sent directly from the steppes of Gronn itself. Without the main support of your warband, in this odd Kingdom, you've lost most of your party. Now, it's just the two of you."

/datum/migrant_wave/gronn_down_six
	name = "Gronn Raiding Party"
	shared_wave_type = /datum/migrant_wave/gronn
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/gronn/chieftain = 1
	)
	greet_text = "You were a scouting party sent directly from the steppes of Gronn itself. Without the main support of your warband, all but you have fallen. For what little hope there is, perhaps Graggah himself could guide you."
