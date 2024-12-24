// Eldritch faithless healing
/obj/effect/proc_holder/spell/invoked/eldritchhealing/any
	ignore_faithless = TRUE

/obj/effect/proc_holder/spell/invoked/eldritchhealing
	name = "Eldritch Healing"
	overlay_state = null
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 20 SECONDS
	miracle = FALSE
	var/patronname = ""
	var/targetnotification = ""
	var/othernotification = ""
	var/ignore_faithless = FALSE

/obj/effect/proc_holder/spell/invoked/eldritchhealing/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		target.visible_message(span_info("[target] "+othernotification), span_notice(targetnotification))
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

// curse
/obj/effect/proc_holder/spell/invoked/eldritchcurse
	name = "curse of the "
	overlay_state = null
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 20 SECONDS
	miracle = FALSE
	var/patronname = ""
	var/datum/status_effect/buff/eldritchcurse/curse

/obj/effect/proc_holder/spell/invoked/eldritchcurse/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]

		if(target.has_status_effect(curse))
			target.remove_status_effect(curse)
		else
			target.apply_status_effect(curse) //apply debuff

/datum/status_effect/buff/eldritchcurse
	id = "eldritchcurse"
	alert_type = /atom/movable/screen/alert/status_effect/buff/eldritchcurse
	duration = -1

/datum/status_effect/buff/eldritchcurse/archfey
	effectedstats = list("intelligence" = -2, "fortune" = -2)

/datum/status_effect/buff/eldritchcurse/celestial
	effectedstats = list("constitution" = -2, "perception" = -2)

/datum/status_effect/buff/eldritchcurse/fathomless
	effectedstats = list("endurance" = -2, "perception" = -2)

/datum/status_effect/buff/eldritchcurse/genie
	effectedstats = list("fortune" = -4)

/datum/status_effect/buff/eldritchcurse/goo
	effectedstats = list("intelligence" = -2, "constitution" = -2)

/datum/status_effect/buff/eldritchcurse/hexblade
	effectedstats = list("speed" = -2,"strength" = -2)

/datum/status_effect/buff/eldritchcurse/undead
	effectedstats = list("constitution" = -4)

/atom/movable/screen/alert/status_effect/buff/eldritchcurse
	name = "eldritch curse"
	desc = "I am cursed by a lesser diety."
	icon_state = "debuff"

// cloak of flies
/obj/effect/proc_holder/spell/self/cloakofflies
	name = "Cloak of Flies"
	desc = ""
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	charge_max = 20  //2 seconds

	warnie = "spellwarning"

	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	var/activated = FALSE
	var/rot_type = /datum/component/rot/warlock
	var/static/mutable_appearance/flies = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")

/obj/effect/proc_holder/spell/self/cloakofflies/cast(mob/user = usr)
	..()

	if(activated)
		qdel(user.GetComponent(/datum/component/rot/warlock))
		activated = FALSE
		user.cut_overlay(flies)
		user.update_vision_cone()
		user.visible_message("<span class='info'>The flies surrounding [user] go away.</span>", "<span class='notice'>My cloak of flies dissipates.</span>")
	else
		user.AddComponent(/datum/component/rot/warlock)
		activated = TRUE
		user.add_overlay(flies)
		user.update_vision_cone()
		user.visible_message("<span class='info'>[user] is surrounded in a cloud of flies.</span>", "<span class='notice'>My cloak of flies surrounds me.</span>")

/datum/component/rot/warlock
	soundloop = /datum/looping_sound/fliesloop/quiet

/datum/component/rot/warlock/process()
	..()
	var/mob/living/L = parent
	if(soundloop && soundloop.stopped)
		soundloop.start()
	var/turf/open/T = get_turf(L)
	if(istype(T))
		T.add_pollutants(/datum/pollutant/flies, 10)

/datum/looping_sound/fliesloop/quiet
	mid_sounds = list('sound/misc/fliesloop.ogg')
	mid_length = 60
	volume = 25
	extra_range = 0

//find familiar (imp, psuedodragon, quasit, seelie)
/obj/effect/proc_holder/spell/self/findfamiliar
	name = "Find Familiar"
	desc = ""
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	charge_max = 500  //2 seconds

	warnie = "spellwarning"

	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy

	xp_gain = FALSE
	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

	var/mob/living/fam

/obj/effect/proc_holder/spell/self/findfamiliar/cast(mob/user = usr)
	..()

	var/familiars = list(
		/mob/living/carbon/human/species/goblin/hell, //imp
		/mob/living/carbon/human/species/skeleton, //quasit(skeleton?)
		)
	var/familiarchoice = input("Choose your familiar", "Available familiars") as anything in familiars

	to_chat(user, span_notice("Trying to find familiar..."))
	var/list/L = pollCandidatesForMob(
		Question = "Do you want to play as [span_notice("[span_danger("[user.real_name]'s")] familiar")]?",
		jobbanType = ROLE_PAI,
		poll_time = 20 SECONDS,
		ignore_category = POLL_IGNORE_SENTIENCE_POTION,
	)
	if(L.len > 0)
		var/mob/chosen_one =  pick(L)
		fam = new familiarchoice(user.loc)
		fam.key = chosen_one.key
		to_chat(user, span_notice("Your familiar appears..."))
		chosen_one.mind.transfer_to(fam)
		fam.fully_replace_character_name(null, "[user]'s familiar")
		fam.get_language_holder().omnitongue = TRUE //Grants omnitongue
		var/valid_input_name = custom_name(user)
		if(valid_input_name)
			fam.fully_replace_character_name(null, "[valid_input_name]")
		user.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/findfamiliar)
	else
		to_chat(user, span_notice("You could not find a familiar..."))
		revert_cast()

/obj/effect/proc_holder/spell/self/findfamiliar/proc/custom_name(mob/awakener, var/mob/chosen_one, iteration = 1)
	if(iteration > 5)
		return "indecision" // The spirit of indecision
	var/chosen_name = sanitize_name(stripped_input(chosen_one, "What are you named?"))
	if(!chosen_name) // with the way that sanitize_name works, it'll actually send the error message to the awakener as well.
		to_chat(awakener, span_warning("Your weapon did not select a valid name! Please wait as they try again.")) // more verbose than what sanitize_name might pass in it's error message
		return custom_name(awakener, iteration++)
	return chosen_name
