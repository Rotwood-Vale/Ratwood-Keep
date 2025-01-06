/datum/job/roguetown/cook/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Повар"
		tutorial = "Работая вместе с барменом, который владеет Skull Crack Inn, повар должен уделять больше внимания приготовлению пищи для всех голодных ртов города."
