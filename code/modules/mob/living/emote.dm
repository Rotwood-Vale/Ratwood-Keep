
/* EMOTE DATUMS */
/datum/emote/living
	mob_type_allowed_typecache = /mob/living
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/blush
	key = "blush"
	key_third_person = "краснеет"
	message = "крастнеет."


/datum/emote/living/pray
	key = "pray"
	key_third_person = "молится"
	message = "молится."
	restraint_check = FALSE
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_pray()
	set name = "Молится"
	set category = "Emotes"

	emote("pray", intentional = TRUE)

/datum/emote/living/pray/run_emote(mob/user, params, type_override, intentional)
	if(isliving(user))
		var/mob/living/L = user
		var/area/C = get_area(user)

		if(HAS_TRAIT(usr, TRAIT_ATHEISM_CURSE))
			to_chat(usr, span_danger("Молятся только глупцы."))
			return

		var/msg = input("Шепчи свою молитву:", "Молитва") as text|null
		if(msg)
			L.whisper(msg)
			L.roguepray(msg)
//			for(var/obj/structure/fluff/psycross/P in view(7, get_turf(L)) ) // We'll reenable this later when the patron statues are more fleshed out.
//				if(P.obj_broken)
//					continue
//				P.check_prayer(L,msg)
//				break
			if(istype(C, /area/rogue/underworld))
				L.check_prayer_underworld(L,msg)
				return
			L.check_prayer(L,msg)
			for(var/mob/living/LICKMYBALLS in hearers(2,src))
				LICKMYBALLS.succumb_timer = world.time

/mob/living/proc/check_prayer(mob/living/L,message)
	if(!L || !message)
		return FALSE
	var/message2recognize = sanitize_hear_message(message)
	var/mob/living/carbon/human/M = L
	if(length(message2recognize) > 15)
		if(L.mob_timers[MT_PSYPRAY])
			if(world.time < L.mob_timers[MT_PSYPRAY] + 1 MINUTES)
				L.mob_timers[MT_PSYPRAY] = world.time
				return FALSE
		else
			L.mob_timers[MT_PSYPRAY] = world.time
		if(!findtext(message2recognize, "[M.patron]"))
			return FALSE
		else
			L.playsound_local(L, 'sound/misc/notice (2).ogg', 100, FALSE)
			L.add_stress(/datum/stressevent/psyprayer)
			return TRUE
	else 
		to_chat(L, span_danger("Моя молитва была маловата..."))

/mob/living/proc/check_prayer_underworld(mob/living/L,message)
	if(!L || !message)
		return FALSE
	var/list/bannedwords = list("cock","dick","fuck","shit","pussy","ass","cuck","fucker","fucked","cunt","asshole")
	var/message2recognize = sanitize_hear_message(message)
	var/mob/living/carbon/spirit/M = L
	for(var/T in bannedwords)
		var/list/turfs = list()
		if(findtext(message2recognize, T))
			for(var/turf/U in /area/rogue/underworld)
				if(U.density)
					continue
				turfs.Add(U)

			var/turf/pickedturf = safepick(turfs)
			if(!pickedturf)
				return
			to_chat(L, "<font color='yellow'>INSOLENT WRETCH, YOUR STRUGGLE IS DESERVED.</font>")
			L.forceMove(pickedturf)
			return FALSE
	if(length(message2recognize) > 15)
		if(findtext(message2recognize, "[M.patron]"))
			L.playsound_local(L, 'sound/misc/notice (2).ogg', 100, FALSE)
			to_chat(L, "<font color='yellow'>I, [M.patron], твоя молитва была услышана, но тебе ничем не могут помочь.</font>")
			/*var/obj/item/underworld/coin/C = new 
			L.put_in_active_hand(C)*/
			return TRUE
		else
			return TRUE
	else 
		to_chat(L, span_danger("Моя молитва была маловата..."))

/datum/emote/living/meditate
	key = "meditate"
	key_third_person = "медитирует"
	message = "медитирует."
	restraint_check = FALSE
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_meditate()
	set name = "Медитация"
	set category = "Emotes"

	emote("meditate", intentional = TRUE)

/datum/emote/living/meditate/run_emote(mob/user, params, type_override, intentional)
	if(isliving(user))
		if(!COOLDOWN_FINISHED(user, schizohelp_cooldown))
			to_chat(user, span_warning("Мне нужно время прежде чем начать медитировать."))
			return
		var/msg = input("Молви свою медитацию:", "Голоса в твоей голове") as text|null
		if(msg)
			user.schizohelp(msg)

