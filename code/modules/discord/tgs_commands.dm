// Notify
/datum/tgs_chat_command/notify
	name = "notify"
	help_text = "Pings the invoker when the round ends"

/datum/tgs_chat_command/notify/Run(datum/tgs_chat_user/sender, params)
	for(var/member in SSdiscord.notify_members) // If they are in the list, take them out
		if(member == "[sender.mention]")
			SSdiscord.notify_members -= "[SSdiscord.id_clean(sender.mention)]" // The list uses strings because BYOND cannot handle a 17 digit integer
			return "You will no longer be notified when the server restarts"
		
	// If we got here, they arent in the list. Chuck 'em in!
	SSdiscord.notify_members += "[SSdiscord.id_clean(sender.mention)]" // The list uses strings because BYOND cannot handle a 17 digit integer
	return "You will now be notified when the server restarts"

// Verify
/datum/tgs_chat_command/verify
	name = "verify"
	help_text = "Verifies your discord account and your BYOND account linkage"

/datum/tgs_chat_command/verify/Run(datum/tgs_chat_user/sender, params)
	var/lowerparams = replacetext(lowertext(params), " ", "") // Fuck spaces
	if(SSdiscord.account_link_cache[lowerparams]) // First if they are in the list, then if the ckey matches
		if(SSdiscord.account_link_cache[lowerparams] == "[SSdiscord.id_clean(sender.mention)]") // If the associated ID is the correct one
			SSdiscord.link_account(lowerparams)
			return "Successfully linked accounts"
		else
			return "That ckey is not associated to this discord account. If someone has used your ID, please inform an administrator"
	else
		return "Account not setup for linkage"

// Notify

/datum/tgs_chat_command/notify/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(string/chat_announce_new_game))
		return "Notifcations are currently disabled"

	for(var/member in SSdiscord.notify_members) // If they are in the list, take them out
		if(member == sender.mention)
			SSdiscord.notify_members -= sender.mention
			return "You will no longer be notified when the server restarts"

	// If we got here, they arent in the list. Chuck 'em in!
	SSdiscord.notify_members += sender.mention
	return "You will now be notified when the server restarts"

// PQ
/datum/tgs_chat_command/pq
	name = "pq"
	help_text = "Add or remove Player Quality points from user"

/datum/tgs_chat_command/pq/Run(datum/tgs_chat_user/sender, params)
	if(!params)
		return "Использование: !pq <ckey> <amount> <reason>"
	
	var/list/paramslist = splittext(params, " ")
	if(length(paramslist) < 2)
		return "Недостаточно параметров. Использование: !pq <ckey> <amount> <reason>"
	
	var/target_ckey = ckey(paramslist[1])
	message_admins("PQ: Попытка изменить PQ для '[target_ckey]' на [amount] от [sender.friendly_name]")
	
	if(!target_ckey)
		return "Некорректный ckey"
	
	var/amount = text2num(paramslist[2])
	var/reason = length(paramslist) > 2 ? jointext(paramslist.Copy(3), " ") : "Не указана"
	
	if(!amount)
		return "Некорректное количество очков"

	// Используем функцию adjust_playerquality вместо прямого изменения
	var/result = adjust_playerquality(target_ckey, amount, sender.friendly_name, reason)
	if(!result)
		message_admins("PQ: Не удалось найти игрока '[target_ckey]' в базе данных")
		return "Игрок [target_ckey] не найден в базе данных. Убедитесь, что игрок заходил на сервер хотя бы раз"
	
	message_admins("PQ: Успешно изменен PQ для '[target_ckey]'")
	return "PQ игрока [target_ckey] изменен на [amount] ([reason])"
