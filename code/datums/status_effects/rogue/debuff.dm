/datum/status_effect/debuff
	status_type = STATUS_EFFECT_REFRESH

///////////////////////////

/datum/status_effect/debuff/hungryt1
	id = "hungryt1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt1
	effectedstats = list("constitution" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt1
	name = "Hungry"
	desc = "Hunger weakens this living body."
	icon_state = "hunger1"

/datum/status_effect/debuff/hungryt2
	id = "hungryt2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt2
	effectedstats = list("strength" = -2, "constitution" = -2, "endurance" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt2
	name = "Hungry"
	desc = "This living body suffers heavily from hunger."
	icon_state = "hunger2"

/datum/status_effect/debuff/hungryt3
	id = "hungryt3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt3
	effectedstats = list("strength" = -5, "constitution" = -3, "endurance" = -2)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt3
	name = "Hungry"
	desc = "My body can barely hold it!"
	icon_state = "hunger3"

//ARMOR WEARING STRAIN

/datum/status_effect/debuff/armorfail
	id = "armorfail1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/mediumfail
	effectedstats = list("strength" = -3, "constitution" = -2, "endurance" = -2, "speed" = -4)

/atom/movable/screen/alert/status_effect/debuff/mediumfail
	name = "Armor Strain"
	desc = "This armor is too heavy to move in.. I have no training in this!"
	icon_state = "muscles"		//Placeholder

//SILVER DAGGER EFFECT

/datum/status_effect/debuff/silver_curse
	id = "silver_curse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/silver_curse
	duration = 5 SECONDS

/atom/movable/screen/alert/status_effect/debuff/silver_curse
	name = "Silver Curse"
	desc = "My BANE!"
	icon_state = "hunger3"	

////////////////////


/datum/status_effect/debuff/thirstyt1
	id = "thirsty1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt1
	effectedstats = list("endurance" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt1
	name = "Thirsty"
	desc = "I need water."
	icon_state = "thirst1"

/datum/status_effect/debuff/thirstyt2
	id = "thirsty2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt2
	effectedstats = list("speed" = -1, "endurance" = -2)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt2
	name = "Thirsty"
	desc = "My mouth feels much drier."
	icon_state = "thirst2"

/datum/status_effect/debuff/thirstyt3
	id = "thirsty3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt3
	effectedstats = list("strength" = -1, "speed" = -2, "endurance" = -3)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt3
	name = "Thirsty"
	desc = "I urgently need water!"
	icon_state = "thirst3"

/////////

/datum/status_effect/debuff/uncookedfood
	id = "uncookedfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/uncookedfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER) || HAS_TRAIT(owner, TRAIT_ORGAN_EATER) || HAS_TRAIT(owner, TRAIT_WILD_EATER))
		return ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
	return ..()

/datum/status_effect/debuff/badmeal
	id = "badmeal"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/badmeal/on_apply()
	owner.add_stress(/datum/stressevent/badmeal)
	return ..()

/datum/status_effect/debuff/burnedfood
	id = "burnedfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/burnedfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER))
		return ..()
	owner.add_stress(/datum/stressevent/burntmeal)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
	return ..()

/datum/status_effect/debuff/rotfood
	id = "rotfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/rotfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER) || HAS_TRAIT(owner, TRAIT_ROT_EATER))
		return ..()
	owner.add_stress(/datum/stressevent/rotfood)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(200)
	return ..()

/datum/status_effect/debuff/bleeding
	id = "bleedingt1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt1
	effectedstats = list("speed" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt1
	name = "Dizzy"
	desc = ""
	icon_state = "bleed1"

/datum/status_effect/debuff/bleedingworse
	id = "bleedingt2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt2
	effectedstats = list("strength" = -1, "speed" = -2)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt2
	name = "Faint"
	desc = ""
	icon_state = "bleed2"

/datum/status_effect/debuff/bleedingworst
	id = "bleedingt3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt3
	effectedstats = list("strength" = -3, "speed" = -4)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt3
	name = "Drained"
	desc = ""
	icon_state = "bleed3"

/datum/status_effect/debuff/sleepytime
	id = "sleepytime"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/sleepytime
	effectedstats = list("speed" = -1, "endurance" = -1)

/atom/movable/screen/alert/status_effect/debuff/sleepytime
	name = "Tired"
	desc = "I should get some rest."
	icon_state = "sleepy"

/datum/status_effect/debuff/trainsleep
	id = "trainsleep"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/trainsleep
	effectedstats = list("strength" = -1, "endurance" = -1)

/atom/movable/screen/alert/status_effect/debuff/trainsleep
	name = "Muscle Soreness"
	desc = "My muscles need some sleep to recover."
	icon_state = "muscles"
