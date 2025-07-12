#define MAX_DENT_DECALS 15

/turf/closed/wall
	name = ""
	desc = ""
	icon = 'icons/turf/walls/wall.dmi'
	icon_state = "wall"
	explosion_block = 1

	baseturfs = /turf/open/floor/rogue/dirt/road

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

/turf/closed/wall/ex_act(severity, target, epicenter, devastation_range, heavy_impact_range, light_impact_range, flame_range)
	if(target == src)
		dismantle_wall(1,1)
		take_damage(INFINITY, BRUTE, "bomb", 0)
		return
	var/ddist = devastation_range
	var/hdist = heavy_impact_range
	var/ldist = light_impact_range
	var/fdist = flame_range
	var/fodist = get_dist(src, epicenter)
	var/brute_loss = 0
	var/dmgmod = round(rand(0.1, 2), 0.1)

	switch (severity)
		if (EXPLODE_DEVASTATE)
			brute_loss = ((1500+250 * ddist) - (250 * fodist) * dmgmod) // Majorly increased; Anything doing Devastation damage should be tearing holes in structures

		if (EXPLODE_HEAVY)
			brute_loss = ((100 * hdist) - (100 * fodist) * dmgmod)

		if(EXPLODE_LIGHT)
			brute_loss = ((25 * ldist) - (25 * fodist) * dmgmod)

	if(fodist == 0)
		brute_loss *= 2
	take_damage(brute_loss, BRUTE, "bomb", 0)

	if(fdist && !QDELETED(src))
		var/stacks = ((fdist - fodist) * 2)
		fire_act(stacks)

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

// Override the try_wallmount proc instead of attackby
/turf/closed/wall/try_wallmount(obj/item/W, mob/user, turf/T)
	// Check if user has Scholar role and has paper/parchment
	if(user.mind && user.mind.assigned_role == "Scholar")
		if(istype(W, /obj/item/paper) || istype(W, /obj/item/paper/scroll))
			// Check if there's already a notice on this wall location
			var/obj/structure/fluff/walldeco/wantedposter/scholar/existing_notice
			for(var/obj/structure/fluff/walldeco/wantedposter/scholar/BN in get_turf(src))
				existing_notice = BN
				break

			if(existing_notice)
				to_chat(user, "<span class='notice'>There's already a notice posted on this wall.</span>")
				return TRUE

			// Determine wall direction for proper positioning
			var/wall_dir = get_dir(user, src)

			// Create the scholar notice
			var/obj/structure/fluff/walldeco/wantedposter/scholar/new_notice = new(get_turf(src))
			new_notice.OnCrafted(wall_dir, user)

			// Transfer the paper content to the notice
			var/paper_info = ""
			var/paper_name_str = "notice"

			if(istype(W, /obj/item/paper))
				var/obj/item/paper/P = W
				if(P.info)
					paper_info = P.info
				paper_name_str = P.name
			else if(istype(W, /obj/item/paper/scroll))
				var/obj/item/paper/scroll/S = W
				if(S.info)
					paper_info = S.info
				paper_name_str = S.name

			if(paper_info)
				new_notice.stored_info = paper_info
				new_notice.stored_name = paper_name_str
			else
				new_notice.stored_info = "This notice appears to be blank."
				new_notice.stored_name = "blank notice"

			// Update the notice name and description
			new_notice.name = "scholar's notice"
			new_notice.desc = "A [paper_name_str] posted by a scholar. It looks official."

			// Play sound effect
			playsound(get_turf(user), 'sound/foley/dropsound/paper_drop.ogg', 40, TRUE, -1)

			// Remove the paper from user's hand
			qdel(W)

			to_chat(user, "<span class='notice'>You post the [paper_name_str] on the wall as an official notice.</span>")
			return TRUE

	// Check for authority roles that can create bandit notices
	if(user.mind && (user.mind.assigned_role in BANDIT_AUTHORITY_ROLES))
		if(istype(W, /obj/item/paper))
			var/obj/item/paper/P = W
			// Only allow empty papers for bandit notices
			if(!P.info || P.info == "")
				// Check if there's already a bandit notice on this wall
				var/obj/structure/fluff/walldeco/wantedposter/custom/existing_bandit_notice
				for(var/obj/structure/fluff/walldeco/wantedposter/custom/BN in get_turf(src))
					existing_bandit_notice = BN
					break

				if(existing_bandit_notice)
					to_chat(user, "<span class='notice'>There's already a bandit notice posted on this wall.</span>")
					return TRUE

				// Check if user has a feather to write with
				var/obj/item/natural/feather/writing_tool
				for(var/obj/item/natural/feather/F in user.contents)
					writing_tool = F
					break

				if(!writing_tool)
					to_chat(user, "<span class='warning'>You need a feather to write the bandit notice.</span>")
					return TRUE

				// Prompt for bandit name(s)
				var/bandit_names = input(user, "Enter the name(s) of the bandit(s) you wish to post a notice for:", "Bandit Notice", "") as text|null
				if(!bandit_names || bandit_names == "")
					to_chat(user, "<span class='notice'>You decide not to create a bandit notice.</span>")
					return TRUE

				// Reading skill check
				var/reading_skill = user.mind.get_skill_level(/datum/skill/misc/reading)
				var/required_skill = 3
				var/skill_roll = roll(1, 20) + reading_skill

				if(skill_roll < (10 + required_skill)) // DC 13 for skill level 3
					to_chat(user, "<span class='warning'>Your writing is too poor to create an official bandit notice.</span>")
					return TRUE

				// Determine wall direction for proper positioning
				var/wall_dir = get_dir(user, src)

				// Create the custom bandit notice
				var/obj/structure/fluff/walldeco/wantedposter/custom/new_bandit_notice = new(get_turf(src))
				new_bandit_notice.OnCrafted(wall_dir, user)

				// Set bandit notice content
				new_bandit_notice.bandit_names = bandit_names
				new_bandit_notice.posted_by = user.mind.assigned_role
				new_bandit_notice.stored_info = "WANTED: [bandit_names]\n\nBy order of the [user.mind.assigned_role], the above named individual(s) are wanted for banditry and other crimes against the realm.\n\nA reward may be offered for information leading to their capture."
				new_bandit_notice.stored_name = "bandit notice"

				// Update the notice name and description
				new_bandit_notice.name = "bandit notice"
				new_bandit_notice.desc = "An official notice declaring [bandit_names] as wanted bandits."

				// Play sound effect
				playsound(get_turf(user), 'sound/foley/dropsound/paper_drop.ogg', 40, TRUE, -1)

				// Remove the paper from user's hand
				qdel(W)

				to_chat(user, "<span class='notice'>You post an official bandit notice for [bandit_names] on the wall.</span>")
				return TRUE

	// Continue with normal wallmount behavior
	return ..() // This calls the parent's try_wallmount, which returns FALSE

