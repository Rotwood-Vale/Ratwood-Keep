/obj/structure/grille
	desc = ""
	name = "grille"
	icon = 'icons/obj/structures.dmi'
	icon_state = "grille"
	density = TRUE
	anchored = TRUE
	flags_1 = CONDUCT_1
	pressure_resistance = 5*ONE_ATMOSPHERE
	armor = list("blunt" = 50, "slash" = 30, "stab" = 40, "bullet" = 70, "laser" = 70, "energy" = 100, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)
	max_integrity = 50
	integrity_failure = 0.4
	var/rods_type = /obj/item/stack/rods
	var/rods_amount = 2
	var/rods_broken = TRUE
	var/grille_type = null
	var/broken_type = /obj/structure/grille/broken
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/structure/grille/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	update_icon()

/obj/structure/grille/update_icon()
	if(QDELETED(src) || broken)
		return

	var/ratio = obj_integrity / max_integrity
	ratio = CEILING(ratio*4, 1) * 25

	if(smooth)
		queue_smooth(src)

	if(ratio > 50)
		return
	icon_state = "grille50_[rand(0,3)]"

/obj/structure/grille/examine(mob/user)
	. = ..()
//	if(anchored)
//		. += span_notice("It's secured in place with <b>screws</b>. The rods look like they could be <b>cut</b> through.")
//	if(!anchored)
//		. += span_notice("The anchoring screws are <i>unscrewed</i>. The rods look like they could be <b>cut</b> through.")


/obj/structure/grille/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/grille/hulk_damage()
	return 60

/obj/structure/grille/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src, ATTACK_EFFECT_KICK)
	user.visible_message(span_warning("[user] hits [src]."), null, null, COMBAT_MESSAGE_RANGE)
	log_combat(user, src, "hit")


/obj/structure/grille/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGRILLE))
		return TRUE
	else
		if(istype(mover, /obj/projectile) && density)
			return prob(30)
		else
			return !density

/obj/structure/grille/CanAStarPass(ID, dir, caller)
	. = !density
	if(ismovableatom(caller))
		var/atom/movable/mover = caller
		. = . || (mover.pass_flags & PASSGRILLE)

/obj/structure/grille/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	add_fingerprint(user)
	if(W.tool_behaviour == TOOL_WIRECUTTER)
		W.play_tool_sound(src, 100)
		deconstruct()
	else if((W.tool_behaviour == TOOL_SCREWDRIVER) && (isturf(loc) || anchored))
		W.play_tool_sound(src, 100)
		setAnchored(!anchored)
		user.visible_message(span_notice("[user] [anchored ? "fastens" : "unfastens"] [src]."), \
								 span_notice("I [anchored ? "fasten [src] to" : "unfasten [src] from"] the floor."))
		return
	else if(istype(W, /obj/item/stack/rods) && broken)
		var/obj/item/stack/rods/R = W
		user.visible_message(span_notice("[user] rebuilds the broken grille."), \
								 span_notice("I rebuild the broken grille."))
		new grille_type(src.loc)
		R.use(1)
		qdel(src)
		return

//window placing begin
	else if(is_glass_sheet(W))
		if (!broken)
			var/obj/item/stack/ST = W
			if (ST.get_amount() < 2)
				to_chat(user, span_warning("I need at least two sheets of glass for that!"))
				return
			var/dir_to_set = SOUTHWEST
			if(!anchored)
				to_chat(user, span_warning("[src] needs to be fastened to the floor first!"))
				return
			for(var/obj/structure/window/WINDOW in loc)
				to_chat(user, span_warning("There is already a window there!"))
				return
			to_chat(user, span_notice("I start placing the window..."))
			if(do_after(user,20, target = src))
				if(!src.loc || !anchored) //Grille broken or unanchored while waiting
					return
				for(var/obj/structure/window/WINDOW in loc) //Another window already installed on grille
					return
				var/obj/structure/window/WD
				if(istype(W, /obj/item/stack/sheet/plasmarglass))
					WD = new/obj/structure/window/plasma/reinforced/fulltile(drop_location()) //reinforced plasma window
				else if(istype(W, /obj/item/stack/sheet/plasmaglass))
					WD = new/obj/structure/window/plasma/fulltile(drop_location()) //plasma window
				else if(istype(W, /obj/item/stack/sheet/rglass))
					WD = new/obj/structure/window/reinforced/fulltile(drop_location()) //reinforced window
				else if(istype(W, /obj/item/stack/sheet/titaniumglass))
					WD = new/obj/structure/window/shuttle(drop_location())
				else if(istype(W, /obj/item/stack/sheet/plastitaniumglass))
					WD = new/obj/structure/window/plasma/reinforced/plastitanium(drop_location())
				else
					WD = new/obj/structure/window/fulltile(drop_location()) //normal window
				WD.setDir(dir_to_set)
				WD.ini_dir = dir_to_set
				WD.setAnchored(FALSE)
				WD.state = 0
				ST.use(2)
				to_chat(user, span_notice("I place [WD] on [src]."))
			return
//window placing end

	else if(istype(W, /obj/item/shard))
		return ..()

/obj/structure/grille/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/blank.ogg', 80, TRUE)
			else
				playsound(src, 'sound/blank.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/blank.ogg', 80, TRUE)


/obj/structure/grille/deconstruct(disassembled = TRUE)
	if(!loc) //if already qdel'd somehow, we do nothing
		return
//	if(!(flags_1&NODECONSTRUCT_1))
//		var/obj/R = new rods_type(drop_location(), rods_amount)
//		transfer_fingerprints_to(R)
//		qdel(src)
	..()

/obj/structure/grille/obj_break()
//	if(!broken && !(flags_1 & NODECONSTRUCT_1))
//		new broken_type(src.loc)
//		var/obj/R = new rods_type(drop_location(), rods_broken)
//		transfer_fingerprints_to(R)
	..()



/obj/structure/grille/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(!broken)
		if(exposed_temperature > T0C + 1500)
			take_damage(1, BURN, 0, 0)
	..()

/obj/structure/grille/get_dumping_location(datum/component/storage/source,mob/user)
	return null

/obj/structure/grille/broken // Pre-broken grilles for map placement
	icon_state = "brokengrille"
	density = FALSE
	obj_integrity = 20
	broken = TRUE
	rods_amount = 1
	rods_broken = FALSE
	grille_type = /obj/structure/grille
	broken_type = null
