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

//At some point, this spell should Awaken beasts, allowing a ghost to possess them. Not for this PR though.
/obj/effect/proc_holder/spell/targeted/beasttame
	name = "Tame Beast"
	range = 5
	overlay_state = "tamebeast"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Be still and calm, brotherbeast."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/targeted/beasttame/cast(list/targets,mob/user = usr)
	. = ..()
	visible_message(span_green("[usr] soothes the beastblood with Dendor's whisper."))
	var/tamed = FALSE
	for(var/mob/living/simple_animal/hostile/retaliate/B in oview(2))
		if(B.aggressive)
			tamed = TRUE
		B.aggressive = 0
	return tamed

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
