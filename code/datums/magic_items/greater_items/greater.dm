///T3 Enchantmentsdatum
/datum/magic_item/greater/lifesteal
	name = "life steal"
	description = "It seems bloodthirsty."
	var/last_used
	var/flat_heal = 10
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)
	var/warned = FALSE

/datum/magic_item/greater/lifesteal/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)
	if(world.time < src.last_used + 100)
		to_chat(firer, span_notice("[fired_from] is not yet hungry for more life!"))
		return
	if(isliving(firer) && isliving(target))
		var/mob/living/healing = firer
		var/mob/living/damaging = target
		if(damaging.stat != DEAD)
			healing.heal_ordered_damage(flat_heal, damage_heal_order)
			firer.visible_message(span_danger("[fired_from] drains life from [target]!"))
			src.last_used = world.time

/datum/magic_item/greater/lifesteal/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < src.last_used + 100)
		if(!warned)
			to_chat(user, span_notice("[source] is not yet hungry for more life!"))
			warned = TRUE
		return
	if(isliving(user) && isliving(target))
		var/mob/living/healing = user
		var/mob/living/damaging = target
		if(damaging.stat != DEAD)
			healing.heal_ordered_damage(flat_heal, damage_heal_order)
			user.visible_message(span_danger("[source] drains life from [target]!"))
			warned = FALSE
			src.last_used = world.time

/datum/magic_item/greater/deflection
	name = "life steal"
	description = "It seems bloodthirsty."
	var/last_used

/datum/magic_item/greater/deflection