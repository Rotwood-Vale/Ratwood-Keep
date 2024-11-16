// currently unused
/obj/item/flashlight/lantern/shrunken
	name = "shrunken lamp"
	desc = "A beacon."
	icon_state = "shrunkenlamp"
	item_state = "shrunkenlamp"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	light_range = 4
	light_power = 20
	light_color = LIGHT_COLOR_BLOOD_MAGIC

/obj/item/flashlight/lantern/shrunken/update_brightness(mob/user = null)
	if(on)
		icon_state = "[initial(icon_state)]-on"
		set_light_on(TRUE)
	else
		icon_state = initial(icon_state)
		set_light_on(FALSE)


