/// Фикс для статов и навыков после смерти. Связанный код искать по "after_death_stats_fix"

/mob/living
	var/ROUNDSTART_STASTR = 10 // Статы, которые даются в начале раунда (расу, возраст, пол, проклятия, проказа, профессию, +-1 рандом)
	var/ROUNDSTART_STAPER = 10
	var/ROUNDSTART_STAINT = 10
	var/ROUNDSTART_STACON = 10
	var/ROUNDSTART_STAEND = 10
	var/ROUNDSTART_STASPD = 10
	var/ROUNDSTART_STALUC = 10

// У Зомби для навыков используется текущий Mind.
// Если игрок с mind не уходит в преисподнюю, генеря новый mind, то его навыки удаляются. Говнокод в плане статов.
// Чтобы избваиться от этих списков,
// я не придумал ничего лучше, кроме как полностью переписывать поиск зомби в коде (что нужно делать на основу).
/datum/mind
	var/list/backup_known_skills = list() 
	var/list/backup_skill_experience = list()

/mob/living/proc/save_stats_as_roundstarted()
	ROUNDSTART_STASTR = STASTR
	ROUNDSTART_STAPER = STAPER
	ROUNDSTART_STAINT = STAINT
	ROUNDSTART_STACON = STACON
	ROUNDSTART_STAEND = STAEND
	ROUNDSTART_STASPD = STASPD
	ROUNDSTART_STALUC = STALUC

	BUFSTR = 0
	BUFPER = 0
	BUFINT = 0
	BUFCON = 0
	BUFEND = 0
	BUFSPE = 0
	BUFLUC = 0

	statindex = list()
	recalculate_stats()

// Использовать следует только там, где есть риск появления дополнительных отрицательных буферов. Например, при выборе класса в начале раунда
/mob/living/proc/save_stats_as_roundstarted_with_buffers()
	ROUNDSTART_STASTR = STASTR
	if(BUFSTR < 0)
		ROUNDSTART_STASTR += abs(BUFSTR)

	ROUNDSTART_STAPER = STAPER
	if(BUFPER < 0)
		ROUNDSTART_STAPER += abs(BUFPER)

	ROUNDSTART_STAINT = STAINT
	if(BUFINT < 0)
		ROUNDSTART_STAINT += abs(BUFINT)

	ROUNDSTART_STACON = STACON
	if(BUFCON < 0)
		ROUNDSTART_STACON += abs(BUFCON)

	ROUNDSTART_STAEND = STAEND
	if(BUFEND < 0)
		ROUNDSTART_STAEND += abs(BUFEND)

	ROUNDSTART_STASPD = STASPD
	if(BUFSPE < 0)
		ROUNDSTART_STASPD += abs(BUFSPE)

	ROUNDSTART_STALUC = STALUC
	if(BUFLUC < 0)
		ROUNDSTART_STALUC += abs(BUFLUC)

	BUFSTR = 0
	BUFPER = 0
	BUFINT = 0
	BUFCON = 0
	BUFEND = 0
	BUFSPE = 0
	BUFLUC = 0

	statindex = list()
	recalculate_stats()

/// Проклятое. Написано так, чтобы не нужно было переписывать код change_stat. 
/// Нужно добавлять везде, где фигурирует изменение раундстартовых статов (в т.ч. воскрешение, иначе учитываются значения дебафов, которые были ПРИ смерти и ПОСЛЕ смерти)
/mob/living/proc/recalculate_stats()
	for(var/stat in MOBSTATS)
		change_stat(stat, 1)
		change_stat(stat, -1)
