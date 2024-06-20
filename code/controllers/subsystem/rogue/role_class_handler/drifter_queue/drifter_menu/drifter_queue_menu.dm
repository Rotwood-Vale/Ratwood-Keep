/*
	Well, we were on the preferences menu, but now we are on our own datum yet again
*/
/datum/drifter_queue_menu
	var/client/linked_client

/datum/drifter_queue_menu/proc/first_show_drifter_queue_menu()
	var/datum/asset/thicc_assets = get_asset_datum(/datum/asset/simple/blackedstone_drifter_queue_menu_slop_layout)
	thicc_assets.send(linked_client)
	show_drifter_queue_menu()

/datum/drifter_queue_menu/proc/show_drifter_queue_menu()
	if(!linked_client)
		return
	//Opening tags and empty head
	var/data = {"
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<html>
		<head>
			<style>
			</style>
			<link rel='stylesheet' type='text/css' href='slop_menustyle4.css'>
			
		</head>
	"}
	//<script type='text/javascript' src='slop_scriptstyle4.js'></script>
	//Body tag start
	data += "<body>"
	data += "<table class='timer_table'><tr><td class='timer_fluff'>Time to next excursion:</td><td class='timer_time' id='queue_timer'>[SSrole_class_handler.time_left_until_next_wave_string]</td></tr></table>"
	data += "<div class='queue_buttan'>"
	if(linked_client in SSrole_class_handler.drifter_queue_joined_clients)
		data += "<a class='leave_drifter_queue'href='?src=\ref[src];leave_queue=1'>LEAVE QUEUE</a>"
	else
		data += "<a class='join_drifter_queue'href='?src=\ref[src];join_queue=1'>ENTER QUEUE</a>"
	data += "</div>"
	data += "<br>"
	data += "<div class='table_fluff_container'><span class='table_fluff_text'>Forecast:</span><span class='table_fluff_fadeout_line'></span></div><br>"
	/*
		I have decided to just display the current and the next wave
		Three would mean people would get too much heads up information and be more likely to afk than normal
	*/

	data += "<table class='wave_container'>"

	
	if(SSrole_class_handler.drifter_wave_schedule.len)
		// Amount of iterations
		var/current_iteration = 0
		// Amount of waves to display
		var/max_to_display = 2
		for(var/i = SSrole_class_handler.current_wave_number, SSrole_class_handler.drifter_wave_schedule.len >= i, i++)
			var/datum/drifter_wave/cur_datum = SSrole_class_handler.drifter_wave_schedule[i]
			current_iteration++

			data += "<tr class='wave_row'>"
			switch(current_iteration)
				if(1)
					//data += "<td class='wave_entry_href'>"
					//data += "</td>"
					data += "<td class='wave_number'>NOW: </td>"
				if(2)
					data += "<td class='wave_number'>NEXT: </td>"
				else
					data += "<td class='wave_number'>[i]: </td>"

			data += "<td class='wave_type'><a class='wave_type_hlink' href='?src=\ref[src];'>[cur_datum.wave_type_name]<span class='wave_type_hlink_tooltext'>[cur_datum.wave_type_tooltip]</span></a></td>"
			if(current_iteration == 1)
				data += "<td><span id='current_count'>[SSrole_class_handler.drifter_wave_FULLY_entered_clients.len]</span>/[cur_datum.maximum_playercount]</td>"
			else
				data += "<td>0/[cur_datum.maximum_playercount]</td>"
			data += "</tr>"

			if(current_iteration >= max_to_display)
				break
	
	data += "</table>"
	data += "<hr class='fadeout_line'>"

	data += "<table class='player_table' id='player_table'>"
	data += "[SSrole_class_handler.drifter_queue_player_tbl_string]"
	data += "</table>"

	// Script chunk as this will insure something doesn't happen due to the fact we are reloading the menu repeatedly
	data += {"
		<script>
			function update_timer(new_time) {
				document.getElementById('queue_timer').innerHTML = new_time; 
			}

			function update_playersegments(new_count, list) {
				document.getElementById('current_count').innerHTML = new_count;
				document.getElementById('player_table').innerHTML = list;
			}
		</script>
	"}
	//Closing Tags
	data += {"
		</body>
	</html>
	"}

	linked_client << browse(data, "window=drifter_queue;size=400x430;can_close=1;can_minimize=0;can_maximize=0;can_resize=1;titlebar=1")
	// We setup the href_list "close" call if they hit the x on the top right
	for(var/i in 1 to 10)
		if(!linked_client)
			break
		if(winexists(linked_client, "drifter_queue"))
			winset(linked_client, "drifter_queue", "on-close=\".windowclose [REF(src)]\"")
			break

/datum/drifter_queue_menu/proc/ForceCloseMenus()
	if(linked_client)
		linked_client << browse(null, "window=drifter_queue")

/datum/drifter_queue_menu/Topic(href, list/href_list)
	. = ..()
	if(href_list["join_queue"])
		//if(!SSrole_class_handler.drifter_queue_delayed)
		SSrole_class_handler.attempt_to_add_client_to_drifter_queue(linked_client)
		show_drifter_queue_menu()

	if(href_list["leave_queue"])
		SSrole_class_handler.remove_client_from_drifter_queue(linked_client)
		show_drifter_queue_menu()

	if(href_list["close"])
		SSrole_class_handler.cleanup_drifter_queue(linked_client)
		return
