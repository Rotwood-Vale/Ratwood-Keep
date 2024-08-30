obj/item/mundane/puzzlebox/easy
	name = "wooden puzzle-box"
	icon = 'modular_azurepeak/icons/obj/items/mundanities.dmi'
	icon_state = "wood_box"

obj/item/mundane/puzzlebox/attack_self(mob/user)
	var/alert = alert(user, "My fingers trace the outside of this box. It looks easy. Do I try to solve it? \n[usage_prompt]", "wooden puzzle-box", "Yes", "No")
		if(alert != "Yes")
			return
		if(do_after(user,20, target = src))
			if(user.STAINT > 6)
				to_chat(user, span_warning("I solve \the [src] fairly easily. It falls apart in my hands."))
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "weak_puzzle", /datum/mood_event/puzzle_weak
				qdel(src)
			else
				to_chat(user, span_warning("I can't solve \the [src]. Befuddlingly, it falls apart before my eyes...!"))
				qdel(src)

obj/item/mundane/puzzlebox/medium
	name = "ebony puzzle-box"
	icon = 'modular_azurepeak/icons/obj/items/mundanities.dmi'
	icon_state = "ebon_box"

obj/item/mundane/puzzlebox/attack_self(mob/user)
	var/alert = alert(user, "My fingers trace the outside of this box. It looks easy. Do I try to solve it? \n[usage_prompt]", "wooden puzzle-box", "Yes", "No")
		if(alert != "Yes")
			return
		if(do_after(user,20, target = src))
			if(user.STAINT > 6)
				to_chat(user, span_warning("I solve \the [src] fairly easily. It falls apart in my hands. Junk."))
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "medium_puzzle", /datum/mood_event/puzzle_medium
				qdel(src)
			else
				to_chat(user, span_warning("I can't solve \the [src]. Befuddlingly, it falls apart before my eyes...!"))
				qdel(src)