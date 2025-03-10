/obj/item/fbi_open_up
	name = "Squeeze Me"
	desc = "Xylix's gift for open up all traveltile."
	icon_state = "xylixhelm"
	icon = 'modular_redmoon/icons/hats.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/fbi_open_up/attack_self(mob/user)
	. = ..()
	user.visible_message(span_notice("[user] squeezing something..."), \
						span_notice("I begin squeezing something..."))
	for(var/obj/structure/fluff/traveltile/all_traveltile in shuffle(GLOB.traveltiles))
		if(all_traveltile == src)
			continue
		required_trait = null
		can_gain_with_sight = TRUE
		can_gain_by_walking = TRUE
		check_other_side = TRUE
		invis_without_trait = TRUE
	priority_announce("All traveltiles opened up!", "OPEN THE DOOR", 'sound/misc/kybraxorop.ogg', "Xylix")
	playsound(src, 'sound/ravein/small/hello_my_friend.ogg', 40, 1)
	qdel(src)
