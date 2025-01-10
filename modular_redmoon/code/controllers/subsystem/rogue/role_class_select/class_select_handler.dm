/datum/class_select_handler/proc/ru_class_select_slop()

	var/data = {"
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<html>
		<head>
			<style>
				@import url('https://fonts.googleapis.com/css2?family=VT323&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Jacquarda+Bastarda+9&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Silkscreen:wght@400;700&display=swap');
			</style>
			<link rel='stylesheet' type='text/css' href='slop_menustyle2.css'>
		</head>
		<body>
			<div id="top_bloc">
				<span class="title_shit">Название Класса:</span> <span class="post_title_shit">[cur_picked_class.ru_name]</span><br>
				<span class="title_shit">Описание Класса:</span> <span class="post_title_shit">[cur_picked_class.ru_tutorial]</span>
			</div>
				<div id='button_div'>
					<a class='class_desc_YES_LINK' href='?src=\ref[src];yes_to_class_select=1;special_class=0;'>Это моя предыстория</a><br>
					<a class='bottom_buttons' href='?src=\ref[src];no_to_class_select=1'>Это не моя предыстория</a>
				</div>
			</div>
		</body>
	</html>
	"}

	linked_client << browse(data, "window=class_select_yea;size=610x300;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1")
