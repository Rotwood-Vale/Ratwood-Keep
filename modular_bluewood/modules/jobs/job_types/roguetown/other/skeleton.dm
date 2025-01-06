/datum/job/roguetown/skeleton/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Скелет"
		tutorial = "Вы - Скелет. Ваша цель - уничтожить всех, кто вам не нравится."