// Scholar notice subtype extending the existing wanted poster system
/obj/structure/fluff/walldeco/wantedposter/scholar
	name = "scholar's notice"
	desc = "A parchment posted by a scholar."
	icon_state = "wanted2" // Use a specific icon state for scholar notices
	var/stored_info = ""
	var/stored_name = "notice"

/obj/structure/fluff/walldeco/wantedposter/scholar/Initialize()
	. = ..()
	// Don't randomize icon_state for scholar notices
	icon_state = "wanted2"

/obj/structure/fluff/walldeco/wantedposter/scholar/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		. += "<span class='notice'>You can read the notice by clicking on it.</span>"
		if(user.mind && user.mind.assigned_role == "Scholar")
			. += "<span class='notice'>As a Scholar, you can remove this notice by right-clicking it.</span>"

/obj/structure/fluff/walldeco/wantedposter/scholar/attack_hand(mob/living/user)
	if(!stored_info)
		to_chat(user, "<span class='notice'>The notice appears to be blank.</span>")
		return

	// Show the content to the user
	to_chat(user, "<span class='paper'>The [stored_name] reads:</span>")
	to_chat(user, "<span class='paper'>[stored_info]</span>")

	// Play a paper rustling sound
	user.playsound_local(user, 'sound/foley/dropsound/paper_drop.ogg', 40, FALSE)

/obj/structure/fluff/walldeco/wantedposter/scholar/attack_right(mob/living/user)
	// Right-click to remove notice (scholars only)
	if(user.mind && user.mind.assigned_role == "Scholar")
		to_chat(user, "<span class='notice'>You carefully tear down the notice from the wall.</span>")
		playsound(get_turf(user), 'sound/foley/dropsound/paper_drop.ogg', 40, TRUE, -1)

		// Create a paper with the original content
		var/obj/item/paper/recovered_paper = new(get_turf(user))
		recovered_paper.info = stored_info
		recovered_paper.name = stored_name

		qdel(src)
		return
	else
		to_chat(user, "<span class='warning'>Only scholars can remove these notices.</span>")
		return

