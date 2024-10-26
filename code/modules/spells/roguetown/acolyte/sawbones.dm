/////// SHITCODE MADE BY MORIBUND and modularized so you dickless pricks can cannibalize and swipe it easier. Sprites for this by SINNERPEN and INFRARED BARON. payed for by dragon lee. you gonna swip this shit credit thos due.




///////////////////////////////////////////////////////-----------------------------------------doc surgeries and functions---------------------------------------//////////////////////////////////////////////////


/obj/effect/proc_holder/spell/invoked/diagnose/secular
	name = "Secular Diagnosis"
	overlay_state = "diagnose"
	range = 1
	associated_skill = /datum/skill/misc/medicine
	miracle = FALSE
	devotion_cost = 0 

/obj/effect/proc_holder/spell/targeted/docheal  /////// miricle on 3x cooldown from normal
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Rapid Treatment"
	overlay_state = "doc"
	range = 1
	include_user = TRUE
	sound = 'sound/gore/flesh_eat_03.ogg'
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/stable // sets ox lose to 0 knocks out some toxin, brings blood levels to safe. epi stabalizes ox lose, antihol purges booze, water and iron slowly restores blood.
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Stabalizing Syringe"
	overlay_state = "stable"
	range = 1
	sound = 'modular/Smoker/sound/inject.ogg'
	associated_skill = /datum/skill/misc/medicine
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
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 5 MINUTES
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/targeted/debride // Cure rot if has weak liver debuff
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Tissue Debridement"
	overlay_state = "heal"
	range = 1
	include_user = FALSE
	sound = 'sound/combat/newstuck.ogg'
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	chargetime = 100
	charge_max = 2 MINUTES
	miracle = FALSE
	devotion_cost = 0
	var/unzombification_pq = PQ_GAIN_UNZOMBIFY

/obj/effect/proc_holder/spell/targeted/cpr
	action_icon = 'icons/mob/actions/roguespells.dmi'
	name = "Cardiac Massage"
	overlay_state = "heal"
	range = 1
	include_user = FALSE
	sound = 'sound/combat/newstuck.ogg'
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	chargetime = 100
	charge_max = 2 MINUTES
	miracle = FALSE
	devotion_cost = 0
	var/revive_pq = PQ_GAIN_REVIVE

/obj/effect/proc_holder/spell/targeted/cpr/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]) && targets[1].has_status_effect(/datum/status_effect/debuff/wheart))
		testing("revived1")
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		if(target.stat < DEAD)
			to_chat(user, span_warning("Nothing happens."))
			return FALSE
		if(target.mob_biotypes & MOB_UNDEAD)
			to_chat(user, span_warning("it's undead, I can't."))
			return FALSE
		if(!target.revive(full_heal = FALSE))
			to_chat(user, span_warning("they need to be mended more."))
			return FALSE
		testing("revived2")
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
		if(target.mind)
			if(revive_pq && !HAS_TRAIT(target, TRAIT_IWASREVIVED) && user?.ckey)
				adjust_playerquality(revive_pq, user.ckey)
				ADD_TRAIT(target, TRAIT_IWASREVIVED, "[type]")
			target.mind.remove_antag_datum(/datum/antagonist/zombie)
		return TRUE
	to_chat(user, span_warning("I need too prime their heart first"))
	return FALSE

/obj/effect/proc_holder/spell/targeted/cpr/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/bed/rogue/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need them on a bed"))
		return FALSE
	return TRUE



