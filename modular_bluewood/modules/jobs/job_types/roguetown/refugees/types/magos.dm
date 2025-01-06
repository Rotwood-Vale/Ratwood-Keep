/datum/subclass/magos/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Магос"
		tutorial = "Обученные в арканной или оккультной магии, вы сбежали от распространения чумы, чтобы продолжить свои исследования."
