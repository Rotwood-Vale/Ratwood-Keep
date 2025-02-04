#define MOSSBACK_MOVEMENT_SPEED 0.7 SECONDS

//Appears to be a simple mob
/datum/ai_controller/mossback
	movement_delay = MOSSBACK_MOVEMENT_SPEED

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/being_a_minion,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/find_food,
		/datum/ai_planning_subtree/find_dead_bodies/mole,
		/datum/ai_planning_subtree/eat_dead_body,

	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
