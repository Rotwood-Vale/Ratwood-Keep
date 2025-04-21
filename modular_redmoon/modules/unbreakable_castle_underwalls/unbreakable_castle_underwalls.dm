#define CASTLE_NORTH_OUTER_WALLS_Y 403 // НУЖНО ОБСЛУЖИВАТЬ ПРИ ИЗМЕНЕНИИ КАРТЫ! Стена на сервере подземки замка, через которую не должно быть возможно прокопаться
#define CASTLE_SOUTH_OUTER_WALLS_Y_END 360 // НУЖНО ОБСЛУЖИВАТЬ ПРИ ИЗМЕНЕНИИ КАРТЫ! Конец стены на юге подземки замка
#define CASTLE_SOUTH_OUTER_WALLS_Y 358 // НУЖНО ОБСЛУЖИВАТЬ ПРИ ИЗМЕНЕНИИ КАРТЫ! Начало стены на юге подземки замка
#define CASTLE_RIGHT_OUTER_WALLS_X 188 // НУЖНО ОБСЛУЖИВАТЬ ПРИ ИЗМЕНЕНИИ КАРТЫ! Крайняя стена на востоке подземки замка

/turf/closed/mineral/rogue/attackby(obj/item/I, mob/user, params)
	..()
	var/too_hard = FALSE

	if(y >= CASTLE_SOUTH_OUTER_WALLS_Y) // Проверяются только тайлы начала южной стены и выше
		if(is_station_level(z))
			if(y <= CASTLE_SOUTH_OUTER_WALLS_Y_END) // Запрет на выкапывание южной стены
				too_hard = TRUE

			else if(y == CASTLE_NORTH_OUTER_WALLS_Y) // Запрет на выкапывание северной стены
				too_hard = TRUE

			else if(x == CASTLE_RIGHT_OUTER_WALLS_X) // Запрет на выкапывание восочной стены
				too_hard = TRUE

	if(too_hard)
		to_chat(user, span_warning("CASTLE UNDERWALLS ARE TOO HARD TO BE BROKEN!"))
		turf_integrity = max_integrity

// Часть южной стены из камня, а не из породы
/turf/closed/wall/mineral/rogue/attackby(obj/item/I, mob/user, params)
	..()
	if(y >= CASTLE_SOUTH_OUTER_WALLS_Y) // Проверяются только тайлы начала южной стены и выше
		if(is_station_level(z))
			if(y <= CASTLE_SOUTH_OUTER_WALLS_Y_END) // Запрет на выкапывание южной стены
				to_chat(user, span_warning("CASTLE UNDERWALLS ARE TOO HARD TO BE BROKEN!"))
				turf_integrity = max_integrity
