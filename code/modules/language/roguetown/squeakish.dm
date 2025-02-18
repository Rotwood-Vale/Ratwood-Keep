/datum/language/squeakish
	name = "Squeakish"
	desc = "Squeakish, is the chittering and hasty language of the Skaven. Skaven dialogue is often littered with a hodgepodge of rapid squeaks and trills. Squeakish words are short, clipped, and often repeated several times in a row in an effort to add emphasis to statements. Due to the speed with which Squeakish is spoken, long sentences are often broken up into several fragments."
	speech_verb = "squeaks"
	ask_verb = "trills"
	exclaim_verb = "chitters"
	key = "r"
	flags = LANGUAGE_HIDE_ICON_IF_UNDERSTOOD | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 80
	default_priority = 90
	icon_state = "asse"
	spans = list(SPAN_SQUEAKISH)
	syllables = list(
	    "ti","ti","ti-ti","hi","hi","ki","ki","ki","ki","ya-ya","ta","hi-hi","ka","ya","yi","chi","chi-chi","ka"
		,"KI","KI-KI","KRI-KRI","III","EEE","KI","II","KRI","KA","sqi-sqi","sqi","mr"
	)
