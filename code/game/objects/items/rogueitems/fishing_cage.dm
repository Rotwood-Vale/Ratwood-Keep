/obj/item/fishingcage
	name = "fishing cage"
	desc = "A miraculous invention. Just place a worm inside after putting it on the water and it will magically turn into a fish. Just don't spend too much time staring at it."
	icon_state = "fishingcage"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	slot_flags = ITEM_SLOT_BACK
	var/check_counter = 0
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
			icon_state = "fishingcage_deployed"
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
				icon_state = "fishingcage_deployed"
				add_sleep_experience(user, /datum/skill/labor/fishing, 20)
				new caught(user.loc)
				caught = null
				desc = initial(desc)
		else
			user.visible_message(span_notice("[user] begins disarming the fishing cage..."), \
								span_notice("I begin disarming the fishing cage..."))
			if(do_after(user, deploy_speed, target = src))
				STOP_PROCESSING(SSobj, src)
				deployed = 0
				QDEL_NULL(bait) //you lose the bait if you take out the cage without catching anything
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
				time2catch = 25 MINUTES - 5 MINUTES * skill 
			if(skill == 5)
				time2catch = 3 MINUTES 
			if(skill == 6)
				time2catch = 90 SECONDS 
			icon_state = "fishingcage_ready"
			START_PROCESSING(SSobj, src)
			return
	. = ..()

/obj/item/fishingcage/process()
	if(deployed && bait)
		if(world.time > check_counter + time2catch)
			check_counter = world.time
			caught = pickweight(bait.cageloot)
			icon_state = "fishingcage_caught"
			QDEL_NULL(bait)
	..()
