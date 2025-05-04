/datum/objective/bandit
	name = "Бандит"
	explanation_text = "Жертвуй награбленное добро идолу."
	flavor = "Цель"

/datum/objective/bandit/update_explanation_text()
	..()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C)
			explanation_text = "Пожертвуй награбленного добра на сумму [C.banditgoal] маммон, дабы Маттиос тебя благословил."
		else
			explanation_text = "Молись ЗИЗО."

/datum/objective/delf
	name = "delf"
	explanation_text = "Скармливай мёд матери."

/datum/objective/delf/check_completion()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C.delfcontrib >= C.delfgoal)
			return TRUE

/datum/objective/delf/update_explanation_text()
	..()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C)
			explanation_text = "Скорми [C.delfgoal] мёда матери."
		else
			explanation_text = "Молись ЗИЗО."

/datum/objective/werewolf
	name = "Покорить"
	explanation_text = "Покончите с угрозой вампиров и покорите Рокхилл."
	flavor = "Цель"
	team_explanation_text = "Вампиры и оборотни кровные враги, не способные выносить друг друга и ведущие древнюю войну на истребление. Кто же победит в этой схватке за право покорить Рокхилл?"
	triumph_count = 5

/datum/objective/werewolf/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "werewolf")
			return TRUE

/datum/objective/vampire
	name = "Покорить"
	explanation_text = "Покончите с угрозой оборотней и покорите Рокхилл."
	flavor = "Цель"
	team_explanation_text = "Вампиры и оборотни кровные враги, не способные выносить друг друга и ведущие древнюю войну на истребление. Кто же победит в этой схватке за право покорить Рокхилл?"
	triumph_count = 5

/datum/objective/vampire/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "vampire")
			return TRUE

/datum/objective/maniac
	name = "ПРОСНИСЬ"
	explanation_text = "СЛЕДОВАТЬ зову моего СЕРДЦА - МОЙ единственный ШАНС."
	flavor = "Сон"
