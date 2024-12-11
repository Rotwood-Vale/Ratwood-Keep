/**
 * Behavior for mob sitting and healing bleed/brute. This does not recover blood, the mobs will still be vulnerable to being bled out.
 */
/datum/ai_behavior/rest_and_recuperate
	action_cooldown = 2 SECONDS
	behavior_flags = AI_BEHAVIOR_MOVE_AND_PERFORM
	var/bleed_clot = 0.01 	// 1% of max hp bleed clotted every perform
	var/brute_heal = 0.10  // 10% of maxhp healed every perform
	//values are intentionally kept lowish


/datum/ai_behavior/rest_and_recuperate/perform(seconds_per_tick, datum/ai_controller/controller, heal_message)
	. = ..()
	var/mob/living/simple_animal/pawn = controller.pawn
	if(pawn.doing)
		return

	var/max_hp = pawn.maxHealth

	pawn.visible_message(span_danger("[pawn]"+heal_message))
	if(do_after(pawn, 8 SECONDS, target = pawn)) //maybe better to just give healing buff here
		pawn.bleed_rate = pawn.bleed_rate - (max_hp * bleed_clot)
		pawn.bleed_rate = clamp(pawn.bleed_rate, 0, max_hp)
		pawn.adjustBruteLoss( (max_hp * -brute_heal) )
		pawn.health = clamp(pawn.health, 0, max_hp)

	finish_action(controller, TRUE)
