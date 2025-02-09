//By DREAMKEEP, Vide Noir https://github.com/EaglePhntm.
//GRAPHICS & SOUNDS INCLUDED:
//DARKEST DUNGEON (STRESS, RELIEF, AFFLICTION)
/mob/living/proc/play_overhead_indicator(icon_path, overlay_name, clear_time, overlay_layer, private = FALSE, soundin = null)
	if(!ishuman(src))
		return
	if(stat != DEAD)
		var/mob/living/carbon/human/humie = src
		var/datum/species/species =	humie.dna.species
		var/list/offset_list
		if(humie.gender == FEMALE)
			offset_list = species.offset_features[OFFSET_HEAD_F]
		else
			offset_list = species.offset_features[OFFSET_HEAD]
		if(!private)
			var/mutable_appearance/appearance = mutable_appearance(icon_path, overlay_name, overlay_layer)
			if(offset_list)
				appearance.pixel_x += (offset_list[1])
				appearance.pixel_y += (offset_list[2]+12)
			appearance.appearance_flags = RESET_COLOR
			overlays_standing[OBJ_LAYER] = appearance
			apply_overlay(OBJ_LAYER)
			addtimer(CALLBACK(humie, PROC_REF(clear_overhead_indicator), appearance), clear_time)
			playsound(src, soundin, 100, FALSE, extrarange = -1, ignore_walls = FALSE)
		else
			var/list/can_see = list(src)
			for(var/mob/M in viewers(world.view, src))
				if(HAS_TRAIT(M, TRAIT_EMPATH))
					if(M != src)
						can_see += M
			
			for(var/mob/M in can_see)
				new /obj/effect/temp_visual/stress_event/invisible(get_turf(src.loc), M, icon_path, overlay_name, offset_list)
				if(soundin)
					var/turf/T = get_turf(src)
					M.playsound_local(T, soundin, 100, FALSE)

/obj/effect/temp_visual/stress_event
	icon = 'icons/mob/overhead_effects.dmi'
	duration = 20

/obj/effect/temp_visual/stress_event/invisible
	icon_state = null

/obj/effect/temp_visual/stress_event/invisible/Initialize(mapload, mob/seer, path, iname, list/offsets)
	. = ..()
	var/image/I = image(icon = path, icon_state = iname, layer = ABOVE_MOB_LAYER, loc = src)
	I.alpha = 255
	I.appearance_flags = RESET_ALPHA
	if(offsets)
		I.pixel_x += (offsets[1])
		I.pixel_y += (offsets[2]+12)
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/onePerson, iname, I, seer)

/mob/living/proc/clear_overhead_indicator(appearance)
	remove_overlay(OBJ_LAYER)
	cut_overlay(appearance, TRUE)
	qdel(appearance)
	update_icon()
	return

/mob/living/proc/play_stress_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "stress", 15, OBJ_LAYER, private = TRUE, soundin = 'sound/ddstress.ogg')

/mob/living/proc/play_relief_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "relief", 15, OBJ_LAYER, private = TRUE, soundin = 'sound/ddrelief.ogg')

/mob/living/proc/play_mental_break_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "mentalbreak", 20, OBJ_LAYER)
	playsound(src, 'sound/stressaffliction.ogg', 100, FALSE, ignore_walls = FALSE)
