/obj/structure/veil/carriageman
	name = "The Carriageman"
	desc = "They will take the reigns and lead the way. But only if the price I can pay."
	icon = 'icons/roguetown/underworld/enigma_carriageman.dmi'
	icon_state = null
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE
	
	var/image/veil_icon
	var/sounds = list('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg')

/obj/structure/veil/carriageman/Initialize()
	. = ..()

	veil_icon = image(
				icon = src.icon,
				icon_state = "carriageman",
				loc = src
			)
	apply_veil(veil_icon, src)

/obj/structure/veil/carriageman/update_icon()
	. = ..()
	apply_veil(veil_icon, src)

/obj/structure/veil/carriageman/attack_ghost(mob/dead/observer/rogue/veil/ghost)

	if(!ghost.Adjacent(src))
		return FALSE

	if(!ghost.collected_toll)
		to_chat(ghost, span_bold("<br><font color=purple>ONLY THE TOLL WILL I ACCEPT</font>"))
		return FALSE
	
	if(ghost.paid_toll)
		to_chat(ghost, span_bold("<br><font color=purple>FURTHER PAYMENT WILL NOT CHANGE HER JUDGEMENT.</font>"))
		return FALSE

	to_chat(ghost, span_bold("<br><font color=purple>THE TOLL IS PAID, THROUGH THE CARRIAGE THE UNDERMAIDEN WAITS.</font>"))
	ghost << sound(pick(sounds), 0, 0 ,0, 50)
	ghost.collected_toll = FALSE
	ghost.paid_toll = TRUE

	return TRUE
	