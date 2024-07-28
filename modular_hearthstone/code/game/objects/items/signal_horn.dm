/obj/item/signal_horn
	name = "signal horn"
	desc = "Used to sound the alarm."
	icon = 'modular_hearthstone/icons/obj/items/signalhorn.dmi'
	icon_state = "signalhorn"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/signal_horn/attack_self(mob/living/user)
	. = ..()
	user.visible_message(span_warning("[user] is about to sound the [src]!"))
	if(do_after(user, 15))
		sound_horn(user)

/obj/item/signal_horn/proc/sound_horn(mob/living/user)
	user.visible_message(span_warning("[user] sounds the alarm!"))
	playsound(src, 'modular_hearthstone/sound/items/signalhorn.ogg', 100, TRUE)

	for(var/mob/player in GLOB.player_list)

		if(!player.mind) continue
		if(player.stat == DEAD) continue
		if(isbrain(player)) continue

		//sound played for other players
		if(player == src) continue
		if(get_dist(player, src) > 7)
			player.playsound_local(get_turf(player), 'modular_hearthstone/sound/items/signalhorn.ogg', 35, FALSE, pressure_affected = FALSE)
			to_chat(player, span_warning("I hear the horn alarm!"))

