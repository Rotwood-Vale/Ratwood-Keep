/obj/effect/proc_holder/spell/invoked/diagnose/secular
	name = "Secular Diagnosis"
	overlay_state = "diagnose"
	range = 1
	associated_skill = /datum/skill/misc/treatment
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/docheal  /////// miricle on 3x cooldown from normal
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Rapid Treatment"
	overlay_state = "doc"
	range = 1
	include_user = TRUE
	sound = 'sound/gore/flesh_eat_03.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/docheallsser  /////// lesser miricle, granted by enchanted rings
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Close Wounds"
	overlay_state = "doc"
	range = 1
	include_user = TRUE
	sound = 'sound/gore/flesh_eat_03.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/stable // sets ox lose to 0 knocks out some toxin, brings blood levels to safe. epi stabalizes ox lose, antihol purges booze, water and iron slowly restores blood.
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Stabilising Syringe"
	overlay_state = "stable"
	range = 1
	sound = 'modular/Smoker/sound/inject.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	include_user = TRUE
	charge_max = 5 MINUTES
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/purge // Purges all reagents and clears all toxin damage while lowering blood levels and hitting with brute
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Purifying Blood Draw"
	overlay_state = "snek"
	range = 1
	include_user = TRUE
	sound = 'sound/combat/newstuck.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 5 MINUTES
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/debride // Cure rot if has weak liver debuff
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Tissue Debridement"
	overlay_state = "unrot"
	range = 1
	include_user = FALSE
	sound = 'sound/combat/newstuck.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 1 MINUTES
	miracle = FALSE
	devotion_cost = 0
	/// Amount of PQ gained for curing zombos
	var/unzombification_pq = PQ_GAIN_UNZOMBIFY

/obj/effect/proc_holder/spell/targeted/cpr
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Cardiac Massage"
	overlay_state = "cpr"
	range = 1
	include_user = FALSE
	sound = 'sound/combat/newstuck.ogg'
	associated_skill = /datum/skill/misc/treatment
	antimagic_allowed = TRUE
	charge_max = 1 MINUTES
	miracle = FALSE
	devotion_cost = 0
	/// Amount of PQ gained for reviving
	var/revive_pq = PQ_GAIN_REVIVE

/obj/effect/proc_holder/spell/targeted/cpr/cast(list/targets, mob/living/user)
	. = ..()

	if(!isliving(targets[1]))
		revert_cast()
		return FALSE

	var/mob/living/target = targets[1]
	if(target == user)
		revert_cast()
		return FALSE
	if(target.stat < DEAD)
		to_chat(user, span_warning("Nothing happens."))
		revert_cast()
		return FALSE
	if(HAS_TRAIT(target, TRAIT_RITUALIZED))
		to_chat(user, span_warning("The life essence was sucked out of this body."))
		revert_cast()
		return FALSE
	if(world.time > target.mob_timers["lastdied"] + 10 MINUTES)
		to_chat(user, span_warning("It's too late."))
		revert_cast()
		return FALSE
	if(target.mob_biotypes & MOB_UNDEAD)
		to_chat(user, span_warning("It's undead, I can't."))
		revert_cast()
		return FALSE
	if(!target.revive(full_heal = FALSE))
		to_chat(user, span_warning("They need to be mended more."))
		revert_cast()
		return FALSE
	
	var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
	//GET OVER HERE!
	if(underworld_spirit)
		var/mob/dead/observer/ghost = underworld_spirit.ghostize()
		qdel(underworld_spirit)
		ghost.mind.transfer_to(target, TRUE)
	target.grab_ghost(force = TRUE)
	target.emote("breathgasp")
	target.Jitter(100)
	if(isseelie(target))
		var/mob/living/carbon/human/fairy_target = target
		fairy_target.set_heartattack(FALSE)
		var/obj/item/organ/wings/Wing = fairy_target.getorganslot(ORGAN_SLOT_WINGS)
		if(Wing == null)
			var/wing_type = fairy_target.dna.species.organs[ORGAN_SLOT_WINGS]
			var/obj/item/organ/wings/seelie/new_wings = new wing_type()
			new_wings.Insert(fairy_target)
	target.update_body()
	target.visible_message(span_notice("[target] is revived by holy light!"), span_green("I awake from the void."))
	target.mind?.remove_antag_datum(/datum/antagonist/zombie)
	return TRUE

/obj/effect/proc_holder/spell/targeted/cpr/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		revert_cast()
		return FALSE
	var/found = null
	for(var/obj/structure/bed/rogue/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need them on a bed."))
		revert_cast()
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/targeted/debride/cast(list/targets, mob/living/user)

	if(!isliving(targets[1]))
		revert_cast()
		return FALSE

	if(!targets[1].has_status_effect(/datum/status_effect/debuff/wliver))
		to_chat(user, span_warning("I need to prime their liver first"))
		revert_cast() // No need to consume the spell if it isn't properly cast.
		return FALSE

	var/mob/living/target = targets[1]

	if(target == user)
		revert_cast()
		return FALSE

	// If, for whatever reason, someone manages to capture a vampire with (somehow) rot??? This prevents them from losing their undead biotype.
	if(target.mind?.has_antag_datum(/datum/antagonist/vampire) || target.mind?.has_antag_datum(/datum/antagonist/vampire/lesser) || target.mind?.has_antag_datum(/datum/antagonist/vampirelord))
		to_chat(user, span_warning("It's of an incurable evil, I can't."))
		revert_cast()
		return FALSE

	var/datum/antagonist/zombie/was_zombie = target.mind?.has_antag_datum(/datum/antagonist/zombie)

	if(was_zombie)
		target.mind.remove_antag_datum(/datum/antagonist/zombie)
		target.Unconscious(20 SECONDS)
		target.emote("breathgasp")
		target.Jitter(100)
		if(unzombification_pq && !HAS_TRAIT(target, TRAIT_IWASUNZOMBIFIED) && user?.ckey)
			adjust_playerquality(unzombification_pq, user.ckey)
			ADD_TRAIT(target, TRAIT_IWASUNZOMBIFIED, TRAIT_GENERIC)

	var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)

	if(rot)
		rot.amount = 0

	if(iscarbon(target))
		var/mob/living/carbon/stinky = target
		for(var/obj/item/bodypart/limb in stinky.bodyparts)
			limb.rotted = FALSE
			limb.skeletonized = FALSE
			limb.update_limb()
			limb.update_disabled()

	// Specific edge-case where a body rots without a head or rots after a head is placed back on. We always want this gone so we can at least revive the person even if there is no mind, this is caused by the failure to remove the zombie antag datum.
	// un-deadite'ing process
	target.mob_biotypes &= ~MOB_UNDEAD // the zombie antag on_loss() does this as well, but this is for the times it doesn't work properly. We check if they're any special undead role first.

	for(var/trait in GLOB.traits_deadite)
		REMOVE_TRAIT(target, trait, TRAIT_GENERIC)

	if(target.stat < DEAD) // Drag and shove ghost back in.
		var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
		if(underworld_spirit)
			var/mob/dead/observer/ghost = underworld_spirit.ghostize()
			ghost.mind.transfer_to(target, TRUE)
			qdel(underworld_spirit)
	target.grab_ghost(force = TRUE) // even suicides
	
	target.update_body()
	target.visible_message(span_notice("The rot leaves [target]'s body!"), span_green("I feel the rot leave my body!"))

	return TRUE

