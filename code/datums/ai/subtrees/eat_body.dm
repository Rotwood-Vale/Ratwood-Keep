/datum/ai_planning_subtree/eat_dead_body

/datum/ai_planning_subtree/eat_dead_body/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_FOOD_TARGET]
	if(QDELETED(target))
		return
	var/mob/living/pawn = controller.pawn
	if(pawn.doing)
		return
	controller.queue_behavior(/datum/ai_behavior/eat_dead_body, BB_BASIC_MOB_FOOD_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	return SUBTREE_RETURN_FINISH_PLANNING //we are going into battle...no distractions.
