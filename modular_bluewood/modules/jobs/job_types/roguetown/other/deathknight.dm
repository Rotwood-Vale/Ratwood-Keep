/datum/job/roguetown/deathknight/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Рыцарь Смерти"
		tutorial = "Вы - Рыцарь Смерти. Ваша цель - уничтожить всех, кто вам не нравится."
