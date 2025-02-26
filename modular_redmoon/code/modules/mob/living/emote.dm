/datum/species/vulpkanin/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	C.verbs += list(
		/mob/proc/growl,
		/mob/proc/barks,
	)

/datum/species/vulpkanin/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.verbs -= list(
		/mob/proc/growl,
		/mob/proc/barks,
	)

/datum/species/lupian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	C.verbs += list(
		/mob/proc/growl,
		/mob/proc/barks,
	)

/datum/species/lupian/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.verbs -= list(
		/mob/proc/growl,
		/mob/proc/barks,
	)

/datum/emote/living/growl
	key = "growl"
	key_third_person = "growls"
	message = "growls."
	message_muffled = "makes a muffled noise."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/proc/growl()
	set name = "Growl"
	set category = "Noises"
	if(stat != CONSCIOUS)
		return
	if(next_move > world.time)
		return
	emote("growl")
	next_move = world.time + 3

/datum/emote/living/bark
	key = "bark"
	key_third_person = "barks"
	message = "barks."
	message_muffled = "makes a muffled noise."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/proc/barks()
	set name = "Bark"
	set category = "Noises"
	if(stat != CONSCIOUS)
		return
	if(next_move > world.time)
		return
	emote("bark")
	next_move = world.time + 3

/datum/emote/living/lower	// the emote that signals an animal is tamed. Previously smile was used. The chicken smiles. The pig smiles. Wut.
	key = "lower_head"
	key_third_person = "lowers_head"
	message = "lowers its head."
	message_param = "lowers its head."
	emote_type = EMOTE_VISIBLE

/datum/emote/living/lewdmoan
	key = "lewdmoan"
	key_third_person = "moans lewdly"
	message = "moans lewdly"
	message_muffled = "makes a muffled noise."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_lewdmoan()
	set name = "Moan Lewdly"
	set category = "Noises"

	emote("lewdmoan", intentional = TRUE)