/datum/emote/living/bow
	key = "bow"
	key_third_person = "кланяется"
	message = "кланяется."
	message_param = "кланяется %t."
	restraint_check = TRUE
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_bow()
	set name = "Поклониться"
	set category = "Emotes"

	emote("bow", intentional = TRUE)

/datum/emote/living/burp
	key = "burp"
	key_third_person = "рыгает"
	message = "рыгает."
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_burp()
	set name = "Рыгнуть"
	set category = "Noises"

	emote("burp", intentional = TRUE)

/datum/emote/living/choke
	key = "choke"
	key_third_person = "давится"
	message = "давится!"
	emote_type = EMOTE_AUDIBLE
	ignore_silent = TRUE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_choke()
	set name = "Подавиться"
	set category = "Noises"

	emote("choke", intentional = TRUE)

/datum/emote/living/trill
	key = "trill"
	key_third_person = "урчит"
	message = "урчит."
	message_muffled = "издает приглушенный звук."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/meow
	key = "meow"
	key_third_person = "мяукает"
	message = "мяукает."
	message_muffled = "издает приглушенный звук."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/hiss
	key = "hiss"
	key_third_person = "шипит"
	message = "шипит!"
	message_muffled = "издает приглушенный звук."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/purr
	key = "purr"
	key_third_person = "мурчит"
	message = "мурчит."
	message_muffled = "издает приглушенный звук."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/howl
	key = "howl"
	key_third_person = "воет"
	message = "воет."
	message_muffled = "издает приглушенный звук."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/growl
	key = "growl"
	key_third_person = "рычит"
	message = "рычит."
	message_muffled = "издает приглушенный звук."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/whine
	key = "whine"
	key_third_person = "скулит"
	message = "скулит."
	message_muffled = "growl."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/bark
	key = "bark"
	key_third_person = "гавкает"
	message = "гавкает."
	message_muffled = "growl."
	only_forced_audio = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE
	
/datum/emote/living/cross
	key = "crossarms"
	key_third_person = "скрещивает на груди"
	message = "скрещивает на груди."
	restraint_check = TRUE
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_crossarms()
	set name = "Скрестить руки"
	set category = "Emotes"

	emote("crossarms", intentional = TRUE)

/datum/emote/living/collapse
	key = "collapse"
	key_third_person = "падает"
	message = "падает."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/collapse/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Unconscious(40)

/datum/emote/living/whisper
	key = "whisper"
	key_third_person = "шепчет"
	message = "шепчет."
	message_mime = "что-то шепчет."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/aggro
	key = "aggro"
	key_third_person = "aggro"
	message = ""
	nomsg = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/cough
	key = "cough"
	key_third_person = "кашляет"
	message = "кашляет."
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_cough()
	set name = "Кашлять"
	set category = "Noises"

	emote("cough", intentional = TRUE)

/datum/emote/living/clearthroat
	key = "clearthroat"
	key_third_person = "прочещает горло"
	message = "прочещает горло."
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_clearthroat()
	set name = "Прочещать горло"
	set category = "Noises"

	emote("clearthroat", intentional = TRUE)

/datum/emote/living/dance
	key = "dance"
	key_third_person = "танцует"
	message = "танцует."
	restraint_check = TRUE
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_dance()
	set name = "Танцевать"
	set category = "Emotes"

	emote("dance", intentional = TRUE)

/datum/emote/living/deathgasp
	key = ""
	key_third_person = ""
	message = "издаёт свой последний вздох."
	message_monkey = "издает слабый звук, когда падает и перестает двигаться..."
	message_simple =  "падает без сил."
	stat_allowed = UNCONSCIOUS

/datum/emote/living/deathgasp/run_emote(mob/user, params, type_override, intentional)
	var/mob/living/simple_animal/S = user
	if(istype(S) && S.deathmessage)
		message_simple = S.deathmessage
	. = ..()
	message_simple = initial(message_simple)
	if(. && user.deathsound)
		if(isliving(user))
			var/mob/living/L = user
			if(!L.can_speak_vocal() || L.oxyloss >= 50)
				return //stop the sound if oxyloss too high/cant speak
		playsound(user, user.deathsound, 200, TRUE, TRUE)

