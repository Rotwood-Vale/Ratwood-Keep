/obj/effect/proc_holder/spell/self/howl
	name = "Howl"
	desc = "!"
	overlay_state = "howl"
	antimagic_allowed = TRUE
	charge_max = 100 // 10 seconds

/obj/effect/proc_holder/spell/self/howl/cast(mob/living/user = usr)
	..()
	if(user.cmode)
		charge_counter = 50
		playsound(user, pick('sound/vo/mobs/wwolf/idle (1).ogg','sound/vo/mobs/wwolf/idle (3).ogg','sound/vo/mobs/wwolf/idle (4).ogg'), 100, TRUE)
		if(do_after(user, 30, FALSE, user))
			playsound(user, 'sound/vo/mobs/wwolf/roar.ogg', 100, TRUE)
			user.apply_status_effect(/datum/status_effect/wolf/howl_rage)
			for(var/mob/living/player in GLOB.player_list)

				if(!player.mind) continue
				if(player.stat == DEAD) continue
				if(isbrain(player)) continue

				if(player == user) continue
				if(get_dist(player, user) < 26)
					player.apply_status_effect(/datum/status_effect/wolf/wolf_hunt)
				if(get_dist(player, user) > 7 && get_dist(player, user) < 26)
					player.playsound_local(get_step_towards(player, user),'sound/vo/mobs/wwolf/ragehowl.ogg', 100, FALSE, pressure_affected = FALSE)
		return

	var/message = input("Howl at the hidden moon", "WEREWOLF") as text|null
	if(!message) return

	var/datum/antagonist/werewolf/werewolf_player = user.mind.has_antag_datum(/datum/antagonist/werewolf)

	// sound played for owner
	playsound(user, pick('sound/vo/mobs/wwolf/howl (1).ogg','sound/vo/mobs/wwolf/howl (2).ogg'), 100, TRUE)
	
	for(var/mob/player in GLOB.player_list)

		if(!player.mind) continue
		if(player.stat == DEAD) continue
		if(isbrain(player)) continue

		// Announcement to other werewolves
		if(player.mind.has_antag_datum(/datum/antagonist/werewolf))
			to_chat(player, span_boldannounce("[werewolf_player.wolfname] howls: [message]"))

		//sound played for other players
		if(player == user) continue
		if(get_dist(player, user) > 7)
			player.playsound_local(get_step_towards(player, user), pick('sound/vo/mobs/wwolf/howldist (1).ogg','sound/vo/mobs/wwolf/howldist (2).ogg'), 100, FALSE, pressure_affected = FALSE)
		else
			player.playsound_local(get_step_towards(player, user), pick('sound/vo/mobs/wwolf/howl (1).ogg','sound/vo/mobs/wwolf/howl (2).ogg'), 100, FALSE, pressure_affected = FALSE)

	user.log_message("howls: [message] (WEREWOLF)")

/obj/effect/proc_holder/spell/self/claws
	name = "Lupine Claws"
	desc = "!"
	overlay_state = "claws"
	antimagic_allowed = TRUE
	charge_max = 20 //2 seconds
	var/extended = FALSE

/obj/effect/proc_holder/spell/self/claws/cast(mob/user = usr)
	..()
	var/obj/item/rogueweapon/werewolf_claw/left/l
	var/obj/item/rogueweapon/werewolf_claw/right/r

	l = user.get_active_held_item()
	r = user.get_inactive_held_item()
	if(extended)
		if(istype(user.get_active_held_item(), /obj/item/rogueweapon/werewolf_claw))
			user.dropItemToGround(l, TRUE)
			user.dropItemToGround(r, TRUE)
			qdel(l)
			qdel(r)
			//user.visible_message("Your claws retract.", "You feel your claws retracting.", "You hear a sound of claws retracting.")
			extended = FALSE
	else
		l = new(user,1)
		r = new(user,2)
		user.put_in_hands(l, TRUE, FALSE, TRUE)
		user.put_in_hands(r, TRUE, FALSE, TRUE)
		//user.visible_message("Your claws extend.", "You feel your claws extending.", "You hear a sound of claws extending.")
		extended = TRUE

/datum/status_effect/wolf
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/wolf/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_WOLFHUNT, "wolf_hunt")
	SSdroning.play_combat_music(TRUE, owner.client)

/datum/status_effect/wolf/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_WOLFHUNT, "wolf_hunt")
	SSdroning.play_combat_music(TRUE, owner.client)

/datum/status_effect/wolf/howl_rage
	id = "howl_rage"
	alert_type = null
	effectedstats = list("strength" = 7, "perception" = -6, "endurance" = 5, "speed" = 7)
	tick_interval = 30
	duration = 35 SECONDS

/datum/status_effect/wolf/howl_rage/on_apply()
	. = ..()
	owner.overlay_fullscreen("howl_rage", /atom/movable/screen/fullscreen/color_vision/red)
	owner.flash_fullscreen("brutedamageoverlay6")
	if(!owner.hud_used)
		return
	var/matrix/scalie = matrix()
	scalie.Scale(1.15)
	for(var/C in owner.hud_used.plane_masters)
		var/atom/movable/screen/plane_master/whole_screen = owner.hud_used.plane_masters[C]
		if(whole_screen.plane == HUD_PLANE)
			continue
		animate(whole_screen, transform = scalie, time = 1, easing = QUAD_EASING)
		animate(transform = -scalie, time = 30, easing = QUAD_EASING)


/datum/status_effect/wolf/howl_rage/tick()
	owner.flash_fullscreen("brutedamageoverlay6")
	if(!owner.hud_used)
		return
	var/matrix/scalie = matrix()
	scalie.Scale(1.1)
	for(var/C in owner.hud_used.plane_masters)
		var/atom/movable/screen/plane_master/whole_screen = owner.hud_used.plane_masters[C]
		if(whole_screen.plane == HUD_PLANE)
			continue
		animate(whole_screen, transform = scalie, time = 1, easing = QUAD_EASING)
		animate(transform = -scalie, time = 30, easing = QUAD_EASING)

/datum/status_effect/wolf/howl_rage/on_remove()
	. = ..()
	owner.clear_fullscreen("howl_rage", /atom/movable/screen/fullscreen/color_vision/red)


/datum/status_effect/wolf/wolf_hunt
	id = "wolf_hunt"
	alert_type = null
	effectedstats = list("intelligence" = -1) // because its scary, ooooo
	duration = 35 SECONDS
