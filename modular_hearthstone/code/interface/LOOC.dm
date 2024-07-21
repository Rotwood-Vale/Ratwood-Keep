/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'> Speech is currently admin-disabled.</span>")
		return

	if(!mob)
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	if(!(prefs.chat_toggles & CHAT_OOC))
		to_chat(src, "<span class='danger'> You have OOC muted.</span>")
		return

	if(!holder)
		if(findtext(msg, "byond://"))
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			return


	msg = emoji_parse(msg)

	mob.log_talk(msg, LOG_LOOC)

	var/list/heard = get_hearers_in_view(7, get_top_level_mob(src.mob))
	for(var/mob/M in heard)
		if(!M.client)
			continue
		var/client/C = M.client
		if (C in GLOB.admins)
			continue //they are handled after that

		if (isobserver(M))
			continue //Also handled later.

		if(C.prefs.chat_toggles & CHAT_OOC)
			to_chat(C, "<font color='["#6699CC"]'><b><span class='prefix'>LOOC:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]</span></b></font>")

/mob/proc/get_top_level_mob()
	if(ismob(src.loc) && src.loc != src)
		var/mob/M = src.loc
		return M.get_top_level_mob()
	return src

/proc/get_top_level_mob(mob/S)
	if(ismob(S.loc) && S.loc != S)
		var/mob/M = S.loc
		return M.get_top_level_mob()
	return S