/obj/effect/proc_holder/spell/targeted/debride/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		revert_cast()
		return FALSE
	var/found = null
	for(var/obj/structure/bed/rogue/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need to lay them on a bed"))
		revert_cast()
		return FALSE
	return TRUE


/obj/effect/proc_holder/spell/targeted/docheal/cast(list/targets, mob/living/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_green("[user] tends to [target]'s wounds."), span_notice("I feel better already."))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(50, 50))
					C.update_damage_overlays()
				if(affecting.heal_wounds(50))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-50)
			target.adjustFireLoss(-50)
		target.adjustToxLoss(-50)
		target.adjustOxyLoss(-50)
		target.blood_volume += BLOOD_VOLUME_SURVIVE
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/targeted/docheallsser/cast(list/targets, mob/living/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_green("[user] tends to [target]'s wounds."), span_notice("I feel better already."))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(25, 25))
					C.update_damage_overlays()
				if(affecting.heal_wounds(25))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-25)
			target.adjustFireLoss(-25)
		target.adjustToxLoss(-25)
		target.adjustOxyLoss(-25)
		target.blood_volume += BLOOD_VOLUME_SURVIVE/2
		return TRUE
	return FALSE


/obj/effect/proc_holder/spell/targeted/stable/cast(list/targets, mob/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/ramount = 10
		var/rid = /datum/reagent/medicine/stimu
		target.reagents.add_reagent(rid, ramount)
		target.visible_message(span_green("[user] stabs [target]'s chest with a syringe."), span_notice("My grip on life tightens!"))
		target.setOxyLoss(-100)
		target.adjustToxLoss(-50)
		target.emote("rage")
		target.blood_volume += BLOOD_VOLUME_SURVIVE
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/targeted/purge/cast(list/targets, mob/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/obj/item/bodypart/BPA = target.get_bodypart(user.zone_selected)
		if(!BPA)
			to_chat(user, span_warning("They're missing that part!"))
			revert_cast()
			return FALSE
		BPA.add_wound(/datum/wound/artery/)
		target.visible_message(span_danger("[user] drains the reagents and toxins from [target]."))
		target.adjustToxLoss(-999)
		target.reagents.remove_all_type(/datum/reagent, 9999)
		target.emote("scream")
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/targeted/purge/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		revert_cast()
		return FALSE
	var/found = null
	for(var/obj/structure/bed/rogue/S in oview(2, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need to lay them on a bed."))
		revert_cast()
		return FALSE
	return TRUE

/obj/item/organ/liver/weak
	name = "weakened liver"
	desc = "This seems hardly functional."

/datum/status_effect/debuff/wliver
	id = "wliver"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/wliver
	effectedstats = list("strength" = -3, "constitution" = -3, "endurance" = -3, "speed" = -3)

/atom/movable/screen/alert/status_effect/debuff/wliver
	name = "Weak Liver"
	desc = "I feel drained and sluggish. I'm feeling abdominal pain from my liver."

/obj/item/organ/liver/weak/Insert(mob/living/carbon/M)
	..()
	if(M)
		M.apply_status_effect(/datum/status_effect/debuff/wliver)

/obj/item/organ/liver/weak/Remove(mob/living/carbon/M, special = 0)
	..()
	if(M.has_status_effect(/datum/status_effect/debuff/wliver))
		M.remove_status_effect(/datum/status_effect/debuff/wliver)

/datum/surgery/hepa
	name = "Hepatectomy"
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_PRECISE_STOMACH)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/resection,
		/datum/surgery_step/cauterize,
	)

/datum/surgery_step/resection
	name = "Perform Liver Rejuvination"
	time = 20 SECONDS
	accept_hand = FALSE
	possible_locs = list(BODY_ZONE_PRECISE_STOMACH)
	implements = list(
		TOOL_SCALPEL = 60,
		TOOL_SHARP = 40,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	surgery_flags = SURGERY_INCISED | SURGERY_RETRACTED
	skill_min = SKILL_LEVEL_EXPERT
	skill_median = SKILL_LEVEL_MASTER

/datum/surgery_step/resection/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(target.has_status_effect(/datum/status_effect/debuff/wliver))
		to_chat(user, "Their liver is too weak")
		return FALSE
	else
		display_results(user, target, span_notice("I begin a resection on [target]'s liver..."),
			span_notice("[user] begins to carve into [target]'s liver."),
			span_notice("[user] begins to carve into [target]'s liver."))
		return TRUE

/datum/surgery_step/resection/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I successfully resect damaged and infected portions of [target]'s liver."),
		span_notice("[user] successfully carves out chunks of [target]'s liver, restoring its function!"),
		span_notice("[user] successfully carves out chunks of [target]'s liver, restoring its function!"))
	var/obj/item/organ/liver/liver = target.getorganslot(ORGAN_SLOT_LIVER)
	if(liver)
		liver.Remove(target)
		QDEL_NULL(liver)
		liver = new /obj/item/organ/liver/weak
		liver.Insert(target)
		return TRUE

//------------------------------------------------reagents--------------------------------------------//

/obj/item/reagent_containers/powder/alch
	name = "essence"
	desc = "powderized and ready to brew"
	gender = PLURAL
	icon_state = "salt"
	can_brew = TRUE
	list_reagents = null
	grind_results = null
	volume = 24

/obj/item/reagent_containers/powder/alch/berry
	name = "essence of berry"
	gender = PLURAL
	icon_state = "salt"
	color = "#4682b4"
	brew_reagent = /datum/reagent/alch/syrum_berry
	brew_amt = 24
	can_brew = TRUE
	list_reagents = null
	grind_results = null
	volume = 24

/obj/item/reagent_containers/powder/alch/berryp
	name = "essence of poison berry"
	gender = PLURAL
	icon_state = "salt"
	color = "#61DE2A"
	brew_reagent = /datum/reagent/alch/syrum_poison_berry
	brew_amt = 24
	can_brew = TRUE
	list_reagents = null
	grind_results = list(/datum/reagent/berrypoison = 10)
	volume = 10

/obj/item/reagent_containers/powder/alch/mincem
	name = "essence of flesh"
	gender = PLURAL
	icon_state = "salt"
	color = "#ff7f7f"
	can_brew = TRUE
	brew_reagent = /datum/reagent/alch/syrum_meat
	brew_amt = 24
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	grind_results = null
	volume = 10

/obj/item/reagent_containers/powder/alch/mincef
	name = "essence of fish"
	gender = PLURAL
	icon_state = "salt"
	color = "#ff7f7f"
	brew_reagent = /datum/reagent/alch/syrum_fish
	brew_amt = 24
	can_brew = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	grind_results = null
	volume = 10

/obj/item/reagent_containers/powder/alch/stone
	name = "essence of earth"
	gender = PLURAL
	icon_state = "salt"
	brew_reagent = /datum/reagent/alch/syrum_stone
	brew_amt = 24
	can_brew = TRUE
	color = "#808080"
	list_reagents = null
	grind_results = null
	volume = 10

/obj/item/reagent_containers/powder/alch/pipe
	name = "essence of addiction"
	gender = PLURAL
	icon_state = "salt"
	brew_reagent = /datum/reagent/alch/syrum_westleach_leaf
	brew_amt = 24
	can_brew = TRUE
	color = "#808080"
	list_reagents = list(/datum/reagent/drug/nicotine = 30)
	grind_results = null
	volume = 10

/obj/item/reagent_containers/powder/alch/swamp
	name = "essence of clarity"
	gender = PLURAL
	icon_state = "salt"
	brew_reagent = /datum/reagent/alch/syrum_swamp_weed
	brew_amt = 24
	can_brew = TRUE
	color = "#61DE2A"
	list_reagents = list(/datum/reagent/drug/space_drugs = 30)
	grind_results = null
	volume = 10

/datum/reagent/alch
	name = "hmm"
	description = "shouldnt see this"
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_ash
	name = "syrum of fire"
	description = "refined viscous ash"
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 1 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_westleach_leaf
	name = "west syrum"
	description = "refined west essence"
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_swamp_weed
	name = "swamp syrum"
	description = "refined berry poison"
	reagent_state = LIQUID
	color = "#61DE2A"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_meat
	name = "meaty syrum"
	description = "refined viscous slop"
	reagent_state = LIQUID
	color = "#ff7f7f"
	metabolization_rate = 1 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_fish
	name = "fishy syrum"
	description = "refined viscous fishy smelling gunk"
	reagent_state = LIQUID
	color = "#ff7f7f"
	metabolization_rate = 1 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_stone
	name = "earthy syrum"
	description = "refined liquid state stone"
	reagent_state = LIQUID
	color = "#E2E5DE"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_salt
	name = "salty syrum"
	description = "refined liquid state salt"
	reagent_state = LIQUID
	color = "#E2E5DE"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_poison_berry
	name = "poison syrum"
	description = "refined berry poison"
	reagent_state = LIQUID
	color = "#61DE2A"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/syrum_berry
	name = "berry syrum"
	description = "refined berry essence"
	reagent_state = LIQUID
	color = "#61DE2A"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/medicine/caffeine
	name = "caffeine"
	description = "No Sleep"
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 20 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/medicine/stimu
	name = "Stimu"
	description = "crit stabalizer and blood restorer painkiller"
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/alch/on_mob_metabolize(mob/living/carbon/M)
	if(prob(50))
		M.confused = max(M.confused+3,0)
	M.emote(pick("cough"))

/datum/reagent/alch/syrum_ash/on_mob_metabolize(mob/living/carbon/M)
	M.adjustToxLoss(-1*REM, 0)
	M.adjustFireLoss(0.25*REM, 0)
	M.reagents.remove_all_type(/datum/reagent, 1)
	M.emote(pick("gag"))

/datum/reagent/alch/syrum_poison_berry/on_mob_metabolize(mob/living/carbon/M)
	M.add_nausea(9)
	M.adjustToxLoss(2, 0)

/datum/reagent/medicine/caffeine/on_mob_life(mob/living/carbon/M)
	M.energy_add(800)
	..()
	. = 1
	if(M.has_status_effect(/datum/status_effect/debuff/sleepytime))
		M.remove_status_effect(/datum/status_effect/debuff/sleepytime)
		M.remove_stress(/datum/stressevent/sleepytime)
		M.mind.sleep_adv.advance_cycle()

/datum/reagent/medicine/caffeine
	name = "caffeine"
	description = "No Sleep"
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 20 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/medicine/stimu
	name = "Stimu"
	description = "crit stabalizer and blood restorer painkiller"
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/medicine/stimu/on_mob_metabolize(mob/living/carbon/M)
	..()
	ADD_TRAIT(M, TRAIT_NOCRITDAMAGE, TRAIT_GENERIC)
	ADD_TRAIT(M, TRAIT_NOPAIN, TRAIT_GENERIC)

/datum/reagent/medicine/stimu/on_mob_end_metabolize(mob/living/carbon/M)
	REMOVE_TRAIT(M, TRAIT_NOCRITDAMAGE, TRAIT_GENERIC)
	REMOVE_TRAIT(M, TRAIT_NOPAIN, TRAIT_GENERIC)
	..()

/datum/reagent/medicine/stimu/on_mob_life(mob/living/carbon/M)
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.heal_wounds(2) //same as health pot only heal wounds while bleeding. technically.
		M.blood_volume = min(M.blood_volume+15, BLOOD_VOLUME_NORMAL)
	if(M.health <= M.crit_threshold)
		M.adjustToxLoss(-0.5*REM, 0)
		M.adjustBruteLoss(-0.5*REM, 0)
		M.adjustFireLoss(-0.5*REM, 0)
		M.adjustOxyLoss(-0.5*REM, 0)
	if(M.losebreath >= 4)
		M.losebreath -= 2
	if(M.losebreath < 0)
		M.losebreath = 0
	..()

/datum/reagent/medicine/purify
	name = "PURIFY"
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = null
	description = "A powerful drug that purifies the blood and seals wounds painfully on the body."

/datum/reagent/medicine/purify/on_mob_life(mob/living/carbon/human/M)
	M.adjustFireLoss(0.5*REM, 0)
	M.heal_wounds(3)

	// Iterate through all body parts
	for (var/obj/item/bodypart/B in M.bodyparts)
		// Iterate through wounds on each body part
		for (var/datum/wound/W in B.wounds)
			// Check for and remove zombie infection
			if (W.zombie_infection_timer)
				deltimer(W.zombie_infection_timer)
				W.zombie_infection_timer = null
				to_chat(M, "You feel the drugs burning intensely in [B.name].")
			// Check for and remove werewolf infection
			if (W.werewolf_infection_timer)
				deltimer(W.werewolf_infection_timer)
				W.werewolf_infection_timer = null
				to_chat(M, "You feel the drugs burning intensely in [B.name].")

			// Handle destruction of the wound
			W.Destroy(0)

	M.update_damage_overlays()


//---------------------------------------alch reactions----------------------------------------------//


/datum/chemical_reaction/alch
	name = "debug alch reaction"
	mix_sound = 'sound/items/fillbottle.ogg'
	id = /datum/reagent/alch
	required_container = /obj/item/reagent_containers/glass/alembic

/datum/chemical_reaction/alch/lesserhealth
	name = "lesser health pot"
	id = /datum/reagent/medicine/lesserhealthpot
	results = list(/datum/reagent/medicine/lesserhealthpot = 45) //15 oz
	required_reagents = list(/datum/reagent/alch/syrum_meat = 24, /datum/reagent/alch/syrum_ash = 24)

/datum/chemical_reaction/alch/health //purify minor health pot into half a bottle by using essence of clarity (swampweed)
	name = "health pot purification"
	id = /datum/reagent/medicine/healthpot
	results = list(/datum/reagent/medicine/healthpot = 22.5) //about 7.5 oz
	required_reagents = list(/datum/reagent/medicine/lesserhealthpot = 45, /datum/reagent/alch/syrum_swamp_weed = 24)


/datum/chemical_reaction/alch/greaterhealth //purify health pot into half a bottle of super by using essence of poison (poison berry) which used to be in the old red recipe
	name = "greater health pot purification"
	id = /datum/reagent/medicine/greaterhealthpot
	results = list(/datum/reagent/medicine/greaterhealthpot = 22.5) //about 7.5 oz
	required_reagents = list(/datum/reagent/medicine/healthpot = 45, /datum/reagent/alch/syrum_poison_berry = 24)

/*documentation: 15 oz = 45 units
2 lesser health makes 1 health bottle, 2 health makes 1 greater health
you need 4 lesser bottles to make 2 health to make 1 half bottle of greater
8 lesser bottles for 1 bottle of greater 
end recipe count: 8 ash, 8 minced meat, 4 swampweed, 2 poisonberry to make 1 bottle of greater*/

/datum/chemical_reaction/alch/mana
	name = "mana pot"
	id = /datum/reagent/medicine/manapot
	results = list(/datum/reagent/medicine/manapot = 45)
	required_reagents = list(/datum/reagent/alch/syrum_fish = 24, /datum/reagent/alch/syrum_ash = 24)

/datum/chemical_reaction/alch/salt
	name = "saltify"
	id = "saltify"
	required_reagents = list(/datum/reagent/alch/syrum_stone = 24, /datum/reagent/alch/syrum_ash = 24)

/datum/chemical_reaction/alch/salt/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/salt(location)

/datum/chemical_reaction/alch/ozium
	name = "oziumify"
	id = "oziumify"
	required_reagents = list(/datum/reagent/alch/syrum_poison_berry = 24, /datum/reagent/alch/syrum_swamp_weed = 24)

/datum/chemical_reaction/alch/ozium/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/ozium(location)

/datum/chemical_reaction/alch/moon
	name = "moondustify"
	id = "moondustify"
	required_reagents = list(/datum/reagent/alch/syrum_poison_berry = 24, /datum/reagent/alch/syrum_westleach_leaf = 24)

/datum/chemical_reaction/alch/moon/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/moondust(location)

/datum/chemical_reaction/alch/puresalt
	name = "puresalt"
	id = "puresalt"
	required_reagents = list(/datum/reagent/water/salty = 30) //Boil off the water to get pure salt
	results = list(/datum/reagent/rawsalt = 15)
	
/datum/chemical_reaction/alch/saltsea
	name = "saltsea"
	id = "saltsea"
	required_reagents = list(/datum/reagent/rawsalt = 15)

/datum/chemical_reaction/alch/saltsea/on_reaction(datum/reagents/holder, created_volume)	
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/salt(location)

/datum/chemical_reaction/alch/spice
	name = "spiceify"
	id = "spiceify"
	required_reagents = list(/datum/reagent/alch/syrum_swamp_weed = 24, /datum/reagent/alch/syrum_westleach_leaf = 24)

/datum/chemical_reaction/alch/spice/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/spice(location)

/datum/chemical_reaction/alch/pure
	name = "clean moondustify"
	id = "clean moondustify"
	required_reagents = list(/datum/reagent/ozium = 15, /datum/reagent/moondust = 15)

/datum/chemical_reaction/alch/pure/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/powder/moondust_purest(location)

//------------------------------------tools and pre made bottles-----------------------------------------//

/obj/item/storage/backpack/rogue/backpack/rucksack
	name = "rucksack"
	desc = "A bulky backpack worn on the back which can store many items."
	icon_state = "rucksack"
	item_state = "rucksack"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = NONE
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE

/obj/item/storage/backpack/rogue/backpack/rucksack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 42
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 10
		STR.not_while_equipped = TRUE

/obj/item/rogueweapon/surgery/saw/improv
	name = "improvised saw"
	desc = "A tool used to carve through bone... poorly, but better than nothing."
	icon_state = "bonesaw_wood"
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/cleaver)
	slot_flags = ITEM_SLOT_HIP
	parrysound = list('sound/combat/parry/bladed/bladedmedium (1).ogg','sound/combat/parry/bladed/bladedmedium (2).ogg','sound/combat/parry/bladed/bladedmedium (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshmed (1).ogg','sound/combat/wooshes/bladed/wooshmed (2).ogg','sound/combat/wooshes/bladed/wooshmed (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	force = 12
	throwforce = 12
	wdefense = 3
	wbalance = 1
	w_class = WEIGHT_CLASS_NORMAL
	thrown_bclass = BCLASS_CHOP
	tool_behaviour = TOOL_IMPROVSAW

/obj/item/rogueweapon/surgery/hemostat/improv
	name = "improvised clamp"
	desc = "A tool used to clamp down on soft tissue. A poor alternative to metal but, better than nothing."
	icon_state = "forceps_wood"
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	tool_behaviour = TOOL_IMPROVHEMOSTAT

/obj/item/rogueweapon/surgery/retractor/improv
	name = "improvised retractor"
	desc = "A tool used to spread tissue open for surgical access. hopefully it will hold."
	icon_state = "speculum_wood"
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	wdefense = 3
	wbalance = 1
	w_class = WEIGHT_CLASS_NORMAL
	thrown_bclass = BCLASS_BLUNT
	tool_behaviour = TOOL_IMPROVRETRACTOR

/obj/item/storage/fancy/pilltin
	name = "pill tin"
	desc = "A tin for all your pill needs."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "pilltin"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 1
	slot_flags = null
	icon_type = "pill"

/obj/item/storage/fancy/pilltin/update_icon()
	if(fancy_open)
		if(contents.len == 0)
			icon_state = "pilltin_empty"
		else if(istype(contents[1], /obj/item/reagent_containers/pill/caffpill))
			icon_state = "pilltinwake_open"
		else if(istype(contents[1], /obj/item/reagent_containers/pill/pnkpill))
			icon_state = "pilltinpink_open"
		else
			icon_state = "pilltincustom_open"
	else
		icon_state = "pilltin"

/obj/item/storage/fancy/pilltin/MiddleClick(mob/user, params)
	fancy_open = !fancy_open
	update_icon()
	to_chat(user, span_notice("[src] is now [fancy_open ? "open" : "closed"]."))

/obj/item/storage/fancy/pilltin/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 42
		STR.max_w_class = WEIGHT_CLASS_NORMAL
		STR.max_items = 12
		STR.set_holdable(list(/obj/item/reagent_containers/pill))

/obj/item/storage/fancy/pilltin/wake
	name = "pill tin (wake)"

/obj/item/storage/fancy/pilltin/wake/PopulateContents()
	new /obj/item/reagent_containers/pill/caffpill(src)
	new /obj/item/reagent_containers/pill/caffpill(src)
	new /obj/item/reagent_containers/pill/caffpill(src)

/obj/item/storage/fancy/skit
	name = "surgery kit"
	desc = "portable and compact"
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "skit"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_HIP
	throwforce = 1

/obj/item/storage/fancy/skit/update_icon()
	if(fancy_open)
		if(contents.len == 0)
			icon_state = "skit_empty"
		else
			icon_state = "skit_open"
	else
		icon_state = "skit"

/obj/item/storage/fancy/skit/examine(mob/user)
	. = ..()
	if(fancy_open)
		if(length(contents) == 1)
			. += "There is one item left."
		else
			. += "There are [contents.len <= 0 ? "no" : "[contents.len]"] items left."

/obj/item/storage/fancy/skit/attack_self(mob/user)
	fancy_open = !fancy_open
	update_icon()
	. = ..()

/obj/item/storage/fancy/skit/Entered(mob/user)
	if(!fancy_open)
		to_chat(user, span_notice("[src] needs to be opened first."))
		return
	fancy_open = TRUE
	update_icon()
	. = ..()

/obj/item/storage/fancy/skit/Exited(mob/user)
	fancy_open = FALSE
	update_icon()
	. = ..()

/obj/item/storage/fancy/skit/MiddleClick(mob/user, params)
	fancy_open = !fancy_open
	update_icon()
	to_chat(user, span_notice("[src] is now [fancy_open ? "open" : "closed"]."))

/obj/item/storage/fancy/skit/ComponentInitialize()
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 10
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 42
	STR.set_holdable(list(
		/obj/item/rogueweapon/surgery/scalpel,
		/obj/item/rogueweapon/surgery/saw,
		/obj/item/rogueweapon/surgery/hemostat,
		/obj/item/rogueweapon/surgery/retractor,
		/obj/item/rogueweapon/surgery/bonesetter,
		/obj/item/rogueweapon/surgery/cautery,
		/obj/item/natural/worms/leech/cheele,
		/obj/item/needle,
		/obj/item/needle/thorn,
		/obj/item/needle/pestra
	))

/obj/item/storage/fancy/skit/PopulateContents()
	new /obj/item/rogueweapon/surgery/scalpel(src)
	new /obj/item/rogueweapon/surgery/saw(src)
	new /obj/item/rogueweapon/surgery/hemostat(src)
	new /obj/item/rogueweapon/surgery/hemostat(src)
	new /obj/item/rogueweapon/surgery/retractor(src)
	new /obj/item/rogueweapon/surgery/bonesetter(src)
	new /obj/item/rogueweapon/surgery/cautery(src)
	new /obj/item/natural/worms/leech/cheele(src)
	new /obj/item/needle/pestra(src)

/obj/item/storage/fancy/ifak
	name = "personal patch kit"
	desc = "Personal treatment pouch; has all you need to stop you or someone else from meeting Necra. It even comes with a little guide scroll for the slow minded."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "ifak"
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 1
	slot_flags = null

/obj/item/storage/fancy/ifak/PopulateContents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	for(var/i = 1 to STR.max_items)
		new spawn_type(src)

/obj/item/storage/fancy/ifak/update_icon()
	if(fancy_open)
		if(contents.len == 0)
			icon_state = "ifak_empty"
		else
			icon_state = "ifak_open"
	else
		icon_state = "ifak"

/obj/item/storage/fancy/ifak/examine(mob/user)
	. = ..()
	if(fancy_open)
		if(length(contents) == 1)
			. += "There is one item left."
		else
			. += "There are [contents.len <= 0 ? "no" : "[contents.len]"] items left."

/obj/item/storage/fancy/ifak/attack_self(mob/user)
	fancy_open = !fancy_open
	update_icon()
	. = ..()

/obj/item/storage/fancy/ifak/Entered(mob/user)
	if(!fancy_open)
		to_chat(user, span_notice("[src] needs to be opened first."))
		return
	fancy_open = TRUE
	update_icon()
	. = ..()

/obj/item/storage/fancy/ifak/Exited(mob/user)
	fancy_open = FALSE
	update_icon()
	. = ..()

/obj/item/storage/fancy/ifak/MiddleClick(mob/user, params)
	fancy_open = !fancy_open
	update_icon()
	to_chat(user, span_notice("[src] is now [fancy_open ? "open" : "closed"]."))

/obj/item/storage/fancy/ifak/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 8
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 42
	STR.set_holdable(list(
		/obj/item/reagent_containers/hypospray/medipen/sealbottle/reju,
		/obj/item/reagent_containers/hypospray/medipen/sty/detox,
		/obj/item/natural/cloth/bandage,
		/obj/item/natural/bundle/cloth/bandage,
		/obj/item/natural/bundle/cloth/bandage/full,
		/obj/item/reagent_containers/pill/pnkpill,
		/obj/item/candle,
		/obj/item/needle,
		/obj/item/needle/thorn,
		/obj/item/needle/pestra,
	))

/obj/item/storage/fancy/ifak/PopulateContents()
	new /obj/item/reagent_containers/hypospray/medipen/sealbottle/reju(src)
	new /obj/item/natural/bundle/cloth/bandage/full(src)
	new /obj/item/reagent_containers/hypospray/medipen/sty/detox(src)
	new /obj/item/reagent_containers/pill/pnkpill(src)
	new /obj/item/candle/yellow(src)
	new /obj/item/needle(src)
	new /obj/item/book/rogue/medical_notebook(src)

/obj/item/reagent_containers/hypospray/medipen/sealbottle
	name = "sealed bottle item"
	desc = "If you see this, call an admin."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "THEbottle"

/obj/item/reagent_containers/hypospray/medipen/sealbottle/attack_self(mob/user)
	if(has_cap)
		has_cap = FALSE
		icon_state = "[icon_state]_nocap"  // Update icon state for no cap
		to_chat(user, span_notice("You thumb off the cork from [src]."))
		playsound(src, 'modular/Smoker/sound/corkpop.ogg', 100, TRUE)
	else
		to_chat(user, span_warning("[src] doesn't have a cork."))

/obj/item/reagent_containers/hypospray/medipen/sealbottle/update_icon()
	if(reagents.total_volume > 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]0"

/obj/item/reagent_containers/hypospray/medipen/sealbottle/inject(mob/living/M, mob/user)
	if(reagents.total_volume <= 0)
		return FALSE
	if(!M)
		return FALSE
	if(user == M)
		to_chat(user, span_danger("You chug [src]!"))
	else
		to_chat(user, span_danger("You force [M] to swallow [src]."))
	reagents.trans_to(M, reagents.total_volume, transfered_by = user)  // Transfer all remaining reagents
	reagents.maximum_volume = 0  // Makes them useless afterwards
	reagents.flags = NONE  // Ensure reagents are deactivated
	update_icon()
	playsound(src, 'modular/Smoker/sound/chug.ogg', 100, TRUE)
	return TRUE

/obj/item/reagent_containers/hypospray/medipen/sealbottle/attack(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		if(has_cap)
			to_chat(user, span_warning("[src] has a cork still! You need to remove it first."))
			return
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/sealbottle/attack(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		if(has_cap)
			to_chat(user, span_warning("[src] has a cork still! You need to remove it first."))
			return
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/sty
	name = "sealed sty"
	desc = "If you see this, call an admin."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "sty"

/obj/item/reagent_containers/hypospray/medipen/sty/attack_self(mob/user)
	if(has_cap)
		has_cap = FALSE
		icon_state = "[icon_state]_nocap"  // Update icon state for no cap
		to_chat(user, span_notice("You bite the cap off [src] and spit it out."))
		playsound(src, 'modular/Smoker/sound/capoff.ogg', 100, TRUE)
	else
		to_chat(user, span_warning("[src] doesn't have a cap."))

/obj/item/reagent_containers/hypospray/medipen/sty/update_icon()
	if(reagents.total_volume > 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]0"

/obj/item/reagent_containers/hypospray/medipen/sty/inject(mob/living/M, mob/user)
	if(reagents.total_volume <= 0)
		return FALSE
	if(!M)
		return FALSE
	if(user == M)
		to_chat(user, span_danger("You inject yourself with [src]."))
	else
		to_chat(user, span_danger("You inject [M] with [src]!"))
	reagents.trans_to(M, reagents.total_volume, transfered_by = user)  // Transfer all remaining reagents
	reagents.maximum_volume = 0  // Makes them useless afterwards
	reagents.flags = NONE  // Ensure reagents are deactivated
	update_icon()
	playsound(src, 'modular/Smoker/sound/inject.ogg', 100, TRUE)
	return TRUE

/obj/item/reagent_containers/hypospray/medipen/sty/attack(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		if(has_cap)
			to_chat(user, span_warning("[src] has a cap still! You need to remove it first."))
			return
		inject(user, user)

/obj/item/reagent_containers/pill/caffpill
	name = "WAKE-UP"
	desc = "Pep-pills. A promise to make you alert."
	icon_state = "pillg"
	icon = 'icons/roguetown/items/surgery.dmi'
	list_reagents = list(/datum/reagent/medicine/caffeine = 1, /datum/reagent/medicine/antihol = 10, /datum/reagent/consumable/coffee = 81) //coffee OD is safe. causes jitters for awhile.
	dissolvable = FALSE
	grind_results = null

/obj/item/reagent_containers/pill/pnkpill
	name = "PNKBAWLS"
	desc = "Little pink balls. From a cursory glance, you can be pretty certain this is watered down red and ash."
	icon_state = "pinkb"
	icon = 'icons/roguetown/items/surgery.dmi'
	list_reagents = list(/datum/reagent/ash = 15, /datum/reagent/iron = 15, /datum/reagent/medicine/healthpot = 15)
	dissolvable = FALSE
	grind_results = null

/obj/item/reagent_containers/hypospray/medipen/sty/detox
	name = "DETOX"
	desc = "Purges the body of all that is not natural."
	volume = 34
	amount_per_transfer_from_this = 34
	list_reagents = list(/datum/reagent/medicine/antihol = 10, /datum/reagent/medicine/pen_acid = 24)

/obj/item/reagent_containers/hypospray/medipen/sealbottle/reju
	name = "rejuv elixer"
	desc = "Restores blood, seals wounds, helps to stabalize breathing and lightly numbs pain."
	icon_state = "THEbottle"
	volume = 16
	amount_per_transfer_from_this = 16
	list_reagents = list(/datum/reagent/medicine/stimu = 15, /datum/reagent/medicine/caffeine = 1)

/obj/item/reagent_containers/hypospray/medipen/sealbottle/purify
	name = "purifying elixer"
	desc = "A powerful drug that purifies the blood and seals wounds on the body. Painfully."
	icon_state = "THEbottle"
	volume = 30
	amount_per_transfer_from_this = 30
	list_reagents = list(/datum/reagent/medicine/purify = 20, /datum/reagent/ozium = 5, /datum/reagent/consumable/ethanol/hooch = 5) // lil laudanum for your troubles

/obj/item/natural/cloth/bandage
	name = "bandage"
	desc = "A simple bandage used to bind wounds. takes longer to apply but is more effective than just cloth. Slowly heals wounds and binded fractures."
	icon_state = "bandageroll"
	icon = 'icons/roguetown/items/surgery.dmi'
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH | ITEM_SLOT_HIP
	body_parts_covered = null
	experimental_onhip = TRUE
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/cloth/bandage
	bandage_effectiveness = 1

/obj/item/natural/cloth/bandage/attack(mob/living/carbon/human/M, mob/user)
	if (!M.can_inject(user, TRUE)) return
	if (!ishuman(M)) return
	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if (!affecting) return
	if (affecting.bandage)
		to_chat(user, "There is already a bandage.")
		return
	var/used_time = 100
	if (H.mind)
		used_time -= (H.mind.get_skill_level(/datum/skill/misc/treatment) * 10)
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	if (!do_mob(user, M, used_time)) return
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	user.dropItemToGround(src)
	affecting.try_bandage(src)
	H.update_damage_overlays()

	// Heal the specific body part every second while bandaged and manage wound pain and disabling effects
	addtimer(CALLBACK(src, /proc/heal_and_manage_pain_disabling, H, affecting), 10, 1, TRUE)
	if (M == user)
		user.visible_message("You bandage your [affecting].")
	else
		user.visible_message("You bandage [M]'s [affecting].")

/proc/heal_and_manage_pain_disabling(var/mob/living/carbon/human/H, var/obj/item/bodypart/affecting)
	if (!affecting) return
	affecting.heal_wounds(0.5)
	for (var/datum/wound/W in affecting.wounds)
		if (W.woundpain > 30)
			W.woundpain = 30

/obj/item/natural/bundle/cloth/bandage
	name = "roll of bandages"
	desc = "A bundle of bandages used to bind wounds. More effective than just cloth."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "bandageroll1"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	maxamount = 3
	firefuel = 15 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	stacktype = /obj/item/natural/cloth/bandage
	stackname = "bandages"
	icon1 = "bandageroll1"
	icon1step = 2
	icon2 = "bandageroll2"
	icon2step = 3

/obj/item/book/rogue/medical_notebook
	name = "Medical Notebook"
	desc = "A quick rundown on medical works."
	icon_state ="book6_0"
	base_icon_state = "book6"
	bookfile = "medical.json"

/obj/item/natural/bundle/cloth/bandage/full
	icon_state = "bandageroll2"
	amount = 3
	firefuel = 60 MINUTES

//------------------------------------alembic/brewing--------------------------------//

// I'm going to hate every moment of working on this.


// *cry. agony.

/obj/item/reagent_containers/glass/alembic
	name = "metal alembic"
	possible_item_intents = list(INTENT_POUR, INTENT_SPLASH, /datum/intent/fill) //It's janky and annoying to need to fill the alembic this way, but also Moricode is stupid and I'll refactor it later.
	desc = "so you're an alchemist then?"
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "alembic_empty"
	volume = 120
	reagent_flags = OPENCONTAINER|REFILLABLE|DRAINABLE|AMOUNT_VISIBLE
	var/speed_multiplier = 1 // How fast it brews. Defaults to 100% (1.0). Lower is better.
	var/list/active_brews = list()
	var/brewing_started = FALSE // Track if brewing has started
	var/datum/looping_sound/boilloop/boilloop

/obj/item
	var/can_brew = FALSE // If FALSE, this object cannot be brewed
	var/brew_reagent // If NULL and this object can be brewed, it uses a generic fruit_wine reagent and adjusts its variables
	var/brew_amt = 24
	var/brewing_time
	var/start_time
	var/mill_result = null

/obj/item/reagent_containers/glass/alembic/Initialize()
	create_reagents(100, REFILLABLE | DRAINABLE | AMOUNT_VISIBLE) // 2 Bottles capacity
	icon_state = "alembic_empty"
	boilloop = new(src, FALSE)
	. = ..()

/obj/item/reagent_containers/glass/alembic/examine(mob/user)
	. = ..()
	if (active_brews.len == 0)
		. += span_notice("The alembic is not brewing.")
	else
		. += span_notice("The alembic is brewing.")
		for (var/obj/item/I in active_brews)
			var/time_left = (I.brewing_time - (world.time - I.start_time)) / 10
			. += span_notice("[I]: [time_left] seconds left until completion.")

/obj/item/reagent_containers/glass/alembic/proc/makebrew(obj/item/I)
	if(I.reagents)
		I.reagents.remove_all_type(/datum/reagent, I.reagents.total_volume)
		I.reagents.trans_to(src, I.reagents.total_volume)
	if(I.brew_reagent)
		reagents.add_reagent(I.brew_reagent, I.brew_amt)
	qdel(I)
	active_brews -= I
	if(active_brews.len >= 2)
		icon_state = "alembic_full"
	else
		icon_state = "alembic_empty"
	playsound(src, "bubbles", 60, TRUE)
	boilloop.stop() // Stop the looping sound once brewing is done
	brewing_started = FALSE // Reset brewing status after brewing completes

/obj/item/reagent_containers/glass/alembic/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item))
		if(user.mind.get_skill_level(/datum/skill/misc/treatment) <= 2)
			to_chat(user, span_warning("I don't know how this works."))
			return TRUE
		if(!I.can_brew)
			to_chat(user, span_warning("I can't brew this into anything."))
			return TRUE
		else if(active_brews.len >= 2 || reagents.total_volume >= 99)
			to_chat(user, span_warning("I can only brew two items at a time or it is too full."))
			return TRUE
		else if(!user.transferItemToLoc(I, src))
			to_chat(user, span_warning("[I] is stuck to my hand!"))
			return TRUE
		to_chat(user, span_info("I place [I] into [src]."))
		I.start_time = world.time
		I.brewing_time = 600
		active_brews += I
		icon_state = "alembic_brew"
		boilloop.start()
		addtimer(CALLBACK(src, /obj/item/reagent_containers/glass/alembic/proc/makebrew, I), I.brewing_time)
		return TRUE
	return ..()

/obj/item/reagent_containers/glass/alembic/attack_self(mob/user)
	if(brewing_started)
		to_chat(user, span_warning("Brewing has started, you cannot remove items now."))
		return TRUE
	for(var/obj/item/I in active_brews)
		I.forceMove(drop_location())
	active_brews.Cut()
	icon_state = "alembic_empty"
	to_chat(user, span_notice("I remove the items inside."))



/obj/item/reagent_containers/glass/mortar
	name = "mortar"
	desc = "A small, thick-walled stone bowl made for grinding things up inside."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "mortar_empty"
	volume = 100
	reagent_flags = OPENCONTAINER|REFILLABLE|DRAINABLE
	spillable = FALSE
	var/obj/item/grinded
	var/grinding_started = FALSE

/obj/item/reagent_containers/glass/mortar/attack_self(mob/user)
	if(grinding_started)
		to_chat(user, "Grinding has started, you cannot remove items now.")
		return TRUE
	if(grinded)
		grinded.forceMove(drop_location())
		grinded = null
		icon_state = "mortar_empty"
		to_chat(user, "I eject the item inside.")

/obj/item/reagent_containers/glass/mortar/MiddleClick(mob/user, params)
	if(grinded)
		grinding_started = TRUE // Mark grinding as started
		to_chat(user, "I start grinding...")
		if((do_after(user, 25, target = src)) && grinded)
			if(grinded.mill_result && !istype(user.rmb_intent, /datum/rmb_intent/strong)) // This goes first. Strong intent to bypass.
				new grinded.mill_result(get_turf(src))
				QDEL_NULL(grinded)
				icon_state = reagents.total_volume > 0 ? "mortar_full" : "mortar_empty"
				grinding_started = FALSE // Reset grinding status
				return
			if(grinded.juice_results)
				grinded.on_juice()
				reagents.add_reagent_list(grinded.juice_results)
				to_chat(user, "I juice [grinded] into a fine liquid.")
			if(grinded.grind_results && !isemptylist(grinded.grind_results))
				grinded.on_grind()
				reagents.add_reagent_list(grinded.grind_results)
				to_chat(user, "I break [grinded] into powder.")
				QDEL_NULL(grinded)
				icon_state = reagents.total_volume > 0 ? "mortar_full" : "mortar_empty"
				grinding_started = FALSE // Reset grinding status
				return
			if(grinded.reagents) // Other stuff that might have reagents in them, let's not cause a runtime shall we?
				grinded.reagents.trans_to(src, grinded.reagents.total_volume, transfered_by = user)
				icon_state = reagents.total_volume > 0 ? "mortar_full" : "mortar_empty"
				to_chat(user, "I pound [grinded] into mush.")
				QDEL_NULL(grinded)
				grinding_started = FALSE // Reset grinding status
				return
			grinding_started = FALSE // Reset grinding status
			return
		else
			to_chat(user, "There is nothing to grind!")
			return

/obj/item/reagent_containers/glass/mortar/attackby(obj/item/I, mob/living/carbon/human/user)
	if(grinded)
		to_chat(user, "There is something inside already!")
		return TRUE
	if(istype(I, /obj/item/reagent_containers/glass))
		if(user.used_intent.type == INTENT_POUR)
			if(!I.reagents.total_volume)
				to_chat(user, "[I] is empty!")
				return TRUE
			if(reagents.holder_full())
				to_chat(user, "[src] is full.")
				return TRUE
			user.visible_message(span_notice("Starting the transfer"), span_notice("Completing the transfer"))
			if(user.m_intent != MOVE_INTENT_SNEAK)
				if(poursounds)
					playsound(user.loc, pick(poursounds), 100, TRUE)
			for(var/i in 1 to 10)
				if(do_after(user, 8, target = src))
					if(!I.reagents.total_volume) break
					if(reagents.holder_full()) break
					if(!I.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user))
						reagents.reaction(src, TOUCH, amount_per_transfer_from_this)
					else break
			return
		if(is_drainable() && (user.used_intent.type == /datum/intent/fill))
			if(!reagents.total_volume)
				to_chat(user, "[src] is empty!")
				return
			if(I.reagents.holder_full())
				to_chat(user, "[I] is full.")
				return
			if(user.m_intent != MOVE_INTENT_SNEAK)
				if(fillsounds)
					playsound(user.loc, pick(fillsounds), 100, TRUE)
			user.visible_message(span_notice("Starting the transfer"), span_notice("Completing the transfer"))
			for(var/i in 1 to 10)
				if(do_after(user, 8, target = src))
					if(I.reagents.holder_full()) break
					if(!reagents.total_volume) break
					reagents.trans_to(I, amount_per_transfer_from_this, transfered_by = user)
				else break
			return
	if(I.juice_results || I.grind_results || I.mill_result)
		I.forceMove(src)
		grinded = I
		icon_state = "mortar_grind"
		return
	to_chat(user, "I can't grind this!")




//-----------------------------------crafts----------------------------------------//

/datum/anvil_recipe/tools/alembic
	name = "Alembic"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/reagent_containers/glass/alembic
	i_type = "Tools"

/datum/crafting_recipe/roguetown/mortar
	name = "mortar and pestle"
	result = /obj/item/reagent_containers/glass/mortar
	reqs = list(/obj/item/grown/log/tree/stick = 1, /obj/item/grown/log/tree/small = 1,)
	skill_level = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/bandage
	name = "roll of bandages"
	result = /obj/item/natural/bundle/cloth/bandage/full
	reqs = list(/obj/item/natural/cloth = 3, /obj/item/ash = 1,)
	skill_level = 2
	skillcraft = /datum/skill/misc/treatment

/datum/crafting_recipe/roguetown/impsaw
	name = "improvised saw"
	result = /obj/item/rogueweapon/surgery/saw/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/stone = 1, /obj/item/grown/log/tree/stick = 1,)
	skill_level = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/impretra
	name = "improvised clamp"
	result = /obj/item/rogueweapon/surgery/hemostat/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2,)
	skill_level = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/imphemo
	name = "improvised retractor"
	result = /obj/item/rogueweapon/surgery/retractor/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2,)
	skill_level = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/rucksack
	name = "Rucksack"
	result = /obj/item/storage/backpack/rogue/backpack/rucksack
	reqs = list(/obj/item/rope = 1, /obj/item/storage/roguebag/crafted = 1,)
	skill_level = 0
	skillcraft = /datum/skill/craft/crafting

/*/datum/crafting_recipe/roguetown/splint
	name = "splint"
	result = /obj/item/splint
	reqs = list(/obj/item/natural/cloth = 1, /obj/item/grown/log/tree/stick = 1,)
	skill_level = 2
	skillcraft = /datum/skill/misc/treatment*/
