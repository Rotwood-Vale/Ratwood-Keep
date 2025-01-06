/datum/job/roguetown/tester/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Тестер"
		tutorial = "Вы - Тестер. Ваша цель - уничтожить всех, кто вам не нравится."
