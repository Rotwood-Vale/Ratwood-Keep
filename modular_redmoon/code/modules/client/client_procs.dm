/client
	var/list/triumph_ids = list() //I am not sure if i should put it here, but if it work? this check for specific triumph IDs.

/client/New()
	. = ..()
	spawn() // Goonchat does some non-instant checks in start()
		chatOutput.start()
	process_donator_bonus()

/client/proc/process_donator_bonus()
	
	if(!ckey || !prefs || prefs.donator_bonus_received)
		return
	
	var/is_donor = FALSE
	for(var/i in 5 to 1 step -1)
		var/list/patreon_list = world.file2list("config/roguetown/patreon/p[i].txt")
		for(var/line in patreon_list)
			if(!line || findtextEx(line,"#",1,2))
				continue
			if(ckey(line) == ckey)
				is_donor = TRUE
				break
		if(is_donor)
			break
			
	if(!is_donor)
		return
	

	adjust_playerquality(15, ckey, "SYSTEM", "Donator bonus")

	prefs.donator_bonus_received = TRUE
	prefs.save_preferences()
	prefs.save_character()
	
	to_chat(src, span_notice("Вы получили +15 PQ как бонус для донатера. Спасибо за поддержку!"))