/obj/effect/proc_holder/spell/targeted/debride/cast(list/targets, mob/living/user)
	if(isliving(targets[1]) && targets[1].has_status_effect(/datum/status_effect/debuff/wliver))
		testing("curerot1")
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		var/datum/antagonist/zombie/was_zombie = target.mind?.has_antag_datum(/datum/antagonist/zombie)
		var/has_rot = was_zombie
		if(!has_rot && iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/bodypart as anything in stinky.bodyparts)
				if(bodypart.rotted || bodypart.skeletonized)
					has_rot = TRUE
					break
		if(!has_rot)
			to_chat(user, span_warning("Nothing happens."))
			return FALSE
		testing("curerot2")
		if(was_zombie)
			if(was_zombie.become_rotman && prob(10)) //10% chance to NOT become a rotman
				was_zombie.become_rotman = FALSE
			target.mind.remove_antag_datum(/datum/antagonist/zombie)
			target.Unconscious(20 SECONDS)
			target.emote("breathgasp")
			target.Jitter(100)
			if(unzombification_pq && !HAS_TRAIT(target, TRAIT_IWASUNZOMBIFIED) && user?.ckey)
				adjust_playerquality(unzombification_pq, user.ckey)
				ADD_TRAIT(target, TRAIT_IWASUNZOMBIFIED, "[type]")
		var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
		if(rot)
			rot.amount = 0
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/rotty in stinky.bodyparts)
				rotty.rotted = FALSE
				rotty.skeletonized = FALSE
				rotty.update_limb()
				rotty.update_disabled()
		target.update_body()
		if(!HAS_TRAIT(target, TRAIT_ROTMAN))
			target.visible_message(span_notice("The rot leaves [target]'s body!"), span_green("I feel the rot leave my body!"))
		else
			target.visible_message(span_warning("The rot fails to leave [target]'s body!"), span_warning("I feel no different..."))
		return TRUE
	to_chat(user, span_warning("I need too prime their liver first"))
	return FALSE

/obj/effect/proc_holder/spell/targeted/debride/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/bed/rogue/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need to lay them on a bed"))
		return FALSE
	return TRUE


/obj/effect/proc_holder/spell/targeted/docheal/cast(list/targets, mob/living/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_green("[user] tends to [target]'s wounds with the focus and purpose."), span_notice("I feel better already."))
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
	return FALSE

/obj/effect/proc_holder/spell/targeted/stable/cast(list/targets, mob/user) 
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/ramount = 10
		var/rid = /datum/reagent/medicine/stimu
		target.reagents.add_reagent(rid, ramount)
		target.visible_message(span_green("[user] stabs [target]'s chest with a syringe, causing there breathing to return to normal."), span_notice("I feel my breathing steady and grip on life tighten."))
		target.setOxyLoss(-100)
		target.adjustToxLoss(-50)
		target.emote("rage")
		target.blood_volume += BLOOD_VOLUME_SURVIVE
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/targeted/purge/cast(list/targets, mob/user) 
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/obj/item/bodypart/BPA = target.get_bodypart(BODY_ZONE_R_ARM)
		BPA.add_wound(/datum/wound/artery/)
		target.visible_message(span_danger("[user] slashes [target]'s artery open letting the toxins and other impurities bleed and drain from them. they might want to stitch that soon."), span_notice("I've been cut by [user] I feel the toxins leaving my body with each heart beat. im getting light headed...."))
		target.adjustToxLoss(-999)
		target.adjustBruteLoss(30, BRUTE, BPA)
		target.reagents.remove_all_type(/datum/reagent, 9999)
		target.emote("scream")
		return TRUE
	return FALSE

/obj/item/organ/heart/weak
	name = "weakened heart"
	desc = "this thing seems barely functional"

/datum/status_effect/debuff/wheart
	id = "wheart"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/wheart
	effectedstats = list("strength" = -3, "constitution" = -3, "endurance" = -3, "speed" = -3)

/atom/movable/screen/alert/status_effect/debuff/wheart
	name = "Weak Heart"
	desc = "I feel drained and sluggish, I should get a new heart."

/obj/item/organ/heart/weak/Insert(mob/living/carbon/M)
	..()
	M.apply_status_effect(/datum/status_effect/debuff/wheart)

/obj/item/organ/heart/weak/Remove(mob/living/carbon/M, special = 0)
	..()
	if(M.has_status_effect(/datum/status_effect/debuff/wheart))
		M.remove_status_effect(/datum/status_effect/debuff/wheart)

/obj/item/organ/liver/weak
	name = "weakened liver"
	desc = "this thing seems barely functional"

/datum/status_effect/debuff/wliver
	id = "wliver"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/wliver
	effectedstats = list("strength" = -3, "constitution" = -3, "endurance" = -3, "speed" = -3)

/atom/movable/screen/alert/status_effect/debuff/wliver
	name = "Weak Liver"
	desc = "I feel drained and sluggish, I should get a new liver."

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
	

/datum/surgery/bypass
	name = "Coronary artery bypass surgery"
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/bypass,
		/datum/surgery_step/cauterize,
	)

