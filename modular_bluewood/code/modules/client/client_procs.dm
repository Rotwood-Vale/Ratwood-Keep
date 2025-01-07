/client/proc/is_donator(ckey)
	if(!ckey)
		return FALSE
	
	// Проверяем все уровни патреона от высшего к низшему
	for(var/i in 5 to 1 step -1)
		var/list/patreon_list = world.file2list("config/roguetown/patreon/p[i].txt")
		for(var/line in patreon_list)
			if(line == ckey)
				return TRUE
	return FALSE

/client/proc/has_donator_bonus(ckey)
	if(!ckey)
		return TRUE // Возвращаем TRUE чтобы предотвратить начисление бонуса
	
	var/json_file = file("data/player_saves/[copytext(ckey,1,2)]/[ckey]/donator_bonus.json")
	if(!fexists(json_file))
		return FALSE
		
	var/list/json = json_decode(file2text(json_file))
	return json["received_bonus"] ? TRUE : FALSE

/client/proc/mark_donator_bonus(ckey)
	if(!ckey)
		return
		
	var/json_file = file("data/player_saves/[copytext(ckey,1,2)]/[ckey]/donator_bonus.json")
	if(!fexists(json_file))
		var/list/json = list()
		json["received_bonus"] = TRUE
		WRITE_FILE(json_file, json_encode(json))

/client/New()
	..()

	if(is_donator(ckey) && !has_donator_bonus(ckey))
		adjust_playerquality(15, ckey, "SYSTEM", "Donator bonus")
		mark_donator_bonus(ckey)
		to_chat(src, span_notice("Вы получили +15 PQ как бонус для донатера. Спасибо за поддержку!"))
