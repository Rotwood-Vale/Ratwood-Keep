/obj/structure/curtain
	name = "curtain"
	desc = ""
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "bathroom-open"
	var/icon_type = "bathroom"//used in making the icon state
	color = "#ACD1E9" //Default color, didn't bother hardcoding other colors, mappers can and should easily change it.
	alpha = 200 //Mappers can also just set this to 255 if they want curtains that can't be seen through
	layer = SIGN_LAYER
	anchored = TRUE
	opacity = 0
	density = FALSE
	var/open = TRUE

/obj/structure/curtain/proc/toggle()
	open = !open
	update_icon()

/obj/structure/curtain/update_icon()
	if(!open)
		icon_state = "[icon_type]-closed"
		layer = WALL_OBJ_LAYER
		density = TRUE
		open = FALSE

	else
		icon_state = "[icon_type]-open"
		layer = SIGN_LAYER
		density = FALSE
		open = TRUE

/obj/structure/curtain/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I, 50)
	return TRUE

/obj/structure/curtain/wirecutter_act(mob/living/user, obj/item/I)
	..()
	if(anchored)
		return TRUE

	user.visible_message("<span class='warning'>[user] cuts apart [src].</span>",
		"<span class='notice'>I start to cut apart [src].</span>", "<span class='hear'>I hear cutting.</span>")
	if(I.use_tool(src, user, 50, volume=100) && !anchored)
		to_chat(user, "<span class='notice'>I cut apart [src].</span>")
		deconstruct()

	return TRUE


/obj/structure/curtain/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	playsound(loc, 'sound/blank.ogg', 50, TRUE)
	toggle()

/obj/structure/curtain/deconstruct(disassembled = TRUE)
	qdel(src)

/obj/structure/curtain/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src.loc, 'sound/blank.ogg', 80, TRUE)
			else
				playsound(loc, 'sound/blank.ogg', 50, TRUE)
		if(BURN)
			playsound(loc, 'sound/blank.ogg', 80, TRUE)

/obj/structure/curtain/bounty
	icon_type = "bounty"
	icon_state = "bounty-open"
	color = null
	alpha = 255
