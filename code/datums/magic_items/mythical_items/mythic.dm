//T4 Enchantments

/datum/magic_item/mythic/infernalflame
	name = "infernal flame"
	description = "It glows with white hot heat."
	var/last_used
	var/warned

/datum/magic_item/mythic/infernalflame/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < src.last_used + 100)
		return
	if(isliving(target))
		var/mob/living/targeted = target
		targeted.adjust_fire_stacks(10)
		targeted.IgniteMob()
		targeted.visible_message(span_danger("[source] sets [targeted] on fire!"))
		src.last_used = world.time

/datum/magic_item/mythic/infernalflame/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)
	if(world.time < src.last_used + 100)
		if(!warned)
			to_chat(firer, span_notice("[fired_from] is not yet ready to immolate!"))
			warned = TRUE
	if(isliving(firer) && isliving(target))
		var/mob/living/damaging = target
		if(damaging.stat != DEAD)
			damaging.adjust_fire_stacks(10)
			damaging.IgniteMob()
			damaging.visible_message(span_danger("[fired_from] sets [damaging] on fire!"))
			src.last_used = world.time

/datum/magic_item/mythic/infernalflame/on_hit_response(var/obj/item/I, var/mob/living/carbon/human/owner, var/mob/living/carbon/human/attacker)
	if(world.time < src.last_used + 100)
		return
	if(isliving(attacker) && attacker != owner)
		attacker.adjust_fire_stacks(10)
		attacker.IgniteMob()
		attacker.visible_message(span_danger("[I] sets [attacker] on fire!"))
		src.last_used = world.time

/datum/magic_item/mythic/freezing
	name = "freezing"
	description = "It feels ice cold."
	var/last_used
	var/warned
/datum/magic_item/mythic/freezing/on_hit_response(var/obj/item/I, var/mob/living/carbon/human/owner, var/mob/living/carbon/human/attacker)
	if(world.time < src.last_used + 100)
		return
	if(isliving(attacker) && attacker != owner)
		attacker.apply_status_effect(/datum/status_effect/freon/freezing)
		attacker.visible_message(span_danger("[I] freezes [attacker] solid!"))
		src.last_used = world.time

/datum/magic_item/mythic/freezing/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)
	if(world.time < src.last_used + 100)
		if(!warned)
			to_chat(firer, span_notice("[fired_from] is not yet ready to glaciate!"))
			warned = TRUE
	if(isliving(firer) && isliving(target))
		var/mob/living/damaging = target
		if(damaging.stat != DEAD)
			damaging.apply_status_effect(/datum/status_effect/freon/freezing)
			damaging.visible_message(span_danger("[fired_from] freezes[damaging] solid!"))
			src.last_used = world.time

/datum/magic_item/mythic/freezing/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < src.last_used + 100)
		return
	if(isliving(target))
		var/mob/living/targeted = target
		targeted.apply_status_effect(/datum/status_effect/freon/freezing)
		targeted.visible_message(span_danger("[source] freezes [targeted] solid!"))
		src.last_used = world.time

/datum/magic_item/mythic/briarcurse
	name = "Briar's curse"
	description = "Its grip seems thorny. Must hurt to use."
	var/last_used

/datum/magic_item/mythic/briarcurse/on_apply(var/obj/item/i)
	.=..()
	i.force = i.force + 10

/datum/magic_item/mythic/briarcurse/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	.=..()
	if(isliving(target))
		var/mob/living/carbon/targeted = target
		targeted.adjustBruteLoss(10)
		to_chat(user, span_notice("[source] gouges you with it's sharp edges!"))

/datum/magic_item/mythic/rewind
	name = "Temporal Rewind"
	description = "Its seems both old and new at the same time."
	var/last_used
	var/active_item = FALSE
	var/warned = FALSE

/datum/magic_item/mythic/rewind/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	.=..()
	if(world.time < src.last_used + 100)
		return
	else
		var/turf/target_turf = get_turf(user)
		active_item = TRUE
		sleep(5 SECONDS)
		to_chat(user, span_notice("[source] rewinds you back in time!"))
		do_teleport(user, target_turf, channel = TELEPORT_CHANNEL_QUANTUM)
		src.last_used = world.time

/datum/magic_item/mythic/rewind/on_hit_response(var/obj/item/I, var/mob/living/carbon/human/owner, var/mob/living/carbon/human/attacker)
	if(world.time < src.last_used + 100)
		return
	if(!active_item)
		var/turf/target_turf = get_turf(owner)
		active_item = TRUE
		sleep(5 SECONDS)
		to_chat(owner, span_notice("[I] rewinds you back in time!"))
		do_teleport(owner, target_turf, channel = TELEPORT_CHANNEL_QUANTUM)
		src.last_used = world.time
		active_item = FALSE