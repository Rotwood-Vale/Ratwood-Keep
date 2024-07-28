/datum/role_bans
	var/list/bans = list()

/proc/get_role_bans_for_ckey(passed_ckey)
	passed_ckey = ckey(passed_ckey)
	if(!GLOB.ckey_role_bans[passed_ckey])
		load_role_bans_for_ckey(passed_ckey)
	return GLOB.ckey_role_bans[passed_ckey]

/proc/load_role_bans_for_ckey(passed_ckey)
	if(GLOB.ckey_role_bans[passed_ckey])
		return
	
	return

/proc/is_role_banned(passed_ckey, role_name)
	return

/proc/is_migrant_banned(passed_ckey, migrant_name)
	return

/proc/is_advclass_banned(passed_ckey, advclass_name)
	return

/proc/is_antag_banned(passed_ckey, antag_name)
	return

/proc/is_misc_banned(passed_ckey, misc_name)
	return
