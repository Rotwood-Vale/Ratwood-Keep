/obj/effect/proc_holder/spell/invoked/seelie_dust
	name = "Seelie Dust"
	overlay_state = "createlight"
	releasedrain = 50
	charge_max = 150 SECONDS
	range = 7
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/seelie_dust/cast(list/targets, mob/living/user)
	. = ..()
	user.emote("giggle")
	var/target = targets[1]
	if(isliving(target))
		var/obj/item/reagent_containers/powder/K = new /obj/item/reagent_containers/powder/SD(get_turf(target))
		K.reagents.trans_to(target, K.reagents.total_volume, transfered_by = user, method = "swallow")
		qdel(K)
	return TRUE
//Later:tm:
/*
/obj/effect/proc_holder/spell/targeted/static_room
	name = "Static"
	range = 12
	overlay_state = "necra"
	releasedrain = 30
	charge_max = 30 SECONDS
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation = "*laugh"
	invocation_type = "none" //can be none, whisper, emote and shout

obj/effect/proc_holder/spell/targeted/static_room/cast(list/targets, mob/user = usr)
	. = ..()
	for(var/mob/living/carbon/CA in targets)
		if(CA.has_status_effect(STATUS_EFFECT_STUN))
			for(CA in targets)
				if(CA.anti_magic_check())
					visible_message(span_warning("[src] fizzles on contact with [CA]!"))
					playsound(get_turf(CA), 'sound/magic/magic_nulled.ogg', 100)
					qdel(src)
					return BULLET_ACT_BLOCK
				if(isliving(CA))
					CA.electrocute_act(1, src)
				return TRUE
	return TRUE*/

