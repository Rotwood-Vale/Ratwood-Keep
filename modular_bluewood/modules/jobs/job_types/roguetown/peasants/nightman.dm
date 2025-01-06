/datum/job/roguetown/nightman/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Ночной Мастер"
		f_title = "Ночная Матрона"
		tutorial = "Падший дворянин и владелец Whitevein Lounge, вы управляете запущенным бассейном, превращенным в место, где живут нелюди, которых другие не любят терпеть."

