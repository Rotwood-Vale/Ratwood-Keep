/client/proc/forcerandomrotate()
	set category = "Server"
	set name = "Trigger Random Map Rotation"
	var/rotate = alert("Force a random map rotation to trigger?", "Rotate map?", "Yes", "Cancel")
	if (rotate != "Yes")
		return
	message_admins("[key_name_admin(usr)] is forcing a random map rotation.")
	log_admin("[key_name(usr)] is forcing a random map rotation.")
	SSticker.maprotatechecked = 1
	SSmapping.maprotate()

/client/proc/adminchangemap()
	set category = "Server"
	set name = "Change Map"
	var/list/maprotatechoices = list()
	for (var/map in config.maplist)
		var/datum/map_config/VM = config.maplist[map]
		var/mapname = VM.map_name
		if (VM == config.defaultmap)
			mapname += " (Default)"

		if (VM.config_min_users > 0 || VM.config_max_users > 0)
			mapname += " \["
			if (VM.config_min_users > 0)
				mapname += "[VM.config_min_users]"
			else
				mapname += "0"
			mapname += "-"
			if (VM.config_max_users > 0)
				mapname += "[VM.config_max_users]"
			else
				mapname += "inf"
			mapname += "\]"

		maprotatechoices[mapname] = VM
	var/chosenmap = input("Choose a map to change to", "Change Map")  as null|anything in sortList(maprotatechoices)|"Custom"
	if (!chosenmap)
		return

	SSticker.maprotatechecked = 1
	if(chosenmap == "Custom")
		message_admins("[key_name_admin(usr)] is changing the map to a custom map")
		log_admin("[key_name(usr)] is changing the map to a custom map")
		var/datum/map_config/VM = new

		var/map_file = input("Pick file:", "Map File") as null|file
		if(isnull(map_file))
			return

		if(copytext("[map_file]",-4) != ".dmm")
			to_chat(src, span_warning("Filename must end in '.dmm': [map_file]"))
			return

		if(!fcopy(map_file, "_maps/custom/[map_file]"))
			return

		// This is to make sure the map works so the server does not start without a map.
		var/datum/parsed_map/M = new (map_file)
		if(!M)
			to_chat(src, span_warning("Map '[map_file]' failed to parse properly."))
			return

		if(!M.bounds)
			to_chat(src, span_warning("Map '[map_file]' has non-existant bounds."))
			qdel(M)
			return

		qdel(M)
		var/config_file = null
		var/list/json_value = list()
		var/config = input(usr, "Would you like to upload an additional config for this map?", "Map Config") as null|anything in list("Yes", "No")
		if(config == "Yes")
			config_file = input(usr, "Pick file:", "Config JSON File") as null|file
			if(isnull(config_file))
				return
			if(copytext("[config_file]", -5) != ".json")
				to_chat(src, span_warning("Filename must end in '.json': [config_file]"))
				return
			if(fexists("data/custom_map_json/[config_file]"))
				fdel("data/custom_map_json/[config_file]")
			if(!fcopy(config_file, "data/custom_map_json/[config_file]"))
				return

			json_value = VM.LoadConfig("data/custom_map_json/[config_file]", TRUE)

			if(!json_value)
				to_chat(src, span_warning("Failed to load config: [config_file]. Check that the fields are filled out correctly. \"map_path\": \"custom\" and \"map_file\": \"your_map_name.dmm\""))
				return
		else
			VM.map_name = input("Choose the name for the map", "Map Name") as null|text
			if(isnull(VM.map_name))
				VM.map_name = "Custom"

		VM.map_path = "custom"
		VM.map_file = "[map_file]"

		// If the file isn't removed text2file will just append.
		if(fexists("data/next_map.json"))
			fdel("data/next_map.json")
		text2file(json_encode(json_value), "data/next_map.json")

		if(SSmapping.changemap(VM))
			message_admins("[key_name_admin(usr)] has changed the map to [VM.map_name]")
	else
		var/datum/map_config/VM = maprotatechoices[chosenmap]
		message_admins("[key_name_admin(usr)] is changing the map to [VM.map_name]")
		log_admin("[key_name(usr)] is changing the map to [VM.map_name]")
		if (SSmapping.changemap(VM))
			message_admins("[key_name_admin(usr)] has changed the map to [VM.map_name]")
