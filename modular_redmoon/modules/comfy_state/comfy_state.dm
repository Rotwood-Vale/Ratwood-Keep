// Связанное искать через "comfy_state"

/mob/living/carbon/human
	var/insanelycomfy = FALSE // Если персонаж стоит 3 минуты на одном месте, у него не снижается голод и жажда

/datum/status_effect/buff/comfy
	id = "comfy"
	alert_type = /atom/movable/screen/alert/status_effect/buff/comfy
	duration = 99999

/atom/movable/screen/alert/status_effect/buff/comfy
	name = "Комфортно"
	desc = "Жажда, голод и порок не будут мучать меня до тех пор, пока я остаюсь на одном месте."
	icon_state = "stressg"