/datum/emote/living/drool
	key = "drool"
	key_third_person = "пускает слюни"
	message = "пускает слюни."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_drool()
	set name = "Пускать слюнки"
	set category = "Emotes"

	emote("drool", intentional = TRUE)

/datum/emote/living/faint
	key = "faint"
	key_third_person = "теряет сознание"
	message = "теряет сознание."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_faint()
	set name = "Обморок"
	set category = "Emotes"

	emote("faint", intentional = TRUE)

/datum/emote/living/faint/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/L = user
		if(L.get_complex_pain() > (L.STAEND * 9))
			L.setDir(2)
			L.SetUnconscious(200)
		else
			L.Knockdown(10)

/datum/emote/living/flap
	key = "flap"
	key_third_person = "хлопает"
	message = "хлопает крыльями."
	restraint_check = TRUE
	var/wing_time = 20

/datum/emote/living/carbon/human/flap/can_run_emote(mob/user, status_check = TRUE , intentional)
	return FALSE

/datum/emote/living/flap/aflap
	key = "aflap"
	key_third_person = "агрессивно хлопает"
	message = "агрессивно хлопает крыльями!"
	restraint_check = TRUE
	wing_time = 10

/datum/emote/living/carbon/human/aflap/can_run_emote(mob/user, status_check = TRUE , intentional)
	return FALSE

/datum/emote/living/frown
	key = "frown"
	key_third_person = "хмурится"
	message = "хмурится."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_frown()
	set name = "Хмуриться"
	set category = "Emotes"

	emote("frown", intentional = TRUE)

/datum/emote/living/gag
	key = "gag"
	key_third_person = "поперхнулся"
	message = "поперхнулся."
	emote_type = EMOTE_AUDIBLE
	ignore_silent = TRUE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_gag()
	set name = "Поперхнуться"
	set category = "Noises"

	emote("gag", intentional = TRUE)

/datum/emote/living/gasp
	key = "gasp"
	key_third_person = "задыхается"
	message = "задыхается!"
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_gasp()
	set name = "Задыхаться"
	set category = "Noises"

	emote("gasp", intentional = TRUE)

/datum/emote/living/breathgasp
	key = "breathgasp"
	key_third_person = "задыхается от нехватки воздуха"
	message = "задыхается от нехватки воздуха!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/giggle
	key = "giggle"
	key_third_person = "хихикает"
	message = "хихикает."
	message_mime = "беззвучно хихикает!"
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_giggle()
	set name = "Хихикать"
	set category = "Noises"

	emote("giggle", intentional = TRUE)

/datum/emote/living/chuckle
	key = "chuckle"
	key_third_person = "издаёт смешок"
	message = "издаёт смешок"
	message_muffled = "издаёт пришглушённый смешок"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_chuckle()
	set name = "Смешок"
	set category = "Noises"

	emote("chuckle", intentional = TRUE)

/datum/emote/living/glare
	key = "glare"
	key_third_person = "пялится"
	message = "пялится"
	message_param = "пялится на %t"
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_glare()
	set name = "Пялиться"
	set category = "Emotes"

	emote("glare", intentional = TRUE)

/datum/emote/living/grin
	key = "grin"
	key_third_person = "ухмеляется"
	message = "ухмыляется."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_grin()
	set name = "Ухмельнуться"
	set category = "Emotes"

	emote("grin", intentional = TRUE)

/datum/emote/living/groan
	key = "groan"
	key_third_person = "тяжело вздыхает"
	message = "тяжело вздыхает."
	message_muffled = "издаёт сдавленный вздох."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_groan()
	set name = "Тяжело вздыхать"
	set category = "Noises"

	emote("groan", intentional = TRUE)

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "кривится"
	message = "кривится."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_grimace()
	set name = "Кривиться"
	set category = "Emotes"

	emote("grimace", intentional = TRUE)

/datum/emote/living/jump
	key = "jump"
	key_third_person = "прыгает"
	message = "прыгает!"
	restraint_check = TRUE

/datum/emote/living/leap
	key = "leap"
	key_third_person = "напрыгивает"
	message = "напрыгивает!"
	restraint_check = TRUE
	only_forced_audio = TRUE