/obj/structure/fluff/walldeco/wantedposter/scholar/attackby(obj/item/W, mob/living/user, params)
	// Allow scholars to remove their notices
	if(user.mind && user.mind.assigned_role == "Scholar")
		// Check for wrench or similar tool
		if(W.tool_behaviour == TOOL_WRENCH || istype(W, /obj/item/rogueweapon/huntingknife))
			to_chat(user, "<span class='notice'>You carefully remove the notice from the wall.</span>")
			playsound(get_turf(user), 'sound/foley/dropsound/paper_drop.ogg', 40, TRUE, -1)

			// Create a paper with the original content
			var/obj/item/paper/recovered_paper = new(get_turf(src))
			recovered_paper.info = stored_info
			recovered_paper.name = stored_name

			qdel(src)
			return

		// Allow scholars to edit the notice content
		if(istype(W, /obj/item/natural/feather))
			var/new_content = input(user, "What would you like to write on this notice?", "Edit Notice", stored_info) as message|null
			if(new_content && user.Adjacent(src))
				stored_info = new_content
				to_chat(user, "<span class='notice'>You update the content of the notice.</span>")
				playsound(get_turf(user), 'sound/foley/dropsound/paper_drop.ogg', 40, TRUE, -1)
			return

	return ..()

// Custom bandit notice subtype that authority figures can create
/obj/structure/fluff/walldeco/wantedposter/custom
	name = "bandit notice"
	desc = "An official notice declaring someone as a wanted bandit."
	icon_state = "wanted3" // Use a different icon state for custom bandit notices
	var/stored_info = ""
	var/stored_name = "bandit notice"
	var/bandit_names = ""
	var/posted_by = ""

/obj/structure/fluff/walldeco/wantedposter/custom/Initialize()
	. = ..()
	// Don't randomize icon_state for custom bandit notices
	icon_state = "wanted3"

/obj/structure/fluff/walldeco/wantedposter/custom/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		. += "<span class='notice'>You can read the notice by clicking on it.</span>"
		if(user.mind && user.mind.assigned_role == "Bandit")
			. += "<span class='warning'>As a Bandit, you can tear down this notice by right-clicking it.</span>"

/obj/structure/fluff/walldeco/wantedposter/custom/attack_hand(mob/living/user)
	if(!stored_info)
		to_chat(user, "<span class='notice'>The notice appears to be blank.</span>")
		return

	// Show the content to the user
	to_chat(user, "<span class='paper'>The [stored_name] reads:</span>")
	to_chat(user, "<span class='paper'>[stored_info]</span>")

	// Play a paper rustling sound
	user.playsound_local(user, 'sound/foley/dropsound/paper_drop.ogg', 40, FALSE)

/obj/structure/fluff/walldeco/wantedposter/custom/attack_right(mob/living/user)
	// Right-click to tear down notice (bandits only)
	if(user.mind && user.mind.assigned_role == "Bandit")
		to_chat(user, "<span class='warning'>You angrily tear down the bandit notice!</span>")
		playsound(get_turf(user), 'sound/foley/dropsound/paper_drop.ogg', 60, TRUE, -1)

		// Create torn paper scraps instead of recovering the original
		var/obj/item/paper/torn_paper = new(get_turf(user))
		torn_paper.info = ""
		torn_paper.name = "torn paper scraps"

		// Send a message to nearby players
		for(var/mob/living/M in view(7, user))
			if(M != user)
				to_chat(M, "<span class='warning'>[user] tears down a bandit notice!</span>")

		qdel(src)
		return
	else
		to_chat(user, "<span class='warning'>You don't dare tear down an official notice.</span>")
		return

/obj/structure/fluff/walldeco/wantedposter/custom/attackby(obj/item/W, mob/living/user, params)
	// Allow authority figures to remove bandit notices
	if(user.mind && (user.mind.assigned_role in BANDIT_AUTHORITY_ROLES))
		// Check for wrench or similar tool
		if(W.tool_behaviour == TOOL_WRENCH || istype(W, /obj/item/rogueweapon/huntingknife))
			to_chat(user, "<span class='notice'>You carefully remove the bandit notice from the wall.</span>")
			playsound(get_turf(user), 'sound/foley/dropsound/paper_drop.ogg', 40, TRUE, -1)

			// Create a paper with the original content
			var/obj/item/paper/recovered_paper = new(get_turf(src))
			recovered_paper.info = stored_info
			recovered_paper.name = stored_name

			qdel(src)
			return

	// Allow bandits to tear down notices with weapons
	if(user.mind && user.mind.assigned_role == "Bandit")
		if(istype(W, /obj/item/rogueweapon) || W.force > 0)
			to_chat(user, "<span class='warning'>You slash at the bandit notice, tearing it to shreds!</span>")
			playsound(get_turf(user), 'sound/foley/dropsound/paper_drop.ogg', 60, TRUE, -1)

			// Create torn paper scraps
			var/obj/item/paper/torn_paper = new(get_turf(user))
			torn_paper.info = ""
			torn_paper.name = "shredded paper"

			// Send a message to nearby players
			for(var/mob/living/M in view(7, user))
				if(M != user)
					to_chat(M, "<span class='warning'>[user] destroys a bandit notice with [W]!</span>")

			qdel(src)
			return

	return ..()
