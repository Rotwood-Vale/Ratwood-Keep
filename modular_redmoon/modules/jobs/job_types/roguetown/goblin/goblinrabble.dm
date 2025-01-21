/datum/job/roguetown/goblinrabble
	ru_title = "Раб Племени"
	ru_tutorial = "Вы - самый низкий из низких. Гоблин среди многих других гоблинов. \
		Вам нечего сказать о себе, кроме того, что ваш Главный считает вас непригодным для службы."
	allowed_races = RACES_ALL_KINDS

	announce_latejoin = FALSE

/obj/effect/landmark/start/goblinrabble // Позволяет спавниться на этих точках гоблинам вместо обычных мест лейтжоина
	jobspawn_override = list("Goblin Chief", "Goblin Shaman", "Goblin Rabble", "Goblin Smith", "Goblin Guard", "Goblin Cook")
