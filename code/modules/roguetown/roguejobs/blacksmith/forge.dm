
/obj/machinery/light/rogue/forge
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "stone forge"
	desc = "This forge sings of war and creation."
	icon_state = "forge0"
	base_state = "forge"
	density = TRUE
	anchored = TRUE
	on = FALSE
	climbable = TRUE
	climb_time = 0
	layer = 2.8
	var/obj/item/attachment = null
	var/obj/item/reagent_containers/food/snacks/food = null
	cookonme = TRUE
	var/datum/looping_sound/boilloop/boilloop

/obj/machinery/light/rogue/forge/Initialize()
	boilloop = new(list(src), FALSE)
	. = ..()

/obj/machinery/light/rogue/forge/attackby(obj/item/W, mob/living/user, params)
	if(!attachment)
		if(istype(W, /obj/item/cooking/pan) || istype(W, /obj/item/reagent_containers/glass/pot))
			attachment = W
			W.forceMove(src)
			update_icon()
			return
	if(istype(W, /obj/item/rogueweapon/tongs) && on)
		var/obj/item/rogueweapon/tongs/T = W
		if(T.hingot)
			var/tyme = world.time
			T.hott = tyme
			addtimer(CALLBACK(T, TYPE_PROC_REF(/obj/item/rogueweapon/tongs, make_unhot), tyme), 100)
			T.update_icon()
			user.visible_message(span_info("[user] heats the bar."))
			return
	else
		if(istype(attachment, /obj/item/cooking/pan))
			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/S = W
				if(!food)
					S.forceMove(src)
					food = S
					update_icon()
					playsound(src.loc, 'sound/misc/frying.ogg', 100, FALSE, extrarange = 5)
					return
		else if(istype(attachment, /obj/item/reagent_containers/glass/pot))
			var/obj/item/reagent_containers/glass/pot = attachment
			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks) || W.type == /obj/item/reagent_containers/powder/flour) 
				if(pot.reagents.chem_temp < 374)
					to_chat(user, span_warning("[pot] isn't boiling!"))
					return
				var/nutrimentamount = W.reagents.get_reagent_amount(/datum/reagent/consumable/nutriment)
				if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks))
					var/obj/item/reagent_containers/food/snacks/snack = W
					if(snack.type in subtypesof(/obj/item/reagent_containers/food/snacks/grown) || snack.eat_effect == /datum/status_effect/debuff/uncookedfood)
						nutrimentamount *= 1.25 //Boiling food makes more nutrients digestable.
				if(istype(W, /obj/item/reagent_containers/food/snacks/grown/wheat) || istype(W, /obj/item/reagent_containers/food/snacks/grown/oat) || istype(W, /obj/item/reagent_containers/powder/flour))
					nutrimentamount += 2 //Boiling is a way of cooking grain without baking
				if(nutrimentamount > 0)
					if(nutrimentamount + pot.reagents.total_volume > pot.volume)
						to_chat(user, span_warning("[attachment] is full!"))
						return
					user.visible_message(span_info("[user] places [W] into the pot."))
					pot.reagents.add_reagent(/datum/reagent/consumable/nutriment, nutrimentamount)
					qdel(W)
				return
	. = ..()
	return ..()

/obj/machinery/light/rogue/forge/update_icon()
	cut_overlays()
	icon_state = "[base_state][on]"
	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan) || istype(attachment, /obj/item/reagent_containers/glass/pot))
			var/obj/item/I = attachment
			I.pixel_x = 0
			I.pixel_y = 0
			add_overlay(new /mutable_appearance(I))
			if(food)
				I = food
				I.pixel_x = 0
				I.pixel_y = 0
				add_overlay(new /mutable_appearance(I))
	
/obj/machinery/light/rogue/forge/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan))
			if(food)
				if(!user.put_in_active_hand(food))
					food.forceMove(user.loc)
				food = null
				update_icon()
			else
				if(!user.put_in_active_hand(attachment))
					attachment.forceMove(user.loc)
				attachment = null
				update_icon()
		if(istype(attachment, /obj/item/reagent_containers/glass/pot))
			if(!user.put_in_active_hand(attachment))
				attachment.forceMove(user.loc)
			attachment = null
			update_icon()
			boilloop.stop()
	else
		if(on)
			var/mob/living/carbon/human/H = user
			if(istype(H))
				H.visible_message(span_info("[H] warms \his hand over the embers."))
				if(do_after(H, 50, target = src))
					var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
					to_chat(H, span_warning("HOT!"))
					if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
						H.update_damage_overlays()
			return TRUE

/obj/machinery/light/rogue/forge/process()
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()
	if(on)
		if(initial(fueluse) > 0)
			if(fueluse > 0)
				fueluse = max(fueluse - 10, 0)
			if(fueluse == 0)
				burn_out()
		if(attachment)
			if(istype(attachment, /obj/item/cooking/pan))
				if(food)
					var/obj/item/C = food.cooking(20, src)
					if(C)
						qdel(food)
						food = C
			if(istype(attachment, /obj/item/reagent_containers/glass/pot))
				if(attachment.reagents)
					attachment.reagents.expose_temperature(1000, 0.1)
					if(attachment.reagents.chem_temp > 374)
						boilloop.start()
					else
						boilloop.stop()
		update_icon()

/obj/machinery/light/rogue/forge/Destroy()
	QDEL_NULL(boilloop)	
	. = ..()
