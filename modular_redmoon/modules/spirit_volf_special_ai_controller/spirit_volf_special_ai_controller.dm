// ai_fixes

/datum/ai_controller/volf/familiar
	planning_subtrees = list(
		/datum/ai_planning_subtree/flee_target,

		/datum/ai_planning_subtree/simple_find_target/closest, // единственное изменение. Атакует ближайшую цель
		/datum/ai_planning_subtree/basic_melee_attack_subtree,

		/datum/ai_planning_subtree/find_dead_bodies,
		/datum/ai_planning_subtree/eat_dead_body,
	)
