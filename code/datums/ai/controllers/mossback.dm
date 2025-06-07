//Appears to be a simple mob
/datum/ai_controller/mossback

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/find_food,
	) // I dont want to touch AI from now because the PR is massive already, so eat_food and being_a minion been removed from here

	idle_behavior = /datum/idle_behavior/idle_random_walk
