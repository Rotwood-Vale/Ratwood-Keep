/client/New()
	. = ..()
	spawn(20)
		process_donator_bonus()

/client/proc/process_donator_bonus()
	set waitfor = 0
	
	message_admins("DEBUG: Начало проверки доната для [ckey]") // Отладочное сообщение
	
	if(!ckey)
		message_admins("DEBUG: Нет ckey")
		return
	
	// Проверяем, получал ли уже бонус через preferences
	if(prefs && prefs.donator_bonus_received)
		message_admins("DEBUG: [ckey] уже получал бонус (проверка через prefs)")
		return
	
	// Проверяем все уровни патреона
	var/is_donor = FALSE
	for(var/i in 5 to 1 step -1)
		var/list/patreon_list = world.file2list("config/roguetown/patreon/p[i].txt")
		for(var/line in patreon_list)
			if(!line || findtextEx(line,"#",1,2))
				continue
			if(ckey(line) == ckey)
				is_donor = TRUE
				message_admins("DEBUG: [ckey] найден в файле p[i].txt (строка: '[line]')")
				break
		if(is_donor)
			break
			
	if(!is_donor)
		message_admins("DEBUG: [ckey] не является донатером")
		return
		
	message_admins("DEBUG: Начисляем бонус для [ckey]")
	
	// Начисляем бонус
	adjust_playerquality(15, ckey, "SYSTEM", "Donator bonus")
	
	// Отмечаем что бонус получен в preferences
	if(prefs)
		prefs.donator_bonus_received = TRUE
		prefs.save_preferences()
		prefs.save_character()
	
	to_chat(src, span_notice("Вы получили +15 PQ как бонус для донатера. Спасибо за поддержку!"))
	message_admins("PQ: [ckey] получил бонус донатера (+15 PQ)")
