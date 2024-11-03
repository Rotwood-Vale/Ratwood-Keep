/obj/structure/fluff/grindwheel
	name = "grinding wheel"
	desc = "Steadily hums when operated, a massive wheel of grinding stone."
	icon = 'icons/roguetown/misc/forge.dmi'
	icon_state = "grindwheel"
	density = TRUE
	anchored = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 300

/obj/structure/fluff/grindwheel/attackby(obj/item/I, mob/living/user, params)
	if(I.max_blade_int)
		playsound(loc,'sound/foley/grindblade.ogg', 100, FALSE)
		if(do_after(user, 41, target = src))
			I.add_bintegrity(999)
		return
	if(istype(I, /obj/item/grown/log/tree/small))
		var/skill_level = user.mind.get_skill_level(/datum/skill/labor/lumberjacking)
		var/wood_time = (40 - (skill_level * 5))
		if(skill_level)
			playsound(src, pick('sound/misc/slide_wood (2).ogg', 'sound/misc/slide_wood (1).ogg'), 100, FALSE)
			if(do_after(user, wood_time, target = src))
				new /obj/item/grown/log/tree/small/plank(get_turf(src))
				user.mind.add_sleep_experience(/datum/skill/labor/lumberjacking, (user.STAINT*0.5))
				return
		else
			to_chat(user, span_info("I do not have the required knowledge to do this."))
			return
	. = ..()