/datum/emote/living/kiss
	key = "kiss"
	key_third_person = "целует"
	message = "дарит поцелуй."
	message_param = "целует %t."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_kiss()
	set name = "Поцелуй"
	set category = "Emotes"

	emote("kiss", intentional = TRUE, targetted = TRUE)

/datum/emote/living/kiss/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_EORA_CURSE))
		var/mob/living/carbon/human/H = user
		to_chat(H, "<span class='warning'>Эта идея отвращает меня!</span>")
		H.cursed_freak_out()
		return FALSE

/datum/emote/living/kiss/adjacentaction(mob/user, mob/target)
	. = ..()
	message_param = initial(message_param) // re
	if(!user || !target)
		return
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/E = target

		// cursed is the one being kissed
		if(HAS_TRAIT(E, TRAIT_EORA_CURSE))
			to_chat(E, "<span class='warning'>Я чувствую необъяснимое отвращение!</span>")
			E.cursed_freak_out()

		var/do_change
		if(target.loc == user.loc)
			do_change = TRUE
		if(!do_change)
			if(H.pulling == target)
				do_change = TRUE
		if(do_change)
			if(H.zone_selected == BODY_ZONE_PRECISE_MOUTH)
				message_param = "глубоко целует %t."
			else if(H.zone_selected == BODY_ZONE_PRECISE_EARS)
				message_param = "целует %t в ушко."
				if(iself(E) || ishalfelf(E))
					if(!E.cmode)
						to_chat(target, span_love("Это щекотно..."))
			else if(H.zone_selected == BODY_ZONE_PRECISE_R_EYE || H.zone_selected == BODY_ZONE_PRECISE_L_EYE)
				message_param = "целует %t в бровь."
			else
				message_param = "целует %t в \the [parse_zone(H.zone_selected)]."

	playsound(target.loc, pick('sound/vo/kiss (1).ogg','sound/vo/kiss (2).ogg'), 100, FALSE, -1)


/datum/emote/living/spit
	key = "spit"
	key_third_person = "плюётся"
	message = "сплёвывает на землю."
	message_param = "плюётся в %t."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_spit()
	set name = "Плеваться"
	set category = "Emotes"

	emote("spit", intentional = TRUE, targetted = TRUE)


/datum/emote/living/spit/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param) // reset
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.mouth)
			if(H.mouth.spitoutmouth)
				H.visible_message(span_warning("[H] spits out [H.mouth]."))
				H.dropItemToGround(H.mouth, silent = FALSE)
			return
	..()

/datum/emote/living/spit/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(user.gender == MALE)
		playsound(target.loc, pick('sound/vo/male/gen/spit.ogg'), 100, FALSE, -1)
	else
		playsound(target.loc, pick('sound/vo/female/gen/spit.ogg'), 100, FALSE, -1)


/datum/emote/living/hug
	key = "hug"
	key_third_person = "обнимает"
	message = ""
	message_param = "обнимает %t."
	emote_type = EMOTE_VISIBLE
	restraint_check = TRUE

/mob/living/carbon/human/verb/emote_hug()
	set name = "Обнять"
	set category = "Emotes"

	emote("hug", intentional = TRUE, targetted = TRUE)

/datum/emote/living/hug/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_EORA_CURSE))
		var/mob/living/carbon/human/H = user
		to_chat(H, "<span class='warning'>The idea repulses me!</span>")
		H.cursed_freak_out()
		return FALSE

/datum/emote/living/hug/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target

		// cursed is the one being hugged
		if(HAS_TRAIT(H, TRAIT_EORA_CURSE))
			to_chat(H, "<span class='warning'>Я испытываю необъяснимое отвращение!</span>")
			H.cursed_freak_out()
			return

/datum/emote/living/holdbreath
	key = "hold"
	key_third_person = "holds"
	message = "задерживает дыхание."
	stat_allowed = SOFT_CRIT

/mob/living/carbon/human/verb/emote_hold()
	set name = "Задержать дыхание"
	set category = "Emotes"

	emote("hold", intentional = TRUE)

/datum/emote/living/holdbreath/can_run_emote(mob/living/user, status_check = TRUE, intentional)
	. = ..()
	if(. && intentional && !HAS_TRAIT(user, TRAIT_HOLDBREATH) && !HAS_TRAIT(user, TRAIT_PARALYSIS))
		to_chat(user, span_warning("Я не настолько отчаянный, чтобы сделать это."))
		return FALSE

