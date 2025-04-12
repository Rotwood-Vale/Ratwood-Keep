/obj/item/fishingrod
	force = 12
	possible_item_intents = list(ROD_CAST, SPEAR_BASH)
	name = "fishing rod"
	desc = "Made from weathered wood and coarse twine. The tool of the battle against the dark waters below."
	icon_state = "rod"
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	wlength = 33
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_BULKY
	///The current bait that we have attached to our fishing rod
	var/obj/item/baited = null

/datum/intent/cast
	name = "cast"
	chargetime = 0
	noaa = TRUE
	misscost = 0
	icon_state = "inuse"
	no_attack = TRUE

/obj/item/fishingrod/New()
	. = ..()
	icon_state = "rod[rand(1,3)]"

/obj/item/fishingrod/attack_self(mob/user)
	if(user.doing)
		user.doing = 0
	else
		..()


/obj/item/fishingrod/attackby(obj/item/I, mob/user, params)
	if(I.baitchance && !baited)
		user.visible_message(span_notice("[user] hooks something to the line."), \
							span_notice("I hook [I] to my line."))
		playsound(src.loc, 'sound/foley/pierce.ogg', 50, FALSE)
		I.forceMove(src)
		baited = I
		update_icon()
		return
	. = ..()

/obj/item/fishingrod/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -14,"sy" = -1,"nx" = 11,"ny" = -1,"wx" = -11,"wy" = 0,"ex" = 5,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/fishingrod/afterattack(obj/target, mob/user, proximity)
	if(user.used_intent.type == SPEAR_BASH \
	|| !check_allowed_items(target,target_self=1) \
	|| !istype(target, /turf/open/water) \
	|| user.used_intent.type != ROD_CAST \
	|| user.doing \
	|| get_dist(user, target) > 5 \
	|| !isliving(user) \
	)
		return ..()

	var/mob/living/current_fisherman = user
	
	if(!is_valid_fishing_spot(target))
		to_chat(current_fisherman, span_warning("This body of water seems devoid of aquatic life..."))
		return
	
	current_fisherman.visible_message(span_warning("[current_fisherman] casts a line!"), \
						span_notice("I cast a line."))
	playsound(loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)

	var/amt2raise = 0 //How much exp we gain on catch
	var/casting_time = (rand(8 SECONDS, 15 SECONDS)) //How long before a fish bites
	var/fishing_time = 3 SECONDS //How long to reel in our catch
	var/skill_level 
	if(current_fisherman.mind)
		skill_level = current_fisherman.mind.get_skill_level(/datum/skill/labor/fishing)
		if(skill_level)
			casting_time = clamp((casting_time - skill_level SECONDS), 1, 15 SECONDS) //Can't go under 1
			fishing_time = clamp((fishing_time / skill_level), 1, 3 SECONDS)

	if(!do_after(current_fisherman, casting_time, target = target))
		return
	if(!baited)
		to_chat(current_fisherman, span_warning("This seems pointless."))
		return

	if(!prob(baited.baitchance))
		to_chat(current_fisherman, span_warning("Damn, got away..."))
		QDEL_NULL(baited)
		update_icon()
		return

	to_chat(current_fisherman, span_notice("Something tugs the line!"))
	playsound(loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
	if(!do_after(current_fisherman, fishing_time, target = target))
		to_chat(current_fisherman, span_warning("Damn, got away..."))
		QDEL_NULL(baited)
		update_icon()
		return

	var/caught_thing = pickweight(baited.fishloot)
	new caught_thing(current_fisherman.loc)
	amt2raise = current_fisherman.STAINT * 2
	playsound(loc, 'sound/items/Fish_out.ogg', 100, TRUE)

	QDEL_NULL(baited)
	current_fisherman.mind.add_sleep_experience(/datum/skill/labor/fishing, amt2raise) 
	update_icon()

/obj/item/fishingrod/update_icon()
	cut_overlays()
	if(baited)
		var/obj/item/I = baited
		I.pixel_x = 6
		I.pixel_y = -6
		add_overlay(new /mutable_appearance(I))
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

/obj/item/fishingrod/attack_turf(turf/T, mob/living/user)
	var/list/obj/item/baitables = list()
	for(var/obj/item/I in T.contents)
		if(I.baitchance)
			baitables += I
		if(baited)
			to_chat(user, "My rod already has bait.")
			return
		for(I in baitables)
			if(I.baitchance && !baited)
				to_chat(user, span_info("I begin baiting \the [src]..."))
				if(!do_after(user, 5, TRUE, src))
					return
				user.visible_message(span_notice("[user] hooks something to the line."), \
								span_notice("I hook [I] to my line."))
				playsound(src.loc, 'sound/foley/pierce.ogg', 50, FALSE)
				I.forceMove(src)
				baited = I
				update_icon()
				return
			. = ..()
