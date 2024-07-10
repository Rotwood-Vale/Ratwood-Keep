
/obj/structure/roguemachine/scomm
	name = "SCOM"
	desc = "The Supernatural Communication Optical Machine is a wonder of magic and technology."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "scomm1"
	density = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	pixel_y = 32
	flags_1 = HEAR_1
	anchored = TRUE
	var/next_decree = 0
	var/listening = TRUE
	var/speaking = TRUE
	var/dictating = FALSE

/obj/structure/roguemachine/scomm/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/roguemachine/scomm/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/roguemachine/scomm/examine(mob/user)
	. = ..()
	. += "<b>THE LAWS OF THE LAND:</b>"
	if(!length(GLOB.laws_of_the_land))
		. += span_danger("The land has no laws! <b>We are doomed!</b>")
		return
	if(!user.is_literate())
		. += span_warning("Uhhh... I can't read them...")
		return
	for(var/i in 1 to length(GLOB.laws_of_the_land))
		. += span_small("[i]. [GLOB.laws_of_the_land[i]]")

/obj/structure/roguemachine/scomm/process()
	if(world.time > next_decree)
		next_decree = world.time + rand(3 MINUTES, 8 MINUTES)
		if(GLOB.lord_decrees.len)
			say("The King Decrees: [pick(GLOB.lord_decrees)]", spans = list("info"))

/obj/structure/roguemachine/scomm/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	listening = !listening
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the SCOM."))
	update_icon()

/obj/structure/roguemachine/scomm/attack_right(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	var/contents
	if(SSticker.rulertype == "King")
		contents += "<center>KING'S DECREES<BR>"
	else
		contents += "<center>QUEEN'S DECREES<BR>"
	contents += "-----------<BR><BR></center>"
	for(var/i = GLOB.lord_decrees.len to 1 step -1)
		contents += "[i]. <span class='info'>[GLOB.lord_decrees[i]]</span><BR>"
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 220)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/scomm/obj_break(damage_flag)
	..()
	speaking = FALSE
	listening = FALSE
	update_icon()
	icon_state = "[icon_state]-br"

/obj/structure/roguemachine/scomm/Initialize()
	. = ..()
//	icon_state = "scomm[rand(1,2)]"
	START_PROCESSING(SSroguemachine, src)
	update_icon()
	SSroguemachine.scomm_machines += src

/obj/structure/roguemachine/scomm/update_icon()
	if(obj_broken)
		set_light(0)
		return
	if(listening)
		icon_state = "scomm1"
	else
		icon_state = "scomm0"

/obj/structure/roguemachine/scomm/Destroy()
	SSroguemachine.scomm_machines -= src
	STOP_PROCESSING(SSroguemachine, src)
	set_light(0)
	return ..()

/obj/structure/roguemachine/scomm/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null

/obj/structure/roguemachine/scomm/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	if(speaker == src)
		return
	if(speaker.loc != loc)
		return
	if(!ishuman(speaker))
		return
	var/mob/living/carbon/human/H = speaker
	if(!listening)
		return
	var/usedcolor = H.voice_color
	if(H.voicecolor_override)
		usedcolor = H.voicecolor_override
	if(raw_message)
		if(lowertext(raw_message) == "say laws")
			dictate_laws()
			return
		for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
			S.repeat_message(raw_message, src, usedcolor, message_language)
		for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
			S.repeat_message(raw_message, src, usedcolor, message_language)
		for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)
			S.repeat_message(raw_message, src, usedcolor, message_language)//make the listenstone hear scom

/obj/structure/roguemachine/scomm/proc/dictate_laws()
	if(dictating)
		return
	dictating = TRUE
	repeat_message("THE LAWS OF THE LAND ARE...", tcolor = COLOR_RED)
	INVOKE_ASYNC(src, PROC_REF(dictation))

/obj/structure/roguemachine/scomm/proc/dictation()
	if(!length(GLOB.laws_of_the_land))
		sleep(2)
		repeat_message("THE LAND HAS NO LAWS!", tcolor = COLOR_RED)
		dictating = FALSE
		return
	for(var/i in 1 to length(GLOB.laws_of_the_land))
		sleep(2)
		repeat_message("[i]. [GLOB.laws_of_the_land[i]]", tcolor = COLOR_RED)
	dictating = FALSE

/proc/scom_announce(message)
	for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
		S.say(message, spans = list("info"))



//SCOMSTONE                 SCOMSTONE

/obj/item/scomstone
	name = "emerald ring"
	icon_state = "ring_emerald"
	desc = "A golden ring with an emerald gem."
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_RING
	obj_flags = null
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = HEAR_1
	muteinmouth = TRUE
	var/listening = TRUE
	var/speaking = TRUE
	sellprice = 35
//wip
/obj/item/scomstone/attack_right(mob/user)
    user.changeNext_move(CLICK_CD_MELEE)
    var/input_text = input(user, "Enter your message:", "Message")
    if(input_text)
        for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
            S.repeat_message(input_text)
        for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
            S.repeat_message(input_text)
        for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)//make the listenstone hear scomstone
            S.repeat_message(input_text)

/obj/item/scomstone/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	listening = !listening
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the scomstone."))
	update_icon()

/obj/item/scomstone/Destroy()
	SSroguemachine.scomm_machines -= src
	return ..()

/obj/item/scomstone/Initialize()
	. = ..()
	update_icon()
	SSroguemachine.scomm_machines += src

/obj/item/scomstone/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(!ismob(loc))
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/misc/scom.ogg', 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null


/obj/item/scomstone/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, 1, I, , spans, message_language=language)
	else
		send_speech(message, 1, src, , spans, message_language=language)

/obj/item/scomstone/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	if(speaker == src)
		return
	if(loc != speaker)
		return
	if(!ishuman(speaker))
		return
	var/mob/living/carbon/human/H = speaker
	if(!listening)
		return
	var/usedcolor = H.voice_color
	if(H.voicecolor_override)
		usedcolor = H.voicecolor_override
	if(raw_message)
		for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
			S.repeat_message(raw_message, src, usedcolor, message_language)
		for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
			S.repeat_message(raw_message, src, usedcolor, message_language)
		for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)
			S.repeat_message(raw_message, src, usedcolor, message_language)//make the listenstone hear scomstone scream

/obj/item/scomstone/bad
	name = "serfstone"
	icon_state = "ring_emerald"
	listening = FALSE
	sellprice = 2

/obj/item/scomstone/bad/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	return
//LISTENSTONE		LISTENSTONE
/obj/item/listenstone
	name = "emerald choker"
	icon_state = "listenstone"
	desc = "A iron and gold choker with an emerald gem."
	gripped_intents = null
	//dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	//force = 10
	//throwforce = 10
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_WRISTS
	obj_flags = null
	icon = 'icons/roguetown/clothing/neck.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = HEAR_1
	muteinmouth = TRUE
	var/listening = TRUE
	var/speaking = TRUE
	sellprice = 200


/obj/item/listenstone/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	listening = !listening
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the scomstone."))
	update_icon()
	if(listening)
		icon_state = "listenstone"
	else
		icon_state = "listenstone_act"

/obj/item/listenstone/Initialize()
	. = ..()
	update_icon()
	SSroguemachine.scomm_machines += src//dont know what this is for


/obj/item/listenstone/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null

/obj/item/listenstone/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, 1, I, , spans, message_language=language)
	else
		send_speech(message, 1, src, , spans, message_language=language)

	return
