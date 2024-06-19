// player table for the html menus
/datum/controller/subsystem/role_class_handler/proc/rebuild_drifter_html_table()
	if(!drifter_wave_FULLY_entered_clients.len)
		drifter_queue_player_tbl_string = "<tr></tr>"
		return

	var/data
	// Wave entrants
	var/on_playa_num = 1
	var/total_rows = ceil(drifter_wave_FULLY_entered_clients.len/2)
	var/row_cellcount = 2
	if(drifter_wave_FULLY_entered_clients.len < 2)
		row_cellcount = 1
	for(var/i in 1 to total_rows)
		data += "<tr>"

		for(var/ii in 1 to row_cellcount)
			var/client/C = drifter_wave_FULLY_entered_clients[on_playa_num]
			data += "<td>[C.prefs.real_name]</td>"
			on_playa_num++
			if(on_playa_num > drifter_wave_FULLY_entered_clients.len)
				break

		data += "</tr>"


	// One building of the motherfuckin table per iteration
	drifter_queue_player_tbl_string = data

// Time string for the html menus
/datum/controller/subsystem/role_class_handler/proc/rebuild_drifter_time_string()
	if(!drifter_queue_enabled)
		time_left_until_next_wave_string = "DISABLED"
		return

	if(drifter_queue_delayed)
		time_left_until_next_wave_string = "DELAYED"
		return

	var/time_left = max(0, next_drifter_mass_release_time - world.time)
	var/seconds = round(time_left/10)
	var/minutes = round(seconds/60)

	if(minutes)
		seconds = seconds-minutes*60
	if(10 > seconds)
		seconds = "0[seconds]"
	if(10 > minutes)
		minutes = "0[minutes]"
	time_left_until_next_wave_string = "[minutes]:[seconds]"

