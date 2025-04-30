/datum/species/vulpkanin/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	C.verbs += list(
		/mob/proc/howl,
		/mob/proc/growl,
		/mob/proc/whine,
		/mob/proc/barks,
	)

/datum/species/vulpkanin/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.verbs -= list(
		/mob/proc/howl,
		/mob/proc/growl,
		/mob/proc/whine,
		/mob/proc/barks,
	)

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

/datum/emote/living/chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "chirps!"
	message_muffled = "makes a muffled noise."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_chirp()
	set name = "Chirp"
	set category = "Noises"

	emote("chirp", intentional = TRUE)

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	message_muffled = "makes a muffled noise."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_caw()
	set name = "Caw"
	set category = "Noises"

	emote("caw", intentional = TRUE)

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "hoots"
	message = "hoots!"
	message_muffled = "makes a muffled noise."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_hoot()
	set name = "Hoot"
	set category = "Noises"

	emote("hoot", intentional = TRUE)

/datum/emote/living/bawk
	key = "bawk"
	key_third_person = "BAWKS!"
	message = "BAWKS!"
	message_muffled = "makes a muffled noise."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_bawk()
	set name = "Bawk"
	set category = "Noises"

	emote("bawk", intentional = TRUE)

/datum/emote/living/trill_bird
	key = "trill_bird"
	key_third_person = "trills!"
	message = "trills!"
	message_muffled = "makes a muffled noise."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_bird_trill()
	set name = "Trill"
	set category = "Noises"

	emote("trill_bird", intentional = TRUE)

/datum/emote/living/chirp_squeaky
	key = "chirp_squaky"
	key_third_person = "chirps squeaky!"
	message = "chirps squeaky!"
	message_muffled = "makes a muffled noise."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_chirp_squeaky()
	set name = "Chirp Squeaky"
	set category = "Noises"

	emote("chirp_squaky", intentional = TRUE)

/datum/emote/living/pip
	key = "pip"
	key_third_person = "pip!"
	message = "pips!"
	message_muffled = "makes a muffled noise."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_pip()
	set name = "Pip"
	set category = "Noises"

	emote("pip", intentional = TRUE)
