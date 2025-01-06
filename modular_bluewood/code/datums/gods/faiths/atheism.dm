/datum/faith/godless/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		name = "Атеизм"
		desc = "Хотя боги, конечно, существуют в этом мире, вы не склоняетесь к ним! Вы абсолютно безбожны."
		worshippers = "Безумные, звери и некоторые гномы"

