
/*
Grappling hook! Comes in 3 strict steps w/ unique intents: Grab -> Attach -> Reel.
Grab grabs onto a floor turf in range, only works for floors ABOVE the user.
Attach clasps a hook onto the chosen atom (obj / mob, has to be unanchored and not a structure or machinery)
Reel teleports the attached atom to the grabbed turf.
*/
/obj/item/grapplinghook
	name = "bronze grappler"
	desc = "One of the finest innovation in heartfelt engineering. Used to haul crates and kegs in shafts too steep for railcarts. Can be used on people who aren't too large."
	icon = 'icons/roguetown/items/gadgets.dmi'
	icon_state = "grappler_used"
	item_state = "grappler"
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	possible_item_intents = list(/datum/intent/grapple, /datum/intent/attach, /datum/intent/reel)
	experimental_inhand = FALSE
	var/is_loaded = FALSE
	var/in_use = FALSE
	var/turf/grappled_turf
	var/atom/attached
	var/mutable_appearance/tile_effect
	var/mutable_appearance/target_effect
	var/max_range = 3
	var/leash_range = 7
	var/list/obj_to_destroy = list()
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = /obj/item/ingot/bronze
	slot_flags = ITEM_SLOT_HIP

/obj/item/grapplinghook/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)	//For preventing hooking / attaching something and walking away.


/obj/item/grapplinghook/Destroy()
	STOP_PROCESSING(SSobj, src)
	reset_tile()
	reset_target()
	return ..()

//Range check for both the tool itself and anything it has attached to the turf it's hooked to.
/obj/item/grapplinghook/process()
	if(in_use && grappled_turf)
		if(get_dist(grappled_turf, src) > leash_range)
			reset_tile()
			reset_target()
	if(grappled_turf && attached)
		if(get_dist(grappled_turf, attached) > leash_range)
			reset_tile()
			reset_target()


/datum/intent/grapple
	name = "grapple"
	icon_state = "ingrab"
	desc = "Used to grapple onto an open, unobstructed tile."

/datum/intent/attach
	name = "attach"
	icon_state = "inattach"
	desc = "Used to attach an entity to the hook for reeling. Must not be heavy, large, or anchored."

/datum/intent/reel
	name = "reel"
	icon_state = "inreel"
	desc = "Used to reel the attached entity to the grappled tile."

/obj/item/grapplinghook/examine()
	. = ..()
	if(is_loaded && !in_use)
		. += span_warning("It's ready to use. <b>GRAB</b> onto a turf above you.")
	else if(!is_loaded && !in_use)
		. += span_warning("It's expended. It must be reloaded.")
	else if(!is_loaded && grappled_turf && in_use)
		. += span_warning("It's deployed. You can <b>ATTACH</b> a hook to an entity.")
		. += span_info("I may activate this in my hand to reset.")
	if(attached && grappled_turf && in_use && !is_loaded)
		. += span_warning("It's ready to use. You may <b>REEL</b> in \the [attached].")

/obj/item/grapplinghook/obj_break(damage_flag)
	reset_tile()
	reset_target()
	. = ..()

/obj/item/grapplinghook/obj_destruction(damage_flag)
	reset_tile()
	reset_target()
	. = ..()


/obj/item/grapplinghook/attack_self(mob/living/user)
	if(!is_loaded && !in_use && user.used_intent != /datum/intent/reel)
		var/stat = max(user.STASPD, user.STAPER)	//We check the PER / SPD stats first
		stat = stat - 10
		if(stat > 0)
			stat = stat * 3
			if(user.STASTR > 11)	//Then we add their strength if they had any of the previous
				stat += (user.STASTR - 10) * 2
		else
			stat = 0
		stat += (user.mind?.get_skill_level(/datum/skill/craft/engineering)) * 5	//And finally their Engineering level.
		stat = clamp(stat, 10, 70)	//Clamp to a very loud second just in case you're a superhuman engineer
		user.visible_message(span_info("[user] begins cranking the [src]..."))
		playsound(user, 'sound/misc/grapple_crank.ogg', 100, FALSE, 3)
		if(do_after(user, (70 - stat)))
			playsound(src, 'sound/foley/trap_arm.ogg', 100, FALSE , 5)
			to_chat(user, span_info("It's loaded!"))
			is_loaded = TRUE
			update_icon()
		else
			user.visible_message(span_info("[user] gets interrupted!"))
	else if(istype(user.used_intent, /datum/intent/reel))	//Alternative to clicking on an empty tile. You can self-use it to reel instead.
		if(attached && in_use)
			if(get_dist(attached, grappled_turf) <= max_range)
				user.visible_message("[user] reels in the [src]!")
				if(do_after(user, 10))
					reel()
			else
				to_chat(user, span_info("[attached] is too far!"))
	else if(!is_loaded && in_use && grappled_turf && tile_effect)	//Reset option.
		user.visible_message("[user] unhooks from the tile.")
		reset_tile()
		reset_target()

