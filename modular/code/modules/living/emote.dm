/datum/emote/living/subtle
	key = "subtle"
	key_third_person = "subtleemote"
#ifdef MATURESERVER
	message_param = "%t"
#endif

/datum/emote/living/subtle/can_run_emote(mob/user, status_check, intentional)
	. = ..() && intentional

/datum/emote/living/subtle/run_emote(mob/user, params, type_override = null, intentional = FALSE)
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	else if(QDELETED(user))
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "<span class='boldwarning'>I cannot send IC messages (muted).</span>")
		return FALSE
	else if(!params)
		var/custom_emote = copytext(sanitize(input("What does your character subtly do?") as text|null), 1, MAX_MESSAGE_LEN)
		if(custom_emote)
			message = custom_emote
			emote_type = EMOTE_VISIBLE
	else
		message = params
		if(type_override)
			emote_type = type_override

	user.log_message("SUBTLE - " + message, LOG_EMOTE)
	message = "<b>[user]</b> " + message

	for(var/mob/M in GLOB.dead_mob_list)
		if(!M.client || isnewplayer(M))
			continue
		var/T = get_turf(user)
		if(M.stat == DEAD && M.client && (M.client.prefs?.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(T, null)))
			M.show_message(message)

	user.visible_message("<i>[message]</i>", vision_distance = 1)

