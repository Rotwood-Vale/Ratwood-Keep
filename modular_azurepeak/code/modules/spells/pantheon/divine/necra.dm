// T1: Avert End (channel on an adjacent target to slowly spend devotion to grant them NODEATH and ticks of oxyloss healing)

/obj/effect/proc_holder/spell/invoked/avert
	name = "Borrowed Time"
	desc = "Shield your fellow man from the Undermaiden's gaze, preventing them from slipping into death for as long as your faith and fatigue may muster."
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	associated_skill = /datum/skill/magic/holy
	miracle = TRUE
	devotion_cost = 10
	var/list/near_death_lines = list(
		"A haze begins to envelop me, but then suddenly recedes, as if warded back by some great light...",
		"A terrible weight bears down upon me, as if the wyrld itself were crushing me with its heft...",
		"The sound of a placid river drifts into hearing, followed by the ominous toll of a ferryman's bell...",
		"Some vast, immeasurably distant figure looms beyond my perception - I feel it, more than I see. It waits. It watches.",
	)

/obj/effect/proc_holder/spell/invoked/avert/cast(list/targets, mob/living/carbon/human/user)
	. = ..()
	var/atom/target = targets[1]
	if (!isliving(target))
		revert_cast()
		return FALSE

	var/mob/living/living_target = target
	if (!user.Adjacent(target))
		to_chat(user, span_warning("I must be beside [living_target] to avert Her gaze from [living_target.p_them()]!"))
		revert_cast()
		return FALSE
	
	// add the no-death trait to them....
	user.visible_message(span_notice("Whispering motes gently bead from [user]'s fingers as [user.p_they()] place a hand near [living_target], scriptures of the Undermaiden spilling from their lips..."), span_notice("I stand beside [living_target] and utter the hallowed words of Aeon's Intercession, staying Her grasp for just a little while longer..."))
	to_chat(user, span_small("I must remain still and at [living_target]'s side..."))
	to_chat(living_target, span_warning("An odd sensation blossoms in my chest, cold and unknown..."))

	ADD_TRAIT(living_target, TRAIT_NODEATH, "avert_spell")

	var/our_holy_skill = user.mind?.get_skill_level(associated_skill)
	var/tickspeed = 30 + (5 * our_holy_skill)

	while (do_after(user, tickspeed, target = living_target))
		user.rogfat_add(2.5)

		living_target.adjustOxyLoss(-10)
		living_target.blood_volume = max((BLOOD_VOLUME_SURVIVE * 1.5), living_target.blood_volume)

		if (living_target.health <= 5)
			if (prob(5))
				to_chat(living_target, span_small(pick(near_death_lines)))

		if (user.devotion?.check_devotion(src))
			user.devotion?.update_devotion(-10)
		else
			to_chat(span_warning("My devotion runs dry - the Intercession fades from my lips!"))
			break
	
	REMOVE_TRAIT(living_target, TRAIT_NODEATH, "avert_spell")

	user.visible_message(span_danger("[user]'s concentration breaks, the motes receding from [living_target] and into [user.p_their()] hand once more."), span_danger("My concentration breaks, and the Intercession falls silent."))
