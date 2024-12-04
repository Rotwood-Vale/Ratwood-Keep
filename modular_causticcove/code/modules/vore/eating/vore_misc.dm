/mob/living
	//oh no vore time
	var/voremode = FALSE

/mob/living/proc/toggle_vore_mode()
	if(cmode)
		return FALSE
	voremode = !voremode
	init_vore()
	if(voremode)
		to_chat(src, span_info("I feel voracious."))
	else
		to_chat(src, span_info("I no longer feel voracious."))
	return TRUE

/mob/proc/disable_vore_mode()
	return

/mob/living/disable_vore_mode()
	voremode = FALSE

/datum/preferences
	//bad stuff
	var/vorepref = "Ask"
	var/vore_flags = 0
	var/list/belly_prefs = list()
	var/vore_taste = "nothing in particular"
	var/toggleeatingnoise = TRUE
	var/toggledigestionnoise = TRUE
	var/cit_toggles = CIT_TOGGLES_DEFAULT

/obj/item
	var/hides_bulges = FALSE

//Readds quotes and apostrophes to HTML-encoded strings
/proc/readd_quotes(var/t)
	var/list/repl_chars = list("&#34;" = "\"","&#39;" = "'")
	for(var/char in repl_chars)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + repl_chars[char] + copytext(t, index+5)
			index = findtext(t, char)
	return t
