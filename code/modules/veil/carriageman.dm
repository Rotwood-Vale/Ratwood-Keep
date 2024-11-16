/obj/structure/veil/carriageman
	name = "The Carriageman"
	desc = "They will take the reigns and lead the way. But only if the price I can pay."
	icon = 'icons/roguetown/underworld/enigma_carriageman.dmi'
	icon_state = "carriageman"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = FALSE //dont want living people to get stuck on it
	invisibility = INVISIBILITY_OBSERVER
	
	var/sounds = list('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg')

/obj/structure/veil/carriageman/attack_ghost(mob/dead/observer/rogue/veil/ghost)

	if(!ghost.Adjacent(src))
		return FALSE

	ghost << sound(pick(sounds), 0, 0 ,0, 50)

	if(!ghost.collected_toll)
		to_chat(ghost, span_bold("<br><font color=purple>ONLY THE TOLL WILL I ACCEPT</font>"))
		return FALSE
	
	if(ghost.paid_toll)
		to_chat(ghost, span_bold("<br><font color=purple>FURTHER PAYMENT WILL NOT CHANGE HER JUDGEMENT.</font>"))
		return FALSE

	to_chat(ghost, span_bold("<br><font color=purple>THE TOLL IS PAID, THROUGH THE CARRIAGE THE UNDERMAIDEN WAITS.</font>"))
	ghost.collected_toll = FALSE
	ghost.paid_toll = TRUE

	return TRUE
	