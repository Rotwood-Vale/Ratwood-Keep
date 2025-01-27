/**
 * # Targeted Mob Ability
 * Attempts to use a mob's cooldown ability on a target
 */
/datum/ai_behavior/targeted_mob_ability

/datum/ai_behavior/targeted_mob_ability/perform(seconds_per_tick, datum/ai_controller/controller, ability_key, target_key)
	var/obj/effect/proc_holder/spell/ability = controller.blackboard[ability_key]
	var/mob/living/target = controller.blackboard[target_key]
	if(QDELETED(ability) || QDELETED(target))
		finish_action(controller, FALSE, ability_key, target_key)
		return
	var/mob/pawn = controller.pawn
	pawn.face_atom(target)
	var/result = ability.perform(targets = list(target), user = controller.pawn)
	finish_action(controller, result, ability_key, target_key)

/datum/ai_behavior/targeted_mob_ability/finish_action(datum/ai_controller/controller, succeeded, ability_key, target_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if (QDELETED(target))
		controller.clear_blackboard_key(target_key)

/**
 * # Try Mob Ability and clear target
 * Attempts to use a mob's cooldown ability on a target and releases the target when the action completes
 */
/datum/ai_behavior/targeted_mob_ability/and_clear_target

/datum/ai_behavior/targeted_mob_ability/and_clear_target/finish_action(datum/ai_controller/controller, succeeded, ability_key, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)

/datum/ai_behavior/targeted_mob_ability/proc/get_ability_to_use(datum/ai_controller/controller, ability_key)
	return controller.blackboard[ability_key]

/**
 * Attempts to move into the provided range and then use a mob's cooldown ability on a target
 */
/datum/ai_behavior/targeted_mob_ability/min_range
	required_distance = 6
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT
	var/datum/ai_movement/new_movement

/datum/ai_behavior/targeted_mob_ability/min_range/setup(datum/ai_controller/controller, ability_key, target_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target, new_movement)
