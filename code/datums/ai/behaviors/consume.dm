/datum/ai_behavior/consume
	required_distance = 1
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT
	action_cooldown = 2 SECONDS
/datum/ai_behavior/consume/setup(datum/ai_controller/controller, obj/item/target)
	. = ..()
	controller.current_movement_target = target
/datum/ai_behavior/consume/perform(delta_time, datum/ai_controller/controller, obj/item/target)
	. = ..()
	var/mob/living/pawn = controller.pawn
	if(!(target in pawn.held_items))
		if(!pawn.put_in_hand_check(target))
			finish_action(controller, FALSE)
			return
		pawn.put_in_hands(target)
	target.melee_attack_chain(pawn, pawn)
	if(QDELETED(target) || prob(10)) // Even if we don't finish it all we can randomly decide to be done
		finish_action(controller, TRUE)
