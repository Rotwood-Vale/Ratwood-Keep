
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
	var/heat_time = 100
	var/obj/item/attachment = null
	var/obj/item/reagent_containers/food/snacks/food = null
	cookonme = TRUE
	var/datum/looping_sound/boilloop/boilloop

/obj/machinery/light/rogue/forge/Initialize()
	boilloop = new(list(src), FALSE)
	. = ..()

/obj/machinery/light/rogue/forge/attackby(obj/item/W, mob/living/user, params)
	if(!attachment)
		if(istype(W, /obj/item/cooking/pan) || istype(W, /obj/item/reagent_containers/glass/bucket/pot))
			playsound(get_turf(user), 'sound/foley/dropsound/shovel_drop.ogg', 40, TRUE, -1)
			attachment = W
			W.forceMove(src)
			update_icon()
			return
	if(istype(W, /obj/item/rogueweapon/tongs) && on)
		var/obj/item/rogueweapon/tongs/T = W
		if(T.hingot)
			var/tyme = world.time
			T.hott = tyme
			addtimer(CALLBACK(T, TYPE_PROC_REF(/obj/item/rogueweapon/tongs, make_unhot), tyme),heat_time )
			T.update_icon()
			user.visible_message(span_info("[user] heats the bar."))
			return
	else
		if(istype(W, /obj/item/reagent_containers/glass/bowl))
			to_chat(user, "<span class='notice'>Remove the pot from the forge first.</span>")
			return
		if(istype(attachment, /obj/item/cooking/pan))
			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/S = W
				if(istype(W, /obj/item/reagent_containers/food/snacks/egg)) // added
					playsound(get_turf(user), 'modular/Neu_Food/sound/eggbreak.ogg', 100, TRUE, -1)
					sleep(25) // to get egg crack before frying hiss
					W.icon_state = "rawegg" // added
					mouse_opacity = 0 // so you cannot scoop up raw egg in the pan. Returned to 1 in process proc below
				if(!food)
					S.forceMove(src)
					food = S
					update_icon()
					playsound(src.loc, 'sound/misc/frying.ogg', 80, FALSE, extrarange = 5)
					return
		// New concept = boil at least 66 water, add item, it turns into food reagent volume 66 of the appropriate type
		else if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/obj/item/reagent_containers/glass/bucket/pot = attachment
			if(istype(W, /obj/item/reagent_containers/food/snacks/grown/oat))
				if(!pot.reagents.has_reagent(/datum/reagent/water, 66))
					to_chat(user, "<span class='notice'>Not enough water.</span>")
					return TRUE
				if(pot.reagents.chem_temp < 374)
					to_chat(user, "<span class='warning'>[pot] isn't boiling!</span>")
					return
				if(do_after(user,2 SECONDS, target = src))
					user.visible_message("<span class='info'>[user] places [W] into the pot.</span>")
					qdel(W)
					playsound(src.loc, 'sound/items/Fish_out.ogg', 20, TRUE)
					pot.reagents.remove_reagent(/datum/reagent/water, 65)
					sleep(300)
					playsound(src, "bubbles", 30, TRUE)
					pot.reagents.add_reagent(/datum/reagent/consumable/soup/oatmeal, 65)
					pot.reagents.remove_reagent(/datum/reagent/water, 1)
				return

			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks/rogue/veg))
				if(!pot.reagents.has_reagent(/datum/reagent/water, 65))
					to_chat(user, "<span class='notice'>Not enough water.</span>")
					return TRUE
				if(pot.reagents.chem_temp < 374)
					to_chat(user, "<span class='warning'>[pot] isn't boiling!</span>")
					return
				if(do_after(user,2 SECONDS, target = src))
					user.visible_message("<span class='info'>[user] places [W] into the pot.</span>")
					playsound(src.loc, 'sound/items/Fish_out.ogg', 20, TRUE)
					pot.reagents.remove_reagent(/datum/reagent/water, 32)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced))
						qdel(W)
						sleep(800)
						playsound(src, "bubbles", 30, TRUE)
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/veggie/potato, 65)
						pot.reagents.remove_reagent(/datum/reagent/water, 1)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced))
						qdel(W)
						sleep(600)
						playsound(src, "bubbles", 30, TRUE)
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/veggie/onion, 65)
						pot.reagents.remove_reagent(/datum/reagent/water, 1)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced))
						qdel(W)
						sleep(700)
						playsound(src, "bubbles", 30, TRUE)
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/veggie/cabbage, 65)
						pot.reagents.remove_reagent(/datum/reagent/water, 1)
				return

			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks/rogue/meat))
				if(!pot.reagents.has_reagent(/datum/reagent/water, 66))
					to_chat(user, "<span class='notice'>Not enough water.</span>")
					return TRUE
				if(pot.reagents.chem_temp < 374)
					to_chat(user, "<span class='warning'>[pot] isn't boiling!</span>")
					return
				if(do_after(user,2 SECONDS, target = src))
					user.visible_message("<span class='info'>[user] places [W] into the pot.</span>")
					playsound(src.loc, 'sound/items/Fish_out.ogg', 20, TRUE)
					pot.reagents.remove_reagent(/datum/reagent/water, 65)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish))
						qdel(W)
						sleep(800)
						playsound(src, "bubbles", 30, TRUE)
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/stew/fish, 65)
						pot.reagents.remove_reagent(/datum/reagent/water, 1)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/meat/spider))
						qdel(W)
						sleep(1000)
						playsound(src, "bubbles", 30, TRUE)
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/stew/yucky, 65)
						pot.reagents.remove_reagent(/datum/reagent/water, 1)
					if(istype(W, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet) || istype(W, /obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry))
						qdel(W)
						sleep(900)
						playsound(src, "bubbles", 30, TRUE)
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/stew/chicken, 65)
						pot.reagents.remove_reagent(/datum/reagent/water, 1)
					else
						qdel(W)
						sleep(900)
						playsound(src, "bubbles", 30, TRUE)
						pot.reagents.add_reagent(/datum/reagent/consumable/soup/stew/meat, 65)
						pot.reagents.remove_reagent(/datum/reagent/water, 1)
				return
	. = ..()

/obj/machinery/light/rogue/forge/update_icon()
	cut_overlays()
	icon_state = "[base_state][on]"
	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan) || istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
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
		if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
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
						mouse_opacity = 1
						qdel(food)
						food = C
			if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
				if(attachment.reagents)
					attachment.reagents.expose_temperature(400, 0.033)
					if(attachment.reagents.chem_temp > 374)
						boilloop.start()
					else
						boilloop.stop()
		update_icon()

/obj/machinery/light/rogue/forge/Destroy()
	QDEL_NULL(boilloop)
	. = ..()
