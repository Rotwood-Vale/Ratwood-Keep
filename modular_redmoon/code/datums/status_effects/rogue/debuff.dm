///////////////////////////

/datum/status_effect/debuff/hungryt1
	id = "hungryt1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt1
	effectedstats = list(STATKEY_SPD = -1, STATKEY_STR = -1, STATKEY_CON = -1, STATKEY_END = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt1
	name = "Peckish, stomach growling"
	desc = "<span class='warning'>I am getting hungry.</span>\n"
	icon_state = "hunger1"

/datum/status_effect/debuff/hungryt1/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/peckish)

/datum/status_effect/debuff/hungryt1/refresh()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/peckish)

/datum/status_effect/debuff/hungryt1/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/peckish)

/datum/status_effect/debuff/hungryt2
	id = "hungryt2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt2
	effectedstats = list(STATKEY_SPD = -4, STATKEY_STR = -2, STATKEY_CON = -2, STATKEY_END = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt2
	name = "Hungry, need food"
	desc = "<span class='warning'>My stomach hurts, I need food.</span>\n"
	icon_state = "hunger2"

/datum/status_effect/debuff/hungryt2/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/hungry)

/datum/status_effect/debuff/hungryt2/refresh()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/hungry)

/datum/status_effect/debuff/hungryt2/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/hungry)

/datum/status_effect/debuff/hungryt3
	id = "hungryt3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt3
	effectedstats = list(STATKEY_SPD = -6, STATKEY_STR = -6, STATKEY_CON = -6, STATKEY_END = -6)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt3
	name = "STARVING"
	desc = "<span class='boldwarning'>I AM STARVING!</span>\n"
	icon_state = "hunger3"

/datum/status_effect/debuff/hungryt3/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/starving)

/datum/status_effect/debuff/hungryt3/refresh()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/starving)

/datum/status_effect/debuff/hungryt3/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/starving)

///////////////////////////

/datum/status_effect/debuff/thirstyt1
	id = "thirsty1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt1
	effectedstats = list(STATKEY_END = -1, STATKEY_SPD = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt1
	name = "Getting thirsty"
	desc = "<span class='warning'>I could use a drink.</span>\n"
	icon_state = "thirst1"


/datum/status_effect/debuff/thirstyt1/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/drym)

/datum/status_effect/debuff/thirstyt1/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/drym)

/datum/status_effect/debuff/thirstyt2
	id = "thirsty2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt2
	effectedstats = list(STATKEY_SPD = -4, STATKEY_END = -4)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt2
	name = "Extremly thirsty"
	desc = "<span class='warning'>If I don't drink something soon, my mouth will be sand.</span>\n"
	icon_state = "thirst2"

/datum/status_effect/debuff/thirstyt2/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/thirst)

/datum/status_effect/debuff/thirstyt2/refresh()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/thirst)

/datum/status_effect/debuff/thirstyt2/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/thirst)

/datum/status_effect/debuff/thirstyt3
	id = "thirsty3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt3
	effectedstats = list(STATKEY_STR = -6, STATKEY_SPD = -6, STATKEY_END = -6)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt3
	name = "Extreme Dehydration"
	desc = "<span class='boldwarning'>I AM DYING OF THIRST!</span>\n"
	icon_state = "thirst3"

/datum/status_effect/debuff/thirstyt3/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/parched)

/datum/status_effect/debuff/thirstyt3/refresh()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/parched)

/datum/status_effect/debuff/thirstyt3/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/parched)

/////////

/datum/status_effect/debuff/uncookedfood
	id = "uncookedfood"
	effectedstats = null
	duration = 10 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/debuff/uncookedfood

/atom/movable/screen/alert/status_effect/debuff/uncookedfood
	name = "Raw Food!"
	desc = "<span class='warning'>Augh! Why didn't I bring that food to fire?!</span>\n"
	icon_state = "uncookedfood"

/datum/status_effect/debuff/uncookedfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER) || HAS_TRAIT(owner, TRAIT_ORGAN_EATER))
		return FALSE
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
		C.add_stress(/datum/stressevent/uncookedfood)

/////////

/datum/status_effect/debuff/badmeal
	alert_type = /atom/movable/screen/alert/status_effect/debuff/badmeal
	id = "badmeal"
	effectedstats = null
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/debuff/badmeal
	name = "Foul Food!"
	desc = "<span class='warning'>That tasted vile!</span>\n"
	icon_state = "badmeal"

/datum/status_effect/debuff/badmeal/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/badmeal)

/////////

/datum/status_effect/debuff/burnedfood
	alert_type = /atom/movable/screen/alert/status_effect/debuff/burntmeal
	id = "burnedfood"
	effectedstats = null
	duration = 10 MINUTES

/datum/status_effect/debuff/burnedfood/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/burntmeal)
		C.add_nausea(100)

/atom/movable/screen/alert/status_effect/debuff/burntmeal
	name = "Burnt Food!"
	desc = "<span class='warning'>That tasted like charcoal and cinder!</span>\n"
	icon_state = "burntmeal"

/////////

/datum/status_effect/debuff/rotfood
	alert_type = /atom/movable/screen/alert/status_effect/debuff/rotfood
	id = "rotfood"
	effectedstats = null
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/debuff/rotfood
	name = "Rotten Food!"
	desc = "<span class='warning'>MAGGOT-INFESTED BILE RISES TO MY THROAT!</span>\n"
	icon_state = "burntmeal"

/datum/status_effect/debuff/rotfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_ROT_EATER))
		return FALSE
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(200)
		C.add_stress(/datum/stressevent/rotfood)

/////////

/atom/movable/screen/alert/status_effect/debuff/sleepytime
	name = "Tired"
	desc = "<span class='warning'>I am feeling tired.</span>\n"
	icon_state = "sleepy"

/datum/status_effect/debuff/sleepytime
	id = "sleepytime"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/sleepytime
	effectedstats = list(STATKEY_SPD = -2, STATKEY_END = -2)

/datum/status_effect/debuff/sleepytime/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/sleepytime)

/datum/status_effect/debuff/sleepytime/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/sleepytime)
