/////////////////////////////////////////Scrying///////////////////

/obj/item/scrying
	name = "scrying orb"
	desc = "On it's glass depths, you can scry on many beings... After each use it must recharge for three minutes."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state ="scrying"
	throw_speed = 3
	throw_range = 7
	throwforce = 15
	damtype = BURN
	force = 15
	hitsound = 'sound/blank.ogg'
	sellprice = 30
	dropshrink = 0.6

	var/mob/current_owner
	var/last_scry


/obj/item/scrying/attack_self(mob/user)
	. = ..()
	if(world.time < last_scry + 3 MINUTES)
		to_chat(user, span_warning("I look into the ball but only see inky smoke. Maybe I should wait."))
		return
	var/input = stripped_input(user, "Who are you looking for?", "Scrying Orb")
	if(!input)
		return
	if(!user.key)
		return
	if(world.time < last_scry + 3 MINUTES)
		to_chat(user, span_warning("I look into the ball but only see inky smoke. Maybe I should wait."))
		return
	if(!user.mind || !user.mind.do_i_know(name=input))
		to_chat(user, span_warning("I don't know anyone by that name."))
		return
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HL.real_name == input)
			var/turf/T = get_turf(HL)
			if(!T)
				continue
			var/mob/dead/observer/screye/S = user.scry_ghost()
			if(!S)
				return
			S.ManualFollow(HL)
			last_scry = world.time
			user.visible_message(span_danger("[user] stares into [src], [user.p_their()] eyes rolling back into [user.p_their()] head."))
			message_admins("SCRYING: [user] ([user.ckey]) has used the scrying orb to leer at [HL] ([HL.ckey])")
			log_game("SCRYING: [user] ([user.ckey]) has used the scrying orb to leer at [HL] ([HL.ckey])")
			addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 8 SECONDS)
			if(!HL.stat)
				if(HL.STAPER >= 11)
					if(HL.mind)
						if(HL.mind.do_i_know(name=user.real_name))
							to_chat(HL, span_warning("I can clearly see the face of [user.real_name] staring at me!."))
							return
					to_chat(HL, span_warning("I can clearly see the face of an unknown [user.gender == FEMALE ? "woman" : "man"] staring at me!"))
					return
				if(HL.STAPER >= 9)
					to_chat(HL, span_warning("I feel a pair of unknown eyes on me."))
			return
	to_chat(user, span_warning("I peer into the ball, but can't find [input]."))
	return

/////////////////////////////////////////Crystal ball ghsot vision///////////////////

/obj/item/crystalball/attack_self(mob/user)
	user.visible_message(span_danger("[user] stares into [src], \their eyes rolling back into \their head."))
	user.ghostize(1)