//Resets the tile effect and the grappled turf. Generally called with reset_target()
/obj/item/grapplinghook/proc/reset_tile(silent = FALSE)
	if(tile_effect && grappled_turf)
		grappled_turf.cut_overlay(tile_effect)
		qdel(tile_effect)
		grappled_turf = null
	if(!silent)	//Silent is used during a successful reel because it has its own distinct sounds
		playsound(src, 'sound/foley/trap.ogg', 100, FALSE , 5)
	is_loaded = FALSE
	update_icon()

//Resets the target effect overlay and the attached atom. Generally called with reset_tile()
/obj/item/grapplinghook/proc/reset_target()
	if(attached && target_effect)
		attached.cut_overlay(target_effect)
		qdel(target_effect)
		attached = null
	in_use = FALSE
	update_icon()

/obj/item/grapplinghook/proc/check_path(turf/Tu, turf/Tt)
	var/dist = get_dist(Tt, Tu)
	var/last_dir
	var/turf/last_step = get_step_multiz(Tu, UP)
	var/success = FALSE
	for(var/i = 0, i <= dist, i++)
		last_dir = get_dir(last_step, Tt)
		var/turf/Tstep = get_step(last_step, last_dir)
		if(!Tstep.density)
			success = TRUE
			var/list/cont = Tstep.GetAllContents(/obj/structure/roguewindow)
			for(var/obj/structure/roguewindow/W in cont)
				if(W.climbable && !W.opacity)	//It's climable and can be seen through
					success = TRUE
					LAZYADD(obj_to_destroy, W)
					continue
				else if(!W.climbable)
					success = FALSE
					return success
		else
			success = FALSE
			return success
		last_step = Tstep
	return success



//Successful reel, complete reset.
/obj/item/grapplinghook/proc/reel()
	if(attached && in_use && grappled_turf)
		if(do_teleport(attached, grappled_turf))
			playsound(attached, 'sound/misc/grapple_reel.ogg', 100, FALSE)
			playsound(grappled_turf, 'sound/misc/grapple_reel.ogg', 100, FALSE)
			destroy_eligible_objects()
			reset_tile(silent = TRUE)
			reset_target()
			unload(failure = TRUE)

/obj/item/grapplinghook/proc/destroy_eligible_objects()
	if(length(obj_to_destroy))
		for(var/obj/O in obj_to_destroy)
			if(istype(O,/obj/structure/roguewindow))
				var/obj/structure/roguewindow/W = O
				if(!W.climbable)
					O.obj_integrity = 1	//Keeps it from being destroyed
					O.obj_break()
		LAZYCLEARLIST(obj_to_destroy)

/obj/item/grapplinghook/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(istype(user.used_intent, /datum/intent/grapple))	//First step, grappling onto a tile. Spawns an indicator on it.
		if(is_loaded && istype(target, /turf/))
			var/turf/T = target
			if(!istransparentturf(T) && T.z > user.z) //We are shooting at a floor turf above
				var/reason
				if(max_range >= get_dist(user, T) && !T.density)
					if(check_path(get_turf(user), T))	//We check for opaque turfs or non-climbable windows in the way via a simple pathfind.
						to_chat(user, span_info("The grapple lands on the tile!"))
						grapple_to(T)
						return
					else
						to_chat(user, span_info("The path is blocked!"))
						return
				else if(get_dist(user, T) > max_range)
					reason = "It's too far."
				else if (T.density)
					reason = "It's a wall!"
				to_chat(user, span_info("The hook fails! "+"[reason]"))
				playsound(user, 'sound/foley/trap.ogg', 100, FALSE , 5)
				unload(failure = TRUE)
			else
				to_chat(user, span_info("Incorrect target! It needs a clear floor tile above me to grapple onto."))
		else if(!is_loaded)
			to_chat(user, span_info("It's been used already."))
	if(istype(user.used_intent, /datum/intent/attach))	//Second step. Once we have a turf we've grappled onto, we can use this to attach to an entity.
		if(in_use && !istype(target, /turf/))	//Can't use the feature unless it's grappled already
			var/safe_to_teleport = TRUE
			if(isobj(target))
				var/obj/O = target
				if(!istype(target, /obj/structure/closet/crate) && !istype(target, /obj/structure/fermenting_barrel))	//We DO want to move crates & barrels
					if(O.density || istype(target, /obj/structure) || O.anchored || istype(target, /obj/machinery)) //This should cover most (fingers crossed) objects that shouldn't be moved around like this.
						safe_to_teleport = FALSE
