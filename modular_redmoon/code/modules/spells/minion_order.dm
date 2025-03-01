/obj/effect/proc_holder/spell/invoked/minion_order
	name = "Order Minions"
	desc = "Cast on turf to head in that direction ignoring all else. Cast on a minion to set to aggressive, cast on self to passive and follow, cast on target to focus them."
	overlay_state = "message"
	range = 12
	associated_skill = /datum/skill/misc/athletics
	chargedrain = 1
	chargetime = 0 SECONDS
	releasedrain = 0 
	charge_max = 3 SECONDS
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
		if(mob_target.summoner && mob_target.summoner == caster.real_name)  // REDMOON EDIT - ai_fixes - замена name на real_name, т.к. кастер может надеть маску - WAS: caster.name
			src.process_minions(order_type = "aggressive", target = target)
			return
		else
			// Set all minions to focus on the enemy target
			src.process_minions(order_type = "attack", target = target)
			return
	else
		revert_cast()
		return

/obj/effect/proc_holder/spell/invoked/minion_order/proc/process_minions(var/order_type, turf/target_location = null, mob/living/target = null)
	var/mob/caster = usr
	var/count = 0
	var/msg = ""

	for (var/mob/other_mob in oview(src.order_range, caster))
		if(!other_mob.client) // REDMOON EDIT - ai_fixes - убирание проверки на симпл-моба, чтобы можно было интереснее играть некроманту - WAS if(istype(other_mob, /mob/living/simple_animal) && !other_mob.client)
			var/mob/living/minion = other_mob // REDMOON EDIT - ai_fixes - замена var/mob/living/simple_animal/minion на var/mob/living/minion, чтобы некромант мог контролировать поднятых из людей скелетов без игроков

			if ((faction_ordering && caster.faction_check_mob(minion)) || (!faction_ordering && minion.summoner == caster.real_name)) // REDMOON EDIT - ai_fixes - замена name на real_name, т.к. кастер может надеть маску - WAS: caster.name
				if(!minion.ai_controller) // REDMOON ADD - ai_fixes - Если за скелета зайдёт игрок и выйдет из него, то получится моб без ИИ. Нужно в будущем прикрутить ИИ.
					continue // REDMOON ADD
				minion.ai_controller.CancelActions() // REDMOON ADD - отмена всех приказов
				minion.ai_controller.clear_blackboard_key(BB_FOLLOW_TARGET)
				minion.ai_controller.ordered_to_attack = null // REDMOON ADD - сброс приказа на атаку
				/* REDMOON REMOVAL START - ai_fixes - CancelActions() уже делает это
				minion.ai_controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
				minion.ai_controller.clear_blackboard_key(BB_TRAVEL_DESTINATION)
				minion.ai_controller.clear_blackboard_key(BB_BASIC_MOB_RETALIATE_LIST)
				/ REDMOON REMOVAL END */
				count += 1
				switch (order_type)
					if ("goto")
						minion.ai_controller.set_blackboard_key(BB_TRAVEL_DESTINATION, target_location)
						//minion.balloon_alert(caster, "Going to [target_location].")
						msg = "go to [target_location]"
					if ("follow")
						minion.ai_controller.set_blackboard_key(BB_FOLLOW_TARGET, target)
						//minion.balloon_alert(caster, "Following you.")
						msg = "follow you."
					if ("aggressive")
						//minion.balloon_alert(caster, "Returning to my natural state.")
						msg = "roam free."
					if ("attack")
						minion.ai_controller.ordered_to_attack = target // REDMOON ADD - отдача приказа на атаку цели независимо от фракции
						minion.ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
						//minion.balloon_alert(caster, "Attacking [target.name].")
						msg = "attack [target.name]"
	if(count>0)
		to_chat(caster, "Ordered [count] minions to " + msg)
	else
		to_chat(caster, "We weren't able to order anyone.")
