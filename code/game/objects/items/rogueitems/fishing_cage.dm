/obj/item/fishingcage
	name = "fishing cage"
	desc = "A cage used with bait to catch shellfish without much work outside of deploying it."
	icon_state = "beartrap" //need sprites, using beartrap as replacement
	icon = 'icons/roguetown/items/misc.dmi' //need sprites, using beartrap as replacement
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	slot_flags = ITEM_SLOT_BACK
	var/check_counter = 0
	var/attraction_chance = 100
	var/deployed = 0
	var/obj/item/caught
	var/obj/item/bait
	var/time2catch = 20 MINUTES

/obj/item/fishingcage/attack_self(mob/user)
	. = ..()
	user.visible_message(span_notice("[user] begins deploying the fishing cage..."), \
						span_notice("I begin deploying the fishing cage..."))
	var/deploy_speed = 15 SECONDS - (user.mind.get_skill_level(/datum/skill/labor/fishing) * 2 SECONDS)
	var/turf/T = get_step(user, user.dir)
	if(istype(T, /turf/open/water))
		if(do_after(user, deploy_speed, target = src))
			user.transferItemToLoc(src, T)
			deployed = 1
	else
		to_chat(user, span_warning("I'm not catching anything if i don't put this on water"))
		return

/obj/item/fishingcage/attack_hand(mob/user)
	if(deployed)
		var/deploy_speed = 15 SECONDS - (user.mind.get_skill_level(/datum/skill/labor/fishing) * 2 SECONDS)
		if(caught)
			user.visible_message(span_notice("[user] begins to harvest the shellfish from the cage..."), \
								span_notice("I begin harvesting the shellfish from the cage..."))
			if(do_after(user, deploy_speed, target = src))
				STOP_PROCESSING(SSobj, src)
				icon_state = initial(icon_state)
				add_sleep_experience(user, /datum/skill/labor/fishing, 20)
				new caught(user.loc)
				caught = null
		else
			user.visible_message(span_notice("[user] begins disarming the fishing cage..."), \
								span_notice("I begin disarming the fishing cage..."))
			if(do_after(user, deploy_speed, target = src))
				STOP_PROCESSING(SSobj, src)
				deployed = 0
				bait.forceMove(src)
				bait = 0
				desc = initial(desc)
				icon_state = initial(icon_state)
				..()
	else
		..()

/obj/item/fishingcage/attackby(obj/item/I, mob/user, params)
	if(bait)
		to_chat(user, span_warning("There's bait already on the cage."))
		return
	if(I.baitchance)
		user.visible_message(span_notice("[user] starts adding the bait to the fishing cage..."), \
							span_notice("I start to add [I] to the fishing cage..."))
		if(do_after(user, 3 SECONDS, target = src))
			playsound(src.loc, 'sound/foley/pierce.ogg', 50, FALSE)
			I.forceMove(src)
			bait = I
			check_counter = world.time
			var/skill = user.mind.get_skill_level(/datum/skill/labor/fishing)
			if(skill > 1) //novice and no skill are both 20 minutes
				time2catch = 25 SECONDS - 5 SECONDS * skill
			if(skill == 5)
				time2catch = 3 SECONDS
			if(skill == 6)
				time2catch = 90 SECONDS
			desc = "[desc] [time2catch] ticks for a catch" //THIS IS DEBUG, DON'T FORGET TO REMOVE IT DUMBASS
			icon_state = "[icon_state]1"
			START_PROCESSING(SSobj, src)
			return
	. = ..()

/obj/item/fishingcage/process()
	if(deployed && bait)
		if(world.time > check_counter + time2catch)
			check_counter = world.time
			caught = pickweight(bait.fishloot)
			icon_state = initial(icon_state)
			QDEL_NULL(bait)
	..()

/obj/item/fishingcage/update_icon()
	cut_overlays()
	if(bait)
		var/obj/item/I = bait
		I.pixel_x = 6
		I.pixel_y = -6
		add_overlay(new /mutable_appearance(I))
	if(caught)
		var/obj/item/I = caught
		I.pixel_x = 6
		I.pixel_y = -6
		add_overlay(new /mutable_appearance(I))
