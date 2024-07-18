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

/datum/curse/proc/on_gain(mob/living/carbon/human/owner)
	ADD_TRAIT(owner, trait, TRAIT_CURSE)
	to_chat(owner, span_userdanger("Something is wrong... I feel cursed."))
	to_chat(owner, span_danger(description))
	owner.playsound_local(get_turf(owner), 'sound/misc/cursed.ogg', 80, FALSE, pressure_affected = FALSE)
	return

/datum/curse/proc/on_loss(mob/living/carbon/human/owner)
	REMOVE_TRAIT(owner, trait, TRAIT_CURSE)
	to_chat(owner, span_userdanger("Something has changed... I feel relieved."))
	owner.playsound_local(get_turf(owner), 'sound/misc/curse_lifted.ogg', 80, FALSE, pressure_affected = FALSE)
	qdel(src)
	return

/mob/living/carbon/human/proc/handle_curses()
	for(var/curse in curses)
		var/datum/curse/C = curse
		C.on_life(src)

/mob/living/carbon/human/proc/add_curse(datum/curse/C)
	if(is_cursed(C))
		return FALSE

	C = new C()
	curses += C
	C.on_gain(src)
	return TRUE

/mob/living/carbon/human/proc/remove_curse(datum/curse/C)
	if(!is_cursed(C))
		return FALSE
	
	for(var/datum/curse/curse in curses)
		if(curse.name == C.name)
			curse.on_loss(src)
			curses -= curse
			return TRUE
			break

	return FALSE

/mob/living/carbon/human/proc/is_cursed(datum/curse/C)
	if(!src)
		return FALSE
	if(!C)
		return FALSE
	if(!length(curses))
		return FALSE
	if(!C in curses)
		return FALSE
	return TRUE

//////////////////////
/// SPECIAL CURSES ///
//////////////////////

/datum/curse/atheism
	name = "Curse of Atheism"
	description = "I cannot stand any mention of the divine, and I refuse to believe either the gods or miracles are real."
	trait = TRAIT_ATHEISM_CURSE
	var/datum/patron/old_patron

//////////////////////
///   TEN CURSES   ///
//////////////////////

/datum/curse/astrata
	name = "Astrata's Curse"
	description = "I am forsaken by the Sun. Healing miracles have no effect on me."
	trait = TRAIT_ASTRATA_CURSE

/datum/curse/noc
	name = "Noc's Curse"
	description = "Magical knowledge is now beyond my grasp."
	trait = TRAIT_NOC_CURSE

/datum/curse/ravox
	name = "Ravox's Curse"
	description = "Violence disgusts me. I cannot bring myself to wield any kind of weapon."
	trait = TRAIT_RAVOX_CURSE

/datum/curse/necra
	name = "Necra's Curse"
	description = "Necra has claimed my soul. No one will bring me back from the dead."
	trait = TRAIT_NECRA_CURSE

/datum/curse/xylix
	name = "Xylix's Curse"
	description = "Fortune is no longer on my side."
	trait = TRAIT_XYLIX_CURSE

/datum/curse/pestra
	name = "Pestra's Curse"
	description = "I feel sick to my stomach, and my skin is slowly starting to rot."
	trait = TRAIT_PESTRA_CURSE

/datum/curse/eora
	name = "Eora's Curse"
	description = "I am unable to show any kind of affection or love, whether carnal or platonic."
	trait = TRAIT_EORA_CURSE

//////////////////////
/// INHUMEN CURSES ///
//////////////////////

/datum/curse/zizo
	name = "Zizo's Curse"
	description = "I can no longer distinguish reality from delusion."
	trait = TRAIT_ZIZO_CURSE
	var/atom/movable/screen/fullscreen/maniac/hallucinations

/datum/curse/graggar
	name = "Graggar's Curse"
	description = "I am engulfed by unspeakable rage. I cannot stop myself from harming others. When that's not an option, my rage is directed inward."
	trait = TRAIT_GRAGGAR_CURSE

/datum/curse/matthios
	name = "Matthios' Curse"
	description = "I hate the sight of wealth, and I cannot have anything to do with mammons."
	trait = TRAIT_MATTHIOS_CURSE	

/datum/curse/baotha
	name = "Baotha's Curse"
	description = "I'm in a constant state of arousal, and I cannot control my urges."
	trait = TRAIT_BAOTHA_CURSE

//////////////////////
/// ON GAIN / LOSS ///
//////////////////////

/datum/curse/atheism/on_gain(mob/living/carbon/human/owner)
	. = ..()
	old_patron = owner.patron
	owner.patron = /datum/patron/godless
	owner.gain_trauma(/datum/brain_trauma/mild/phobia/religion)

/datum/curse/atheism/on_loss(mob/living/carbon/human/owner)
	. = ..()
	owner.patron = old_patron
	owner.cure_trauma_type(/datum/brain_trauma/mild/phobia/religion)

/datum/curse/zizo/on_gain(mob/living/carbon/human/owner)
	. = ..()
	hallucinations = owner.overlay_fullscreen("maniac", /atom/movable/screen/fullscreen/maniac)

/datum/curse/zizo/on_loss(mob/living/carbon/human/owner)
	. = ..()
	hallucinations = null

/datum/curse/xylix/on_gain(mob/living/carbon/human/owner)
	. = ..()
	owner.STALUC -= 10

/datum/curse/xylix/on_loss(mob/living/carbon/human/owner)
	. = ..()
	owner.STALUC += 10


//////////////////////
///    ON LIFE     ///
//////////////////////

/datum/curse/pestra/on_life(mob/living/carbon/human/owner)
	. = ..()
	if(prob(3))
		var/effect = rand(1, 4)
		switch(effect)
			if(1)
				owner.vomit()
			if(2)
				owner.Unconscious(20)
			if(3)
				owner.blur_eyes(10)
			if(4)
				var/obj/item/bodypart/BP = pick(owner.bodyparts)
				BP.rotted = TRUE
				owner.playsound_local(get_turf(owner), 'sound/foley/butcher.ogg', 80, FALSE, pressure_affected = FALSE)
				owner.regenerate_icons()

/datum/curse/baotha/on_life(mob/living/carbon/human/owner)
	. = ..()
	if(prob(3))
		var/effect = rand(1, 3)
		if(owner.gender == "female")
			switch(effect)
				if(1)
					owner.emote("sexmoanhvy")
				if(2)
					owner.emote("sexmoanlight")
				if(3)
					owner.freak_out()
		//else //we dont have male moans yet

/datum/curse/graggar/on_life(mob/living/carbon/human/owner)
	. = ..()		
	if(prob(5))
		for(var/mob/living/carbon/human in view(1, owner))
			owner.emote("rage")
			human.attacked_by(owner.get_active_held_item(), owner)
			owner.freak_out()
			break

// Currently calls maniac hallucinations
/datum/curse/zizo/on_life(mob/living/carbon/human/owner)
	. = ..()
	handle_visions(owner, hallucinations)
	handle_hallucinations(owner)
	handle_floors(owner)
	handle_walls(owner)
	
