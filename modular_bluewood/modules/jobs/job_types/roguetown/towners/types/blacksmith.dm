/datum/subclass/blacksmith/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		name = "Кузнец"
		tutorial = "Вы мастер кузнечного дела без кузницы, способный изготавливать достойные оружия для воинов. Вам ещё предстоит о себе заявить."
	