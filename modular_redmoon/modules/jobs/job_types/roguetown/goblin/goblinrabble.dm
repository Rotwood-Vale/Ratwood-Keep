/datum/job/roguetown/goblinrabble
	ru_title = "Племенной раб"
	ru_f_title = "Племенная рабыня"
	ru_tutorial = "Вы – самый низший из низших. Гоблин или не-гоблин среди многих других гоблинов. \
		О вас нечего особо рассказать, кроме того, что ваш Вождь не смотрит на вас как \
		пригодного для иной службы."
	allowed_races = RACES_ALL_KINDS

	announce_latejoin = FALSE

/obj/effect/landmark/start/goblinrabble // Позволяет спавниться на этих точках гоблинам вместо обычных мест лейтжоина
	jobspawn_override = list("Goblin Chief", "Goblin Shaman", "Goblin Rabble", "Goblin Smith", "Goblin Guard", "Goblin Cook")
