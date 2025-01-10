/datum/preferences/proc/redmoon_character_pref_load(savefile/S)
	S["be_russian"]			>> be_russian
	S["donator_bonus_received"]    >> donator_bonus_received

	S["bark_id"] >> bark_id
	S["bark_speed"] >> bark_speed
	S["bark_pitch"] >> bark_pitch
	S["bark_variance"] >> bark_variance

/datum/preferences/proc/redmoon_character_pref_save(savefile/S)
	WRITE_FILE(S["be_russian"], be_russian)
	WRITE_FILE(S["donator_bonus_received"], donator_bonus_received)

	WRITE_FILE(S["bark_id"]								, bark_id)
	WRITE_FILE(S["bark_speed"]							, bark_speed)
	WRITE_FILE(S["bark_pitch"]							, bark_pitch)
	WRITE_FILE(S["bark_variance"]						, bark_variance)
