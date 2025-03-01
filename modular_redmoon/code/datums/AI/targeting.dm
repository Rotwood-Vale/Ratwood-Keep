/datum/ai_controller
	var/mob/living/ordered_to_attack = null // Моб, которого приказано атаковать через управление миньонами

/datum/ai_controller/Destroy(force, ...)
	ordered_to_attack = null
	. = ..()
