GLOBAL_LIST_EMPTY(bunker_bypasses)

/client/proc/bunker_bypass()
	set category = "GameMaster"
	set name = "Add Bunker Bypass"

	var/selection = input("Who would you like to let in?", "CKEY", "") as text|null
	if(selection)
		add_bunker_bypass(selection, ckey)

/proc/add_bunker_bypass(target_ckey, admin_ckey = "SYSTEM")
	if(!target_ckey)
		return

	target_ckey = ckey(target_ckey)
	GLOB.bunker_bypasses |= target_ckey
	message_admins("BUNKER BYPASS: Added [target_ckey] to the bypass list[admin_ckey? " by [admin_ckey]":""]")
	log_admin("BUNKER BYPASS: Added [target_ckey] to the bypass list[admin_ckey? " by [admin_ckey]":""]")

