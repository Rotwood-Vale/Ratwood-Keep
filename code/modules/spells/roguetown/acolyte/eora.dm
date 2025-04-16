/obj/effect/proc_holder/spell/invoked/bud
	name = "Eoran Bloom"
	desc = ""
	clothes_req = FALSE
	range = 7
	overlay_state = "pflower"
	sound = list('sound/magic/magnet.ogg')
	req_items = list(/obj/item/clothing/neck/roguetown/psicross/eora)
	releasedrain = 40
	chargetime = 40
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/holy
	charge_max = 60 SECONDS
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/bud/cast(list/targets, mob/living/user)
	var/turf/T = get_turf(targets[1])
	if(!isclosedturf(T))
		new /obj/item/clothing/head/peaceflower(T)
		return TRUE
	to_chat(user, span_warning("The targeted location is blocked. The flowers of Eora refuse to grow."))
	return FALSE

/obj/effect/proc_holder/spell/invoked/eoracurse
	name = "Eora's Curse"
	overlay_state = "curse2"
	releasedrain = 50
	chargetime = 20
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokegen
	req_items = list(/obj/item/clothing/neck/roguetown/psicross/eora)
	sound = list('sound/magic/whiteflame.ogg')
	invocation = "Nulla felicitas sine amore!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 30 SECONDS
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/eoracurse/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.apply_status_effect(/datum/status_effect/buff/eoradruqks)
		target.visible_message(span_info("A purple haze shrouds [target]!"), span_info("I feel much calmer."))
		target.blur_eyes(20)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/eoracharm
	name = "Charm"
	overlay_state = "love"
	releasedrain = 60
	chargetime = 60
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokegen
	req_items = list(/obj/item/clothing/neck/roguetown/psicross/eora)
	sound = list('sound/magic/whiteflame.ogg')
	invocation = "Experiamur vim amoris!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 45 SECONDS
	miracle = TRUE
	devotion_cost = 100

/obj/effect/proc_holder/spell/invoked/eoracharm/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		var/charm_to_public = pick("<b style='color:pink'>[user] is influenced by the beauty of Eora's follower.</b>", "<b style='color:pink'>[target] stares mesmerized at [user].</b>")
		var/charm_to_target = pick("<b style='color:pink'>Your eyes cannot move away from [user].</b>", "<b style='color:pink'>You are enchanted by the beauty of the follower of Eora.</b>")
		target.visible_message(span_warning("[charm_to_public]"), span_warning("[charm_to_target]"))
		target.apply_status_effect(/datum/status_effect/eorapacify)
	return FALSE
