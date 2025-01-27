/datum/class_select_handler/proc/ru_class_select_slop()
	SSassets.transport.send_assets(linked_client, list("try4_border.png", "try4.png", "slop_menustyle2.css"))
	var/data = {"
	<!DOCTYPE html> <!-- Add doctype to ensure proper rendering -->
	<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<style>
			@import url('https://fonts.googleapis.com/css2?family=Tangerine:wght@400;700&display=swap');
			@import url('https://fonts.googleapis.com/css2?family=UnifrakturMaguntia&display=swap');
			@import url('https://fonts.googleapis.com/css2?family=Charm&display=swap');
			body {
				background-color: rgb(31, 20, 24);
				background:
					url('[SSassets.transport.get_asset_url("try4_border.png")]'),
					url('[SSassets.transport.get_asset_url("try4.png")]');
				background-repeat: no-repeat;
				background-attachment: fixed;
				background-size: 100% 100%;
			}
		</style>
		<link rel='stylesheet' type='text/css' href='[SSassets.transport.get_asset_url("slop_menustyle2.css")]'>
	</head>
	<body>
		<div id="button_div">
			<span class="title_shit">Class Name:</span>
			<span class="post_title_shit">[cur_picked_class.ru_name]</span><br>
			<span class="title_shit">Description:</span>
			<span class="post_title_shit">[cur_picked_class.ru_tutorial]</span>
		</div>

		<div id='button_div'>
			<a class='class_desc_YES_LINK' href='byond://?src=\ref[src];yes_to_class_select=1;special_class=0;'>This is my background</a><br>
			<a class='bottom_buttons' href='byond://?src=\ref[src];no_to_class_select=1'>I reject this background</a>
		</div>
	</body>
	</html>

	"}

	linked_client << browse(data, "window=class_select_yea;size=610x300;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=0;border=0")
