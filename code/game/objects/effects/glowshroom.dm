//separate dm since hydro is getting bloated already

/obj/structure/glowshroom
	name = "kneestingers"
	desc = ""
	anchored = TRUE
	opacity = 0
	density = FALSE
	icon = 'icons/roguetown/misc/foliage.dmi'
	icon_state = "glowshroom1" //replaced in New
	layer = ABOVE_NORMAL_TURF_LAYER
	max_integrity = 30
	blade_dulling = DULLING_CUT
	resistance_flags = FLAMMABLE

/obj/structure/glowshroom/fire_act(added, maxstacks)
	visible_message(span_warning("[src] catches fire!"))
	var/turf/T = get_turf(src)
	qdel(src)
	new /obj/effect/hotspot(T)

/obj/structure/glowshroom/CanAStarPass(ID, to_dir, caller)
	return !can_zap(caller)

/obj/structure/glowshroom/CanPass(atom/movable/mover, turf/target)
	if(isliving(mover) && mover.z == z)
		return !can_zap(mover)
	. = ..()

/obj/structure/glowshroom/proc/can_zap(atom/movable/movable_victim)
	if(!isliving(movable_victim))
		return FALSE
	var/mob/living/victim = movable_victim
	if(HAS_TRAIT(victim, TRAIT_KNEESTINGER_IMMUNITY))
		return FALSE
	if(victim.throwing) // Exception to floor hazard immunity: they'll graze you if you're thrown over it.
		victim.throwing.finalize(FALSE) // This will unset victim.throwing, so we can still do floor hazard immunity check to check for other sources of immunity.
	if(victim.is_floor_hazard_immune()) // Floating or flying over the kneestinger
		return FALSE
	return TRUE

/obj/structure/glowshroom/proc/do_zap(atom/movable/movable_victim)
	if(!isliving(movable_victim))
		return FALSE
	var/mob/living/victim = movable_victim
	if(victim.electrocute_act(30, src))
		victim.emote("painscream")
		victim.update_sneak_invis(TRUE)
		victim.consider_ambush()
		if(victim.throwing)
			victim.throwing.finalize(FALSE)
		return TRUE
	return FALSE

/obj/structure/glowshroom/Bumped(atom/movable/bumper)
	. = ..()
	if(can_zap(bumper))
		do_zap(bumper)

/obj/structure/glowshroom/Crossed(atom/movable/crosser)
	if(can_zap(crosser))
		do_zap(crosser)
	. = ..()

/obj/structure/glowshroom/attackby(obj/item/W, mob/user, params)
	if(isliving(user) && W && user.z == z && (W.flags_1 & CONDUCT_1))
		// The kneestingers will let you pass if you worship dendor, but they won't take your stupid ass hitting them.
		if(do_zap(user))
			return FALSE
	return ..()


/obj/structure/glowshroom/Initialize(mapload, obj/item/seeds/newseed, mutate_stats)
	. = ..()
	set_light(1.5, 1.5, "#d4fcac")

	icon_state = "glowshroom[rand(1,3)]"

	pixel_x = rand(-4, 4)
	pixel_y = rand(0,5)


/obj/structure/glowshroom/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	if(damage_type == BURN && damage_amount)
		playsound(src.loc, 'sound/blank.ogg', 100, TRUE)

/obj/structure/glowshroom/temperature_expose(exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		take_damage(5, BURN, 0, 0)

/obj/structure/glowshroom/acid_act(acidpwr, acid_volume)
	. = 1
	visible_message(span_danger("[src] melts away!"))
	var/obj/effect/decal/cleanable/molten_object/I = new (get_turf(src))
	I.desc = ""
	qdel(src)
