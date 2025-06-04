
/datum/antagonist/serial_killer
	name = "Serial Killer"
	roundend_category = "serial killer"
	antagpanel_category = "Serial Killer"
	antag_memory = "<b>The visions haunt me every waking moment, they tell me to kill.. I know I have to. They tell me I have no other choice... I must appease the voices.</b>"
	job_rank = ROLE_SERIALKILLER
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "villain"
	confess_lines = list(
		"I gave them no time to squeal.",
		"I shant quit ripping them.",
		"They deserve to be put at my blade.",
		"Do what thou wilt shall be the whole of the law.",
	)

	rogue_enabled = TRUE

	/// Whether he has killed anyone in the last 24 ingame hours.
	var/has_killed = FALSE

	/// Small 15 minute prep phase before the killing timer starts ticking.
	var/prep_phase = TRUE

	/// Whether the killing intro has been sent to the player.
	var/killing_intro = FALSE


	var/static/list/applied_traits = list(
		TRAIT_DECEIVING_MEEKNESS,
		TRAIT_NOSTINK,
		TRAIT_EMPATH,
		TRAIT_STEELHEARTED,
		TRAIT_SCHIZO_AMBIENCE,
		TRAIT_DARKVISION,
	)

	var/static/list/male_relief_sounds = list(
		'sound/villain/male_talk1.ogg',
		'sound/villain/male_talk2.ogg',
		'sound/villain/male_talk3.ogg',
		'sound/villain/male_talk4.ogg',
		'sound/villain/male_talk5.ogg',
		'sound/villain/male_talk6.ogg',
	)

	var/static/list/female_relief_sounds = list(
		'sound/villain/female_talk1.ogg',
		'sound/villain/female_talk2.ogg',
		'sound/villain/female_talk3.ogg',
		'sound/villain/female_talk4.ogg',
		'sound/villain/female_talk5.ogg',
	)

	var/static/list/possible_weapons = list(
		/obj/item/rogueweapon/huntingknife/cleaver,
		/obj/item/rogueweapon/huntingknife/cleaver/combat,
		/obj/item/rogueweapon/huntingknife/idagger/steel/special,
	)
	/// Hallucinations screen object
	var/atom/movable/screen/fullscreen/serialkiller/hallucinations

/datum/antagonist/serial_killer/New()
	load_strings_file("serial_killer.json")
	return ..()

/datum/antagonist/serial_killer/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/antagonist/serial_killer/on_gain()
	. = ..()
	owner.special_role = ROLE_SERIALKILLER
	owner.special_items["Surgical Kit"] = /obj/item/storage/backpack/rogue/backpack/surgery

	if(owner.current)
		if(ishuman(owner.current))
			var/mob/living/carbon/human/SK = owner.current
			SK.cmode_music = 'sound/music/combat_maniac2.ogg'
			SK.remove_stress(/datum/stressevent/saw_wonder)
			SK.remove_curse(/datum/curse/zizo, TRUE)

		for(var/trait in applied_traits)
			ADD_TRAIT(owner.current, trait, "[type]")

		owner.current.mind.teach_crafting_recipe(/datum/crafting_recipe/roguetown/structure/wonder)

		hallucinations = owner.current.overlay_fullscreen("serial killer", /atom/movable/screen/fullscreen/serialkiller)

		// Save Serial Killer's key so we will know if he killed someone in death.dm
		if(SSticker.mode)
			var/datum/game_mode/C = SSticker.mode
			C.serial_killer_ckeys |= owner.current.ckey

	forge_objectives()

	if(length(objectives))
		SEND_SOUND(owner.current, 'sound/villain/dreamer_warning.ogg')
		to_chat(owner.current, span_danger("[antag_memory]"))
		owner.announce_objectives()
	
	owner.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

	START_PROCESSING(SSobj, src)

/datum/antagonist/serial_killer/on_removal()
	STOP_PROCESSING(SSobj, src)
	if(owner.current)
		if(!silent)
			to_chat(owner.current,span_danger("I am no longer a SERIAL KILLER!"))
		if(ishuman(owner.current))
			var/mob/living/carbon/human/dreamer = owner.current
			var/client/clinet = dreamer?.client
			if(clinet) //clear screenshake animation
				animate(clinet, dreamer.pixel_y)
		for(var/trait in applied_traits)
			REMOVE_TRAIT(owner.current, trait, "[type]")
		owner.current.clear_fullscreen("serial killer")

	owner.adjust_skillrank(/datum/skill/combat/knives, -2, TRUE)

	owner.special_role = null
	hallucinations = null
	return ..()

/datum/antagonist/serial_killer/proc/forge_objectives()
	message_admins("Serial Killer objectives forged for [owner.current ? owner.current.ckey : "unknown"]")
	var/datum/objective/serial_killer/kill = new()
	objectives.Add(kill)
	message_admins("Serial Killer objectives forged: [objectives.len] objectives.")

/datum/antagonist/serial_killer/on_life(mob/user)
	. = ..()

	var/mob/living/carbon/human/SK = owner?.current

	// We want to give the player some breathing room to prepare before the killing timer starts ticking.
	if(prep_phase)

		if(SK.mob_timers["no_killing_yet"])
			if(world.time < SK.mob_timers["no_killing_yet"] + 1 MINUTES)
				return
			else
				prep_phase = FALSE
				return

		SK.mob_timers["no_killing_yet"] = world.time
		return 
	
	if(!killing_intro)
		to_chat(owner.current, span_purple("The visions are getting stronger, I- I cannot resist them any longer!"))
		SK.add_curse(/datum/curse/zizo, TRUE)
		killing_intro = TRUE

	// Starts the killing timer after the prep phase is over. 25 minutes is around 1 ingame dae/night cycle.
	if(!SK.mob_timers["need_to_kill"])
		SK.mob_timers["need_to_kill"] = world.time
		return

	if(world.time < SK.mob_timers["need_to_kill"] + 2 MINUTES)
		return

	// If the Serial Killer has not killed anyone before the end of the timer, he will receive a deadly heart attack.
	if(!has_killed && SK.stat != DEAD)
		to_chat(SK, span_purple("W- Wait- NO! I NEED MORE TIME!"))
		sleep(5 SECONDS)
		SK.add_stress(/datum/stressevent/serial_killer_death)
		SK.visible_message(span_danger("[SK] clutches at [SK.p_their()] chest. [SK.p_their()] heart is stopping!"))
		sleep(5 SECONDS)
		SK.death(FALSE)

	// Timer ends and Serial Killer has killed someone, repeat.
	else 
		to_chat(SK, span_purple("Oh no.. they are coming back... I must keep killing!"))
		has_killed = FALSE
		START_PROCESSING(SSobj, src)
		SK.adjust_triumphs(1)
		SK.mob_timers["need_to_kill"] = null



/datum/antagonist/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(objectives.len)
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(objective.check_completion())
				to_chat(world, "<B>[objective.flavor] #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
			else
				to_chat(world, "<B>[objective.flavor] #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
				traitorwin = FALSE
			count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(!considered_alive(owner))
		traitorwin = FALSE

	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, span_greentext("The [special_role_text] has TRIUMPHED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, span_redtext("The [special_role_text] has FAILED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
