/datum/job/roguetown/clerk/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Клерк"
		tutorial = "Вы - Клерк. Вы помогаете лорду с его документами и изучаете, как деньги делают город процветающим."
