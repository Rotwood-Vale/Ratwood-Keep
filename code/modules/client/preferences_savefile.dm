//This is the lowest supported version, anything below this is completely obsolete and the entire savefile will be wiped.
#define SAVEFILE_VERSION_MIN	18

//This is the current version, anything below this will attempt to update (if it's not obsolete)
//	You do not need to raise this if you are adding new values that have sane defaults.
//	Only raise this value when changing the meaning/format/name/layout of an existing value
//	where you would want the updater procs below to run
#define SAVEFILE_VERSION_MAX	30

/*
SAVEFILE UPDATING/VERSIONING - 'Simplified', or rather, more coder-friendly ~Carn
	This proc checks if the current directory of the savefile S needs updating
	It is to be used by the load_character and load_preferences procs.
	(S.cd=="/" is preferences, S.cd=="/character[integer]" is a character slot, etc)

	if the current directory's version is below SAVEFILE_VERSION_MIN it will simply wipe everything in that directory
	(if we're at root "/" then it'll just wipe the entire savefile, for instance.)

	if its version is below SAVEFILE_VERSION_MAX but above the minimum, it will load data but later call the
	respective update_preferences() or update_character() proc.
	Those procs allow coders to specify format changes so users do not lose their setups and have to redo them again.

	Failing all that, the standard sanity checks are performed. They simply check the data is suitable, reverting to
	initial() values if necessary.
*/
/datum/preferences/proc/savefile_needs_update(savefile/S)
	var/savefile_version
	S["version"] >> savefile_version

	if(savefile_version < SAVEFILE_VERSION_MIN)
		S.dir.Cut()
		return -2
	if(savefile_version < SAVEFILE_VERSION_MAX)
		return savefile_version
	return -1

//should these procs get fairly long
//just increase SAVEFILE_VERSION_MIN so it's not as far behind
//SAVEFILE_VERSION_MAX and then delete any obsolete if clauses
//from these procs.
//This only really meant to avoid annoying frequent players
//if your savefile is 3 months out of date, then 'tough shit'.

/datum/preferences/proc/update_preferences(current_version, savefile/S)
	if(current_version < 29)
		key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
		parent.update_movement_keys()
		to_chat(parent, span_danger("Empty keybindings, setting default to [hotkeys ? "Hotkey" : "Classic"] mode"))

/datum/preferences/proc/update_character(current_version, savefile/S)
	if(current_version < 19)
		pda_style = "mono"
	if(current_version < 20)
		pda_color = "#808000"
	if((current_version < 21) && features["ethcolor"] && (features["ethcolor"] == "#9c3030"))
		features["ethcolor"] = "9c3030"
	if(current_version < 22)
		job_preferences = list() //It loaded null from nonexistant savefile field.
		var/job_civilian_high = 0
		var/job_civilian_med = 0
		var/job_civilian_low = 0

		var/job_medsci_high = 0
		var/job_medsci_med = 0
		var/job_medsci_low = 0

		var/job_engsec_high = 0
		var/job_engsec_med = 0
		var/job_engsec_low = 0

		S["job_civilian_high"]	>> job_civilian_high
		S["job_civilian_med"]	>> job_civilian_med
		S["job_civilian_low"]	>> job_civilian_low
		S["job_medsci_high"]	>> job_medsci_high
		S["job_medsci_med"]		>> job_medsci_med
		S["job_medsci_low"]		>> job_medsci_low
		S["job_engsec_high"]	>> job_engsec_high
		S["job_engsec_med"]		>> job_engsec_med
		S["job_engsec_low"]		>> job_engsec_low

		//Can't use SSjob here since this happens right away on login
		for(var/job in subtypesof(/datum/job))
			var/datum/job/J = job
			var/new_value
			var/fval = initial(J.flag)
			switch(initial(J.department_flag))
				if(CIVILIAN)
					if(job_civilian_high & fval)
						new_value = JP_HIGH
					else if(job_civilian_med & fval)
						new_value = JP_MEDIUM
					else if(job_civilian_low & fval)
						new_value = JP_LOW
				if(MEDSCI)
					if(job_medsci_high & fval)
						new_value = JP_HIGH
					else if(job_medsci_med & fval)
						new_value = JP_MEDIUM
					else if(job_medsci_low & fval)
						new_value = JP_LOW
				if(ENGSEC)
					if(job_engsec_high & fval)
						new_value = JP_HIGH
					else if(job_engsec_med & fval)
						new_value = JP_MEDIUM
					else if(job_engsec_low & fval)
						new_value = JP_LOW
			if(new_value)
				job_preferences[initial(J.title)] = new_value
	if(current_version < 23)
		if(all_quirks)
			all_quirks -= "Physically Obstructive"
			all_quirks -= "Neat"
			all_quirks -= "NEET"
	if(current_version < 25)
		randomise = list(RANDOM_UNDERWEAR = TRUE, RANDOM_UNDERWEAR_COLOR = TRUE, RANDOM_UNDERSHIRT = TRUE, RANDOM_SOCKS = TRUE, RANDOM_BACKPACK = TRUE, RANDOM_JUMPSUIT_STYLE = FALSE, RANDOM_SKIN_TONE = TRUE, RANDOM_EYE_COLOR = TRUE)
		if(S["name_is_always_random"] == 1)
			randomise[RANDOM_NAME] = TRUE
		if(S["body_is_always_random"] == 1)
			randomise[RANDOM_BODY] = TRUE
		if(S["species_is_always_random"] == 1)
			randomise[RANDOM_SPECIES] = TRUE
		if(S["backbag"])
			S["backbag"]	>> backpack
		if(S["hair_style_name"])
			S["hair_style_name"]	>> hairstyle
		if(S["facial_style_name"])
			S["facial_style_name"]	>> facial_hairstyle
	if(current_version < 30)
		S["voice_color"]		>> voice_color