/obj/effect/proc_holder/spell/invoked/summon_rat
	name = "Call Beast"
	overlay_state = "dendor"
	releasedrain = 30
	charge_max = 2 MINUTES
	range = 7
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/summon_rat/cast(list/targets, mob/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	user.emote("giggle")
	var/chance = rand(1,100)
	if(chance == 100)
		new /mob/living/simple_animal/hostile/retaliate/rogue/bigrat (T)
	else
		new /obj/item/reagent_containers/food/snacks/smallrat (T)
	return TRUE

//Because seelie glows constantly, this seemed unnecessary. May revisit if we can find a better execution
/*	
/obj/effect/proc_holder/spell/invoked/brighten
	name = "Light"
	overlay_state = "tamebeast"
	releasedrain = 30
	charge_max = 30 SECONDS
	range = 7
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/brighten/cast(list/targets, mob/user)
	. = ..()
	user.emote("giggle")
	var/target = targets[1]
	if(isliving(target) && !isseelie(target) && iscarbon(target))
		light(target)
		return TRUE

/obj/effect/proc_holder/spell/invoked/brighten/proc/light(mob/target)
	target.set_light(2, 1, "#d4fcac")
	sleep(100)
	target.set_light(0, 0, null)


/obj/effect/proc_holder/spell/invoked/strip
	name = "Strip Clothes"
	overlay_state = "bcry"
	releasedrain = 80
	charge_max = 6 MINUTES
	range = 1
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/strip/cast(list/targets, mob/user)
	. = ..()
	user.emote("giggle")
	var/pick = rand(1,3)//Now it randomly strips shoes, hats or gloves!
	var/mob/living/target = targets[1]
	if(iscarbon(target))
		switch(pick)
			if (1)
				var/obj/item/object = target.get_item_by_slot(SLOT_GLOVES)
				target.dropItemToGround(object)
			if(2)
				var/obj/item/object = target.get_item_by_slot(SLOT_SHOES)
				target.dropItemToGround(object)
			if(3)
				var/obj/item/object = target.get_item_by_slot(SLOT_HEAD)
				if(!istype(object, /obj/item/clothing/head/roguetown/helmet))//Can't take helmets!
					target.dropItemToGround(object)
	return TRUE

/obj/effect/proc_holder/spell/invoked/drain_stam
	name = "Drain"
	overlay_state = "bloodsteal"
	releasedrain = 1
	charge_max = 3 MINUTES
	range = 1
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none" //can be none, whisper, emote and shout
	//random_target = TRUE
	//random_target_priority = TARGET_RANDOM
	cast_without_targets = TRUE

/obj/effect/proc_holder/spell/invoked/drain_stam/cast(list/targets, mob/user)
	. = ..()
	if(targets.len == 0)
		to_chat(user, span_warning("There is no one close enough to drain from!"))
	if(iscarbon(targets[1]))
		var/mob/living/target = targets[1]
		var/mob/living/carbon/human/caster = user
		if((target.rogstam > 100) && (caster.rogstam < (caster.maxrogstam - 60)) )
			to_chat(target, span_warning("I suddenly feel burdened and fatigued!"))
			to_chat(user, span_warning("I reinvigorate myself with [target]'s energy!"))
			target.rogstam_add(-100)
			caster.rogstam_add(61)
			return TRUE
		else if(target.rogstam < 100)
			to_chat(user, span_warning("[target] is too exhausted to drain from!"))
			return FALSE
		else if(caster.rogstam >= (caster.maxrogstam - 60))
			to_chat(target, span_warning("I suddenly feel burdened and fatigued!"))
			to_chat(user, span_warning("I dont feel any more invigorated than I did..."))
			target.rogstam_add(-100)
			return TRUE
		else
			to_chat(user, span_warning("I have no idea how I caused this to happen"))
			return FALSE
	else
		to_chat(user, span_warning("I cant drain energy from that!"))
	
	return FALSE
		

/obj/effect/proc_holder/spell/invoked/replenish
	name = "Replenish Nature"
	overlay_state = "blesscrop"
	releasedrain = 40
	charge_max = 3 MINUTES
	range = 1
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/replenish/cast(list/targets, mob/user)
	. = ..()
	var/obj/structure/flora/roguegrass/bush/bushes = targets[1]
	if(isemptylist(bushes.looty))
		bushes.looty.Insert(1, pickweight(list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue=5,
						/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison=3,
						/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed=1)), /obj/item/natural/thorn, /obj/item/natural/fibers)
	return TRUE

/obj/effect/proc_holder/spell/invoked/projectile/animate_object
	name = "Animate Object"
	overlay_state = "bigpsy"
	//user.emote("laugh")
	sound = 'sound/magic/lightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/animate
	releasedrain = 220
	chargedrain = 1
	chargetime = 15
	charge_max = 8 MINUTES
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane*/

/obj/effect/proc_holder/spell/targeted/roustame
	name = "Tame Rous"
	range = 5
	overlay_state = "tamebeast"
	releasedrain = 30
	charge_max = 5 MINUTES
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	invocation = "Feel my presence, and be calmed."
	invocation_type = "whisper" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/targeted/roustame/cast(list/targets,mob/user = usr)
	. = ..()
	visible_message(span_green("[usr] soothes the beast with Seelie dust."))
	var/tamed = FALSE
	for(var/mob/living/simple_animal/hostile/retaliate/rogue/bigrat/B in oview(2))
		if(!B.tame)
			B.tame = TRUE
			B.tamed()
			B.friends = list(user) //Makes the Rous not target the Seelie when on aggro
		//user.visible_message(span_info("[B] calms down."))
		B.enemies = list()
		B.aggressive = 0
		B.LoseTarget()
		tamed = B.tame
	return tamed

/obj/effect/proc_holder/spell/targeted/seelie_kiss
	name = "Kiss"
	overlay_state = "bloodsteal"
	releasedrain = 0
	charge_max = 10 MINUTES
	range = 1
	invocation_type = "none" //can be none, whisper, emote and shout
	//random_target = TRUE
	//random_target_priority = TARGET_RANDOM

/obj/effect/proc_holder/spell/targeted/seelie_kiss/cast(mob/living/carbon/target, mob/user)
	. = ..()
	var/obj/item/reagent_containers/powder/K = new /obj/item/reagent_containers/powder/SK(target.loc)
	K.reagents.trans_to(target, K.reagents.total_volume, transfered_by = user, method = "swallow")
	user.emote("kiss")
	target.add_nausea(9)
	qdel(K)
		
	return TRUE
	
/obj/effect/proc_holder/spell/invoked/projectile/splash
	name = "Water splash"
	overlay_state = "bigpsy"
	//user.emote("laugh")
	range = 8
	projectile_type = /obj/projectile/magic/water
	releasedrain = 50
	chargedrain = 1
	chargetime = 5
	charge_max = 5 MINUTES
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen

/obj/item/reagent_containers/powder/SK
	list_reagents = list(/datum/reagent/medicine/healthpot = 1, /datum/reagent/medicine/manapot = 1)

/obj/item/reagent_containers/powder/SD
	list_reagents = list(/datum/reagent/seelie_drugs = 10)

/obj/item/reagent_containers/glass/bucket/wooden/SW
	list_reagents = list(/datum/reagent/water = 10)
