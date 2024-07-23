/datum/species
	var/amtfail = 0

/datum/species/proc/get_accent(mob/living/carbon/human)
	return

/datum/species/proc/get_accent_start(mob/living/carbon/human)
	return

/datum/species/proc/get_accent_any(mob/living/carbon/human)
	return

#define REGEX_STARTWORD 1
#define REGEX_FULLWORD 2
#define REGEX_ANY 3

/datum/species/proc/handle_speech(datum/source, mob/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]

	message = treat_message_accent(message, get_accent(source), REGEX_FULLWORD)
	message = treat_message_accent(message, get_accent_start(source), REGEX_STARTWORD)
	message = treat_message_accent(message, get_accent_any(source), REGEX_ANY)

	message = treat_message_accent(message, strings("accent_universal.json", "universal"), REGEX_FULLWORD)

	speech_args[SPEECH_MESSAGE] = trim(message)


/proc/treat_message_accent(message, list/accent_list, chosen_regex)
	if(!message)
		return
	if(!accent_list)
		return message
	if(message[1] == "*")
		return message
	message = "[message]"
	for(var/key in accent_list)
		var/value = accent_list[key]
		if(islist(value))
			value = pick(value)

		switch(chosen_regex)
			if(REGEX_STARTWORD)
				// Start word regex (Some words that get different endings)
				message = replacetextEx(message, regex("\\b[uppertext(key)]", "(\[\\w'-\]+)"), uppertext(value))
				message = replacetextEx(message, regex("\\b[capitalize(key)]", "(\[\\w'-\]+)"), capitalize(value))
				message = replacetextEx(message, regex("\\b[key]", "(\[\\w'-\]+)"), value)
			if(REGEX_FULLWORD)
				// Full word regex (full world replacements)
				message = replacetextEx(message, regex("\\b[uppertext(key)]\\b", "(\[\\w'-\]+)"), uppertext(value))
				message = replacetextEx(message, regex("\\b[capitalize(key)]\\b", "(\[\\w'-\]+)"), capitalize(value))
				message = replacetextEx(message, regex("\\b[key]\\b", "(\[\\w'-\]+)"), value)
			if(REGEX_ANY)
				// Any regex (syllables)
				message = replacetextEx(message, uppertext(key), uppertext(value))
				message = replacetextEx(message, capitalize(key), capitalize(value))
				message = replacetextEx(message, key, value)

	return message

#undef REGEX_STARTWORD
#undef REGEX_FULLWORD
#undef REGEX_ANY