/*			if(ishuman(target))			///TO DO: Make GIANT special people have a trait that makes them giant, so they can not use grapplers.
				var/mob/living/carbon/human/H = target
				if(HAS_TRAIT(H, TRAIT_GIANT))
					safe_to_teleport = FALSE*/
			if(safe_to_teleport)
				to_chat(user, span_info("I begin to attach the hook..."))
				if(do_after(user, 30))
					if(target != user)
						user.visible_message(span_warning("[user] attaches the hook to [target]."))
					if(target == user)
						user.visible_message(span_warning("[user] attaches the hook to themselves!"))
					attach(target)
			else
				to_chat(user, span_warning("[target] is too large or unwieldy to attach!"))
		else
			to_chat(user, span_info("I need to have it hooked onto a tile first."))
	if(istype(user.used_intent, /datum/intent/reel))	//Last step, we reel in the attached entity to the grappled turf.
		if(attached && in_use)
			if(get_dist(attached, grappled_turf) <= max_range)
				user.visible_message("[user] reels in \the [src]!")
				if(do_after(user, 10))
					reel()
			else
				to_chat(user, span_info("[target] is too far!"))
		else
			to_chat(user, span_info("I need to have something attached."))
	. = ..()

//Attaches a hook to an atom. Used with the "ATTACH" intent.
/obj/item/grapplinghook/proc/attach(atom/A)
	if(A && !isturf(A))
		if(target_effect && attached)
			attached.cut_overlay(target_effect)
			qdel(target_effect)
		playsound(A,'sound/misc/grapple_attach.ogg', 100, FALSE, 5)
		attached = A
		target_effect = mutable_appearance(icon = 'icons/effects/effects.dmi', icon_state = "aimwarn", layer = 20)
		attached.add_overlay(target_effect)

//Hooks onto a turf. Used with the "GRAB" intent.
/obj/item/grapplinghook/proc/grapple_to(turf/T)
	unload()
	playsound(T, 'sound/misc/grapple_land.ogg', 100, FALSE, 5)
	tile_effect = mutable_appearance(icon = 'icons/effects/effects.dmi', icon_state = "hooked_tile", layer = 18)
	grappled_turf = T
	grappled_turf.add_overlay(tile_effect)

//Reloads the grappler.
/obj/item/grapplinghook/proc/load()
	is_loaded = TRUE
	in_use = FALSE
	update_icon()

//Unloads the grappler after a successful, or not, attempt to use on a turf.
/obj/item/grapplinghook/proc/unload(failure)
	if(!failure)
		is_loaded = FALSE
		in_use = TRUE
	else
		is_loaded = FALSE
		in_use = FALSE
	update_icon()

/obj/item/grapplinghook/update_icon()
	. = ..()
	if(is_loaded && !in_use)
		icon_state = "grappler"
	else if(!is_loaded && !in_use)
		icon_state = "grappler_used"
	else if(!is_loaded && in_use)
		icon_state = "grappler_inuse"

/obj/item/reagent_containers/glass/bottle/waterskin/purifier
	name = "purifying waterskin"
	desc = "Bronze tubes spiral about from the mouth of this waterskin in complex, dizzying patterns."
	icon_state = "water-purifier"
	var/filtered_reagents = list(/datum/reagent/water/gross) // List of liquids it turns into drinkable water

/obj/item/reagent_containers/glass/bottle/waterskin/purifier/onfill(obj/target, mob/user, silent = FALSE)
	. = ..()
	cleanwater(user, silent)

/obj/item/reagent_containers/glass/bottle/waterskin/purifier/proc/cleanwater(mob/living/carbon/human/user, silent = FALSE)
	// If there is dirty water inside the device, clean it!
	if (hasdirtywater())
		for (var/datum/reagent/R in reagents.reagent_list)
			if(R.type in filtered_reagents)
				var/amt2clean = reagents.get_reagent_amount(R.type)
				reagents.remove_all_type(R, amt2clean)
				reagents.add_reagent(/datum/reagent/water, amt2clean)
		if (!silent)
			playsound(user, 'sound/items/waterfilter.ogg', 40, TRUE)
			to_chat(user, span_hear("I hear whizzing clockwork and gurgling water within [src]."))
			if (prob(25))
				new /obj/effect/temp_visual/small_smoke(user.loc)
				user.visible_message(span_notice("A cloud of steam momentarily envelops [user]!"), span_notice("The device sputters and spews a cloud of steam." + span_warning(" How annoying!")))


/obj/item/reagent_containers/glass/bottle/waterskin/purifier/proc/hasdirtywater()
	for (var/datum/reagent/R in reagents.reagent_list)
		if(R.type in filtered_reagents)
			return TRUE
	return FALSE
