/datum/species
	var/amtfail = 0

/datum/species/proc/get_accent(mob/living/carbon/human/H)
	switch(H.char_accent)
		if("No accent")
			return
		if("Dwarf accent")
			return strings("dwarf_replacement.json", "full")
		if("Dark Elf accent")
			return strings("french_replacement.json", "full")
		if("Elf accent")
			return strings("russian_replacement.json", "full")
		if("Grenzelhoft accent")
			return strings("german_replacement.json", "full")
		if("Hammerhold accent")
			return strings("Anglish.json", "full")
		if("Assimar accent")
			return strings("proper_replacement.json", "full")
		if("Lizard accent")
			return strings("brazillian_replacement.json", "brazillian")
		if("Tiefling accent")
			return strings("spanish_replacement.json", "full")
		if("Half Orc accent")
			return strings("middlespeak.json", "full")
		if("Akula accent")
			return strings("pirate_replacement.json", "full")

/datum/species/proc/post_accent_treatment(mob/living/carbon/human, message)
	return message

/datum/species/proc/get_accent_start(mob/living/carbon/human/H)
	switch(H.char_accent)
		if("Dwarf accent")
			return strings("dwarf_replacement.json", "start")
		if("Dark Elf accent")
			return strings("french_replacement.json", "start")
		if("Elf accent")
			return strings("russian_replacement.json", "start")
		if("Grenzelhoft accent")
			return strings("german_replacement.json", "start")
		if("Hammerhold accent")
			return strings("Anglish.json", "start")
		if("Assimar accent")
			return strings("proper_replacement.json", "start")
		if("Tiefling accent")
			return strings("spanish_replacement.json", "start")
		if("Half Orc accent")
			return strings("middlespeak.json", "start")

/datum/species/proc/get_accent_end(mob/living/carbon/human/H)
	switch(H.char_accent)
		if("Dwarf accent")
			return strings("dwarf_replacement.json", "end")
		if("Dark Elf accent")
			return strings("french_replacement.json", "end")
		if("Elf accent")
			return strings("russian_replacement.json", "end")
		if("Grenzelhoft accent")
			return strings("german_replacement.json", "end")
		if("Hammerhold accent")
			return strings("Anglish.json", "end")
		if("Assimar accent")
			return strings("proper_replacement.json", "end")
		if("Tiefling accent")
			return strings("spanish_replacement.json", "end")
		if("Half Orc accent")
			return strings("middlespeak.json", "end")

/datum/species/proc/get_accent_any(mob/living/carbon/human/H)
	switch(H.char_accent)
		if("Dwarf accent")
			return strings("dwarf_replacement.json", "syllable")
		if("Dark Elf accent")
			return strings("french_replacement.json", "syllable")
		if("Elf accent")
			return strings("russian_replacement.json", "syllable")
		if("Grenzelhoft accent")
			return strings("german_replacement.json", "syllable")
		if("Hammerhold accent")
			return strings("Anglish.json", "syllable")
		if("Assimar accent")
			return strings("proper_replacement.json", "syllable")
		if("Tiefling accent")
			return strings("spanish_replacement.json", "syllable")
		if("Half Orc accent")
			return strings("middlespeak.json", "syllable")

#define REGEX_FULLWORD 1
#define REGEX_STARTWORD 2
#define REGEX_ENDWORD 3
#define REGEX_ANY 4

/datum/species/proc/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]

	message = treat_message_accent(message, strings("accent_universal.json", "universal"), REGEX_FULLWORD)

	message = treat_message_accent(message, get_accent(source), REGEX_FULLWORD)
	message = treat_message_accent(message, get_accent_start(source), REGEX_STARTWORD)
	message = treat_message_accent(message, get_accent_end(source), REGEX_ENDWORD)
	message = treat_message_accent(message, get_accent_any(source), REGEX_ANY)

	message = autopunct_bare(message)

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
			if(REGEX_FULLWORD)
				// Full word regex (full world replacements)
				message = replacetextEx(message, regex("\\b[uppertext(key)]\\b|\\A[uppertext(key)]\\b|\\b[uppertext(key)]\\Z|\\A[uppertext(key)]\\Z", "(\\w+)/g"), uppertext(value))
				message = replacetextEx(message, regex("\\b[capitalize(key)]\\b|\\A[capitalize(key)]\\b|\\b[capitalize(key)]\\Z|\\A[capitalize(key)]\\Z", "(\\w+)/g"), capitalize(value))
				message = replacetextEx(message, regex("\\b[key]\\b|\\A[key]\\b|\\b[key]\\Z|\\A[key]\\Z", "(\\w+)/g"), value)
			if(REGEX_STARTWORD)
				// Start word regex (Some words that get different endings)
				message = replacetextEx(message, regex("\\b[uppertext(key)]|\\A[uppertext(key)]", "(\\w+)/g"), uppertext(value))
				message = replacetextEx(message, regex("\\b[capitalize(key)]|\\A[capitalize(key)]", "(\\w+)/g"), capitalize(value))
				message = replacetextEx(message, regex("\\b[key]|\\A[key]", "(\\w+)/g"), value)
			if(REGEX_ENDWORD)
				// End of word regex (Replaces last letters of words)
				message = replacetextEx(message, regex("[uppertext(key)]\\b|[uppertext(key)]\\Z", "(\\w+)/g"), uppertext(value))
				message = replacetextEx(message, regex("[key]\\b|[key]\\Z", "(\\w+)/g"), value)
			if(REGEX_ANY)
				// Any regex (syllables)
				// Careful about use of syllables as they will continually reapply to themselves, potentially canceling each other out
				message = replacetextEx(message, uppertext(key), uppertext(value))
				message = replacetextEx(message, key, value)

	return message

#undef REGEX_FULLWORD
#undef REGEX_STARTWORD
#undef REGEX_ENDWORD
#undef REGEX_ANY
