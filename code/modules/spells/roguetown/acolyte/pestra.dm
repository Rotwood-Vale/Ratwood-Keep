// Diagnose
/obj/effect/proc_holder/spell/invoked/diagnose
	name = "Diagnose"
	overlay_state = "diagnose"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS //very stupidly simple spell
	miracle = TRUE
	devotion_cost = 0 //come on, this is very basic

/obj/effect/proc_holder/spell/invoked/diagnose/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/human_target = targets[1]
		human_target.check_for_injuries(user)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/diagnose/secular
	name = "Secular Diagnosis"
	overlay_state = "diagnose"
	range = 1
	associated_skill = /datum/skill/misc/medicine
	miracle = FALSE
	devotion_cost = 0 //Doctors are not clerics

// Limb or organ attachment
/obj/effect/proc_holder/spell/invoked/attach_bodypart
	name = "Bodypart Miracle"
	overlay_state = "limb_attach"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/gore/flesh_eat_03.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS //attaching a limb is pretty intense
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_organs(mob/living/target, mob/living/user)
	var/list/missing_organs = list(
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
		ORGAN_SLOT_APPENDIX,
	)
	for(var/missing_organ_slot in missing_organs)
		if(!target.getorganslot(missing_organ_slot))
			continue
		missing_organs -= missing_organ_slot
	if(!length(missing_organs))
		return
	var/list/organs = list()
	//try to get from user's hands first
	for(var/obj/item/organ/potential_organ in user?.held_items)
		if(potential_organ.owner || !(potential_organ.slot in missing_organs))
			continue
		organs += potential_organ
	//then target's hands
	for(var/obj/item/organ/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/organ/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	return organs

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_limbs(mob/living/target, mob/living/user)
	var/list/missing_limbs = target.get_missing_limbs()
	if(!length(missing_limbs))
		return
	var/list/limbs = list()
	//try to get from user's hands first
	for(var/obj/item/bodypart/potential_limb in user?.held_items)
		if(potential_limb.owner || !(potential_limb.body_zone in missing_limbs))
			continue
		limbs += potential_limb
	//then target's hands
	for(var/obj/item/bodypart/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/bodypart/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	return limbs

// consider adding functionality to regrow one entire organ or limb per casting?
/obj/effect/proc_holder/spell/invoked/attach_bodypart/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/human_target = targets[1]
		for(var/obj/item/bodypart/limb as anything in get_limbs(human_target, user))
			if(human_target.get_bodypart(limb.body_zone) || !limb.attach_limb(human_target))
				continue
			human_target.visible_message(span_info("\The [limb] attaches itself to [human_target]!"), \
								span_notice("\The [limb] attaches itself to me!"))
		for(var/obj/item/organ/organ as anything in get_organs(human_target, user))
			if(human_target.getorganslot(organ.slot) || !organ.Insert(human_target))
				continue
			human_target.visible_message(span_info("\The [organ] attaches itself to [human_target]!"), \
								span_notice("\The [organ] attaches itself to me!"))
		if(!(human_target.mob_biotypes & MOB_UNDEAD))
			for(var/obj/item/bodypart/limb as anything in human_target.bodyparts)
				limb.rotted = FALSE
				limb.skeletonized = FALSE
		human_target.update_body()
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/mercy
	name = "Pestra's Mercy"
	desc = "Call upon Pestra's mercy to shield your fellow man from the Undermaiden's gaze, preventing them from slipping into death for as long as your faith and fatigue may muster."
	overlay_state = "limb_attach"
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	associated_skill = /datum/skill/magic/holy
	miracle = TRUE
	no_early_release = TRUE
	movement_interrupt = TRUE
	devotion_cost = 10
	var/list/near_death_lines = list(
		"A haze begins to envelop me, but then suddenly recedes, as if warded back by some great light...",
		"A terrible weight bears down upon me, as if the wyrld itself were crushing me with its heft...",
		"The sound of a placid river drifts into hearing, followed by the ominous toll of a ferryman's bell...",
		"Some vast, immeasurably distant figure looms beyond my perception - I feel it, more than I see. It waits. It watches.",
	)

/obj/effect/proc_holder/spell/invoked/mercy/cast(list/targets, mob/living/carbon/human/user)
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
	user.visible_message(span_notice("Whispering motes gently bead from [user]'s fingers as [user.p_they()] place a hand near [living_target], scriptures of the Pestra spilling from their lips..."), span_notice("I stand beside [living_target] and utter the hallowed words, staying The undermaidens grasp for just a little while longer..."))
	to_chat(user, span_small("I must remain still and at [living_target]'s side..."))
	to_chat(living_target, span_warning("An odd sensation blossoms in my chest, cold and unknown..."))

	ADD_TRAIT(living_target, TRAIT_NODEATH, "avert_spell")

	var/our_holy_skill = user.mind?.get_skill_level(associated_skill)
	var/tickspeed = 30 + (5 * our_holy_skill)

	while (do_after(user, tickspeed, target = living_target))
		user.stamina_add(-2.5)

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


// Cure rot
/obj/effect/proc_holder/spell/invoked/cure_rot
	name = "Cure Rot"
	overlay_state = "cure_rot"
	releasedrain = 90
	chargedrain = 0
	chargetime = 50
	range = 1
	warnie = "sydwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/revive.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 2 MINUTES
	miracle = TRUE
	devotion_cost = 30
	/// Amount of PQ gained for curing zombos
	var/unzombification_pq = PQ_GAIN_UNZOMBIFY

/obj/effect/proc_holder/spell/invoked/cure_rot/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		testing("curerot1")
		var/mob/living/target = targets[1]
		if(target == user)
			revert_cast()
			return FALSE
		if(HAS_TRAIT(target, TRAIT_ROTTOUCHED))
			to_chat(user, span_warning("The Rot has spread too deeply for even Pestra to clean."))
			revert_cast()
			return FALSE
		if(HAS_TRAIT(target, TRAIT_EXCOMMUNICATED))
			to_chat(user, span_warning("Pestra gives no answer back to clean their body from the rot."))
			revert_cast()
			return FALSE
		// If, for whatever reason, someone manages to capture a vampire with (somehow) rot??? This prevents them from losing their undead biotype.
		if(target.mind?.has_antag_datum(/datum/antagonist/vampire) || target.mind?.has_antag_datum(/datum/antagonist/vampire/lesser) || target.mind?.has_antag_datum(/datum/antagonist/vampirelord))
			to_chat(user, span_warning("It's of an incurable evil, I can't."))
			revert_cast()
			return FALSE

		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)
		testing("curerot2")

		var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
		var/become_rot_touched = FALSE
		if(rot)
			rot.amount = 0
			become_rot_touched = TRUE
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/limb in stinky.bodyparts)
				limb.rotted = FALSE
				limb.skeletonized = FALSE
				limb.update_limb()
				limb.update_disabled()

				limb.cure_infections(TRUE, FALSE)

		// un-deadite'ing process
		target.mob_biotypes &= ~MOB_UNDEAD // the zombie antag on_loss() does this as well, but this is for the times it doesn't work properly. We check if they're any special undead role first.

		for(var/trait in GLOB.traits_deadite)
			REMOVE_TRAIT(target, trait, DEADITE_TRAIT)

		if(target.stat < DEAD) // Drag and shove ghost back in.
			var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
			if(underworld_spirit)
				var/mob/dead/observer/ghost = underworld_spirit.ghostize()
				ghost.mind.transfer_to(target, TRUE)
				qdel(underworld_spirit)
		target.grab_ghost(force = TRUE) // even suicides

		var/datum/antagonist/zombie/was_zombie = target.mind?.has_antag_datum(/datum/antagonist/zombie)	//This should be after putting the mind back into the target
		if(was_zombie)
			// Only kill the target if they were already a deadite -
			// NOT if they were just infected.
			if (was_zombie.has_turned)
				target.death()
				become_rot_touched = TRUE
			target.mind.remove_antag_datum(/datum/antagonist/zombie)
			// Currently, this trait is only used for determining whether to award PQ - it can stay unconditional
			// if we remove the antag datum. Pestrans shouldn't be incentivised to let infected patients die.
			if(unzombification_pq && !HAS_TRAIT(target, TRAIT_IWASUNZOMBIFIED) && user?.ckey)
				adjust_playerquality(unzombification_pq, user.ckey)
				ADD_TRAIT(target, TRAIT_IWASUNZOMBIFIED, "[type]")

		if (become_rot_touched)
			ADD_TRAIT(target, TRAIT_ROTTOUCHED, "[type]")

		target.update_body()
		target.visible_message(span_notice("The rot leaves [target]'s body!"), span_green("I feel the rot leave my body!"))
		if(target.mind?.funeral && (target.stat != DEAD) && !CONFIG_GET(flag/force_respawn_on_funeral))
			to_chat(target, span_warning("My funeral rites are undone!"))
			target.mind.funeral = FALSE
		return TRUE

	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/cure_rot/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need a holy cross."))
		return FALSE
	return TRUE
