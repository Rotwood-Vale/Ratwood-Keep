/datum/migrant_wave/warden
	name = "The Wardens of the North"
	max_spawns = 1
	weight = 5
	downgrade_wave = /datum/migrant_wave/warden_down_one
	roles = list(
		/datum/migrant_role/warden/warden = 1,
		/datum/migrant_role/warden/wraith = 2,
		/datum/migrant_role/warden/shaman = 1,
		/datum/migrant_role/warden/forager = 1,
		/datum/migrant_role/warden/sheep = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to protect the forests from the destructive actions of the local folk, distraught by their technologies. \
	No mortal can defeat or tame the beast, but the pack shall follow his path. And we shall not fall to our bloodlust: there's no point in harming rockhillians as long as they dont harm us. \
	We were among the sheep ourselves, many of us were born inbetween the brick walls. Now, its time to free the others off their shackles and reunite them with the nature."

/datum/migrant_wave/warden_down_one
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	downgrade_wave = /datum/migrant_wave/warden_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden/warden = 1,
		/datum/migrant_role/warden/wraith = 1,
		/datum/migrant_role/warden/shaman = 1,
		/datum/migrant_role/warden/forager = 1,
		/datum/migrant_role/warden/sheep = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to protect the forests from the destructive actions of the local folk, distraught by their technologies. \
	No mortal can defeat or tame the beast, but the pack shall follow his path. And we shall not fall to our bloodlust: there's no point in harming rockhillians as long as they dont harm us. \
	We were among the sheep ourselves, many of us were born inbetween the brick walls. Now, its time to free the others off their shackles and reunite them with the nature."

/datum/migrant_wave/warden_down_two
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	downgrade_wave = /datum/migrant_wave/warden_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden/warden = 1,
		/datum/migrant_role/warden/wraith = 1,
		/datum/migrant_role/warden/shaman = 1,
		/datum/migrant_role/warden/sheep = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to protect the forests from the destructive actions of the local folk, distraught by their technologies. \
	No mortal can defeat or tame the beast, but the pack shall follow his path. And we shall not fall to our bloodlust: there's no point in harming rockhillians as long as they dont harm us. \
	We were among the sheep ourselves, many of us were born inbetween the brick walls. Now, its time to free the others off their shackles and reunite them with the nature."

/datum/migrant_wave/warden_down_three
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	downgrade_wave = /datum/migrant_wave/warden_down_four
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden/warden = 1,
		/datum/migrant_role/warden/wraith = 1,
		/datum/migrant_role/warden/shaman = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to protect the forests from the destructive actions of the local folk, distraught by their technologies. \
	Though we are little in numbers, we will rise. This little town looks like a great place to find new warriors for our clan, perhaps we will be able to earn trust of the locals."

/datum/migrant_wave/warden_down_four
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	downgrade_wave = /datum/migrant_wave/warden_down_five
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden/warden = 1,
		/datum/migrant_role/warden/shaman = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to get supplies and find new worthy warriors. \
	Though the pack has been weakened, we have NOT been defeated. The volfs shall rise, we will recover."

/datum/migrant_wave/warden_down_five
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden/warden = 1
	)
	greet_text = "You were once leading a huge pack of volfs, however the spirits have brought their rage upon you and for now you remain alone. \
	But a volf who surrenders without a fight is no volf, you must claim what's yours."