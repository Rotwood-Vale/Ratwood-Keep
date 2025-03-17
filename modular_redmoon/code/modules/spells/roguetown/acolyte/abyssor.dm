/obj/effect/proc_holder/spell/invoked/abyssor_bends/cast(list/targets, mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		user.visible_message("<font color='yellow'>[user] makes a fist at [target]!</font>")
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.Dizzy(30)
		target.blur_eyes(30)
		target.apply_status_effect(/datum/status_effect/buff/frostbite)
		target.emote("drown")
		return TRUE
	revert_cast()
	return FALSE
