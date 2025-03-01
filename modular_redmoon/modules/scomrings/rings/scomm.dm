/obj/structure/roguemachine/scomm
	var/spawned_rat = FALSE
	var/garrisonline = FALSE

/obj/structure/roguemachine/scomm/MiddleClick(mob/living/carbon/human/user)
	if(.)
		return
	if((user.job == "Warden") || (user.job == "Knight") || (user.job == "Duke") || (user.job == "Retinue Captain") || (user.job == "Duchess") || (user.job == "Town Sheriff") || (user.job == "Royal Marshal") || (user.job == "Man At Arms") || (user.job == "Steward") || (user.job == "Hand"))
		if(alert("Would you like to swap lines or connect to a jabberline?",, "Swap line", "Jabberline") != "jabberline")
			garrisonline = !garrisonline
			to_chat(user, span_info("I [garrisonline ? "connect to the court SCOMline" : "connect to the general SCOMLINE"]"))
			playsound(loc, 'modular_redmoon/modules/scomrings/ringssound/garrisonscom.ogg', 100, FALSE, -1)
			update_icon()
			return

//SCOMSTONE                 SCOMSTONE

/obj/item/scomstone_rk
	name = "Gemerald tuned ring"
	icon_state = "ring_emerald"
	desc = "A golden ring with a beautiful gem"
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_RING
	obj_flags = null
	icon = 'modular_redmoon/modules/scomrings/rings/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = HEAR_1
	muteinmouth = TRUE
	var/listening = TRUE
	var/speaking = TRUE
	var/messagereceivedsound = 'sound/misc/scom.ogg'
	var/hearrange = 1 // change to 0 if you want your special scomstone_rk to be only hearable by wearer
	drop_sound = 'sound/foley/coinphy (1).ogg'
	sellprice = 100
	grid_width = 32
	grid_height = 32
//wip
/obj/item/scomstone_rk/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_MELEE)
	var/input_text = input(user, "Enter your message:", "Message")
	if(input_text)
		var/usedcolor = user.voice_color
		if(user.voicecolor_override)
			usedcolor = user.voicecolor_override
		user.whisper(input_text)
		if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
			input_text = "<small>[input_text]</small>"
		for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)
		for(var/obj/item/scomstone_rk/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)
		for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)//make the listenstone hear scomstone_rk
			S.repeat_message(input_text, src, usedcolor)

/obj/item/scomstone_rk/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	listening = !listening
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the ring."))
	update_icon()

/obj/item/scomstone_rk/Destroy()
	SSroguemachine.scomm_machines -= src
	return ..()

/obj/item/scomstone_rk/Initialize()
	. = ..()
	update_icon()
	SSroguemachine.scomm_machines += src

/obj/item/scomstone_rk/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(!ismob(loc))
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, messagereceivedsound, 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null


/obj/item/scomstone_rk/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, hearrange, I, , spans, message_language=language)
	else
		send_speech(message, hearrange, src, , spans, message_language=language)

/obj/item/scomstone_rk/bad
	name = "Cheap tuned ring"
	desc = "A rusty ring with a dull glass piece shoddily sticking out of it."
	icon_state = "ring_lamerald"
	listening = FALSE
	sellprice = 40

/obj/item/scomstone_rk/bad/attack_right(mob/user)
	return

// garrison scoms/listenstones

/obj/item/scomstone_rk/garrison
	name = "Saffira tuned ring"
	icon_state = "ring_sapphire"
	desc = "A silver ring with an sapphire gem. This actually makes you feel important"
	var/garrisonline = TRUE
	messagereceivedsound = 'modular_redmoon/modules/scomrings/ringssound/garrisonscom.ogg'
	hearrange = 0
	sellprice = 150

/obj/item/scomstone_rk/garrison/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_MELEE)
	var/input_text = input(user, "Enter your message:", "Message")
	if(input_text)
		var/usedcolor = user.voice_color
		if(user.voicecolor_override)
			usedcolor = user.voicecolor_override
		user.whisper(input_text)
		if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
			input_text = "<small>[input_text]</small>"
		if(!garrisonline)
			for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
				S.repeat_message(input_text, src, usedcolor)
			for(var/obj/item/scomstone_rk/S in SSroguemachine.scomm_machines)
				S.repeat_message(input_text, src, usedcolor)
			for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)
				S.repeat_message(input_text, src, usedcolor)
		if(garrisonline)
			for(var/obj/item/scomstone_rk/bad/garrison/S in SSroguemachine.scomm_machines)
				S.repeat_message(input_text, src, usedcolor)
			for(var/obj/item/scomstone_rk/garrison/S in SSroguemachine.scomm_machines)
				S.repeat_message(input_text, src, usedcolor)
			for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
				if(S.garrisonline)
					S.repeat_message(input_text, src, usedcolor)

/obj/item/scomstone_rk/garrison/attack_self(mob/living/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	garrisonline = !garrisonline
	to_chat(user, span_info("I [garrisonline ? "connect to the court SCOMline" : "connect to the general SCOMline"]"))

/obj/item/scomstone_rk/bad/garrison
	name = "Striped tuned ring"
	desc = "A silver ring with a glass imitation of a gem shoddily sticking out of it. This one has the badly painted red stripe, it inspires you to push forward."
	icon_state = "ring_lamerag"
	listening = FALSE
	sellprice = 40
	messagereceivedsound = 'modular_redmoon/modules/scomrings/ringssound/garrisonscom.ogg'
	hearrange = 0
