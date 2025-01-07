/proc/is_donator(ckey)
	if(!ckey)
		return FALSE
	
	// Проверяем все уровни патреона от высшего к низшему
	for(var/i in 5 to 1 step -1)
		var/list/patreon_list = world.file2list("config/roguetown/patreon/p[i].txt")
		for(var/line in patreon_list)
			if(line == ckey)
				return TRUE
	return FALSE

// Проверяет, получал ли игрок бонусные PQ за донат
/proc/has_donator_bonus(ckey)
	if(!ckey)
		return TRUE // Возвращаем TRUE чтобы предотвратить начисление бонуса
	
	var/json_file = file("data/player_saves/[copytext(ckey,1,2)]/[ckey]/donator_bonus.json")
	if(!fexists(json_file))
		return FALSE
		
	var/list/json = json_decode(file2text(json_file))
	return json["received_bonus"] ? TRUE : FALSE

// Отмечает что игрок получил бонус
/proc/mark_donator_bonus(ckey)
	if(!ckey)
		return
		
	var/json_file = file("data/player_saves/[copytext(ckey,1,2)]/[ckey]/donator_bonus.json")
	if(!fexists(json_file))
		var/list/json = list()
		json["received_bonus"] = TRUE
		WRITE_FILE(json_file, json_encode(json))
