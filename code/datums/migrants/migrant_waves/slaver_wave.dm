/datum/migrant_wave/slaver
	name = "The Zybantine Slavers"
	max_spawns = 1
	weight = 60
	downgrade_wave = /datum/migrant_wave/slaver_down_one
	roles = list(
		/datum/migrant_role/slaver/master = 1,
		/datum/migrant_role/slaver/slavemercsword = 3,
		/datum/migrant_role/slaver/slavemercwhip = 2,
		/datum/migrant_role/slaver/slavemercbow = 1,
		/datum/migrant_role/slaver/slavez = 2
	)
	greet_text = "A group of slavers coming to the Isle of Enigma from the western deserts of Zybantine in the hopes of gathering wealth through the trade unfortunate laborers."

/datum/migrant_wave/slaver_down_one
	name = "The Zybantine Slavers"
	shared_wave_type = /datum/migrant_wave/slaver
	downgrade_wave = /datum/migrant_wave/slaver_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/slaver/master = 1,
		/datum/migrant_role/slaver/slavemercsword = 2,
		/datum/migrant_role/slaver/slavemercwhip = 2,
		/datum/migrant_role/slaver/slavemercbow = 1,
		/datum/migrant_role/slaver/slavez = 2
	)
	greet_text = "A group of slavers coming to the Isle of Enigma from the western deserts of Zybantine in the hopes of gathering wealth through the trade unfortunate laborers."

/datum/migrant_wave/slaver_down_two
	name = "The Zybantine Slavers"
	shared_wave_type = /datum/migrant_wave/slaver
	downgrade_wave = /datum/migrant_wave/slaver_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/slaver/master = 1,
		/datum/migrant_role/slaver/slavemercsword = 1,
		/datum/migrant_role/slaver/slavemercwhip = 2,
		/datum/migrant_role/slaver/slavemercbow = 1,
		/datum/migrant_role/slaver/slavez = 1
	)
	greet_text = "A group of slavers coming to the Isle of Enigma from the western deserts of Zybantine in the hopes of gathering wealth through the trade unfortunate laborers."

/datum/migrant_wave/slaver_down_three
	name = "The Zybantine Slavers"
	shared_wave_type = /datum/migrant_wave/slaver
	downgrade_wave = /datum/migrant_wave/slaver_down_four
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/slaver/master = 1,
		/datum/migrant_role/slaver/slavemercsword = 1,
		/datum/migrant_role/slaver/slavemercwhip = 1,
		/datum/migrant_role/slaver/slavemercbow = 1,
		/datum/migrant_role/slaver/slavez = 1
	)
	greet_text = "A group of slavers coming to the Isle of Enigma from the western deserts of Zybantine in the hopes of gathering wealth through the trade unfortunate laborers."

/datum/migrant_wave/slaver_down_four
	name = "The Zybantine Slavers"
	shared_wave_type = /datum/migrant_wave/slaver
	downgrade_wave = /datum/migrant_wave/slaver_down_five
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/slaver/master = 1,
		/datum/migrant_role/slaver/slavemercwhip = 1,
		/datum/migrant_role/slaver/slavemercbow = 1,
		/datum/migrant_role/slaver/slavez = 1
	)
	greet_text = "A group of slavers coming to the Isle of Enigma from the western deserts of Zybantine in the hopes of gathering wealth through the trade unfortunate laborers."

/datum/migrant_wave/slaver_down_five
	name = "The Zybantine Slavers"
	shared_wave_type = /datum/migrant_wave/slaver
	downgrade_wave = /datum/migrant_wave/slaver_down_six
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/slaver/master = 1,
		/datum/migrant_role/slaver/slavemercwhip = 1,
		/datum/migrant_role/slaver/slavez = 1
	)
	greet_text = "A group of slavers coming to the Isle of Enigma from the western deserts of Zybantine in the hopes of gathering wealth through the trade unfortunate laborers."

/datum/migrant_wave/slaver_down_six
	name = "The Zybantine Slavers"
	shared_wave_type = /datum/migrant_wave/slaver
	downgrade_wave = /datum/migrant_wave/slaver_down_seven
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/slaver/master = 1,
		/datum/migrant_role/slaver/slavez = 1
	)
	greet_text = "A group of slavers coming to the Isle of Enigma from the western deserts of Zybantine in the hopes of gathering wealth through the trade unfortunate laborers."

/datum/migrant_wave/slaver_down_seven
	name = "The Zybantine Slavers"
	shared_wave_type = /datum/migrant_wave/slaver
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/slaver/master = 1
	)
	greet_text = "A group of slavers coming to the Isle of Enigma from the western deserts of Zybantine in the hopes of gathering wealth through the trade unfortunate laborers."
