/// When no target and wounds, slowly cure bleeding and damage.
///Needs to be improved. todo: crix
/datum/ai_planning_subtree/self_recovery
	var/datum/ai_behavior/behavior = /datum/ai_behavior/rest_and_recuperate
	var/heal_message = "'s wounds begin to knit and mend."

/datum/ai_planning_subtree/self_recovery/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	var/mob/living/pawn = controller.pawn
	
	//Already doing something or don't need healing
	//And not in some enviro that will tick damage
	if((pawn.doing) || (pawn.get_bleed_rate() == 0 && pawn.getBruteLoss() == 0))
	//|| (!get_turf(pawn).can_traverse_safely(pawn))
		return
	controller.queue_behavior(behavior, heal_message) //tmp until i add the blackboard stuff

	return SUBTREE_RETURN_FINISH_PLANNING //we are going to heal...no distractions.


/datum/ai_planning_subtree/self_recovery/dragon
	heal_message = " licks their wounds."

/datum/ai_planning_subtree/self_recovery/humanoid
	heal_message = " tends to their wounds."
