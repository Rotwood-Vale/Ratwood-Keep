#define EMOTE_VISIBLE 1
#define EMOTE_AUDIBLE 2

/datum/emote
	var/key = "" //What calls the emote
	var/key_third_person = "" //This will also call the emote
	var/message = "" //Message displayed when emote is used
	var/message_mime = "" //Message displayed if the user is a mime
	var/message_alien = "" //Message displayed if the user is a grown alien
	var/message_larva = "" //Message displayed if the user is an alien larva
	var/message_robot = "" //Message displayed if the user is a robot
	var/message_AI = "" //Message displayed if the user is an AI
	var/message_monkey = "" //Message displayed if the user is a monkey
	var/message_simple = "" //Message to display if the user is a simple_animal
	var/message_param = "" //Message to display if a param was given
	var/emote_type = EMOTE_VISIBLE //Whether the emote is visible or audible
	var/restraint_check = FALSE //Checks if the mob is restrained before performing the emote
	var/muzzle_ignore = FALSE //Will only work if the emote is EMOTE_AUDIBLE
	var/list/mob_type_allowed_typecache = /mob //Types that are allowed to use that emote
	var/list/mob_type_blacklist_typecache //Types that are NOT allowed to use that emote
	var/list/mob_type_ignore_stat_typecache
	var/stat_allowed = CONSCIOUS
	var/sound //Sound to play when emote is called
	var/vary = FALSE	//used for the honk borg emote
	var/only_forced_audio = FALSE //can only code call this event instead of the player.
	var/nomsg = FALSE
	var/soundping = TRUE
	var/ignore_silent = FALSE
	var/snd_vol = 100
	var/snd_range = -1
	var/mute_time = 30//time after where someone can't do another emote

/datum/emote/New()
	if (ispath(mob_type_allowed_typecache))
		switch (mob_type_allowed_typecache)
			if (/mob)
				mob_type_allowed_typecache = GLOB.typecache_mob
			if (/mob/living)
				mob_type_allowed_typecache = GLOB.typecache_living
			else
				mob_type_allowed_typecache = typecacheof(mob_type_allowed_typecache)
	else
		mob_type_allowed_typecache = typecacheof(mob_type_allowed_typecache)
	mob_type_blacklist_typecache = typecacheof(mob_type_blacklist_typecache)
	mob_type_ignore_stat_typecache = typecacheof(mob_type_ignore_stat_typecache)

/datum/emote/proc/adjacentaction(mob/user, mob/target)
	return

/datum/emote/proc/run_emote(mob/user, params, type_override, intentional = FALSE, targetted = FALSE)
	. = TRUE
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	if(only_forced_audio && intentional)
		return FALSE
	if(targetted)
		var/list/mobsadjacent = list()
		var/mob/chosenmob
		for(var/mob/living/M in range(user, 2))
			if(M != user)
				mobsadjacent += M
		if(mobsadjacent.len)
			chosenmob = input("[key] who?") in mobsadjacent
		if(chosenmob)
			if(user.Adjacent(chosenmob))
				params = chosenmob.name
				adjacentaction(user, chosenmob)
	var/msg = select_message_type(user, intentional)
	if(params && message_param)
		msg = select_param(user, params)

	msg = replace_pronoun(user, msg)

	if(!msg && nomsg == FALSE)
		return

	if(!nomsg)
		user.log_message(msg, LOG_EMOTE)
		msg = "<b>[user]</b> " + msg

	var/pitch = 1 //bespoke vary system so deep voice/high voiced humans
	if(isliving(user))
		var/mob/living/L = user
		for(var/obj/item/implant/I in L.implants)
			I.trigger(key, L)
		pitch = L.get_emote_pitch()

	var/sound/tmp_sound = get_sound(user)
	if(!istype(tmp_sound))
		tmp_sound = sound(get_sfx(tmp_sound))
	tmp_sound.frequency = pitch
	if(tmp_sound && (!only_forced_audio || !intentional))
		playsound(user, tmp_sound, snd_vol, FALSE, snd_range, soundping = soundping)
	if(!nomsg)
		for(var/mob/M in GLOB.dead_mob_list)
			if(!M.client || isnewplayer(M))
				continue
			var/T = get_turf(user)
			if(M.stat == DEAD && M.client && (M.client.prefs?.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(T, null)))
				M.show_message(msg)
		if(emote_type == EMOTE_AUDIBLE)
			user.audible_message(msg)
		else
			user.visible_message(msg)

/mob/living/proc/get_emote_pitch()
	return clamp(voice_pitch, 0.7, 1.5)

