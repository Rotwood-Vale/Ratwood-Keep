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
		// Currently only allow 1 role preffed up for clarity
		role_preferences.Cut()

		if(SSmigrants.can_be_role(prefs.parent, role_type))
			role_preferences += role_type
		else
			to_chat(prefs.parent, span_warning("You can't be this role. (Wrong species, gender or age)"))

/datum/migrant_pref/proc/post_spawn()
	set_active(FALSE)
	hide_ui()

/datum/migrant_pref/proc/hide_ui()
	var/client/client = prefs.parent
	if(!client)
		return
	client.mob << browse(null, "window=migration")

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
		dat += "<br><center>The mist will clear out of the way in [(SSmigrants.time_until_next_wave / (1 SECONDS))] seconds...</center>"
	else
		var/datum/migrant_wave/wave = MIGRANT_WAVE(SSmigrants.current_wave)
		dat += "<br><center><b>[wave.name]</b></center>"
		for(var/role_type in wave.roles)
			var/datum/migrant_role/role = MIGRANT_ROLE(role_type)
			var/role_amount = wave.roles[role_type]
			var/role_name = role.name
			if(active  && (role_type in role_preferences))
				role_name = "<u><b>[role_name]</b></u>"
			var/stars_amount = SSmigrants.get_stars_on_role(role_type)
			var/stars_string = ""
			if(stars_amount)
				stars_string = "(*\Roman[stars_amount])"
			dat += "<center><a href='?src=[REF(src)];task=toggle_role_preference;role=[role_type]'>[role_name]</a> - \Roman[role_amount] [stars_string]</center>"

		dat += "<br><center>They will arrive in [(SSmigrants.wave_timer / (1 SECONDS))] seconds...</center>"

	var/datum/browser/popup = new(client.mob, "migration", "<center>Find a purpose</center>", 330, 410)
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

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
