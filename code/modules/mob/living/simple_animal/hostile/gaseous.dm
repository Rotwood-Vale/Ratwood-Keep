/mob/living/simple_animal/hostile/retaliate/gaseousform
	name = "gaseous mist"
	desc = ""
	icon = 'icons/mob/mob.dmi'
	icon_state = "mist"
	icon_living = "mist"
	mob_biotypes = MOB_SPIRIT
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	a_intent = INTENT_HARM
	healable = 0
	speed = 0
	maxHealth = 40
	health = 40
	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 15
	del_on_death = 1
	emote_see = list("blows")
	attack_verb_continuous = "grips"
	attack_verb_simple = "grip"
	attack_sound = 'sound/blank.ogg'
	speak_emote = list("wails")
	deathmessage = "wails, disintegrating into a pile of ectoplasm!"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	movement_type = FLYING
	gold_core_spawnable = NO_SPAWN //too spooky for science
	var/random = TRUE //if you want random names for ghosts or not
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE

/mob/living/simple_animal/hostile/retaliate/gaseousform/Initialize()
	. = ..()
	set_light(1, 2)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/simple_animal/hostile/retaliate/gaseousform, revert), "VAMPIRE LORD"), 10 SECONDS)

/mob/living/simple_animal/hostile/retaliate/gaseousform/proc/revert()
	qdel()

/mob/living/simple_animal/hostile/retaliate/gaseousform/Move(NewLoc, direct)
	var/oldloc = loc

	if(NewLoc)
		var/NewLocTurf = get_turf(NewLoc)
		if(istype(NewLocTurf, /turf/closed/mineral/rogue/bedrock)) // prevent going out of bounds.
			return
		if(istype(NewLocTurf, /turf/closed/wall)) // gas can go through doors/windows but not walls
			return
		forceMove(NewLoc)
		update_parallax_contents()
	else
		forceMove(get_turf(src))  //Get out of closets and such as a ghost
		if((direct & NORTH) && y < world.maxy)
			y++
		else if((direct & SOUTH) && y > 1)
			y--
		if((direct & EAST) && x < world.maxx)
			x++
		else if((direct & WEST) && x > 1)
			x--

	Moved(oldloc, direct)
