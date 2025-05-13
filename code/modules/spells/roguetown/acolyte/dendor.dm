// Druid
/obj/effect/proc_holder/spell/targeted/blesscrop
	name = "Bless Crops"
	range = 5
	overlay_state = "blesscrop"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Treefather commands thee, be fruitful!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/targeted/blesscrop/cast(list/targets,mob/user = usr)
	. = ..()
	var/growed = FALSE
	var/amount_blessed = 0
	for(var/obj/structure/soil/soil in view(4))
		soil.bless_soil()
		growed = TRUE
		amount_blessed++
		// Blessed only up to 5 crops
		if(amount_blessed >= 5)
			break
	if(growed)
		visible_message(span_green("[usr] blesses the nearby crops with Dendor's Favour!"))
	return growed

/obj/effect/proc_holder/spell/invoked/beasttame
	name = "Tame Beast"
	range = 5
	overlay_state = "tamebeast"
	releasedrain = 30
	chargetime = 15
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	charge_max = 15 SECONDS
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Be still and calm, brotherbeast."
	invocation_type = "none" // can be none, whisper, emote, or shout
	miracle = TRUE
	devotion_cost = 80

/obj/effect/proc_holder/spell/invoked/beasttame/cast(list/targets, mob/user = usr)
	. = ..()
	visible_message(span_green("[usr] calms the beastblood with Dendor's blessing."))

	// This list should contain all the creatures that can be tamed with this spell.
	var/list/tame_types = list(
		/mob/living/simple_animal/hostile/retaliate/rogue/wolf,
		/mob/living/simple_animal/hostile/retaliate/rogue/bigrat,
		/mob/living/simple_animal/hostile/retaliate/rogue/spider,
		/mob/living/simple_animal/hostile/retaliate/rogue/saiga,
		/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck,
	)

	if(!targets.len || !istype(targets[1], /mob/living/simple_animal))
		to_chat(user, span_warning("You must target a valid creature!"))
		return FALSE

	var/mob/living/simple_animal/target = targets[1]

	if(!(target.type in tame_types))
		to_chat(user, span_warning("You cannot tame that!"))
		return FALSE

	else if(target.mind != null && target.mind.awakened == TRUE)
		target.unawaken_beast(target, user.ckey)
		return FALSE

	target.visible_message(span_warning("The [target.real_name]'s body is engulfed by a calming aura..."), runechat_message = TRUE)
	// Kind of a hacky fix to make sure the ai doesn't attack people, but it works. 
	target.faction += "neutral"
	target.tame = TRUE

	if(user.mind.awakened_animals < user.mind.awakened_max)
		to_chat(user, span_warning("I have the capacity to sustain another awakened beast!"))

		// Ask the caster if they want to awaken the animal
		var/awaken_choice = alert(user, "Do you want to awaken the [target.real_name]?", "Awaken Beast", "Yes", "No")
		
		if(awaken_choice == "Yes")
			// Poll for candidates to control the tamed animal
			var/list/candidates = pollCandidatesForMob("Do you want to play as an awakened [target.real_name]?", null, null, null, 100, target, POLL_IGNORE_TAMED_BEAST)

			// If there are candidates, assign control to a player
			if(LAZYLEN(candidates))
				var/mob/C = pick(candidates)
				target.awaken_beast(user, C.ckey)
				user.mind.adjust_awakened(1)
				target.mind.set_awaken_caster(user)
				target.visible_message(span_warning("The [target.real_name]'s eyes light up with intelligence as it awakens!"), runechat_message = TRUE)
				target.mind.set_awakened(TRUE)
				return TRUE
			// If there are no candidates, the animal will have been calmed but not controlled
			else
				target.visible_message(span_warning("The [target.real_name] seems calmer but remains mindless."), runechat_message = TRUE)

				return TRUE
		else
			target.visible_message(span_warning("The [target.real_name] seems calmer but remains mindless."), runechat_message = TRUE)
		return TRUE
	else if(user.mind.awakened_animals >= user.mind.awakened_max)
		to_chat(user, span_warning("I cannot sustain another awakened beast.."))

/mob/living/simple_animal/proc/awaken_beast(mob/living/carbon/human/master, ckey = null)
	if(ckey) // If a player is controlling the animal
		src.ckey = ckey
		to_chat(src, span_userdanger("I was once a creature of instinct, but now... completely new thoughts and ideas flood my mind! I can think! I am free!"))
	if(ai_controller) // Disable AI controller if it exists
		ai_controller = new /datum/ai_controller/basic_controller(src)

	return TRUE

/mob/living/simple_animal/proc/unawaken_beast(mob/living/carbon/human/master, ckey = null)
	to_chat(src, span_userdanger("Your connection to the [src.real_name] has been severed."))
	
	// Revert AI controller based on the type of simple mob
	switch(type)
		if(/mob/living/simple_animal/hostile/retaliate/rogue/wolf)
			ai_controller = new /datum/ai_controller/volf(src)
		if(/mob/living/simple_animal/hostile/retaliate/rogue/bigrat)
			ai_controller = new /datum/ai_controller/big_rat(src)
		if(/mob/living/simple_animal/hostile/retaliate/rogue/spider)
			ai_controller = new /datum/ai_controller/spider(src)
		else
			ai_controller = new /datum/ai_controller/basic_controller(src) // Default fallback AI

	src.visible_message(span_warning("The [src.real_name] loses its awakened intelligence and returns to its natural state."), runechat_message = TRUE)
	src.handle_awakening()
	src.returntolobby()
	src.ckey = null
	return TRUE

/mob/living/proc/handle_awakening()
	if(src.mind.awakened == FALSE)
		return
	if(src.mind.awaken_caster == null)
		return
	var/mob/living/carbon/human/user = src.mind.awaken_caster
	user.mind.adjust_awakened(-1)
	to_chat(user, span_warning("One of my awakened beasts have fallen, I may now awaken another."))
	src.mind.set_awakened(FALSE)
	src.mind.set_awaken_caster(null)

/obj/effect/proc_holder/spell/targeted/conjure_vines
	name = "Vine Sprout"
	range = 1
	overlay_state = "blesscrop"
	releasedrain = 80
	charge_max = 25 SECONDS
	chargetime = 20
	no_early_release = TRUE
	movement_interrupt = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/items/dig_shovel.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Treefather, bring forth vines."
	invocation_type = "shout" //can be none, whisper, emote and shout
	devotion_cost = 40

/obj/effect/proc_holder/spell/targeted/conjure_vines/cast(list/targets, mob/user = usr)
	. = ..()
	var/turf/target_turf = get_step(user, user.dir)
	var/turf/target_turf_two = get_step(target_turf, turn(user.dir, 90))
	var/turf/target_turf_three = get_step(target_turf, turn(user.dir, -90))
	if(!locate(/obj/structure/spacevine) in target_turf)
		new /obj/structure/spacevine/dendor(target_turf)
	if(!locate(/obj/structure/spacevine) in target_turf_two)
		new /obj/structure/spacevine/dendor(target_turf_two)
	if(!locate(/obj/structure/spacevine) in target_turf_three)
		new /obj/structure/spacevine/dendor(target_turf_three)
	
	return TRUE
