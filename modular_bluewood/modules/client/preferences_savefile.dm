/datum/preferences/proc/bluewood_character_pref_load(savefile/S)
	S["be_russian"]			>> be_russian

/datum/preferences/proc/bluewood_character_pref_save(savefile/S)
	WRITE_FILE(S["be_russian"], be_russian)
