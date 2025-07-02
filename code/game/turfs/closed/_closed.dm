/turf/closed
	name = ""
	layer = CLOSED_TURF_LAYER
	opacity = 1
	density = TRUE
	blocks_air = TRUE
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	rad_insulation = RAD_MEDIUM_INSULATION
	baseturfs = /turf/open/floor/rogue/naturalstone
	var/above_floor
	var/leanable = TRUE
	var/wallclimb = FALSE
	var/climbdiff = 0

/turf/closed/Bumped(atom/movable/AM)
	..()
	if(density)
		if(ishuman(AM))
			var/mob/living/carbon/human/H = AM
			if(H.dir == get_dir(H,src) && H.m_intent == MOVE_INTENT_RUN && (H.mobility_flags & MOBILITY_STAND))
				H.Immobilize(10)
				H.apply_damage(15, BRUTE, "head", H.run_armor_check("head", "blunt", damage = 15))
				H.toggle_rogmove_intent(MOVE_INTENT_WALK, TRUE)
				playsound(src, "genblunt", 100, TRUE)
				H.visible_message(span_warning("[H] runs into [src]!"), span_warning("I run into [src]!"))
				addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, Knockdown), 10), 10)

/turf/closed/Initialize()
	. = ..()
	if(above_floor)
		var/turf/open/transparent/openspace/target = get_step_multiz(src, UP)
		if(istype(target))
			target.ChangeTurf(above_floor)
	if(leanable)
		AddComponent(/datum/component/leanable)

/turf/closed/Destroy()
	if(above_floor)
		var/turf/above = get_step_multiz(src, UP)
		if(above)
			if(istype(above, above_floor))
				var/count
				for(var/D in GLOB.cardinals)
					var/turf/T = get_step(above, D)
					if(T)
						var/turf/closed/C = get_step_multiz(T, DOWN)
						if(istype(C))
							count++
					if(count >= 2)
						break
				if(count < 2)
					above.ScrapeAway()
	. = ..()

/turf/closed/attack_paw(mob/user)
	return attack_hand(user)

/turf/closed/attack_hand(mob/user)
	if(wallclimb)
		if(isliving(user))
			var/mob/living/L = user
			var/climbsound = 'sound/foley/climb.ogg'
			if(L.stat != CONSCIOUS)
				return
			var/turf/target = get_step_multiz(user, UP)
			if(!istype(target, /turf/open/transparent/openspace))
				to_chat(user, span_warning("I can't climb here."))
				return
			if(!L.can_zTravel(target, UP))
				to_chat(user, span_warning("I can't climb there."))
				return
			target = get_step_multiz(src, UP)
			if(!target || istype(target, /turf/closed) || istype(target, /turf/open/transparent/openspace))
				target = get_step_multiz(user.loc, UP)
				if(!target || !istype(target, /turf/open/transparent/openspace))
					to_chat(user, span_warning("I can't climb here."))
					return
			for(var/obj/structure/F in target)
				if(F && (F.density && !F.climbable))
					to_chat(user, span_warning("I can't climb here."))
					return
			var/used_time = 0
			if(L.mind)
				var/myskill = L.mind.get_skill_level(/datum/skill/misc/climbing)
				var/obj/structure/table/TA = locate() in L.loc
				if(TA)
					myskill += 1
				else
					var/obj/structure/chair/CH = locate() in L.loc
					if(CH)
						myskill += 1
					var/obj/structure/wallladder/WL = locate() in L.loc
					if(WL)
						if(get_dir(WL.loc,src) == WL.dir)
							myskill += 8
							climbsound = 'sound/foley/ladder.ogg'

				if(myskill < climbdiff)
					to_chat(user, span_warning("I'm not capable of climbing this wall."))
					return
				used_time = max(70 - (myskill * 10) - (L.STASPD * 3), 30)
			if(user.m_intent != MOVE_INTENT_SNEAK)
				playsound(user, climbsound, 100, TRUE)
			user.visible_message(span_warning("[user] starts to climb [src]."), span_warning("I start to climb [src]..."))
			if(do_after(L, used_time, target = src))
				var/pulling = user.pulling
				if(ismob(pulling))
					user.pulling.forceMove(target)
				user.forceMove(target)
				user.start_pulling(pulling,supress_message = TRUE)
				if(user.m_intent != MOVE_INTENT_SNEAK)
					playsound(user, 'sound/foley/climb.ogg', 100, TRUE)
	else
		..()

/turf/closed/attack_ghost(mob/dead/observer/user)
	if(!user.Adjacent(src))
		return
	var/turf/target = get_step_multiz(user, UP)
	if(!target)
		to_chat(user, span_warning("I can't go there."))
		return
	if(!istype(target, /turf/open/transparent/openspace))
		to_chat(user, span_warning("I can't go there."))
		return
	user.forceMove(target)
	to_chat(user, span_warning("I crawl up the wall."))
	. = ..()

/turf/closed/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE

/turf/closed/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSCLOSEDTURF))
		return TRUE
	return ..()

/turf/closed/indestructible
	name = "wall"
	icon = 'icons/turf/walls.dmi'
	explosion_block = 50

/turf/closed/indestructible/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/closed/indestructible/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/indestructible/Melt()
	to_be_destroyed = FALSE
	return src


/turf/closed/indestructible/splashscreen
	name = ""
	icon = 'icons/default_title.dmi'
	icon_state = ""
	layer = FLY_LAYER
	bullet_bounce_sound = null

/turf/closed/indestructible/splashscreen/New()
	SStitle.splash_turf = src
	if(SStitle.icon)
		icon = SStitle.icon
	..()

/turf/closed/indestructible/splashscreen/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if("icon")
				SStitle.icon = icon

/turf/closed/indestructible/riveted
	icon = 'icons/turf/walls/riveted.dmi'
	icon_state = "riveted"
	smooth = SMOOTH_TRUE
