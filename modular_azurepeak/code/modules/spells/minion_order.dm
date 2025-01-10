/obj/effect/proc_holder/spell/invoked/minion_order
	name = "Order Minions"
	desc = "Cast on turf to goto, cast on minion to set to aggressive, cast on self to passive and follow, cast on target to focus."
	range = 12
	associated_skill = /datum/skill/misc/athletics
	chargedrain = 1
	chargetime = 1 SECONDS
	releasedrain = 0 
	charge_max = 10 SECONDS
	var/order_range = 12
	var/faction_ordering = FALSE ///this sets whether it orders mobs the user is aligned with in range or just mobs who are the character's 'friends' (ie, their summons)

/obj/effect/proc_holder/spell/invoked/minion_order/lich //as an example, this should allow the lich to command the entire undead faction
	faction_ordering = TRUE

/obj/effect/proc_holder/spell/invoked/minion_order/cast(list/targets, mob/user)
	var/mob/caster = user
	var/target = targets[1]

	// Minions goto turf
	if(isturf(target))
		src.process_minions(order_type = "goto", target_location = target)
		return

	// Target is the caster (set minions to passive and follow)
	else if(target == caster)
		src.process_minions(order_type = "follow", target = caster)
		return

	// Target is another mob
	else if(ismob(target))
		var/mob/living/mob_target = target
		if(caster.faction_check_mob(target) || (mob_target.summoner && mob_target.summoner == caster.name))
			src.process_minions(order_type = "aggressive", target = target)
			return
		else
			// Set all minions to focus on the enemy target
			src.process_minions(order_type = "attack", target = target)
			return

	revert_cast()
	return

/obj/effect/proc_holder/spell/invoked/minion_order/proc/process_minions(var/order_type, turf/target_location = null, mob/living/target = null)
	var/mob/caster = usr

	for (var/mob/other_mob in oview(src.order_range, caster))
		if (istype(other_mob, /mob/living/simple_animal) && !other_mob.client) // Only simple_mobs for now
			var/mob/living/simple_animal/minion = other_mob

			if ((faction_ordering && caster.faction_check_mob(minion)) || (!faction_ordering && minion.summoner == caster.name))

				minion.ai_controller.clear_blackboard_key(BB_FOLLOW_TARGET)
				minion.ai_controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
				minion.ai_controller.clear_blackboard_key(BB_TRAVEL_DESTINATION)

				switch (order_type)
					if ("goto")
						minion.ai_controller.set_blackboard_key(BB_TRAVEL_DESTINATION, target_location)
						//minion.balloon_alert(caster, "Going to [target_location].")
					if ("follow")
						minion.ai_controller.set_blackboard_key(BB_FOLLOW_TARGET, target)
						//minion.balloon_alert(caster, "Following you.")
					if ("aggressive")
						//minion.balloon_alert(caster, "Returning to my natural state.")
					if ("attack")
						minion.ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
						//minion.balloon_alert(caster, "Attacking [target.name].")