/datum/surgery_step/bypass
	name = "Perform Heart Rejuvination"
	time = 20 SECONDS
	accept_hand = TRUE
	implements = list(
		TOOL_HEMOSTAT = 60,
		TOOL_IMPROVHEMOSTAT = 30,
		TOOL_HAND = 10,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_EXPERT
	skill_median = SKILL_LEVEL_MASTER

/datum/surgery_step/bypass/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(target.has_status_effect(/datum/status_effect/debuff/wheart))
		to_chat(user, "Their heart is too weak")
		return FALSE
	else
		display_results(user, target, span_notice("I begin to bypass the arteries in [target]'s heart...."),
			span_notice("[user] begins to bypass the arteries in [target]'s heart."),
			span_notice("[user] begins to bypass the arteries in [target]'s heart."))
		return TRUE

/datum/surgery_step/bypass/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I successfully bypass the arteries in [target]'s heart."),
		span_notice("[user] successfully bypassess the arteries in [target]'s heart, restoring its function!"),
		span_notice("[user] successfully bypassess the arteries in [target]'s heart, restoring its function!"))
	var/obj/item/organ/heart/heart = target.getorganslot(ORGAN_SLOT_HEART)
	if(heart)
		heart.Remove(target)
		QDEL_NULL(heart)
		heart = new /obj/item/organ/heart/weak
		heart.Insert(target)
		return TRUE


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
///////////////////////////////////////////////------------------------------------------------reagents--------------------------------------------/////////////////////////////////////////////////
/datum/reagent/medicine/caffeine
	name = "caffeine"
	description = "No Sleep"
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 20 * REAGENTS_METABOLISM
	overdose_threshold = null

/datum/reagent/medicine/caffeine/on_mob_life(mob/living/carbon/M)
	M.rogstam_add(800)
	..()
	. = 1
	if(M.has_status_effect(/datum/status_effect/debuff/sleepytime))
		M.remove_status_effect(/datum/status_effect/debuff/sleepytime)
		M.remove_stress(/datum/stressevent/sleepytime)
		M.mind.sleep_adv.advance_cycle()
/////////////////////////////////////////////////////------------------------------------tools and pre made bottles-----------------------------------------/////////////////////////////////////////////////////

/obj/item/rogueweapon/surgery/saw/improv
	name = "improvised saw"
	desc = "A tool used to carve through bone......poorly, but better than nothing."
	icon_state = "bonesaw_wooden"
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
	icon_state = "forceps_wooden"
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

/obj/item/storage/fancy/skit
	name = "surgery kit"
	desc = "portable and compact (close/open mmb)"
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "skit"
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 1
	slot_flags = null

/obj/item/storage/fancy/skit/PopulateContents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	for(var/i = 1 to STR.max_items)
		new spawn_type(src)

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
	STR.max_items = 8
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
	new /obj/item/rogueweapon/surgery/retractor(src)
	new /obj/item/rogueweapon/surgery/bonesetter(src)
	new /obj/item/rogueweapon/surgery/cautery(src)
	new /obj/item/needle/pestra(src)

/obj/item/storage/fancy/ifak
	name = "personal patch kit"
	desc = "Dr V's personal treatment pouch; has all you need to stop you or someone else from meeting necra. even comes with a lil guide scroll for the slow minded. (close/open mmb)"
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
	STR.set_holdable(list(
		/obj/item/reagent_containers/hypospray/medipen/sealbottle/reju,
		/obj/item/rogueweapon/surgery/saw,
		/obj/item/rogueweapon/surgery/hemostat,
		/obj/item/rogueweapon/surgery/retractor,
		/obj/item/rogueweapon/surgery/bonesetter,
		/obj/item/rogueweapon/surgery/cautery,
		/obj/item/natural/worms/leech/cheele,
		/obj/item/needle,
		/obj/item/needle/thorn,
		/obj/item/needle/pestra,
	))

/obj/item/storage/fancy/ifak/PopulateContents()
	new /obj/item/reagent_containers/hypospray/medipen/sealbottle/reju(src)
	new /obj/item/needle(src)

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

