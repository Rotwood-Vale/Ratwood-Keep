/atom/movable/screen/ghost
	icon = 'icons/mob/screen_ghost.dmi'

/atom/movable/screen/ghost/MouseEntered()
//	flick(icon_state + "_anim", src)
	..()

/atom/movable/screen/ghost/jumptomob
	name = "Jump to mob"
	icon_state = "jumptomob"

/atom/movable/screen/ghost/jumptomob/Click()
	var/mob/dead/observer/G = usr
	G.jumptomob()

/atom/movable/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/atom/movable/screen/ghost/orbit/Click()
	var/mob/dead/observer/G = usr
	G.follow()
//skull
/atom/movable/screen/ghost/orbit/rogue
	name = "AFTER LIFE"
	icon = 'icons/mob/ghostspin.dmi'
	icon_state = ""
	screen_loc = "WEST-4,SOUTH+6"
	nomouseover = FALSE

/atom/movable/screen/ghost/orbit/rogue/Click(location, control, params)
	var/mob/dead/observer/G = usr
	var/paramslist = params2list(params)
	var/descend_text = "Descend to the Underworld?"
	if(paramslist["right"]) // screen objects don't do the normal Click() stuff so we'll cheat
		if(G.client?.holder)
			G.follow()
	else
		if(G.client)
			if(istype(G, /mob/dead/observer/rogue/arcaneeye))
				return
			if(isrogueobserver(G) && G.mind?.funeral)
				descend_text = "Your body has been buried.\n\
								Are you ready to be judged?"
				switch(alert(G, descend_text, "", "Yes", "No"))
					if("Yes")
						to_chat(G, span_rose("With my body buried in creation, my soul passes on in peace..."))
						burial_rite_return_ghost_to_lobby(G)
					if("No")
						usr << "You have second thoughts."
			else
				switch(alert(descend_text, "", "Yes", "No"))
					if("Yes")
						G.client.try_descend()
					if("No")
						usr << "You have second thoughts."


/atom/movable/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/atom/movable/screen/ghost/reenter_corpse/Click()
	var/mob/dead/observer/G = usr
	G.client?.admin_ghost()

/atom/movable/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"

/atom/movable/screen/ghost/teleport/Click()
	var/mob/dead/observer/G = usr
	G.dead_tele()

/atom/movable/screen/ghost/moveup
	name = "move up"
	icon_state = "pai"

/atom/movable/screen/ghost/moveup/Click()
	var/mob/dead/observer/G = usr
	G.ghost_up()

/atom/movable/screen/ghost/movedown
	name = "move down"
	icon_state = "pai"

/atom/movable/screen/ghost/bigassuselessbutton
	name = "AFTER LIFE"
	icon = 'icons/mob/ghostspin.dmi'
	icon_state = ""
	screen_loc = "WEST-4,SOUTH+6"
	nomouseover = FALSE

/atom/movable/screen/ghost/movedown/Click()
	var/mob/dead/observer/G = usr
	G.ghost_down()

/datum/hud/ghost/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using =  new /atom/movable/screen/backhudl/ghost()
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/grain
	using.hud = src
	static_inventory += using

	scannies = new /atom/movable/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70

	using = new /atom/movable/screen/ghost/orbit/rogue()
	using.hud = src
	static_inventory += using

/datum/hud/adminghost/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/ghost/orbit(null, src)
	using.screen_loc = ui_ghost_orbit
	static_inventory += using

	using = new /atom/movable/screen/ghost/reenter_corpse(null, src)
	using.screen_loc = ui_ghost_reenter_corpse
	static_inventory += using

	using = new /atom/movable/screen/ghost/teleport(null, src)
	using.screen_loc = ui_ghost_teleport
	static_inventory += using

	using = new /atom/movable/screen/ghost/moveup(null, src)
	using.screen_loc = ui_ghost_moveup
	static_inventory += using

	using = new /atom/movable/screen/ghost/movedown(null, src)
	using.screen_loc = ui_ghost_movedown
	static_inventory += using

	using = new /atom/movable/screen/ghost/bigassuselessbutton(null, src)
	static_inventory += using

/datum/hud/ghost/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client.prefs.ghost_hud)
		screenmob.client.screen -= static_inventory
	else
		screenmob.client.screen += static_inventory

/datum/hud/eye/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using =  new /atom/movable/screen/backhudl/ghost()
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/grain
	using.hud = src
	static_inventory += using

	scannies = new /atom/movable/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70

/datum/hud/eye/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client.prefs.ghost_hud)
		screenmob.client.screen -= static_inventory
	else
		screenmob.client.screen += static_inventory

/datum/hud/obs/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using =  new /atom/movable/screen/backhudl/obs()
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/grain
	using.hud = src
	static_inventory += using

	scannies = new /atom/movable/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70