/datum/emote/living/holdbreath/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		if(HAS_TRAIT(user, TRAIT_HOLDBREATH))
			REMOVE_TRAIT(user, TRAIT_HOLDBREATH, "[type]")
		else
			ADD_TRAIT(user, TRAIT_HOLDBREATH, "[type]")

/datum/emote/living/holdbreath/select_message_type(mob/user, intentional)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_HOLDBREATH))
		. = "перестаёт задерживать дыхание."

/datum/emote/living/slap
	key = "slap"
	key_third_person = "шлёпает"
	message = ""
	message_param = "шлёпает %t по лицу."
	emote_type = EMOTE_VISIBLE
	restraint_check = TRUE


/datum/emote/living/slap/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param) // reset
	// RATWOOD MODULAR START
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.zone_selected == BODY_ZONE_PRECISE_GROIN)
			message_param = "slaps %t's ass!"
	// RATWOOD MODULAR END
	..()

/mob/living/carbon/human/verb/emote_slap()
	set name = "Шлепок"
	set category = "Emotes"

	emote("slap", intentional = TRUE, targetted = TRUE)

/datum/emote/living/slap/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.flash_fullscreen("redflash3")
		H.AdjustSleeping(-50)
		playsound(target.loc, 'sound/foley/slap.ogg', 100, TRUE, -1)

/datum/emote/living/pinch
	key = "pinch"
	key_third_person = "щипает"
	message = ""
	message_param = "щипает %t."
	emote_type = EMOTE_VISIBLE
	restraint_check = TRUE

/datum/emote/living/pinch/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.flash_fullscreen("redflash1")

/mob/living/carbon/human/verb/emote_pinch()
	set name = "Щипать"
	set category = "Emotes"

	emote("pinch", intentional = TRUE, targetted = TRUE)



/datum/emote/living/laugh
	key = "laugh"
	key_third_person = "смеётся"
	message = "смеётся."
	message_mime = "беззвучно смеётся!"
	message_muffled = "издаёт сдавленный смех."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/laugh/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		return !C.silent

/mob/living/carbon/human/verb/emote_laugh()
	set name = "Смех"
	set category = "Noises"

	emote("laugh", intentional = TRUE)

/datum/emote/living/look
	key = "look"
	key_third_person = "смотрит"
	message = "уставился в пустоту."
	message_param = "смотрит на %t."

/datum/emote/living/nod
	key = "nod"
	key_third_person = "кивает"
	message = "кивает."
	message_param = "кивает %t."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_nod()
	set name = "Кивать"
	set category = "Emotes"

	emote("nod", intentional = TRUE)

/datum/emote/living/point
	key = "point"
	key_third_person = "указывает"
	message = "указывает."
	message_param = "указывает на %t."
	restraint_check = TRUE

/datum/emote/living/point/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param) // reset
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.get_num_arms() == 0)
			if(H.get_num_legs() != 0)
				message_param = "пытается указать на %t ногой, <span class='danger'>падая</span> в процессе!"
				H.Paralyze(20)
			else
				message_param = "<span class='danger'>ударяется [user.p_their()] головой о землю</span> пытаясь двигаться в сторону %t."
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
	..()

/datum/emote/living/pout
	key = "pout"
	key_third_person = "pouts"
	message = "pouts."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/scream
	key = "scream"
	key_third_person = "кричит"
	message = "кричит!"
	message_mime = "беззвучно кричит!"
	message_muffled = "издаёт сдавленный звук в попытках вскрикнуть!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_scream()
	set name = "Кричит"
	set category = "Noises"

	emote("scream", intentional = TRUE)

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(intentional)
			if(!C.stamina_add(10))
				to_chat(C, span_warning("Я пытаюсь кричать, но мой голос подводит меня."))
				. = FALSE

/datum/emote/living/scream/painscream
	key = "painscream"
	message = "кричит от боли!"
	emote_type = EMOTE_AUDIBLE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/scream/agony
	key = "agony"
	message = "кричит в агонии!"
	emote_type = EMOTE_AUDIBLE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/scream/firescream
	key = "firescream"
	nomsg = TRUE
	emote_type = EMOTE_AUDIBLE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/aggro
	key = "aggro"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/idle
	key = "idle"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/death
	key = "death"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	stat_allowed = UNCONSCIOUS
	mob_type_ignore_stat_typecache = list(/mob/living)
	show_runechat = FALSE

