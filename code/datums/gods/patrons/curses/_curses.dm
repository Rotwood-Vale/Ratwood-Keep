/mob/living/carbon/human
	/// List of curses on this mob
	var/list/curses = list()

/datum/curse
	var/name = "Debug Curse"
	/// Whats shown to the player upon being cursed
	var/description = "This is a debug curse."
	/// Trait given by this curse
	var/trait

/datum/curse/proc/on_life()
	return

/datum/curse/proc/on_death()
	return

/datum/curse/proc/on_gain(mob/living/carbon/human/owner, silent)
	ADD_TRAIT(owner, trait, TRAIT_CURSE)
	if(!silent)
		to_chat(owner, span_userdanger("Something is wrong... I feel cursed."))
		to_chat(owner, span_danger(description))
		owner.playsound_local(get_turf(owner), 'sound/misc/cursed.ogg', 80, FALSE, pressure_affected = FALSE)
	return

/datum/curse/proc/on_loss(mob/living/carbon/human/owner, silent)
	REMOVE_TRAIT(owner, trait, TRAIT_CURSE)
	if(!silent)
		to_chat(owner, span_userdanger("Something has changed... I feel relieved."))
		owner.playsound_local(get_turf(owner), 'sound/misc/curse_lifted.ogg', 80, FALSE, pressure_affected = FALSE)
	qdel(src)
	return

/mob/living/carbon/human/proc/handle_curses()
	for(var/curse in curses)
		var/datum/curse/C = curse
		C.on_life(src)

/mob/living/carbon/human/proc/add_curse(datum/curse/C, silent)
	if(is_cursed(C))
		return FALSE
	C = new C()
	curses += C
	if(!silent)
		C.on_gain(src)
	else
		C.on_gain(src, TRUE)
	return TRUE

/mob/living/carbon/human/proc/remove_curse(datum/curse/C, silent)
	if(!is_cursed(C))
		return FALSE
	for(var/datum/curse/curse in curses)
		if(curse.name == C.name)
			if(!silent)
				curse.on_loss(src)
			else
				curse.on_loss(src, TRUE)
			curses -= curse
			return TRUE
			break
	return FALSE

/mob/living/carbon/human/proc/is_cursed(datum/curse/C)
	if(!C)
		return FALSE
	for(var/datum/curse/curse in curses)
		if(curse.name == C.name)
			return TRUE
	return FALSE

/// SPECIAL CURSES ///

/datum/curse/atheism
	name = "Curse of Atheism"
	description = "I cannot stand any mention of the divine, and I refuse to believe either the gods or miracles are real."
	trait = TRAIT_ATHEISM_CURSE
	var/datum/patron/old_patron

///   TEN CURSES   ///

/datum/curse/zizo
	name = "Zizo's Curse"
	description = "I can no longer distinguish reality from delusion."
	trait = TRAIT_ZIZO_CURSE
	var/atom/movable/screen/fullscreen/maniac/hallucinations

/datum/curse/graggar

/datum/curse/matthios
	name = "Matthios' Curse"
	description = "I hate the sight of wealth, and I cannot have anything to do with mammons."
	trait = TRAIT_MATTHIOS_CURSE

/datum/curse/atheism/on_gain(mob/living/carbon/human/owner)
	. = ..()
	old_patron = owner.patron
	owner.set_patron(/datum/patron/godless)
	owner.gain_trauma(/datum/brain_trauma/mild/phobia/religion)

/datum/curse/atheism/on_loss(mob/living/carbon/human/owner)
	. = ..()
	owner.set_patron(old_patron)
	owner.cure_trauma_type(/datum/brain_trauma/mild/phobia/religion)

/datum/curse/zizo/on_gain(mob/living/carbon/human/owner)
	. = ..()
	hallucinations = owner.overlay_fullscreen("maniac", /atom/movable/screen/fullscreen/maniac)

/datum/curse/zizo/on_loss(mob/living/carbon/human/owner)
	. = ..()
	hallucinations = null

// Currently calls maniac hallucinations

/datum/curse/zizo/on_life(mob/living/carbon/human/owner)
	. = ..()
	handle_maniac_visions(owner, hallucinations)
	handle_maniac_hallucinations(owner)
	handle_maniac_floors(owner)
	handle_maniac_walls(owner)

// cursed_freak_out() is freak_out() without stress adjustments

// bandaid deserves a second look

/mob/living/proc/cursed_freak_out()
	return

/mob/proc/do_cursed_freakout_scream()
	emote("scream", forced=TRUE)

/mob/living/carbon/cursed_freak_out()
	if(mob_timers["freakout"])
		if(world.time < mob_timers["freakout"] + 10 SECONDS)
			flash_fullscreen("stressflash")
	mob_timers["freakout"] = world.time
	shake_camera(src, 1, 3)
	flash_fullscreen("stressflash")
	changeNext_move(CLICK_CD_EXHAUSTED)
	emote("fatigue", forced = TRUE)
	if(get_stress_amount() > 15)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/mob, do_freakout_scream)), rand(30,50))
	if(hud_used)
		var/matrix/skew = matrix()
		skew.Scale(2)
		var/matrix/newmatrix = skew
		for(var/C in hud_used.plane_masters)
			var/atom/movable/screen/plane_master/whole_screen = hud_used.plane_masters[C]
			if(whole_screen.plane == HUD_PLANE)
				continue
			animate(whole_screen, transform = newmatrix, time = 1, easing = QUAD_EASING)
			animate(transform = -newmatrix, time = 30, easing = QUAD_EASING)
