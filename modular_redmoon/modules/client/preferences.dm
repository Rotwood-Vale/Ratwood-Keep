/datum/preferences
	var/be_russian = FALSE
	var/donator_bonus_received = FALSE
	// Vocal bark prefs
	var/bark_id = "mutedc3"
	var/bark_speed = 4
	var/bark_pitch = 1
	var/bark_variance = 0.2
	COOLDOWN_DECLARE(bark_previewing)
	var/prefer_old_chat = FALSE
	var/datum/loadout_item/loadout