/mob/living/carbon/human/get_emote_pitch()
	var/final_pitch = ..()
	var/pitch_modifier = 0
	if(!HAS_TRAIT(src, TRAIT_DECEIVING_MEEKNESS))
		if(STASTR > 10)
			pitch_modifier -= (STASTR - 10) * 0.03
		else if(STASTR < 10)
			pitch_modifier += (10 - STASTR) * 0.06
	return clamp(final_pitch + pitch_modifier, 0.8, 1.35)

/datum/emote/proc/get_env(mob/living/user)
	return

/datum/emote/living/get_env(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.head)
			var/obj/item/clothing/I = H.head
			if(I.emote_environment)
				return I.emote_environment

/datum/emote/proc/get_sound(mob/living/user)
	if(sound)
		return sound

/datum/emote/living/get_sound(mob/living/user)
	if(sound)
		return sound
	else
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			var/used_sound
			var/possible_sounds
			var/modifier
			if(H.age == AGE_OLD)
				modifier = "old"
			if(!ignore_silent && (H.silent || !H.can_speak()))
				modifier = "silenced"
			if(user.gender == FEMALE && H.dna.species.soundpack_f)
				possible_sounds = H.dna.species.soundpack_f.get_sound(key,modifier)
			else if(H.dna.species.soundpack_m)
				possible_sounds = H.dna.species.soundpack_m.get_sound(key,modifier)
			if(possible_sounds)
				if(islist(possible_sounds))
					var/list/PS = possible_sounds
					if(PS.len > 1)
						used_sound = pick_n_take(possible_sounds)
						if(used_sound == H.last_sound)
							used_sound = pick(possible_sounds)
					else
						used_sound = pick(possible_sounds)
				else //direct file
					used_sound = possible_sounds
				H.last_sound = used_sound
				return used_sound
		else
			return user.get_sound(key)

/mob/living/proc/get_sound(input)
	return

/datum/emote/proc/replace_pronoun(mob/user, message)
	if(findtext(message, "their"))
		message = replacetext(message, "their", user.p_their())
	if(findtext(message, "them"))
		message = replacetext(message, "them", user.p_them())
	if(findtext(message, "%s"))
		message = replacetext(message, "%s", user.p_s())
	return message

/datum/emote/proc/select_message_type(mob/user, intentional)
	. = message
	if(!muzzle_ignore && user.is_muzzled() && emote_type == EMOTE_AUDIBLE)
		return "makes a [pick("strong ", "weak ", "")]noise."
	if(user.mind && user.mind.miming && message_mime)
		. = message_mime
	if(isalienadult(user) && message_alien)
		. = message_alien
	else if(islarva(user) && message_larva)
		. = message_larva
	else if(iscyborg(user) && message_robot)
		. = message_robot
	else if(isAI(user) && message_AI)
		. = message_AI
	else if(ismonkey(user) && message_monkey)
		. = message_monkey
	else if(isanimal(user) && message_simple)
		. = message_simple

/datum/emote/proc/select_param(mob/user, params)
	return replacetext(message_param, "%t", params)

/datum/emote/proc/can_run_emote(mob/user, status_check = TRUE, intentional = FALSE)
	. = TRUE
	message = initial(message)
	if(!is_type_in_typecache(user, mob_type_allowed_typecache))
		return FALSE
	if(is_type_in_typecache(user, mob_type_blacklist_typecache))
		return FALSE
	if(status_check && !is_type_in_typecache(user, mob_type_ignore_stat_typecache))
		if(user.stat > stat_allowed)
			if(!intentional)
				return FALSE
/*			switch(user.stat)
				if(SOFT_CRIT)
					to_chat(user, span_warning("I cannot [key] while dying!"))
				if(UNCONSCIOUS)
					to_chat(user, span_warning("I cannot [key] while unconscious!"))
				if(DEAD)
					to_chat(user, span_warning("I cannot [key] while dead!"))*/
			return FALSE
		if(restraint_check)
			if(isliving(user))
				var/mob/living/L = user
				if(L.IsParalyzed() || L.IsStun())
					if(!intentional)
						return FALSE
//					to_chat(user, span_warning("I cannot [key] while stunned!"))
					return FALSE
		if(restraint_check && user.restrained())
			if(!intentional)
				return FALSE
//			to_chat(user, span_warning("I cannot [key] while restrained!"))
			return FALSE

	if(intentional && HAS_TRAIT(user, TRAIT_EMOTEMUTE))
		return FALSE
