/client/proc/view_rogue_manifest() // round-end manifest, 
	var/dat
	dat += "<h1>Round ID: [GLOB.rogue_round_id]</h1>"
	dat += "<h4>- Inhabitants of [SSmapping.config.map_name || "Rockhill"] -</h4>"
	for(var/X in GLOB.character_list)
		dat += GLOB.character_list[X]
	var/datum/browser/popup = new(src, "actors", "<center>Inhabitants of [SSmapping.config.map_name || "Rockhill"]</center>", 387, 420)
	popup.set_content(dat)
	popup.open(FALSE)

/client/proc/view_actors_manifest()
	var/dat = ""
	for(var/X in GLOB.actors_list)
		dat += GLOB.actors_list[X]

	var/datum/browser/popup = new(src, "actors", "<center>This Story's Actors</center>", 387, 420)
	popup.set_content(dat)
	popup.open(FALSE)
