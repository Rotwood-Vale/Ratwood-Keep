/datum/species
	var/amtfail = 0

/datum/species/proc/get_accent(mob/living/carbon/human)
	return

/datum/species/proc/handle_speech(datum/source, mob/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]

	message = treat_message_accent(message, strings("accent_universal.json", "universal"))
	message = treat_message_accent(message, get_accent(source))

	speech_args[SPEECH_MESSAGE] = trim(message)


/proc/treat_message_accent(message, list/accent_list)
	if(!message)
		return
	if(!accent_file)
		return message
	if(message[1] == "*")
		return message
	message = " [message]"
	for(var/key in accent_list)
		var/value = accent_list[key]
		if(islist(value))
			value = pick(value)
		
		message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
		message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
		message = replacetextEx(message, " [key]", " [value]")
	return message
