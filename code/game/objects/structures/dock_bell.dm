/obj/structure/dock_bell
	name = "Dock Bell"
	desc = "A loud bell that carries its sound to the nearby ports. Signals merchants we are looking to trade."


	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "dock_bell"


	COOLDOWN_DECLARE(ring_bell)


/obj/structure/dock_bell/attack_hand(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, ring_bell))
		to_chat(user, span_notice("I should wait..."))
		return
	if(!do_after(user, 5 SECONDS, target = src))
		return
	if(!COOLDOWN_FINISHED(src, ring_bell))
		to_chat(user, span_notice("Someone beat me to it!"))
		return
	visible_message(span_notice("[user] starts ringing the dock bell."))
	playsound(get_turf(src), 'sound/misc/handbell.ogg', 50, 1)
	if(!SSmerchant.cargo_docked && SSmerchant.cargo_boat.check_living())
		SSmerchant.send_cargo_ship_back()
	else if(SSmerchant.cargo_docked)
		SSmerchant.prepare_cargo_shipment()
	COOLDOWN_START(src, ring_bell, 2 MINUTES)
