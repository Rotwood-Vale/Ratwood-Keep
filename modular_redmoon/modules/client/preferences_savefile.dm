/datum/preferences/proc/redmoon_character_pref_load(savefile/S)
	S["be_russian"]										>> be_russian
	S["donator_bonus_received"]    						>> donator_bonus_received

	S["bark_id"] 										>> bark_id
	S["bark_speed"] 									>> bark_speed
	S["bark_pitch"] 									>> bark_pitch
	S["bark_variance"] 									>> bark_variance

	_load_loadout(S)

/datum/preferences/proc/redmoon_character_pref_save(savefile/S)
	WRITE_FILE(S["be_russian"]							, be_russian)
	WRITE_FILE(S["donator_bonus_received"]				, donator_bonus_received)

	WRITE_FILE(S["bark_id"]								, bark_id)
	WRITE_FILE(S["bark_speed"]							, bark_speed)
	WRITE_FILE(S["bark_pitch"]							, bark_pitch)
	WRITE_FILE(S["bark_variance"]						, bark_variance)

	if(loadout)
		WRITE_FILE(S["loadout"] 						, loadout.type)
	else
		WRITE_FILE(S["loadout"] 						, null)

/datum/preferences/proc/_load_loadout(S)
	var/loadout_type
	S["loadout"] >> loadout_type
	if (loadout_type)
		loadout = new loadout_type()
