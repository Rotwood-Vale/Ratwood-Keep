/datum/subclass/seamstress/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		name = "Швея"
		tutorial = "Вы швея, вы умеете шить одежду и коврики. \
		Присоединяйтесь к местной швее или создайте свою маленькую швейную мастерскую."
	