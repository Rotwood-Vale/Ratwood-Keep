/proc/check_whitelist(key)
	if(!SSdbcore.Connect())
		log_world("Failed to connect to database in check_whitelist(). Disabling whitelist for current round.")
		WRITE_FILE(GLOB.world_game_log, "Failed to connect to database in check_whitelist(). Disabling whitelist for current round.")
		CONFIG_SET(flag/usewhitelist, FALSE)
		return TRUE

	var/datum/db_query/query_get_whitelist = SSdbcore.NewQuery({"
		SELECT id FROM [format_table_name_whitelist("whitelist")]
		WHERE ckey = :ckey and deleted = 0
	"}, list("ckey" = key)
	)

	if(!query_get_whitelist.Execute())
		log_sql("Whitelist check for ckey [key] failed to execute. Rejecting")
		message_admins("Whitelist check for ckey [key] failed to execute. Rejecting")
		qdel(query_get_whitelist)
		return FALSE

	var/allow = query_get_whitelist.NextRow()

	qdel(query_get_whitelist)

	return allow


// usually, this would go into chat_commands.dm
// BUT i don't want to put so much code there
/datum/tgs_chat_command/whitelist
	name = "whitelist"
	help_text = "Usage: whitelist (add ckey (comment)|remove ckey (comment)|reload|list (limit)|logs (limit)|managerlog manager_id (limit)|useraudit ckey (limit))"
	admin_only = TRUE

/datum/tgs_chat_command/whitelist/Run(datum/tgs_chat_user/sender, params)
	// Declare variables before any code
	var/default_limit = 100
	var/ckey_width = 20
	var/manager_width = 20
	var/manager_id_width = 20
	var/action_width = 10
	var/date_width = 19
	var/comment_width = 30

	var/limit
	var/comment
	var/manager_id
	var/key

	. = ""
	if(!CONFIG_GET(flag/usewhitelist))
		. += "The whitelist is not enabled!\nThe command will continue to execute anyway\n"

	var/list/all_params = splittext(params, " ")
	if(length(all_params) < 1)
		. += "[src.help_text]"
		return

	switch(all_params[1])
		if("add")
			if(length(all_params) < 2)
				. += "Invalid argument"
				return

			key = ckey(all_params[2])

			// Extract comment if any
			comment = ""
			if(length(all_params) > 2)
				var/pos = findtext(params, all_params[2]) + length(all_params[2]) + 1
				comment = copytext(params, pos)

			var/datum/db_query/query_get_whitelist = SSdbcore.NewQuery({"
				SELECT id FROM [format_table_name_whitelist("whitelist")]
				WHERE ckey = :ckey
			"}, list("ckey" = key)
			)
			if(!query_get_whitelist.Execute())
				. += "Failed to add ckey `[key]`\n"
				. += query_get_whitelist.ErrorMsg()
				qdel(query_get_whitelist)
				return

			if(query_get_whitelist.NextRow())
				qdel(query_get_whitelist)

				var/datum/db_query/query_update_whitelist = SSdbcore.NewQuery({"
					UPDATE [format_table_name_whitelist("whitelist")]
					SET deleted = 0, manager = :manager, manager_id = :manager_id, comment = :comment
					WHERE ckey = :ckey
				"}, list("ckey" = key, "manager" = sender.friendly_name, "manager_id" = sender.id, "comment" = comment))

				if(!query_update_whitelist.Execute())
					. += "Failed to update ckey `[key]`\n"
					. += query_update_whitelist.ErrorMsg()
					qdel(query_update_whitelist)
					return

				qdel(query_update_whitelist)

				. += "`[key]` has been re-added to the whitelist!\n"
				return

			qdel(query_get_whitelist)

			var/datum/db_query/query_add_whitelist = SSdbcore.NewQuery({"
				INSERT INTO [format_table_name_whitelist("whitelist")] (ckey, manager, manager_id, comment)
				VALUES (:ckey, :manager, :manager_id, :comment)
			"}, list("ckey" = key, "manager" = sender.friendly_name, "manager_id" = sender.id, "comment" = comment))

			if(!query_add_whitelist.Execute())
				. += "Failed to add ckey `[key]`\n"
				. += query_add_whitelist.ErrorMsg()
				qdel(query_add_whitelist)
				return

			qdel(query_add_whitelist)

			. += "`[key]` has been added to the whitelist!\n"
			return

		if("remove")
			if(length(all_params) < 2)
				. += "Invalid argument"
				return

			key = ckey(all_params[2])

			// Extract comment if any
			comment = ""
			if(length(all_params) > 2)
				var/pos = findtext(params, all_params[2]) + length(all_params[2]) + 1
				comment = copytext(params, pos)

			var/datum/db_query/query_remove_whitelist = SSdbcore.NewQuery({"
				UPDATE [format_table_name_whitelist("whitelist")]
				SET deleted = 1, manager = :manager, manager_id = :manager_id, comment = :comment
				WHERE ckey = :ckey
			"}, list("ckey" = key, "manager" = sender.friendly_name, "manager_id" = sender.id, "comment" = comment))

			if(!query_remove_whitelist.Execute())
				. += "Failed to remove ckey `[key]`"
				. += query_remove_whitelist.ErrorMsg()
				qdel(query_remove_whitelist)
				return

			qdel(query_remove_whitelist)

			. += "`[key]` has been removed from the whitelist!\n"
			return

		if("list")
			limit = default_limit  // Use default limit
			if(length(all_params) > 1)
				limit = text2num(all_params[2])
				if(!limit || limit <= 0)
					limit = default_limit

			var/datum/db_query/query_get_all_whitelist = SSdbcore.NewQuery({"
				SELECT ckey FROM [format_table_name_whitelist("whitelist")] WHERE deleted = 0 ORDER BY last_modified DESC LIMIT :limit
			"}, list("limit" = limit))

			if(!query_get_all_whitelist.Execute())
				. += "Failed to get all whitelisted keys\n"
				. += query_get_all_whitelist.ErrorMsg()
				qdel(query_get_all_whitelist)
				return

			while(query_get_all_whitelist.NextRow())
				var/key_result = query_get_all_whitelist.item[1]
				. += "`[key_result]`\n"

			qdel(query_get_all_whitelist)
			return

		if("logs")
			limit = default_limit  // Use default limit
			if(length(all_params) > 1)
				limit = text2num(all_params[2])
				if(!limit || limit <= 0)
					limit = default_limit

			var/datum/db_query/query_get_logs = SSdbcore.NewQuery({"
				SELECT ckey, manager, manager_id, action, date, comment FROM [format_table_name_whitelist("whitelist_log")]
				ORDER BY date DESC
				LIMIT :limit
			"}, list("limit" = limit))

			if(!query_get_logs.Execute())
				. += "Failed to get whitelist logs\n"
				. += query_get_logs.ErrorMsg()
				qdel(query_get_logs)
				return

			. += "```\n"
			. += "Whitelist Log (last [limit] entries):\n"

			. += pad_string("ckey", ckey_width) + pad_string("manager", manager_width) + pad_string("manager_id", manager_id_width) + pad_string("action", action_width) + pad_string("date", date_width) + pad_string("comment", comment_width) + "\n"
			while(query_get_logs.NextRow())
				var/ckey_value = query_get_logs.item[1]
				var/manager_value = query_get_logs.item[2]
				var/manager_id_value = query_get_logs.item[3]
				var/action_value = query_get_logs.item[4]
				var/date_value = query_get_logs.item[5]
				var/comment_value = query_get_logs.item[6]
				. += pad_string(ckey_value, ckey_width) + pad_string(manager_value, manager_width) + pad_string(manager_id_value, manager_id_width) + pad_string(action_value, action_width) + pad_string(date_value, date_width) + pad_string(comment_value, comment_width) + "\n"

			. += "```\n"
			qdel(query_get_logs)
			return

		if("managerlog")
			if(length(all_params) < 2)
				. += "Invalid argument: manager_id is required."
				return

			manager_id = all_params[2]
			limit = default_limit  // Use default limit
			if(length(all_params) > 2)
				limit = text2num(all_params[3])
				if(!limit || limit <= 0)
					limit = default_limit

			var/datum/db_query/query_get_logs = SSdbcore.NewQuery({"
				SELECT ckey, manager, manager_id, action, date, comment FROM [format_table_name_whitelist("whitelist_log")]
				WHERE manager_id =  REPLACE(REPLACE(:manager_id, '<@', ''), '>', '')
				ORDER BY date DESC
				LIMIT :limit
			"}, list("manager_id" = manager_id, "limit" = limit))

			if(!query_get_logs.Execute())
				. += "Failed to get logs for manager_id `[manager_id]`\n"
				. += query_get_logs.ErrorMsg()
				qdel(query_get_logs)
				return

			. += "```\n"
			. += "Whitelist Log for manager_id `[manager_id]` (last [limit] entries):\n"

			. += pad_string("ckey", ckey_width) + pad_string("manager", manager_width) + pad_string("manager_id", manager_id_width) + pad_string("action", action_width) + pad_string("date", date_width) + pad_string("comment", comment_width) + "\n"
			while(query_get_logs.NextRow())
				var/ckey_value = query_get_logs.item[1]
				var/manager_value = query_get_logs.item[2]
				var/manager_id_value = query_get_logs.item[3]
				var/action_value = query_get_logs.item[4]
				var/date_value = query_get_logs.item[5]
				var/comment_value = query_get_logs.item[6]
				. += pad_string(ckey_value, ckey_width) + pad_string(manager_value, manager_width) + pad_string(manager_id_value, manager_id_width) + pad_string(action_value, action_width) + pad_string(date_value, date_width) + pad_string(comment_value, comment_width) + "\n"

			. += "```\n"
			qdel(query_get_logs)
			return

		if("useraudit")
			if(length(all_params) < 2)
				. += "Invalid argument: ckey is required."
				return

			key = ckey(all_params[2])
			limit = default_limit  // Use default limit
			if(length(all_params) > 2)
				limit = text2num(all_params[3])
				if(!limit || limit <= 0)
					limit = default_limit

			var/datum/db_query/query_get_logs = SSdbcore.NewQuery({"
				SELECT ckey, manager, manager_id, action, date, comment FROM [format_table_name_whitelist("whitelist_log")]
				WHERE ckey = :ckey
				ORDER BY date DESC
				LIMIT :limit
			"}, list("ckey" = key, "limit" = limit))

			if(!query_get_logs.Execute())
				. += "Failed to get logs for ckey `[key]`\n"
				. += query_get_logs.ErrorMsg()
				qdel(query_get_logs)
				return

			. += "```\n"
			. += "Whitelist Log for ckey `[key]` (last [limit] entries):\n"

			. += pad_string("ckey", ckey_width) + pad_string("manager", manager_width) + pad_string("manager_id", manager_id_width) + pad_string("action", action_width) + pad_string("date", date_width) + pad_string("comment", comment_width) + "\n"
			while(query_get_logs.NextRow())
				var/ckey_value = query_get_logs.item[1]
				var/manager_value = query_get_logs.item[2]
				var/manager_id_value = query_get_logs.item[3]
				var/action_value = query_get_logs.item[4]
				var/date_value = query_get_logs.item[5]
				var/comment_value = query_get_logs.item[6]
				. += pad_string(ckey_value, ckey_width) + pad_string(manager_value, manager_width) + pad_string(manager_id_value, manager_id_width) + pad_string(action_value, action_width) + pad_string(date_value, date_width) + pad_string(comment_value, comment_width) + "\n"

			. += "```\n"
			qdel(query_get_logs)
			return

		else
			. += "Unknown command!"
			. += "[src.help_text]"
			return

/proc/pad_string(str, width)
	var/padded_str = "[str]"
	while(length(padded_str) < width)
		padded_str += " "
	return padded_str
