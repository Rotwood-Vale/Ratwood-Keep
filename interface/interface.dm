//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki(query as text)
	set name = "wiki"
	set desc = ""
	set category = "OOC"
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl)
		if(query)
			var/output = wikiurl + "/index.php?title=Special%3ASearch&profile=default&search=" + query
			src << link(output)
		else if (query != null)
			src << link(wikiurl)
	else
		to_chat(src, span_danger("The wiki URL is not set in the server configuration."))
	return

/client/verb/discord()
	set name = "discord"
	set desc = ""
	set category = "OOC"
	var/discordurl = CONFIG_GET(string/discordurl)
	if(discordurl)
		if(alert("This will open the discord. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(discordurl)
	else
		to_chat(src, span_danger("The forum URL is not set in the server configuration."))
	return

/client/verb/rules()
	set name = "rules"
	set desc = ""
	set category = "OOC"
	var/rulesurl = CONFIG_GET(string/rulesurl)
	if(rulesurl)
		if(alert("This will open the rules in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(rulesurl)
	else
		to_chat(src, span_danger("The rules URL is not set in the server configuration."))
	return

/client/verb/github()
	set name = "github"
	set desc = ""
	set category = "OOC"
	var/githuburl = CONFIG_GET(string/githuburl)
	if(githuburl)
		if(alert("This will open the Github repository in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(githuburl)
	else
		to_chat(src, span_danger("The Github URL is not set in the server configuration."))
	return

/client/verb/mentorhelp()
	set name = "Mentorhelp"
	set desc = ""
	set category = "Admin"
	if(mob)
		var/msg = input("Say your meditation:", "Voices in your head") as text|null
		if(msg)
			mob.schizohelp(msg)
	else
		to_chat(src, span_danger("You can't currently use Mentorhelp in the main menu."))

/client/verb/reportissue()
	set name = "report-issue"
	set desc = ""
	set category = "OOC"
	var/githuburl = CONFIG_GET(string/githuburl)
	if(githuburl)
		var/message = "This will open the Github issue reporter in your browser. Are you sure?"
		if(GLOB.revdata.testmerge.len)
			message += "<br>The following experimental changes are active and are probably the cause of any new or sudden issues you may experience. If possible, please try to find a specific thread for your issue instead of posting to the general issue tracker:<br>"
			message += GLOB.revdata.GetTestMergeInfo(FALSE)
		if(tgalert(src, message, "Report Issue","Yes","No")!="Yes")
			return
		var/static/issue_template = file2text(".github/ISSUE_TEMPLATE.md")
		var/servername = CONFIG_GET(string/servername)
		var/url_params = "Reporting client version: [byond_version].[byond_build]\n\n[issue_template]"
		if(GLOB.round_id || servername)
			url_params = "Issue reported from [GLOB.round_id ? " Round ID: [GLOB.round_id][servername ? " ([servername])" : ""]" : servername]\n\n[url_params]"
		DIRECT_OUTPUT(src, link("[githuburl]/issues/new?body=[url_encode(url_params)]"))
	else
		to_chat(src, span_danger("The Github URL is not set in the server configuration."))
	return

/client/verb/check_role_bans()
	set name = "Check Role Bans"
	set desc = ""
	set category = "OOC"
	
	var/datum/role_bans/bans = get_role_bans_for_ckey(ckey)
	var/list/dat = list()
	for(var/datum/role_ban_instance/instance as anything in bans.bans)
		if(!instance.permanent && world.realtime >= instance.apply_date + instance.duration)
			dat += "<b>EXPIRED</b><BR>"
		dat += instance.get_ban_string_list().Join("<BR>")
		dat += "<HR>"
	var/datum/browser/popup = new(usr, "check_role_bans", "Role Bans", 550, 500)
	popup.set_content(dat.Join())
	popup.open()

/client/verb/changelog()
	set name = "Changelog"
	set category = "OOC"
	set hidden = 1
//	var/datum/asset/changelog = get_asset_datum(/datum/asset/simple/changelog)
//	changelog.send(src)
	src << browse('html/changelog.html', "window=changes;size=675x650")
	if(prefs.lastchangelog != GLOB.changelog_hash)
		prefs.lastchangelog = GLOB.changelog_hash
		prefs.save_preferences()
		winset(src, "infowindow.changelog", "font-style=;")

/client/verb/hotkeys_help()
	set name = "_Help-Controls"
	set category = "OOC"
	mob.hotkey_help()


/mob/proc/hotkey_help()
	var/hotkey_mode = {"<font color='purple'>
Hotkey-Mode: (hotkey-mode must be on)
\tTAB = toggle hotkey-mode
\tw = north
\ta = west
\ts = south
\td = east
\tq = left hand
\te = right hand
\tr = throw
\tf = fixed eye (strafing mode)
\tSHIFT + f = look up
\tz = drop
\tx = cancel / resist grab
\tc = parry/dodge
\tv = stand up / lay down
\t1 thru 4 = change intent (current hand)
\tmouse wheel = change aim height
\tg = give
\t<B></B>h = bite
\tj = jump
\tk = kick
\tl = steal
\tt = say something
\tALT = sprint
\tCTRL + ALT = sneak
\tLMB = Use intent/Interact (Hold to channel)
\tRMB = Special Interaction
\tMMB = give/kick/jump/steal/spell
\tMMB (no intent) = Special Interaction
\tSHIFT + LMB = Examine something
\tSHIFT + RMB = Focus
\tCTRL + LMB = TileAtomList
\tCTRL + RMB = Point at something
</font>"}

	to_chat(src, hotkey_mode)

/client/verb/set_fixed()
	set name = "IconSize"
	set category = "Options"

	if(winget(src, "mapwindow.map", "icon-size") == "64")
		to_chat(src, "Stretch-to-fit... OK")
		winset(src, "mapwindow.map", "icon-size=0")
	else
		to_chat(src, "64x... OK")
		winset(src, "mapwindow.map", "icon-size=64")

/client/verb/set_stretch()
	set name = "IconScaling"
	set category = "Options"
	if(prefs)
		if(prefs.crt == TRUE)
			to_chat(src, "CRT mode is on.")
			winset(src, "mapwindow.map", "zoom-mode=blur")
			return
	if(winget(src, "mapwindow.map", "zoom-mode") == "normal")
		to_chat(src, "Pixel-perfect... OK")
		winset(src, "mapwindow.map", "zoom-mode=distort")
	else
		to_chat(src, "Anti-aliased... OK")
		winset(src, "mapwindow.map", "zoom-mode=normal")

/client/verb/crtmode()
	set category = "Options"
	set name = "ToggleCRT"
	if(!prefs)
		return
	if(prefs.crt == TRUE)
		winset(src, "mapwindow.map", "zoom-mode=normal")
		prefs.crt = FALSE
		prefs.save_preferences()
		to_chat(src, "CRT... OFF")
		for(var/atom/movable/screen/scannies/S in screen)
			S.alpha = 0
	else
		winset(src, "mapwindow.map", "zoom-mode=blur")
		prefs.crt = TRUE
		prefs.save_preferences()
		to_chat(src, "CRT... ON")
		for(var/atom/movable/screen/scannies/S in screen)
			S.alpha = 70

/client/verb/triggercommend()
	set category = "OOC"
	set name = "Commend Someone"
	commendsomeone()

/client/verb/changefps()
	set category = "Options"
	set name = "ChangeFPS"
	if(!prefs)
		return
	var/newfps = input(usr, "Enter new FPS", "New FPS", 100) as null|num
	if (!isnull(newfps))
		prefs.clientfps = clamp(newfps, 1, 1000)
		fps = prefs.clientfps
		prefs.save_preferences()

/*
/client/verb/set_blur()
	set name = "AAOn"
	set category = "Options"

	winset(src, "mapwindow.map", "zoom-mode=blur")

/client/verb/set_normal()
	set name = "AAOff"
	set category = "Options"

	winset(src, "mapwindow.map", "zoom-mode=normal")*/
