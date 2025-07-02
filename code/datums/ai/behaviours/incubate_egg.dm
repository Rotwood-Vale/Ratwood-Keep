/datum/ai_behavior/incubate_egg

/datum/ai_behavior/incubate_egg/perform(delta_time, datum/ai_controller/controller, emote)
	var/mob/living/simple_animal/hostile/retaliate/rogue/chicken/living_pawn = controller.pawn
	if(!istype(living_pawn))
		return
	controller.PauseAi(15 SECONDS)
	living_pawn.visible_message(span_emote("[living_pawn] begins to brood."))
	addtimer(CALLBACK(living_pawn, TYPE_PROC_REF(/mob/living/simple_animal/hostile/retaliate/rogue/chicken, hatch_eggs)), 15 SECONDS)
