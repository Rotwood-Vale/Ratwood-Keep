// Rogue spells/abilities
/obj/effect/proc_holder/spell/aoe_turf/rogue_knock
	name = "Knock"
	desc = ""
	clothes_req = FALSE
	range = 1
	overlay_state = "null"
	sound = list('sound/combat/cleave.ogg')
	releasedrain = 50
	chargedrain = 1
	chargetime = 15
	cast_without_targets = TRUE
	charge_max = 120 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokegen
	xp_gain = FALSE
	invocation = "OPEN SESAME!!"
	invocation_type = "shout"
	action_icon_state = "knock"
	associated_skill = /datum/skill/magic/arcane
	miracle = FALSE

/obj/effect/proc_holder/spell/aoe_turf/rogue_knock/cast(list/targets,mob/user = usr)
	SEND_SOUND(user, sound('sound/combat/cleave.ogg'))
	knock_sound(user)
	for(var/turf/T in targets)
		for(var/obj/structure/mineral_door/D in T.contents)
			INVOKE_ASYNC(src, PROC_REF(open_door), D)
		for(var/obj/structure/closet/crate/C in T.contents)
			INVOKE_ASYNC(src, PROC_REF(open_closet), C)

/obj/effect/proc_holder/spell/aoe_turf/rogue_knock/proc/open_door(obj/structure/mineral_door/D)
	D.locked = FALSE
	D.force_open()

/obj/effect/proc_holder/spell/aoe_turf/rogue_knock/proc/open_closet(obj/structure/closet/crate/C)
	C.locked = FALSE
	C.open()

/obj/effect/proc_holder/spell/aoe_turf/rogue_knock/proc/knock_sound(mob/living/user)
	user.visible_message(span_warning("A loud KNOCK comes from [user]!"))
	var/turf/origin_turf = get_turf(src)

	for(var/mob/living/player in GLOB.player_list)
		if(player.stat == DEAD)
			continue
		if(isbrain(player))
			continue

		var/distance = get_dist(player, origin_turf)
		if(distance <= 7)
			continue
		var/dirtext = " to the "
		var/direction = get_dir(player, origin_turf)
		switch(direction)
			if(NORTH)
				dirtext += "north"
			if(SOUTH)
				dirtext += "south"
			if(EAST)
				dirtext += "east"
			if(WEST)
				dirtext += "west"
			if(NORTHWEST)
				dirtext += "northwest"
			if(NORTHEAST)
				dirtext += "northeast"
			if(SOUTHWEST)
				dirtext += "southwest"
			if(SOUTHEAST)
				dirtext += "southeast"
			else //Where ARE you.
				dirtext = ", although I cannot make out a direction"
		var/disttext
		switch(distance)
			if(0 to 20)
				disttext = " very close"
			if(20 to 40)
				disttext = " close"
			if(40 to 80)
				disttext = ""
			if(80 to 160)
				disttext = " far"
			else
				disttext = " very far"
		if(distance < 80)
			//sound played for other players
			player.playsound_local(get_turf(player), 'sound/combat/cleave.ogg', 35, FALSE, pressure_affected = FALSE)
			to_chat(player, span_warning("I hear a loud KNOCK somewhere[disttext][dirtext]!"))
