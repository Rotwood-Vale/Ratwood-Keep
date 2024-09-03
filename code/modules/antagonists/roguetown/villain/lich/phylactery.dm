/obj/item/phylactery
	name = "phylactery"
	desc = "Looks like it is filled with some intense power."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "soulstone"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	layer = HIGH_OBJ_LAYER
	w_class = WEIGHT_CLASS_TINY

	var/datum/antagonist/lich/possessor

/obj/item/phylactery/Initialize()
	..()
	filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))

/obj/item/phylactery/proc/be_consumed(timer)
	var/offset = prob(50) ? -2 : 2
	animate(src, pixel_x = pixel_x + offset, time = 0.2, loop = -1) //start shaking
	visible_message(span_warning("[src] begins to glow and shake violently!"))
	spawn(timer)
		possessor.owner.current.forceMove(get_turf(src))
		possessor.rise_anew()
		qdel(src)