/datum/preferences/proc/load_path(ckey,filename="preferences.sav")
	if(!ckey)
		return
	path = "data/player_saves/[copytext(ckey,1,2)]/[ckey]/[filename]"

/datum/preferences/proc/load_preferences()
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE

	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"

	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		return FALSE

	//general preferences
	S["asaycolor"]			>> asaycolor
	S["ooccolor"]			>> ooccolor
	S["lastchangelog"]		>> lastchangelog
	S["UI_style"]			>> UI_style
	S["hotkeys"]			>> hotkeys
	S["chat_on_map"]		>> chat_on_map
	S["showrolls"]			>> showrolls
	S["max_chat_length"]	>> max_chat_length
	S["see_chat_non_mob"] 	>> see_chat_non_mob
	S["tgui_fancy"]			>> tgui_fancy
	S["tgui_lock"]			>> tgui_lock
	S["buttons_locked"]		>> buttons_locked
	S["windowflash"]		>> windowflashing
	S["be_special"] 		>> be_special
	S["triumphs"]			>> triumphs
	S["musicvol"]			>> musicvol
	S["anonymize"]			>> anonymize
	S["crt"]			>> crt
	S["mastervol"]			>> mastervol
	S["lastclass"]			>> lastclass


	S["default_slot"]		>> default_slot
	S["chat_toggles"]		>> chat_toggles
	S["toggles"]			>> toggles
	S["ghost_form"]			>> ghost_form
	S["ghost_orbit"]		>> ghost_orbit
	S["ghost_accs"]			>> ghost_accs
	S["ghost_others"]		>> ghost_others
	S["preferred_map"]		>> preferred_map
	S["ignoring"]			>> ignoring
	S["ghost_hud"]			>> ghost_hud
	S["inquisitive_ghost"]	>> inquisitive_ghost
	S["uses_glasses_colour"]>> uses_glasses_colour
	S["clientfps"]			>> clientfps
	S["parallax"]			>> parallax
	S["ambientocclusion"]	>> ambientocclusion
	S["auto_fit_viewport"]	>> auto_fit_viewport
	S["widescreenpref"]	    >> widescreenpref
	S["menuoptions"]		>> menuoptions
	S["enable_tips"]		>> enable_tips
	S["tip_delay"]			>> tip_delay
	S["pda_style"]			>> pda_style
	S["pda_color"]			>> pda_color

	// Custom hotkeys
	S["key_bindings"]		>> key_bindings

	//try to fix any outdated data if necessary
	if(needs_update >= 0)
		update_preferences(needs_update, S)		//needs_update = savefile_version if we need an update (positive integer)

	//Sanitize
	asaycolor		= sanitize_ooccolor(sanitize_hexcolor(asaycolor, 6, 1, initial(asaycolor)))
	ooccolor		= sanitize_ooccolor(sanitize_hexcolor(ooccolor, 6, 1, initial(ooccolor)))
	lastchangelog	= sanitize_text(lastchangelog, initial(lastchangelog))
	UI_style		= sanitize_inlist(UI_style, GLOB.available_ui_styles, GLOB.available_ui_styles[1])
	hotkeys			= sanitize_integer(hotkeys, 0, 1, initial(hotkeys))
	chat_on_map		= sanitize_integer(chat_on_map, 0, 1, initial(chat_on_map))
	showrolls		= sanitize_integer(showrolls, 0, 1, initial(showrolls))
	max_chat_length = sanitize_integer(max_chat_length, 1, CHAT_MESSAGE_MAX_LENGTH, initial(max_chat_length))
	see_chat_non_mob	= sanitize_integer(see_chat_non_mob, 0, 1, initial(see_chat_non_mob))
	tgui_fancy		= sanitize_integer(tgui_fancy, 0, 1, initial(tgui_fancy))
	tgui_lock		= sanitize_integer(tgui_lock, 0, 1, initial(tgui_lock))
	buttons_locked	= sanitize_integer(buttons_locked, 0, 1, initial(buttons_locked))
	windowflashing	= sanitize_integer(windowflashing, 0, 1, initial(windowflashing))
	default_slot	= sanitize_integer(default_slot, 1, max_save_slots, initial(default_slot))
	toggles			= sanitize_integer(toggles, 0, INFINITY, initial(toggles))
	clientfps		= sanitize_integer(clientfps, 0, 1000, 0)
	parallax		= sanitize_integer(parallax, PARALLAX_INSANE, PARALLAX_DISABLE, null)
	ambientocclusion	= sanitize_integer(ambientocclusion, 0, 1, initial(ambientocclusion))
	auto_fit_viewport	= sanitize_integer(auto_fit_viewport, 0, 1, initial(auto_fit_viewport))
	widescreenpref  = sanitize_integer(widescreenpref, 0, 1, initial(widescreenpref))
	ghost_form		= sanitize_inlist(ghost_form, GLOB.ghost_forms, initial(ghost_form))
	ghost_orbit 	= sanitize_inlist(ghost_orbit, GLOB.ghost_orbits, initial(ghost_orbit))
	ghost_accs		= sanitize_inlist(ghost_accs, GLOB.ghost_accs_options, GHOST_ACCS_DEFAULT_OPTION)
	ghost_others	= sanitize_inlist(ghost_others, GLOB.ghost_others_options, GHOST_OTHERS_DEFAULT_OPTION)
	menuoptions		= SANITIZE_LIST(menuoptions)
	be_special		= SANITIZE_LIST(be_special)
	pda_style		= sanitize_inlist(pda_style, GLOB.pda_styles, initial(pda_style))
	pda_color		= sanitize_hexcolor(pda_color, 6, 1, initial(pda_color))
	key_bindings 	= sanitize_islist(key_bindings, list())

	//ROGUETOWN
	parallax = PARALLAX_INSANE

	return TRUE