/datum/emote/living/pain
	key = "pain"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/drown
	key = "drown"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	ignore_silent = TRUE
	show_runechat = FALSE

/datum/emote/living/paincrit
	key = "paincrit"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/embed
	key = "embed"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/painmoan
	key = "painmoan"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/groin
	key = "groin"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/fatigue
	key = "fatigue"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/jump
	key = "jump"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/haltyell
	key = "haltyell"
	message = "приказывает остановиться!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = TRUE

/mob/living/carbon/human/verb/emote_haltyell()
	set name = "СТОЯТЬ!"
	set category = "Noises"

	emote("haltyell", intentional = TRUE)

/datum/emote/living/rage
	key = "rage"
	message = "кричит в ярости!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_rage()
	set name = "Ярость"
	set category = "Noises"

	emote("rage", intentional = TRUE)

/datum/emote/living/attnwhistle
	key = "attnwhistle"
	message = "свистит, чтобы привлечь внимание!"
	message_muffled = "издаёт сдавленный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_attnwhistle()
	set name = "Освистнуть"
	set category = "Noises"

	emote("attnwhistle", intentional = TRUE)

/datum/emote/living/choke
	key = "choke"
	key_third_person = "давится"
	message = "давится!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/scowl
	key = "scowl"
	key_third_person = "хмурится"
	message = "нахмурился."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/shakehead
	key = "shakehead"
	key_third_person = "машет головой в отрицании"
	message = "машет головой в отрицании."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_shakehead()
	set name = "Отрицать"
	set category = "Emotes"

	emote("shakehead", intentional = TRUE)


/datum/emote/living/shiver
	key = "shiver"
	key_third_person = "дрожит"
	message = "дрожит."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_shiver()
	set name = "Дрожать"
	set category = "Emotes"

	emote("shiver", intentional = TRUE)


/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "вздыхает"
	message = "вздыхает."
	message_muffled = "издаёт сдавленный вздох."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_sigh()
	set name = "Вздыхать"
	set category = "Noises"

	emote("sigh", intentional = TRUE)

/datum/emote/living/whistle
	key = "whistle"
	key_third_person = "свистит"
	message = "свистит."
	message_muffled = "издаёт сдавленный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_whistle()
	set name = "Свистеть"
	set category = "Noises"

	emote("whistle", intentional = TRUE)

/datum/emote/living/hmm
	key = "hmm"
	key_third_person = "хмыкает"
	message = "хмыкает."
	message_muffled = "издаёт сдавленный хмык."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_hmm()
	set name = "Хмм"
	set category = "Noises"

	emote("hmm", intentional = TRUE)

/datum/emote/living/huh
	key = "huh"
	key_third_person = "huhs"
	message_muffled = "издаёт сдавленный звук."
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_huh()
	set name = "Хах?"
	set category = "Noises"

	emote("huh", intentional = TRUE)

/datum/emote/living/hum
	key = "hum"
	key_third_person = "hums"
	message = "мелодично мычит."
	emote_type = EMOTE_AUDIBLE
	message_muffled = "издаёт сдавленное мелодичное мычание."
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_hum()
	set name = "Мелодично мычать"
	set category = "Noises"

	emote("hum", intentional = TRUE)

/datum/emote/living/smile
	key = "smile"
	key_third_person = "улыбается"
	message = "улыбается."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_smile()
	set name = "Улыбнуться"
	set category = "Emotes"

	emote("smile", intentional = TRUE)

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "чихает"
	message = "чихает."
	message_muffled = "издаёт сдавленый чих."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/shh
	key = "shh"
	key_third_person = "shhs"
	message = "шикает."
	message_muffled = "издаёт сдавленный шик."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_shh()
	set name = "Шикнуть"
	set category = "Noises"

	emote("shh", intentional = TRUE)

/datum/emote/living/smug
	key = "smug"
	key_third_person = "smugs"
	message = "grins smugly."

/datum/emote/living/sniff
	key = "sniff"
	key_third_person = "нюхает"
	message = "принюхивается."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/snore
	key = "snore"
	key_third_person = "храпит"
	message = "храпит."
	message_mime = "беззвучно храпит."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS
	snd_range = -4
	show_runechat = FALSE

