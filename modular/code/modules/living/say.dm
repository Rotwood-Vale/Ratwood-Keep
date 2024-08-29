/mob/proc/check_subtler(message, forced)
	if(copytext_char(message, 1, 2) == "@")
		emote("subtle", message = copytext_char(message, 2), intentional = !forced, custom_me = TRUE)
		return TRUE