/datum/preferences/proc/save_preferences()
	if(!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"

	parallax = PARALLAX_INSANE

	WRITE_FILE(S["version"] , SAVEFILE_VERSION_MAX)		//updates (or failing that the sanity checks) will ensure data is not invalid at load. Assume up-to-date

	//general preferences
	WRITE_FILE(S["asaycolor"], asaycolor)
	WRITE_FILE(S["triumphs"], triumphs)
	WRITE_FILE(S["musicvol"], musicvol)
	WRITE_FILE(S["anonymize"], anonymize)
	WRITE_FILE(S["crt"], crt)
	WRITE_FILE(S["lastclass"], lastclass)
	WRITE_FILE(S["mastervol"], mastervol)
	WRITE_FILE(S["ooccolor"], ooccolor)
	WRITE_FILE(S["lastchangelog"], lastchangelog)
	WRITE_FILE(S["UI_style"], UI_style)
	WRITE_FILE(S["hotkeys"], hotkeys)
	WRITE_FILE(S["chat_on_map"], chat_on_map)
	WRITE_FILE(S["showrolls"], showrolls)
	WRITE_FILE(S["max_chat_length"], max_chat_length)
	WRITE_FILE(S["see_chat_non_mob"], see_chat_non_mob)
	WRITE_FILE(S["tgui_fancy"], tgui_fancy)
	WRITE_FILE(S["tgui_lock"], tgui_lock)
	WRITE_FILE(S["buttons_locked"], buttons_locked)
	WRITE_FILE(S["windowflash"], windowflashing)
	WRITE_FILE(S["be_special"], be_special)
	WRITE_FILE(S["default_slot"], default_slot)
	WRITE_FILE(S["toggles"], toggles)
	WRITE_FILE(S["chat_toggles"], chat_toggles)
	WRITE_FILE(S["ghost_form"], ghost_form)
	WRITE_FILE(S["ghost_orbit"], ghost_orbit)
	WRITE_FILE(S["ghost_accs"], ghost_accs)
	WRITE_FILE(S["ghost_others"], ghost_others)
	WRITE_FILE(S["preferred_map"], preferred_map)
	WRITE_FILE(S["ignoring"], ignoring)
	WRITE_FILE(S["ghost_hud"], ghost_hud)
	WRITE_FILE(S["inquisitive_ghost"], inquisitive_ghost)
	WRITE_FILE(S["uses_glasses_colour"], uses_glasses_colour)
	WRITE_FILE(S["clientfps"], clientfps)
	WRITE_FILE(S["parallax"], parallax)
	WRITE_FILE(S["ambientocclusion"], ambientocclusion)
	WRITE_FILE(S["auto_fit_viewport"], auto_fit_viewport)
	WRITE_FILE(S["widescreenpref"], widescreenpref)
	WRITE_FILE(S["menuoptions"], menuoptions)
	WRITE_FILE(S["enable_tips"], enable_tips)
	WRITE_FILE(S["tip_delay"], tip_delay)
	WRITE_FILE(S["pda_style"], pda_style)
	WRITE_FILE(S["pda_color"], pda_color)
	WRITE_FILE(S["key_bindings"], key_bindings)
	return TRUE


/datum/preferences/proc/_load_species(S)
	var/species_name
	testing("begin _load_species()")
	S["species"] >> species_name
	if(species_name)
		var/newtype = GLOB.species_list[species_name]
		if(newtype)
			pref_species = new newtype
			if(!spec_check())
				testing("spec_check() failed on type [newtype] and name [species_name], defaulting to [default_species].")
				pref_species = new default_species.type()
			else
				testing("spec_check() succeeded on type [newtype] and name [species_name].")
		else
			testing("GLOB.species_list failed on name [species_name], defaulting to [default_species].")
			pref_species = new default_species.type()
	else
		pref_species = new default_species.type()

/datum/preferences/proc/_load_flaw(S)
	var/charflaw_type
	S["charflaw"]			>> charflaw_type
	if(charflaw_type)
		charflaw = new charflaw_type()
	else
		charflaw = pick(GLOB.character_flaws)
		charflaw = GLOB.character_flaws[charflaw]
		charflaw = new charflaw()

/datum/preferences/proc/_load_appearence(S)
	S["real_name"]			>> real_name
	S["gender"]				>> gender
	S["domhand"]			>> domhand
//	S["alignment"]			>> alignment
	S["age"]				>> age
	S["hair_color"]			>> hair_color
	S["facial_hair_color"]	>> facial_hair_color
	S["eye_color"]			>> eye_color
	S["voice_color"]		>> voice_color
	S["skin_tone"]			>> skin_tone
	S["hairstyle_name"]	>> hairstyle
	S["facial_style_name"]	>> facial_hairstyle
	S["underwear"]			>> underwear
	S["underwear_color"]	>> underwear_color
	S["undershirt"]			>> undershirt
	S["accessory"]			>> accessory
	S["detail"]			>> detail
	S["socks"]				>> socks
	S["backpack"]			>> backpack
	S["jumpsuit_style"]		>> jumpsuit_style
	S["uplink_loc"]			>> uplink_spawn_loc
	S["randomise"]	>>  randomise
	S["feature_mcolor"]					>> features["mcolor"]
	S["feature_mcolor2"]					>> features["mcolor2"]
	S["feature_mcolor3"]					>> features["mcolor3"]
	S["feature_ethcolor"]					>> features["ethcolor"]

/datum/preferences/proc/load_character(slot)
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"
	if(!slot)
		slot = default_slot
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))
	if(slot != default_slot)
		default_slot = slot
		WRITE_FILE(S["default_slot"] , slot)

	S.cd = "/character[slot]"
	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		return FALSE

	//Species
	_load_species(S)

	_load_flaw(S)

	if(!S["features["mcolor"]"] || S["features["mcolor"]"] == "#000")
		WRITE_FILE(S["features["mcolor"]"]	, "#FFF")
	if(!S["features["mcolor2"]"] || S["features["mcolor2"]"] == "#000")
		WRITE_FILE(S["features["mcolor2"]"]	, "#FFF")
	if(!S["features["mcolor3"]"] || S["features["mcolor3"]"] == "#000")
		WRITE_FILE(S["features["mcolor3"]"]	, "#FFF")

	if(!S["feature_ethcolor"] || S["feature_ethcolor"] == "#000")
		WRITE_FILE(S["feature_ethcolor"], "9c3030")

	//Character
	_load_appearence(S)

	var/patron_typepath
	S["selected_patron"]	>> patron_typepath
	if(patron_typepath)
		selected_patron = GLOB.patronlist[patron_typepath]
		if(!selected_patron) //failsafe
			selected_patron = GLOB.patronlist[default_patron]

	//Custom names
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/savefile_slot_name = custom_name_id + "_name" //TODO remove this
		S[savefile_slot_name] >> custom_names[custom_name_id]

	S["preferred_ai_core_display"] >> preferred_ai_core_display
	S["prefered_security_department"] >> prefered_security_department

	//Jobs
	S["joblessrole"] >> joblessrole
	//Load prefs
	S["job_preferences"] >> job_preferences

	//Quirks
	S["all_quirks"] >> all_quirks

	S["update_mutant_colors"]			>> update_mutant_colors
	update_mutant_colors = sanitize_integer(update_mutant_colors, FALSE, TRUE, initial(update_mutant_colors))

	S["headshot_link"]			>> headshot_link
	if(!valid_headshot_link(null, headshot_link, TRUE))
		headshot_link = null

	//try to fix any outdated data if necessary
	if(needs_update >= 0)
		update_character(needs_update, S)		//needs_update == savefile_version if we need an update (positive integer)

	//Sanitize

	real_name = reject_bad_name(real_name)
	gender = sanitize_gender(gender)
	if(!real_name)
		real_name = random_unique_name(gender)

	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/namedata = GLOB.preferences_custom_names[custom_name_id]
		custom_names[custom_name_id] = reject_bad_name(custom_names[custom_name_id],namedata["allow_numbers"])
		if(!custom_names[custom_name_id])
			custom_names[custom_name_id] = get_default_name(custom_name_id)

	if(!features["mcolor"] || features["mcolor"] == "#000")
		features["mcolor"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
	if(!features["mcolor2"] || features["mcolor2"] == "#000")
		features["mcolor2"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
	if(!features["mcolor3"] || features["mcolor3"] == "#000")
		features["mcolor3"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")

	if(!features["ethcolor"] || features["ethcolor"] == "#000")
		features["ethcolor"] = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]

	randomise = SANITIZE_LIST(randomise)

	socks			= sanitize_inlist(socks, GLOB.socks_list)
	age				= sanitize_inlist(age, pref_species.possible_ages)
	underwear_color			= sanitize_hexcolor(underwear_color, 3, 0)
	eye_color		= sanitize_hexcolor(eye_color, 3, 0)
	voice_color		= voice_color
	skin_tone		= skin_tone
	backpack			= sanitize_inlist(backpack, GLOB.backpacklist, initial(backpack))
	jumpsuit_style	= sanitize_inlist(jumpsuit_style, GLOB.jumpsuitlist, initial(jumpsuit_style))
	uplink_spawn_loc = sanitize_inlist(uplink_spawn_loc, GLOB.uplink_spawn_loc_list, initial(uplink_spawn_loc))
	features["mcolor"]	= sanitize_hexcolor(features["mcolor"], 6, 0)
	features["mcolor2"]	= sanitize_hexcolor(features["mcolor2"], 6, 0)
	features["mcolor3"]	= sanitize_hexcolor(features["mcolor3"], 6, 0)
	features["ethcolor"]	= copytext(features["ethcolor"],1,7)
	features["feature_lizard_legs"]	= sanitize_inlist(features["legs"], GLOB.legs_list, "Normal Legs")
	S["body_markings"] >> body_markings
	body_markings = SANITIZE_LIST(body_markings)
	validate_body_markings()

	var/list/valid_skin_tones = pref_species.get_skin_list()
	var/list/valid_skin_colors = list()
	for(var/skin_tone in pref_species.get_skin_list())
		valid_skin_colors += valid_skin_tones[skin_tone]
	skin_tone = sanitize_inlist(skin_tone, valid_skin_colors, valid_skin_colors[1])

	joblessrole	= sanitize_integer(joblessrole, 1, 3, initial(joblessrole))
	//Validate job prefs
	for(var/j in job_preferences)
		if(job_preferences[j] != JP_LOW && job_preferences[j] != JP_MEDIUM && job_preferences[j] != JP_HIGH)
			job_preferences -= j

	all_quirks = SANITIZE_LIST(all_quirks)

	S["customizer_entries"] >> customizer_entries
	validate_customizer_entries()

	return TRUE

/datum/preferences/proc/save_character()
	if(!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/character[default_slot]"

	WRITE_FILE(S["version"]			, SAVEFILE_VERSION_MAX)	//load_character will sanitize any bad data, so assume up-to-date.)

	//Character
	WRITE_FILE(S["real_name"]			, real_name)
	WRITE_FILE(S["gender"]				, gender)
	WRITE_FILE(S["domhand"]				, domhand)
//	WRITE_FILE(S["alignment"]			, alignment)
	WRITE_FILE(S["age"]					, age)
	WRITE_FILE(S["hair_color"]			, hair_color)
	WRITE_FILE(S["facial_hair_color"]	, facial_hair_color)
	WRITE_FILE(S["eye_color"]			, eye_color)
	WRITE_FILE(S["voice_color"]			, voice_color)
	WRITE_FILE(S["skin_tone"]			, skin_tone)
	WRITE_FILE(S["hairstyle_name"]		, hairstyle)
	WRITE_FILE(S["facial_style_name"]	, facial_hairstyle)
	WRITE_FILE(S["underwear"]			, underwear)
	WRITE_FILE(S["underwear_color"]		, underwear_color)
	WRITE_FILE(S["undershirt"]			, undershirt)
	WRITE_FILE(S["accessory"]			, accessory)
	WRITE_FILE(S["detail"]				, detail)
	WRITE_FILE(S["socks"]				, socks)
	WRITE_FILE(S["backpack"]			, backpack)
	WRITE_FILE(S["jumpsuit_style"]		, jumpsuit_style)
	WRITE_FILE(S["uplink_loc"]			, uplink_spawn_loc)
	WRITE_FILE(S["randomise"]		, randomise)
	WRITE_FILE(S["species"]			, pref_species.name)
	WRITE_FILE(S["charflaw"]			, charflaw.type)
	WRITE_FILE(S["feature_mcolor"]					, features["mcolor"])
	WRITE_FILE(S["feature_mcolor2"]					, features["mcolor2"])
	WRITE_FILE(S["feature_mcolor3"]					, features["mcolor3"])
	WRITE_FILE(S["feature_ethcolor"]					, features["ethcolor"])

	//Custom names
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/savefile_slot_name = custom_name_id + "_name" //TODO remove this
		WRITE_FILE(S[savefile_slot_name],custom_names[custom_name_id])

	WRITE_FILE(S["preferred_ai_core_display"] ,  preferred_ai_core_display)
	WRITE_FILE(S["prefered_security_department"] , prefered_security_department)

	//Jobs
	WRITE_FILE(S["joblessrole"]		, joblessrole)
	//Write prefs
	WRITE_FILE(S["job_preferences"] , job_preferences)

	//Quirks
	WRITE_FILE(S["all_quirks"]			, all_quirks)

	//Patron
	WRITE_FILE(S["selected_patron"]		, selected_patron.type)

	// Organs
	WRITE_FILE(S["customizer_entries"] , customizer_entries)
	// Body markings
	WRITE_FILE(S["body_markings"] , body_markings)
	
	WRITE_FILE(S["update_mutant_colors"] , update_mutant_colors)
	WRITE_FILE(S["headshot_link"] , headshot_link)

	return TRUE


#undef SAVEFILE_VERSION_MAX
#undef SAVEFILE_VERSION_MIN

#ifdef TESTING
//DEBUG
//Some crude tools for testing savefiles
//path is the savefile path
/client/verb/savefile_export(path as text)
	set hidden = TRUE
	var/savefile/S = new /savefile(path)
	S.ExportText("/",file("[path].txt"))
//path is the savefile path
/client/verb/savefile_import(path as text)
	set hidden = TRUE
	var/savefile/S = new /savefile(path)
	S.ImportText("/",file("[path].txt"))

#endif