/datum/emote/living/stare
	key = "stare"
	key_third_person = "пялится"
	message = "пялится."
	message_param = "пялится на %t."

/datum/emote/living/strech
	key = "stretch"
	key_third_person = "разминается"
	message = "разминает руки."

/datum/emote/living/sulk
	key = "sulk"
	key_third_person = "sulks"
	message = "sulks down sadly."

/datum/emote/living/sway
	key = "sway"
	key_third_person = "sways"
	message = "sways around dizzily."

/datum/emote/living/tremble
	key = "tremble"
	key_third_person = "trembles"
	message = "trembles in fear!"

/datum/emote/living/twitch
	key = "twitch"
	key_third_person = "дёргается"
	message = "сильно дёргается."

/datum/emote/living/twitch_s
	key = "twitch_s"
	message = "дёргается."
	stat_allowed = UNCONSCIOUS
	mob_type_ignore_stat_typecache = list(/mob/living/carbon/human)

/datum/emote/living/wave
	key = "wave"
	key_third_person = "машет"
	message = "машет рукой."

/datum/emote/living/whimper
	key = "whimper"
	key_third_person = "хныкает"
	message = "хныкает."
	message_mime = "беззвучно хныкает."
	message_muffled = "издаёт сдавленное хныканье."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_whimper()
	set name = "Хныкать"
	set category = "Noises"

	emote("whimper", intentional = TRUE)

/datum/emote/living/wsmile
	key = "wsmile"
	key_third_person = "слабо улыбается"
	message = "слабо улыбается."

/datum/emote/living/yawn
	key = "yawn"
	key_third_person = "зевает"
	message = "зевает."
	message_muffled = "сдавленно зевает."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_yawn()
	set name = "Зевать"
	set category = "Noises"

	emote("yawn", intentional = TRUE)

/datum/emote/living/custom
	key = "me"
	key_third_person = "custom"
	show_runechat = TRUE
#ifdef MATURESERVER
	message_param = "%t"
#endif

/datum/emote/living/custom/can_run_emote(mob/user, status_check, intentional)
	. = ..() && intentional

/datum/emote/living/custom/proc/check_invalid(mob/user, input)
	. = TRUE
	if(copytext(input,1,5) == "says")
		to_chat(user, span_danger("Invalid emote."))
	else if(copytext(input,1,9) == "exclaims")
		to_chat(user, span_danger("Invalid emote."))
	else if(copytext(input,1,6) == "yells")
		to_chat(user, span_danger("Invalid emote."))
	else if(copytext(input,1,5) == "asks")
		to_chat(user, span_danger("Invalid emote."))
	else
		. = FALSE

/datum/emote/living/custom/run_emote(mob/user, params, type_override = null, intentional = FALSE)
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	else if(QDELETED(user))
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, span_boldwarning("I cannot send IC messages (muted)."))
		return FALSE
	else if(!params)
		var/custom_emote = copytext(sanitize(input("What does your character do?") as text|null), 1, MAX_MESSAGE_LEN)
		if(custom_emote && !check_invalid(user, custom_emote))
/*			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return*/
			message = custom_emote
			emote_type = EMOTE_VISIBLE
	else
		message = params
		if(type_override)
			emote_type = type_override
	. = ..()
	message = null
	emote_type = EMOTE_VISIBLE

/datum/emote/living/custom/replace_pronoun(mob/user, message)
	return message

/datum/emote/living/help
	key = "help"

/datum/emote/living/shake
	key = "shake"
	key_third_person = "машет головой в отрицании"
	message = "машет головой в отрицании."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_shake()
	set name = "Отрицать"
	set category = "Emotes"

	emote("shake", intentional = TRUE)

/* Vomit emote */
/mob/living/carbon/human/verb/emote_vomit()
	set name = "Блевать"
	set category = "Emotes"
	
	emote("vomit", intentional = TRUE)

/datum/emote/living/vomit
	key = "vomit"
	nomsg = TRUE

/datum/emote/living/vomit/run_emote(mob/user, params, type_override, intentional, targetted)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.vomit()
		var/msg = "[key_name(H)] блюёт!"
		message_admins(msg)
		log_admin(msg)

/datum/emote/living/squint
	key = "squint"
	key_third_person = "прищуривается"
	message = "прищуривается."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_squint()
	set name = "Прищуриться"
	set category = "Emotes"

	emote("squint", intentional = TRUE)
