/datum/game_mode/masquerade
	name = "Masquerade"
	score_value = 100
	required_players = 6
	special_roles = list("Veilbound")
	var/list/veilbound = list()
	var/round_start_time

/datum/game_mode/masquerade/announce()
	..()
	world << span_notice("A masquerade begins. Masks hide faces, but not intent...")

/datum/game_mode/masquerade/pre_setup()
	..()
	veilbound = list()
	return TRUE

/datum/game_mode/masquerade/post_setup()
	..()
	round_start_time = world.time
	var/list/eligible = get_possible_veilbound()
	if(!eligible.len)
		to_chat(world, span_warning("No eligible players for Masquerade mode."))
		return FALSE

	var/leader = pick(eligible)
	leader.add_antag_datum(/datum/antagonist/veilbound/arbiter)
	veilbound += leader
	eligible -= leader

	for(var/i in 1 to min(3, eligible.len))
		var/datum/mind/follower = pick(eligible)
		follower.add_antag_datum(/datum/antagonist/veilbound)
		veilbound += follower
		eligible -= follower

	SPAWN(10 SECONDS)
		sacrifice_check_loop()
	return TRUE

/proc/get_possible_veilbound()
	var/list/eligible = list()
	for(var/datum/mind/M in GLOB.minds)
		if(!M.current || M.assigned_role in GLOB.inquisition_positions || HAS_TRAIT(M.current, TRAIT_MINDSHIELD))
			continue
		eligible += M
	return eligible

/proc/sacrifice_check_loop()
	var/datum/game_mode/masquerade/M = SSticker.mode
	if(!M) return
	var/time_passed = (world.time - M.round_start_time) / (10 MINUTES)

	for(var/datum/mind/C in M.veilbound)
		if(!C.current || QDELETED(C.current)) continue
		var/mob/living/carbon/human/H = C.current
		if(!H || !iscarbon(H)) continue
		if(time_passed >= 2)
			to_chat(H, span_danger("You have failed the Rite. Your form begins to twist..."))
			H.mutate_into_unmasked()
			continue
		if(!H.last_rite_time || (world.time - H.last_rite_time) > 10 MINUTES)
			to_chat(H, span_warning("The Whisper stirs. A Rite must be performed soon..."))

	SPAWN(1 MINUTE)
		sacrifice_check_loop()

/mob/living/carbon/human/var/last_rite_time

/mob/living/carbon/human/proc/register_rite()
	last_rite_time = world.time

/mob/living/carbon/human/proc/mutate_into_unmasked()
	visible_message(span_danger("[src] screams as their mask shatters and horror takes shape!"))
	// TODO: Replace with real transformation logic

/datum/antagonist/veilbound
	name = "Veilbound"
	roundend_category = "masquerade"
	antagpanel_category = "Masquerade"
	job_rank = ROLE_VEILBOUND
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "veilbound"
	rogue_enabled = TRUE
	var/islesser = TRUE

/datum/antagonist/veilbound/arbiter
	name = "Arbiter"
	islesser = FALSE

/datum/antagonist/veilbound/on_gain()
	. = ..()
	var/datum/game_mode/masquerade/C = SSticker.mode
	var/mob/living/carbon/human/H = owner.current
	C.veilbound |= owner
	H.patron = GLOB.patronlist[/datum/patron/maskwhisper]

	owner.special_role = "Veilbound"
	H.cmode_music = 'sound/music/ambientveil.ogg'
	owner.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/whisperstart.ogg', 80, FALSE, pressure_affected = FALSE)
	owner.current.verbs |= /mob/living/carbon/human/proc/commune_veil

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.change_stat("strength", 2)

	if(islesser)
		add_objective(/datum/objective/veilserve)
		owner.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.change_stat("intelligence", -2)
		greet()
	else
		add_objective(/datum/objective/veilascend)
		owner.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		owner.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("speed", 1)
		greet()
		owner.special_role = ROLE_VEILBOUND
		owner.current.verbs |= /mob/living/carbon/human/proc/carve_rune
		owner.current.verbs |= /mob/living/carbon/human/proc/release_thrall

/datum/antagonist/veilbound/greet()
	to_chat(owner, span_danger("I wear the Mask. I serve the Arbiter. The Rite must be upheld."))
	owner.announce_objectives()

/datum/antagonist/veilbound/arbiter/greet()
	to_chat(owner, span_danger("I am the Arbiter. The Whisper guides me. I must ascend through the Rite."))
	owner.announce_objectives()

/mob/living/carbon/human/proc/commune_veil()
	set name = "Commune"
	set category = "MASQUERADE"
	if(stat == DEAD) return
	if(mob_timers["veil_commune"] && world.time < mob_timers["veil_commune"] + 5 SECONDS) return
	mob_timers["veil_commune"] = world.time
	var/datum/game_mode/masquerade/C = SSticker.mode
	var/speak = input("What do you whisper?", "THE WHISPER") as text|null
	if(!speak) return
	whisper("A veil ripples softly...")
	whisper("[speak]")
	log_game("[src.real_name]: [speak]")
	for(var/datum/mind/V in C.veilbound)
		to_chat(V, span_boldnotice("A whisper from [src.real_name]: \"[speak]\""))
		playsound_local(V.current, 'sound/vo/cult/skvor.ogg', 100)

/mob/living/carbon/human/proc/release_thrall()
	set name = "Release Thrall"
	set category = "MASQUERADE"
	var/datum/game_mode/masquerade/C = SSticker.mode
	var/list/mob/living/carbon/human/possible = list()
	for(var/datum/mind/V in C.veilbound)
		if(V.special_role == "Veilbound")
			possible |= V.current
	var/mob/living/carbon/human/choice = input(src, "Whom do you release from the Rite?", "THE VEIL") as null|anything in possible
	if(choice)
		var/alert = alert(src, "Are you certain?", "THE VEIL", "Yes", "Cancel")
		if(alert == "Yes")
			visible_message(span_danger("[src] rends the veil over [choice]'s soul!"))
			to_chat(choice, span_userdanger("I HAVE FAILED THE RITE! THE VEIL REJECTS ME!"))
			sleep(20)
			choice.gib()
			C.veilbound -= choice.mind

/datum/objective/veilascend
	name = "ASCEND"
	explanation_text = "Ensure that I ascend."
	team_explanation_text = "Ensure that I ascend."
	triumph_count = 5

/datum/objective/veilascend/check_completion()
	var/datum/game_mode/masquerade/C = SSticker.mode
	if(C.veilascended)
		return TRUE

/datum/objective/veilserve
	name = "Serve the Arbiter"
	explanation_text = "Serve your Arbiter and ensure that they ascend."
	team_explanation_text = "Serve your Arbiter and ensure that they ascend."
	triumph_count = 3

/datum/objective/veilserve/check_completion()
	var/datum/game_mode/masquerade/C = SSticker.mode
	if(C.veilascended)
		return TRUE
