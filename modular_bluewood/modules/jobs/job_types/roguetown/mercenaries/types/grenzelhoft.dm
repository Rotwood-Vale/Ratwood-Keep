/datum/subclass/grenzelhoft
	allowed_races = RACES_TOLERATED_UP

/datum/subclass/grenzelhoft/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		name = "Наёмник Гильдии Грензелофт"
		tutorial = "Эксперты, профессионалы, дорогие. Это первые слова, которые приходят на ум, когда говорят о Грензелофте - гильдии наемников. \
		Хотя вы можете работать за деньги, как и любой обычный вышибала, поддержание престижа гильдии будет на первом месте."
