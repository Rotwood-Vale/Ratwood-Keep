/datum/preferences/proc/bluewood_character_pref_load(savefile/S)
	S["be_russian"]			>> be_russian
	S["donator_bonus_received"]    >> donator_bonus_received

/datum/preferences/proc/bluewood_character_pref_save(savefile/S)
	WRITE_FILE(S["be_russian"], be_russian)
	WRITE_FILE(S["donator_bonus_received"], donator_bonus_received)
