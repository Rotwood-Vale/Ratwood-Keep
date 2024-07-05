/mob/living/carbon/human
	/// List of curses on this mob
	var/list/curses = list()

/datum/curse
	var/name = "Debug Curse"

	/// Whats shown to the player upon being cursed
	var/description = "This is a debug curse."

	/// Trait given by this curse
	var/trait

///Called on life ticks
/datum/curse/proc/on_life()
	return 

///Called on death
/datum/curse/proc/on_death()
	return 


///Calls the on_life proc for all curses affecting a mob.
/mob/living/carbon/human/proc/handle_curses()
	for(var/curse in curses)
		var/datum/curse/C = new curse()
		C.on_life(src)
		qdel(C)

///Adds a curse to a human mob.
///@param C: The curse to be added.
///@return TRUE if the curse was successfully added, FALSE otherwise.
/mob/living/carbon/human/proc/add_curse(datum/curse/C)
	if(is_cursed(C))
		return FALSE
	curses += C
	ADD_TRAIT(src, C.trait, TRAIT_CURSE)
	to_chat(src, span_userdanger("Something is wrong... I feel cursed."))
	src.playsound_local(get_turf(src), 'sound/misc/cursed.ogg', 80, FALSE, pressure_affected = FALSE)
	return TRUE

///Removes a curse from a human mob.
///@param C: The curse to be removed.
///@return TRUE if the curse was successfully removed, FALSE otherwise.
/mob/living/carbon/human/proc/remove_curse(var/datum/curse/C)
	if(!is_cursed(C))
		return FALSE
	
	REMOVE_TRAIT(src, C.trait, TRAIT_CURSE)
	curses -= C
	to_chat(src, span_userdanger("Something has changed... I feel relieved."))
	src.playsound_local(get_turf(src), 'sound/misc/curse_lifted.ogg', 80, FALSE, pressure_affected = FALSE)
	return TRUE


///Checks if a given curse is affecting a human mob.
///@param C: The curse to check.
///@return TRUE if the curse is affecting the mob, FALSE otherwise.
/mob/living/carbon/human/proc/is_cursed(datum/curse/C)
	if(!src)
		return FALSE
	if(!C)
		return FALSE
	if(C in curses)
		return TRUE

//////////////////////
/// SPECIAL CURSES ///
//////////////////////

/datum/curse/science
	name = "Curse of Atheism"
	description = "Any mention of the divine sends me into a rage, I cannot be healed by divine magic, and I cannot pray to the gods."
	trait = TRAIT_SCIENCE_CURSE

/datum/curse/psydon
	name = "Curse of Psydon"
	description = ""
	trait = TRAIT_PSYDON_CURSE

//////////////////////
///   TEN CURSES   ///
//////////////////////

/datum/curse/astrata
	name = "Astrata's Curse"
	description = ""
	trait = TRAIT_ASTRATA_CURSE

/datum/curse/noc
	name = "Noc's Curse"
	description = "Magical knowledge is now beyond my grasp."
	trait = TRAIT_NOC_CURSE

/datum/curse/dendor
	name = "Dendor's Curse"
	description = "My hunger is insatiable."
	trait = TRAIT_DENDOR_CURSE

/datum/curse/abyssor
	name = "Abyssor's Curse"
	description = "Nothing can quench my thirst."
	trait = TRAIT_ABYSSOR_CURSE

/datum/curse/ravox
	name = "Ravox's Curse"
	description = ""
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
	description = "I feel sick to my stomach, and my skin is covered in a sickly green hue."
	trait = TRAIT_PESTRA_CURSE

/datum/curse/malum
	name = "Malum's Curse"
	description = ""
	trait = TRAIT_MALUM_CURSE

/datum/curse/eora
	name = "Eora's Curse"
	description = "I am unable to show any kind of affection or love, whether carnal or platonic."
	trait = TRAIT_EORA_CURSE

//////////////////////
/// INHUMEN CURSES ///
//////////////////////

/datum/curse/zizo
	name = "Zizo's Curse"
	description = ""
	trait = TRAIT_ZIZO_CURSE

/datum/curse/graggar
	name = "Graggar's Curse"
	description = ""
	trait = TRAIT_GRAGGAR_CURSE

/datum/curse/matthios
	name = "Matthios' Curse"
	description = "I hate the sight of wealth, and I cannot have anything to do with mammons."
	trait = TRAIT_MATTHIOS_CURSE	

/datum/curse/baotha
	name = "Baotha's Curse"
	description = ""
	trait = TRAIT_BAOTHA_CURSE

//////////////////////////
/// PERIODICAL EFFECTS ///
//////////////////////////

/datum/curse/pestra/on_life(mob/living/carbon/human/owner)
	. = ..()
	if(prob(3))
		message_admins("Pestra's Curse is active.")
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
