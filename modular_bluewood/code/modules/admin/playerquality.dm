/client/proc/commendsomeone(var/forced = FALSE)
	if(!can_commend(forced))
		return
	if(alert(src,"Был ли в этом раунде персонаж, которого вы хотели бы похвалить?", "Коммендация", "ДА", "НЕТ") != "ДА")
		return
	var/list/selections = GLOB.character_ckey_list.Copy()
	if(!selections.len)
		return
	var/selection
	if(SSticker.current_state == GAME_STATE_FINISHED)
		selection = input(src,"Персонаж?") as null|anything in sortList(selections)
	else
		selection = input(src, "Персонаж?") as null|text
	if(!selection)
		return
	if(!selections[selection])
		to_chat(src, span_warning("Никого с таким именем не найдено"))
		return
	var/theykey = selections[selection]
	if(theykey == ckey)
		to_chat(src,"Вы не можете похвалить себя.")
		return
	if(!can_commend(forced))
		return
	if(theykey)
		prefs.commendedsomeone = TRUE
		add_commend(theykey, ckey)
		to_chat(src,"[selection] commended.")
		log_game("COMMEND: [ckey] commends [theykey].")
		log_admin("COMMEND: [ckey] commends [theykey].")
	return

/proc/add_commend(key, giver)
	if(!giver || !key)
		return
	var/curcomm = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/commends.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	if(json[giver])
		curcomm = json[giver]
	curcomm++
	json[giver] = curcomm
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

	var/fakekey = usr.ckey
	if(usr.ckey in GLOB.anonymize)
		fakekey = get_fake_key(usr.ckey)

	var/raisin = stripped_input("Укажите краткую причину этого изменения", "Симулятор Бога", "", null)
	if(!raisin)
		to_chat(src, span_boldwarning("Причина не указана."))
		return

	if(curcomm == 1)
		adjust_playerquality(1, ckey(key), fakekey, raisin)

/client/proc/uncommendsomeone(var/forced = FALSE)
	if(!can_commend(forced))
		return
	if(alert(src,"Был ли в этом раунде персонаж, которого вы хотели бы покарать?", "Коммендация", "ДА", "НЕТ") != "ДА")
		return
	var/list/selections = GLOB.character_ckey_list.Copy()
	if(!selections.len)
		return
	var/selection
	if(SSticker.current_state == GAME_STATE_FINISHED)
		selection = input(src,"Персонаж?") as null|anything in sortList(selections)
	else
		selection = input(src, "Персонаж?") as null|text
	if(!selection)
		return
	if(!selections[selection])
		to_chat(src, span_warning("Никого с таким именем не найдено"))
		return
	var/theykey = selections[selection]
	if(theykey == ckey)
		to_chat(src,"Вы не можете похвалить себя.")
		return
	if(!can_commend(forced))
		return
	if(theykey)
		prefs.commendedsomeone = TRUE
		add_uncommend(theykey, ckey)
		to_chat(src,"[selection] uncommended.")
		log_game("COMMEND: [ckey] uncommends [theykey].")
		log_admin("COMMEND: [ckey] uncommends [theykey].")
	return

/proc/add_uncommend(key, giver, reason)
	if(!giver || !key)
		return
	var/curcomm = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/commends.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	if(json[giver])
		curcomm = json[giver]
	curcomm++
	json[giver] = curcomm
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

	var/fakekey = usr.ckey
	if(usr.ckey in GLOB.anonymize)
		fakekey = get_fake_key(usr.ckey)

	var/raisin = stripped_input("Укажите краткую причину этого изменения", "Симулятор Бога", "", null)
	if(!raisin)
		to_chat(src, span_boldwarning("Причина не указана."))
		return

	if(curcomm == 1)
		adjust_playerquality(-1, ckey(key), fakekey, raisin)

/client/verb/triggeruncommend()
	set category = "OOC"
	set name = "Uncommend Someone"
	uncommendsomeone()

/datum/controller/subsystem/ticker/give_show_playerlist_button(client/C)
	. = ..()
	C.uncommendsomeone(forced = TRUE)
