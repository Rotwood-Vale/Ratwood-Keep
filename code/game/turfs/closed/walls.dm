#define MAX_DENT_DECALS 15

/turf/closed/wall
	name = ""
	desc = ""
	icon = 'icons/turf/walls/wall.dmi'
	icon_state = "wall"
	explosion_block = 1

	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 312500 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m plasteel wall

	baseturfs = list(/turf/open/floor/rogue/dirt/road)

	var/hardness = 40 //lower numbers are harder. Used to determine the probability of a hulk smashing through.
	var/slicing_duration = 100  //default time taken to slice the wall
	var/sheet_type = null
	var/sheet_amount = 2

	canSmoothWith = list(
	/turf/closed/wall)
	smooth = SMOOTH_TRUE

	var/list/dent_decals

/turf/closed/wall/attack_tk()
	return

/turf/closed/wall/handle_ricochet(obj/projectile/P)			//A huge pile of shitcode!
	var/turf/p_turf = get_turf(P)
	var/face_direction = get_dir(src, p_turf)
	var/face_angle = dir2angle(face_direction)
	var/incidence_s = GET_ANGLE_OF_INCIDENCE(face_angle, (P.Angle + 180))
	if(abs(incidence_s) > 90 && abs(incidence_s) < 270)
		return FALSE
	var/new_angle_s = SIMPLIFY_DEGREES(face_angle + incidence_s)
	P.setAngle(new_angle_s)
	return TRUE

/turf/closed/wall/turf_destruction()
	dismantle_wall(1,0)

/turf/closed/wall/proc/dismantle_wall(devastated=0, explode=0)
	playsound(src, 'sound/blank.ogg', 100, TRUE)
	ScrapeAway()

/turf/closed/wall/ex_act(severity, target)
	if(target == src)
		dismantle_wall(1,1)
		return
	switch(severity)
		if(1)
			//SN src = null
			var/turf/NT = ScrapeAway()
			NT.contents_explosion(severity, target)
			return
		if(2)
			if (prob(50))
				dismantle_wall(0,1)
			else
				dismantle_wall(1,1)
		if(3)
			if (prob(hardness))
				dismantle_wall(0,1)
	if(!density)
		..()

/turf/closed/wall/attack_paw(mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)
	return attack_hand(user)


/turf/closed/wall/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if((M.environment_smash & ENVIRONMENT_SMASH_WALLS) || (M.environment_smash & ENVIRONMENT_SMASH_RWALLS))
		playsound(src, 'sound/blank.ogg', 100, TRUE)
		dismantle_wall(1)
		return

/turf/closed/wall/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	to_chat(user, "<span class='notice'>I push the wall but nothing happens!</span>")
	playsound(src, 'sound/blank.ogg', 25, TRUE)
	add_fingerprint(user)

/turf/closed/wall/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!user.IsAdvancedToolUser())
		to_chat(user, span_warning("I don't have the dexterity to do this!"))
		return

	//get the user's location
	if(!isturf(user.loc))
		return	//can't do this stuff whilst inside objects and such

	add_fingerprint(user)

	var/turf/T = user.loc	//get user's location for delay checks

	//the istype cascade has been spread among various procs for easy overriding
	if(try_clean(W, user, T) || try_wallmount(W, user, T) || try_decon(W, user, T))
		return

	return ..()

/turf/closed/wall/proc/try_clean(obj/item/W, mob/user, turf/T)
	if((user.used_intent.type != INTENT_HELP) || !LAZYLEN(dent_decals))
		return FALSE

	if(W.tool_behaviour == TOOL_WELDER)
		if(!W.tool_start_check(user, amount=0))
			return FALSE

		to_chat(user, span_notice("I begin fixing dents on the wall..."))
		if(W.use_tool(src, user, 0, volume=100))
			if(iswallturf(src) && LAZYLEN(dent_decals))
				to_chat(user, span_notice("I fix some dents on the wall."))
				cut_overlay(dent_decals)
				dent_decals.Cut()
			return TRUE

	return FALSE

/turf/closed/wall/proc/try_wallmount(obj/item/W, mob/user, turf/T)
	return FALSE

/turf/closed/wall/proc/try_decon(obj/item/I, mob/user, turf/T)
	if(I.tool_behaviour == TOOL_WELDER)
		if(!I.tool_start_check(user, amount=0))
			return FALSE

		to_chat(user, span_notice("I begin slicing through the outer plating..."))
		if(I.use_tool(src, user, slicing_duration, volume=100))
			if(iswallturf(src))
				to_chat(user, span_notice("I remove the outer plating."))
				dismantle_wall()
			return TRUE

	return FALSE

/turf/closed/wall/get_dumping_location(obj/item/storage/source, mob/user)
	return null

/turf/closed/wall/acid_act(acidpwr, acid_volume)
	if(explosion_block >= 2)
		acidpwr = min(acidpwr, 50) //we reduce the power so strong walls never get melted.
	. = ..()

/turf/closed/wall/acid_melt()
	dismantle_wall(1)

/turf/closed/wall/proc/add_dent(denttype, x=rand(-8, 8), y=rand(-8, 8))
	if(LAZYLEN(dent_decals) >= MAX_DENT_DECALS)
		return

	var/mutable_appearance/decal = mutable_appearance('icons/effects/effects.dmi', "", BULLET_HOLE_LAYER)
	switch(denttype)
		if(WALL_DENT_SHOT)
			decal.icon_state = "bullet_hole"
		if(WALL_DENT_HIT)
			decal.icon_state = "impact[rand(1, 3)]"

	decal.pixel_x = x
	decal.pixel_y = y

	if(LAZYLEN(dent_decals))
		cut_overlay(dent_decals)
		dent_decals += decal
	else
		dent_decals = list(decal)

	add_overlay(dent_decals)

#undef MAX_DENT_DECALS

/turf/closed/splashscreen
	name = ""
	icon = 'icons/default_title.dmi'
	icon_state = ""
	layer = FLY_LAYER
	bullet_bounce_sound = null

/turf/closed/splashscreen/New()
	SStitle.splash_turf = src
	if(SStitle.icon)
		icon = SStitle.icon
	..()

/turf/closed/splashscreen/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if("icon")
				SStitle.icon = icon
