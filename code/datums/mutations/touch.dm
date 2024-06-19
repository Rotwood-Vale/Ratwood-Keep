/datum/mutation/human/shock
	name = "Shock Touch"
	desc = ""
	quality = POSITIVE
	locked = TRUE
	difficulty = 16
	text_gain_indication = span_notice("I feel power flow through your hands.")
	text_lose_indication = span_notice("The energy in your hands subsides.")
	power = /obj/effect/proc_holder/spell/targeted/touch/shock
	instability = 30

/obj/effect/proc_holder/spell/targeted/touch/shock
	name = "Shock Touch"
	desc = ""
	drawmessage = "You channel electricity into your hand."
	dropmessage = "You let the electricity from your hand dissipate."
	hand_path = /obj/item/melee/touch_attack/shock
	charge_max = 100
	clothes_req = FALSE
	action_icon_state = "zap"

/obj/item/melee/touch_attack/shock
	name = "\improper shock touch"
	desc = ""
	catchphrase = null
	on_use_sound = 'sound/blank.ogg'
	icon_state = "zapper"
	item_state = "zapper"

/obj/item/melee/touch_attack/shock/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(C.electrocute_act(15, user, 1, SHOCK_NOSTUN))//doesnt stun. never let this stun
			C.dropItemToGround(C.get_active_held_item())
			C.dropItemToGround(C.get_inactive_held_item())
			C.confused += 15
			C.visible_message(span_danger("[user] electrocutes [target]!"),span_danger("[user] electrocutes you!"))
			return ..()
		else
			user.visible_message(span_warning("[user] fails to electrocute [target]!"))
			return ..()
	else if(isliving(target))
		var/mob/living/L = target
		L.electrocute_act(15, user, 1, SHOCK_NOSTUN)
		L.visible_message(span_danger("[user] electrocutes [target]!"),span_danger("[user] electrocutes you!"))
		return ..()
	else
		to_chat(user,span_warning("The electricity doesn't seem to affect [target]..."))
		return ..()
