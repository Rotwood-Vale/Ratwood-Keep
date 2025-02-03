/client/proc/give_comment(good_or_bad, key, admin, reason)
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/pq_num.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

	var/text
	if(good_or_bad >= 1)
		text += "Похвала от <b>[admin]</b> за: <i>[reason]</i> ([GLOB.rogue_round_id]) \n"
		text2file(text,"data/player_saves/[copytext(key,1,2)]/[key]/playerquality.txt")
		message_admins("<small>[admin] похвалил (без PQ) [key] с причиной: [reason]</small>")
	else
		text = "Недовольство от <b>[admin]</b> за: <i>[reason]</i> ([GLOB.rogue_round_id]) \n"
		text2file(text,"data/player_saves/[copytext(key,1,2)]/[key]/playerquality.txt")
		message_admins("<small>[admin] поругал (без PQ) [key] с причиной: [reason]</small>")

/client/proc/add_uncommend(key, giver)
	if(!giver || !key)
		return
	var/curcomm = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/commends.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	if(json[giver])
		curcomm = json[giver]
	var/fakekey = src.ckey
	if(src.ckey in GLOB.anonymize)
		fakekey = get_fake_key(src.ckey)

	to_chat(src, span_danger("Укажите краткую причину этого изменения.<br>\
	Учитывайте, что игрок может не знать всего контекста произошедших с вами событий и может быть НЕ их виной.<br>\
	Ставьте негативную оценку только если навредили игровой атмосфере или произошёл гриф без веской причины.<br>\
	Примеры - неуместный сленг, убийство бандитом при кооперации жертвы, пытки без видимой на то причины, не имеющее IC обоснования убийство, запирание до конца раунда без интересной игры, не подходящий сеттингу тёмного фэнтези отыгрыш.<br>\
	В конце концов, спросите себя — <b>\"Это игра такая жестокая или это игрок перегнул палку?\"</b>"))

	var/raisin = stripped_input(src, \
	"\"Я точно знаю, что ими двигало?\"", "Он точно заслужил это?", "", null)
	if(!raisin)
		to_chat(src, span_boldwarning("Причина не указана."))
		fdel(json_file)
		WRITE_FILE(json_file, json_encode(json))
		return FALSE

	if(curcomm >= 0) // Если комменд -1 или более, то нельзя дальше анкоммендить
		adjust_playerquality(-1, ckey(key), fakekey, raisin)
		send2irc("PQ", "[fakekey == ckey ? "[ckey]" : "[fake_key] ([ckey])"] [mob ? "([mob.real_name])" : ""] снял [key] за: \"<i>[raisin]</i>\"") // REDMOON ADD
		curcomm--
		json[giver] = curcomm
		fdel(json_file)
		WRITE_FILE(json_file, json_encode(json))
		return TRUE
	else
		give_comment(-1, ckey(key), fakekey, raisin)
		return TRUE