/obj/item/reagent_containers/hypospray/medipen/sealbottle/reju
	name = "rejuv elixer"
	desc = "Dr V's special formulated body revitalizer; restores blood, helps seal wounds, helps to stabalize breathing and numbs pain with a non-addictive snake venom derived analgesic. Single dose. Caffeinated, just like the snake that made it."
	icon_state = "THEbottle"
	volume = 16
	amount_per_transfer_from_this = 16
	list_reagents = list(/datum/reagent/medicine/stimu = 15, /datum/reagent/medicine/caffeine = 1)

/obj/item/natural/bandage
	name = "bandage"
	desc = "A simple bandage used to bind wounds. Faster than just cloth."
	icon_state = "bandage_closed"
	icon = 'icons/roguetown/items/surgery.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_BELT
	var/charge_amt = 3
	var/max_charge = 3

/obj/item/natural/bandage/examine()
	. = ..()
	if(charge_amt > 0)
		. += span_bold("It has [charge_amt] uses left.")
	else
		. += span_bold("It has no uses left.")

/obj/item/natural/bandage/Initialize()
	. = ..()
	update_icon()

/obj/item/natural/bandage/update_icon()
	if(charge_amt == max_charge)
		icon_state = "bandage_closed"
	else if(charge_amt == 2)
		icon_state = "bandage_1"
	else if(charge_amt == 1)
		icon_state = "bandage_2"
	else
		icon_state = "bandage_empty"

/obj/item/natural/bandage/use()
	charge_amt -= 1
	update_icon()
	return charge_amt > 0

/obj/item/natural/bandage/attack(mob/living/M, mob/user)
	if(use())
		bandage(M, user)

/obj/item/natural/bandage/proc/bandage(mob/living/M, mob/user)
	if(!M.can_inject(user, TRUE))
		return
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(!affecting)
		return
	if(affecting.bandage)
		to_chat(user, span_warning("There is already a bandage."))
		return
	var/used_time = 70
	if(H.mind)
		used_time -= (H.mind.get_skill_level(/datum/skill/misc/medicine) * 10)
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	if(!do_mob(user, M, used_time))
		return
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	user.dropItemToGround(src)
	affecting.try_bandage(src)
	H.update_damage_overlays()
	if(M == user)
		user.visible_message(span_notice("You bandage [user.p_their()] [affecting]."), span_notice("I bandage my [affecting]."))
	else
		user.visible_message(span_notice("You bandage [M]'s [affecting]."), span_notice("I bandage [M]'s [affecting]."))

/*
/obj/item/natural/acid
	name = "acidic salve"
	desc = "A salve that can cauterize wounds and remove early-stage infections."
	icon_state = "acid_closed"
	icon = 'icons/roguetown/items/surgery.dmi'
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_BELT
	var/charge_amt = 3
	var/max_charge = 3

/obj/item/natural/acid/examine()
	. = ..()
	if(charge_amt > 0)
		. += span_bold("It has [charge_amt] uses left.")
	else
		. += span_bold("It has no uses left.")

/obj/item/natural/acid/Initialize()
	. = ..()
	update_icon()

/obj/item/natural/acid/update_icon()
	if(charge_amt == max_charge)
		icon_state = "acid_closed"
	else if(charge_amt == 2)
		icon_state = "acid_1"
	else if(charge_amt == 1)
		icon_state = "acid_2"
	else
		icon_state = "acid_empty"

/obj/item/natural/acid/use(mob/user)
	if(charge_amt <= 0)
		to_chat(user, span_warning("[src] is out of charges."))
		return FALSE
	charge_amt -= 1
	update_icon()
	return TRUE

/obj/item/natural/acid/attack(mob/living/carbon/human/M, mob/user)
	if(use(user))
		cauterize_or_cure(M, user)

/obj/item/natural/acid/proc/cauterize_or_cure(mob/living/carbon/human/M, mob/user)
	if(!M)
		to_chat(user, span_warning("There is no one to treat."))
		return
	var/treated = FALSE
	for(var/datum/wound/W in M.get_wounds())
		if(W.zombie_infection_timer)
			deltimer(W.zombie_infection_timer)
			W.zombie_infection_timer = null
			to_chat(M, span_notice("You feel the infection being burned away by the salve."))
			treated = TRUE
			break
		if(W.werewolf_infection_timer)
			deltimer(W.werewolf_infection_timer)
			W.werewolf_infection_timer = null
			to_chat(M, span_notice("You feel the infection being burned away by the salve."))
			treated = TRUE
			break
	if(treated)
		return
	var/obj/item/bodypart/affecting = M.get_bodypart(check_zone(user.zone_selected))
	if(affecting)
		var/list/wounds = affecting.get_wounds()
		if(wounds.len)
			for(var/datum/wound/W in wounds)
				if(W.can_cauterize)
					var/used_time = 50
					if(M.mind)
						used_time -= (M.mind.get_skill_level(/datum/skill/misc/medicine) * 10)
					playsound(loc, 'sound/items/firelight.ogg', 100, FALSE)
					if(!do_mob(user, M, used_time))
						return
					W.cauterize_wound(src)
					M.update_damage_overlays()
					if(M == user)
						user.visible_message(span_notice("You apply the salve to cauterize [user.p_their()] [affecting]."), span_notice("I apply the salve to cauterize my [affecting]."))
					else
						user.visible_message(span_notice("You apply the salve to cauterize [M]'s [affecting]."), span_notice("I apply the salve to cauterize [M]'s [affecting]."))
					return
	to_chat(user, span_warning("There is no suitable wound to cauterize or infection to cure."))
*/


