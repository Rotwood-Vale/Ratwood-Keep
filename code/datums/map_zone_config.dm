/datum/map_zone_config
	var/map_name
	var/map_path
	var/map_file
	var/traits = null

/datum/map_zone_config/proc/load_config(filename)
	if(!fexists(filename))
		log_world("map_zone_config not found: [filename]")
		return

	var/json = file(filename)
	if(!json)
		log_world("Could not open map_zone_config: [filename]")
		return

	json = file2text(json)
	if(!json)
		log_world("map_zone_config is not text: [filename]")
		return

	json = json_decode(json)
	if(!json)
		log_world("map_zone_config is not json: [filename]")
		return

	if(!json["map_path"])
		log_world("map_zone_config: map_path missing from json!")
		return
	map_path = json["map_path"]

	map_file = json["map_file"]
	if (istext(map_file))
		if (!fexists("_maps/[map_path]/[map_file]"))
			log_world("Map file ([map_path]/[map_file]) does not exist!")
			return
	else if (islist(map_file))
		for (var/file in map_file)
			if (!fexists("_maps/[map_path]/[file]"))
				log_world("Map file ([map_path]/[file]) does not exist!")
				return
	else
		log_world("map_file missing from json!")
		return

	traits = json["traits"]
	if (islist(traits))
		// "Station" is set by default, but it's assumed if you're setting
		// traits you want to customize which level is cross-linked
		for (var/level in traits)
			if (!(ZTRAIT_STATION in level))
				level[ZTRAIT_STATION] = TRUE
	// "traits": null or absent -> default
	else if (!isnull(traits))
		log_world("map_config traits is not a list!")
		return

	return TRUE
