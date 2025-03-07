/mob/living/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	if(has_status_effect(/datum/status_effect/buff/fortify) && amount < 0)
		amount *= 1.5
	. = ..()

/mob/living/heal_wounds(heal_amount)
	if(has_status_effect(/datum/status_effect/buff/fortify))
		heal_amount *= 1.5
	. = ..()

