//used for holding information about unique properties of maps
//feed it json files that match the datum layout
//defaults to box
//  -Cyberboss

/datum/map_config
	// Metadata
	var/config_filename = "_maps/rockhill.json"
	var/defaulted = TRUE  // set to FALSE by LoadConfig() succeeding
	// Config from maps.txt
	var/config_max_users = 0
	var/config_min_users = 0
	var/voteweight = 1
	var/votable = FALSE

	// Map name loaded from json
	var/map_name
	var/list/map_zones = list()
	var/job_config_id = "rockhill"


/proc/load_map_config(filename = "data/next_map.json", default_to_box, delete_after, error_if_missing = TRUE)
	testing("loading map config [filename]")
	var/datum/map_config/config = new
	if (default_to_box)
		return config
	if (!config.LoadConfig(filename, error_if_missing))
		qdel(config)
		if(default_to_box)
			config = new /datum/map_config  // Fall back to Box
	if (delete_after)
		fdel(filename)
	if(config)
		return config

/proc/load_map_zone_config(filename)
	var/datum/map_zone_config/config = new /datum/map_zone_config()
	if(!config.load_config(filename))
		log_world("ERROR: Could not load map zone config: [filename]")
		return null
	return config

#define CHECK_EXISTS(X) if(!istext(json[X])) { log_world("[##X] missing from json!"); return; }
/datum/map_config/proc/LoadConfig(filename, error_if_missing)
	if(!fexists(filename))
		if(error_if_missing)
			log_world("map_config not found: [filename]")
		return

	var/json = file(filename)
	if(!json)
		log_world("Could not open map_config: [filename]")
		return

	json = file2text(json)
	if(!json)
		log_world("map_config is not text: [filename]")
		return

	json = json_decode(json)
	if(!json)
		log_world("map_config is not json: [filename]")
		return

	config_filename = filename

	CHECK_EXISTS("map_name")
	map_name = json["map_name"]

	CHECK_EXISTS("job_config_id")
	job_config_id = json["job_config_id"]

	var/list/map_zone_paths = json["map_zones"]
	if (islist(map_zone_paths))
		for(var/path in map_zone_paths)
			var/datum/map_zone_config/mapzoneconfig = load_map_zone_config(path)
			if(!mapzoneconfig)
				log_world("map_config: Error while loading map zone config: [path]")
				return
			map_zones += mapzoneconfig
	else
		log_world("map_config does not have map zone paths!")
		return

	defaulted = FALSE
	return TRUE
#undef CHECK_EXISTS

/datum/map_config/proc/MakeNextMap()
	return config_filename == "data/next_map.json" || fcopy(config_filename, "data/next_map.json")
