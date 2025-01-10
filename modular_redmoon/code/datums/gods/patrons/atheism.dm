/datum/patron
	var/ru_name
	var/ru_domain
	var/ru_desc
	var/ru_worshippers
	var/ru_confess_lines

/datum/patron/godless
		ru_name = "Безбожник"
		ru_desc = "Нет ни богов, ни королей, только люди! Боги существуют, но вы показываете на них пальцем и смеётесь, называя это фокусом."
		ru_worshippers = "Безбожники, звери и некоторые гномы"	
		ru_confess_lines = list(
		"Боги - бесценны!",
		"Я НЕ НУЖЕН БОГАМ!",
		"Я САМ МОЙ БОГ!",
		"НЕТ БОГОВ, НЕТ КОРОЛЕЙ, ТОЛЬКО ЛЮДИ!",
		)
