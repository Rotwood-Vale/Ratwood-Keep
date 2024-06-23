/datum/species
	var/amtfail = 0

/datum/species/proc/get_accent(mob/living/carbon/human)
	return

/datum/species/proc/post_accent_treatment(mob/living/carbon/human, message)
	return message

/datum/species/proc/handle_speech(datum/source, mob/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]

	if(message)
		// Species accent is first
		var/list/species_accent = get_accent(source)
		if(species_accent)
			if(message[1] != "*")
				message = " [message] "
				for(var/key in species_accent)
					var/value = species_accent[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")
		// Universal accent is second
		if(message[1])
			if(message[1] != "*")
				message = " [message] "
//				var/list/spellcheck_words = strings("spellcheck.json", "spellcheck") Not necessary to fix, but it's just deleting the word. Temporarily commented out, probably permanent.
				var/list/accent_words = strings("accent_universal.json", "universal")

/* 				for(var/key in spellcheck_words)
					var/value = accent_words[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, "[key]", "[value] ") */

				for(var/key in accent_words)
					var/value = accent_words[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")

	if(message[1])
		if(message[1] != "*")
			message = post_accent_treatment(source, message)
	speech_args[SPEECH_MESSAGE] = trim(message)
