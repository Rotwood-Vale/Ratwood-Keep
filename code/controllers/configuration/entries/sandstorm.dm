/datum/config_entry/flag/admin_disk_inactive_msg //Allows admins to globally disable ingame logs for this crap

/datum/config_entry/string/new_round_ping
	default = null

/datum/config_entry/string/active_round_ping
	default = null

/datum/config_entry/string/passive_round_ping
	default = null

/datum/config_entry/string/agressive_round_ping
	default = null

/datum/config_entry/number/max_languages
	default = 1
	min_val = -1

/datum/config_entry/flag/enable_dogborg_sleepers	// enable normal dogborg sleepers (otherwise recreational)

/datum/config_entry/flag/limit_stupor_trances	// enable limits to hypnotic stupor

/datum/config_entry/number/min_stupor_hypno_duration	//Minimum random duration to maintain hypnosis from hypnotic stupor
	default = 6000
	min_val = 10

/datum/config_entry/number/max_stupor_hypno_duration	//Maximum random duration to maintain hypnosis from hypnotic stupor
	default = 12000
	min_val = 10

/datum/config_entry/flag/reveal_everything // On Round end, reveal roles and ghosts

/datum/config_entry/number/roundstart_ai_shells // Per AI, if you ever do get a triumvirate!
	min_val = 0
