/datum/ai_behavior/eat_dead_body
	action_cooldown = 1.5 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/eat_dead_body/setup(datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	//Hiding location is priority
	var/atom/target = controller.blackboard[hiding_location_key] || controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, (target))

/datum/ai_behavior/eat_dead_body/perform(delta_time, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/mob/living/simple_animal/basic_mob = controller.pawn
	//targetting datum will kill the action if not real anymore
	var/mob/living/target = controller.blackboard[target_key]
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	var/hiding_target = targetting_datum.find_hidden_mobs(basic_mob, target) //If this is valid, theyre hidden in something!

	controller.set_blackboard_key(hiding_location_key, hiding_target)

	basic_mob.face_atom()
	basic_mob.visible_message(span_danger("[basic_mob] starts to rip apart [target]!"))
	if(do_after(basic_mob, 10 SECONDS, target = target))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/limb
			var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			for(var/zone in limb_list)
				limb = C.get_bodypart(zone)
				if(limb)
					limb.dismember()
					finish_action(controller, TRUE)
					return
			limb = C.get_bodypart(BODY_ZONE_HEAD)
			if(limb)
				limb.dismember()
				finish_action(controller, TRUE)
				return
			limb = C.get_bodypart(BODY_ZONE_CHEST)
			if(limb)
				if(!limb.dismember())
					C.gib()
		else
			if(basic_mob.attack_sound)
				playsound(basic_mob, pick(basic_mob.attack_sound), 100, TRUE, -1)
			target.gib()
	finish_action(controller, TRUE)


/datum/ai_behavior/eat_dead_body/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		controller.clear_blackboard_key(target_key)


/datum/ai_behavior/eat_dead_body/bog_troll/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		controller.clear_blackboard_key(target_key)
		controller.pawn.icon_state = "Trollso"

/datum/ai_behavior/eat_dead_body/mimic/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		controller.clear_blackboard_key(target_key)
		controller.pawn.icon_state = "mimic"
