/datum/migrant_wave/warden
	name = "The Wardens of the North"
	max_spawns = 1
	weight = 5
	downgrade_wave = /datum/migrant_wave/warden_down_one
	roles = list(
		/datum/migrant_role/warden_overlord/ = 1
		/datum/migrant_role/wraith/ = 2
		/datum/migrant_role/wardenshaman/ = 1
		/datum/migrant_role/forager/ = 1
		/datum/migrant_role/sheep/ = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to protect the forests from the destructive actions of the local folk, distraught by their technologies. No mortal can defeat or tame the beast, but the pack shall follow his path."

/datum/migrant_wave/warden_down_one
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	downgrade_wave = /datum/migrant_wave/warden_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden_overlord/ = 1
		/datum/migrant_role/wraith/ = 1
		/datum/migrant_role/warden_shaman/ = 1
		/datum/migrant_role/forager/ = 1
		/datum/migrant_role/sheep/ = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to protect the forests from the destructive actions of the local folk, distraught by their technologies. No mortal can defeat or tame the beast, but the pack shall follow his path."

/datum/migrant_wave/warden_down_two
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	downgrade_wave = /datum/migrant_wave/warden_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden_overlord/ = 1
		/datum/migrant_role/wraith/ = 1
		/datum/migrant_role/warden_shaman/ = 1
		/datum/migrant_role/sheep/ = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to protect the forests from the destructive actions of the local folk, distraught by their technologies. No mortal can defeat or tame the beast, but the pack shall follow his path."

/datum/migrant_wave/warden_down_three
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	downgrade_wave = /datum/migrant_wave/warden_down_four
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden_overlord/ = 1
		/datum/migrant_role/wraith/ = 1
		/datum/migrant_role/warden_shaman/ = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to protect the forests from the destructive actions of the local folk, distraught by their technologies. Though we are little in numbers, we will rise."

/datum/migrant_wave/warden_down_four
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	downgrade_wave = /datum/migrant_wave/warden_down_five
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden_overlord/ = 1
		/datum/migrant_role/warden_shaman/ = 1
	)
	greet_text = "A clan of stray warriors heads to Rockhill to get supplies and find new worthy warriors. Though the pack has been weakened, we have NOT been defeated. The volfs shall rise, we will recover."

/datum/migrant_wave/warden_down_five
	name = "The Wardens of the North"
	shared_wave_type = /datum/migrant_wave/warden
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/warden_overlord/ = 1
	)
	greet_text = "You were once leading a huge pack of volfs, however the spirits have brought their rage upon you and for now you remain alone. But a volf who surrenders without a fight is no volf, you must claim what's yours."