/datum/ai_planning_subtree/simple_find_target

/datum/ai_planning_subtree/simple_find_target/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	controller.queue_behavior(/datum/ai_behavior/find_potential_targets, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)


/datum/ai_planning_subtree/simple_find_target/rat

/datum/ai_planning_subtree/simple_find_target/rat/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	controller.queue_behavior(/datum/ai_behavior/find_potential_targets/rat, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)

/datum/ai_planning_subtree/simple_find_target/spider

/datum/ai_planning_subtree/simple_find_target/rat/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	controller.queue_behavior(/datum/ai_behavior/find_potential_targets/spider, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
