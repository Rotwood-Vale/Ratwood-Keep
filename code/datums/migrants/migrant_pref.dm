/datum/migrant_pref
	/// Reference to our prefs
	var/datum/preferences/prefs
	/// Whether the user wants to be a migrant
	var/active = FALSE
	/// Role preferences of the user, the things he clicks on to be preferred to be
	var/list/role_preferences = list()

/datum/migrant_pref/New(datum/preferences/passed_prefs)
	. = ..()
	prefs = passed_prefs

/datum/migrant_pref/proc/set_active(new_state)
	if(active == new_state)
		return
	active = new_state
	role_preferences.Cut()

/datum/migrant_pref/proc/toggle_role_preference(role_type)
	if(role_type in role_preferences)
		role_preferences -= role_type
	else
		role_preferences += role_type

/datum/migrant_pref/proc/post_spawn()
	set_active(FALSE)

/datum/migrant_pref/proc/show_ui()
	var/client/client = prefs.parent
	if(!client)
		return
	var/list/dat = list()
	var/current_migrants = SSmigrants.get_active_migrant_amount()
	dat += "WAVE: \Roman[SSmigrants.wave_number]"
	dat += "<center><b>BE A MIGRANT: <a href='?src=[REF(src)];task=toggle_active'>[active ? "YES" : "NO"]</a></b></center>"
	dat += "<br><center>Wandering fools: [current_migrants ? "\Roman[current_migrants]" : "None"]</center>"
	if(!SSmigrants.current_wave)
		dat += "<br><center>The mist will clear it's way in [(SSmigrants.time_until_next_wave / (1 SECONDS))] seconds...</center>"
	else
		var/datum/migrant_wave/wave = MIGRANT_WAVE(SSmigrants.current_wave)
		dat += "<br><center><b>[wave.name]</b></center>"
		for(var/role_type in wave.roles)
			var/datum/migrant_role/role = MIGRANT_ROLE(role_type)
			var/role_amount = wave.roles[role_type]
			var/role_name = role.name
			if(active  && (role_type in role_preferences))
				role_name = "<b>[role_name]</b>"
			var/stars_amount = SSmigrants.get_stars_on_role(role_type)
			var/stars_string = ""
			if(stars_amount)
				stars_string = "(*\Roman[stars_amount])"
			dat += "<center><a href='?src=[REF(src)];task=toggle_role_preference;role=[role_type]'>[role_name]</a> - \Roman[role_amount] [stars_string]</center>"

		dat += "<br><center>They will arrive in [(SSmigrants.wave_timer / (1 SECONDS))] seconds...</center>"

	var/datum/browser/popup = new(client.mob, "migration", "<center>Find a purpose</center>", 330, 380)
	popup.set_content(dat.Join())
	popup.open()

/datum/migrant_pref/Topic(href, href_list)
	var/client/client = prefs.parent
	if(!client)
		return
	switch(href_list["task"])
		if("toggle_active")
			set_active(!active)
		if("toggle_role_preference")
			var/role_type = text2path(href_list["role"])
			toggle_role_preference(role_type)
	show_ui()