///////////////////////////////////////////////////------------------------------------alembic/brewing--------------------------------/////////////////////////////////////////


// I'm going to hate every moment of working on this.


// *cry. agony.

/obj/item/reagent_containers/glass/alembic
	name = "copper alembic"
	possible_item_intents = list(INTENT_POUR, INTENT_SPLASH)
	desc = "so you're an alchemist then?"
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "alembic_empty"
	var/speed_multiplier = 1 // How fast it brews. Defaults to 100% (1.0). Lower is better.
	var/list/active_brews = list()

/obj/item/reagent_containers
	var/can_brew = FALSE // If FALSE, this object cannot be brewed
	var/brew_reagent // If NULL and this object can be brewed, it uses a generic fruit_wine reagent and adjusts its variables
	var/brew_amt = 22
	var/start_time
	var/brewing_time

/obj/item/reagent_containers/glass/alembic/Initialize()
	create_reagents(45, DRAINABLE | AMOUNT_VISIBLE) // Bottle capacity, cannot put liquids into it. Only items to brew into liquids, drainable.
	icon_state = "alembic_empty"
	. = ..()

/obj/item/reagent_containers/glass/alembic/examine(mob/user)
	. = ..()
	if(active_brews.len == 0)
		. += span_notice("The alembic is not brewing.")
	else
		. += span_notice("The alembic is brewing.")
		for(var/obj/item/reagent_containers/I in active_brews)
			var/time_left = (I.brewing_time - (world.time - I.start_time)) / 10
			. += span_notice("[I]: [time_left] seconds left until completion.")

/obj/item/reagent_containers/glass/alembic/proc/makebrew(obj/item/reagent_containers/I)
	if(I.reagents)
		I.reagents.remove_reagent(/datum/reagent, I.reagents.total_volume)
		I.reagents.trans_to(src, I.reagents.total_volume)
	if(I.brew_reagent)
		reagents.add_reagent(I.brew_reagent, I.brew_amt)
	qdel(I)
	active_brews -= I
	if(reagents.total_volume > 0 || active_brews.len >= 2)
		icon_state = "alembic_full"
	else
		icon_state = "alembic_empty"
	playsound(src, "bubbles", 100, TRUE)

/obj/item/reagent_containers/glass/alembic/attackby(obj/item/reagent_containers/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers))
		if(!I.can_brew)
			to_chat(user, span_warning("I can't brew this into anything."))
			return TRUE
		else if(active_brews.len >= 2 || reagents.total_volume >= 44)
			to_chat(user, span_warning("I can only brew two items at a time or it is too full."))
			return TRUE
		else if(!user.transferItemToLoc(I, src))
			to_chat(user, span_warning("[I] is stuck to my hand!"))
			return TRUE
		to_chat(user, span_info("I place [I] into [src]."))
		I.start_time = world.time
		I.brewing_time = rand(600, 1200) // Brewing time between 60 and 120 seconds in deciseconds
		active_brews += I
		icon_state = "alembic_brew"
		addtimer(CALLBACK(src, /obj/item/reagent_containers/glass/alembic/proc/makebrew, I), I.brewing_time)
		return TRUE
	return ..()


