/datum/ai_planning_subtree/eat_dead_body
	var/datum/ai_behavior/eat_dead_body/behavior = /datum/ai_behavior/eat_dead_body
	var/corpse_key = BB_BASIC_MOB_CORPSE_TARGET

/datum/ai_planning_subtree/eat_dead_body/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	var/atom/target = controller.blackboard[corpse_key]
	if(QDELETED(target) || !ismob(target)) //Bodies only
		controller.clear_blackboard_key(corpse_key)
		return FALSE
	var/mob/living/pawn = controller.pawn
	if(pawn.doing)
		return
	controller.queue_behavior(behavior, corpse_key, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	return SUBTREE_RETURN_FINISH_PLANNING //we are going to eat...no distractions.


/datum/ai_planning_subtree/eat_dead_body/bog_troll
	behavior = /datum/ai_behavior/eat_dead_body/bog_troll

/datum/ai_planning_subtree/eat_dead_body/mimic
	behavior = /datum/ai_behavior/eat_dead_body/mimic
