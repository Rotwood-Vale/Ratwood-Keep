/datum/status_effect/buff/fortitudebuff
	id = "fortitudebuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fortitude
	effectedstats = list("strength" = 2)
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/fortitude
	name = "Fortitude"
	desc = ""
	icon_state = "fortitude"

/datum/status_effect/buff/swiftnessbuff
	id = "swiftnessbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/swiftness
	effectedstats = list("speed" = 5, "endurance" = 3)
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/swiftness
	name = "Swiftness"
	desc = ""
	icon_state = "swiftness"

/datum/status_effect/buff/alacritybuff
	id = "alacritybuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/alacrity
	effectedstats = list("perception" = 4)
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/alacrity
	name = "Alacrity"
	desc = ""
	icon_state = "alacrity"

/datum/status_effect/buff/luckbuff
	id = "luckbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/luckbuff
	effectedstats = list("fortune" = 4)
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/luckbuff
	name = "Lucky!"
	desc = ""
	icon_state = "luck"

/datum/status_effect/buff/endurancebuff
	id = "endurancebuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/endurancebuff
	effectedstats = list("endurance" = 4)
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/endurancebuff
	name = "Enduring"
	desc = ""
	icon_state = "endurance"

/datum/status_effect/buff/constitutionbuff
	id = "constitutionbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/constitutionbuff
	effectedstats = list("constitution" = 4)
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/constitutionbuff
	name = "Iron Skin"
	desc = ""
	icon_state = "ironskin"

/datum/status_effect/buff/intellectbuff
	id = "intellectbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/intellect
	effectedstats = list("intelligence" = 3)
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/intellect
	name = "Intellect"
	desc = ""
	icon_state = "intellect"

/datum/status_effect/buff/mfire // Requires a ground riddle of steel and being a follower of malum or baotha. Best case, this is used for a chunky mining buff, as intended.
	id = "mfirebuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/mfire
	effectedstats = list("strength" = 1, "endurance" = 3, "fortune" = 5) 
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/buff/mfire
	name = "Burning Fervor"
	desc = ""
	icon_state = "fire"

/datum/status_effect/buff/virilitybuff
	id = "virilitybuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/virility
	duration = 3000

/atom/movable/screen/alert/status_effect/buff/virility
	name = "Virility"
	desc = ""
	icon_state = "virility"

/datum/status_effect/buff/virilitybuff/on_apply()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.sexcon.set_charge(INFINITY)
	return ..()

/datum/status_effect/buff/virilitybuff/on_remove()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.sexcon.set_charge(0)
	return ..()

/datum/status_effect/buff/invisbuff
	id = "invisbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/invisbuff
	effectedstats = list("constitution" = -6) // You shouldnt risk fighting with this active.
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/invisbuff
	name = "Invisible"
	desc = ""
	icon_state = "invisible"

/datum/status_effect/buff/invisbuff/on_apply()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.visible_message(span_warning("[C] starts to fade into thin air!"), span_notice("You start to become invisible!"))
		animate(C, alpha = 0, time = 2 SECONDS, easing = EASE_IN)
		C.mob_timers[MT_INVISIBILITY] = world.time + 30 SECONDS
		addtimer(CALLBACK(C, TYPE_PROC_REF(/mob/living/carbon, update_sneak_invis), TRUE), 30 SECONDS)
		addtimer(CALLBACK(C, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[C] fades back into view."), span_notice("You become visible again.")), 30 SECONDS)
	return ..()

/datum/status_effect/buff/nullmagicbuff
	id = "virilitybuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/nullmagicbuff
	duration = 1 MINUTES

/atom/movable/screen/alert/status_effect/buff/nullmagicbuff
	name = "Null Magic"
	desc = ""
	icon_state = "virility"

/datum/status_effect/buff/nullmagicbuff/on_apply()
	if(iscarbon(owner))
		ADD_TRAIT(owner, TRAIT_ANTIMAGIC, TRAIT_GENERIC)

	return ..()

/datum/status_effect/buff/nullmagicbuff/on_remove()
	if(iscarbon(owner))
		REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
	return ..()
