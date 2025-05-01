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
	message = "склоняет голову."
	message_param = "склоняет голову перед %t."
	runechat_msg = "склоняет голову"
	emote_type = EMOTE_VISIBLE

/datum/emote/living/lewdmoan
	key = "lewdmoan"
	key_third_person = "moans lewdly"
	message = "пошло стонет!"
	message_muffled = "издаёт сдавленный стон."
	runechat_msg = "пошло стонет"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_lewdmoan()
	set name = "Пошлый Стон"
	set category = "Noises"

	emote("lewdmoan", intentional = TRUE)

/datum/emote/living/chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "чирикает!"
	message_muffled = "издаёт сдавленное чириканье."
	runechat_msg = "чирикает"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_chirp()
	set name = "Чирикать"
	set category = "Noises"

	emote("chirp", intentional = TRUE)

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "каркает!"
	message_muffled = "издаёт сдавленное карканье."
	runechat_msg = "каркает"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_caw()
	set name = "Каркать"
	set category = "Noises"

	emote("caw", intentional = TRUE)

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "hoots"
	message = "ухукает!"
	message_muffled = "издаёт сдавленное ухуканье."
	runechat_msg = "ухукает"

	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_hoot()
	set name = "Уху"
	set category = "Noises"

	emote("hoot", intentional = TRUE)

/datum/emote/living/bawk
	key = "bawk"
	key_third_person = "BAWKS!"
	message = "кудахчет!"
	message_muffled = "издаёт сдавленное кудахтанье."
	runechat_msg = "кудахчет"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_bawk()
	set name = "Кудахтать"
	set category = "Noises"

	emote("bawk", intentional = TRUE)

/datum/emote/living/trill_bird
	key = "trill_bird"
	key_third_person = "trills!"
	message = "издаёт трелль!"
	message_muffled = "издаёт сдавленную трелль."
	runechat_msg = "издаёт трелль"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_bird_trill()
	set name = "Трелль"
	set category = "Noises"

	emote("trill_bird", intentional = TRUE)

/datum/emote/living/chirp_squeaky
	key = "chirp_squaky"
	key_third_person = "chirps squeaky!"
	message = "щебечет!"
	message_muffled = "издаёт сдавленное щебетание."
	runechat_msg = "щебечет"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_chirp_squeaky()
	set name = "Щебетать"
	set category = "Noises"

	emote("chirp_squaky", intentional = TRUE)

/datum/emote/living/pip
	key = "pip"
	key_third_person = "pip!"
	message = "пищит!"
	message_muffled = "издаёт сдавленное пищание."
	runechat_msg = "пищит"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/proc/emote_pip()
	set name = "Пищать"
	set category = "Noises"

	emote("pip", intentional = TRUE)
