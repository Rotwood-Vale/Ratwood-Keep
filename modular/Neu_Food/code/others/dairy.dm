/* * * * * * * * * * * * * * *	*
 *								*
 *		Butter & Cheese			*
 *					 			*
 *								*
 * * * * * * * * * * * * * * * 	*/

/*	........   Salting milk (for butter & cheesemaking)   ................ */
/datum/reagent/consumable/milk/salted
	taste_description = "salty milk"

/obj/item/reagent_containers/attackby(obj/item/I, mob/living/user, params) // add cook time to containers & salted milk for butter churning
	..()
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/powder/salt))
		if(!reagents.has_reagent(/datum/reagent/consumable/milk, 15))
			to_chat(user, span_warning("Not enough milk."))
			return
		to_chat(user, span_warning("Adding salt to the milk."))
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
		if(do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			reagents.remove_reagent(/datum/reagent/consumable/milk, 15)
			reagents.add_reagent(/datum/reagent/consumable/milk/salted, 15)
			qdel(I)

/*	............   Churning butter   ................ */
/obj/item/reagent_containers/glass/bucket/attackby(obj/item/I, mob/living/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/kitchen/spoon))
		if(!reagents.has_reagent(/datum/reagent/consumable/milk/salted, 15))
			to_chat(user, span_warning("Not enough salted milk."))
			return
		user.visible_message(span_info("[user] churns butter..."))
		playsound(get_turf(user), 'modular/Neu_Food/sound/churn.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			reagents.remove_reagent(/datum/reagent/consumable/milk/salted, 15)
			new /obj/item/reagent_containers/food/snacks/butter(drop_location())
		return
	..()

// -------------- BUTTER -----------------
/obj/item/reagent_containers/food/snacks/butter
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	name = "stick of butter"
	desc = ""
	icon_state = "butter6"
	list_reagents = list(/datum/reagent/consumable/nutriment = BUTTER_NUTRITION)
	foodtype = DAIRY
	faretype = FARE_IMPOVERISHED
	slice_path = /obj/item/reagent_containers/food/snacks/butterslice
	slices_num = 6
	slice_batch = FALSE
	bitesize = 6
	slice_sound = TRUE

/obj/item/reagent_containers/food/snacks/butter/attackby(obj/item/I, mob/living/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/egg))
		to_chat(user, span_notice("Cracking an egg over the butter."))
		if(do_after(user, short_cooktime, target = src))
			playsound(get_turf(user), 'modular/Neu_Food/sound/eggbreak.ogg', 100, TRUE, -1)
			new /obj/item/reagent_containers/food/snacks/rogue/foodbase/squires_delight(drop_location())
			qdel(I)
			qdel(src)
			return
	return ..()


/obj/item/reagent_containers/food/snacks/butter/update_icon()
	if(slices_num)
		icon_state = "butter[slices_num]"
	else
		icon_state = "butter_slice"

/obj/item/reagent_containers/food/snacks/butter/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 5
		if(bitecount == 2)
			slices_num = 4
		if(bitecount == 3)
			slices_num = 3
		if(bitecount == 4)
			slices_num = 2
		if(bitecount == 5)
			changefood(slice_path, eater)

/obj/item/reagent_containers/food/snacks/butterslice
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "butter_slice"
	name = "butter"
	desc = ""
	faretype = FARE_IMPOVERISHED
	foodtype = DAIRY
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)


/*	............   Making fresh cheese   ................ */
/obj/item/reagent_containers/glass/bucket/attackby(obj/item/I, mob/living/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/natural/cloth))
		if(reagents.has_reagent(/datum/reagent/consumable/milk/salted, 5))
			user.visible_message(span_info("[user] strains fresh cheese..."))
			playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
			if(do_after(user,long_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				reagents.remove_reagent(/datum/reagent/consumable/milk/salted, 5)
				new /obj/item/reagent_containers/food/snacks/rogue/cheese(drop_location())
			return

		var/obj/item/natural/cloth/T = I
		if(T.wet && !T.return_blood_DNA())
			return
		else
			var/removereg = /datum/reagent/water
			if(!reagents.has_reagent(/datum/reagent/water, 5))
				removereg = /datum/reagent/water/gross
				if(!reagents.has_reagent(/datum/reagent/water/gross, 5))
					to_chat(user, span_warning("No water to soak in."))
					return
			wash_atom(T)
			playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
			reagents.remove_reagent(removereg, 5)
			user.visible_message(span_info("[user] soaks [T] in [src]."))
			return
	..()


/*	............   Making cheese wheel   ................ */
/obj/item/natural/cloth/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			user.visible_message(span_info("[user] starts packing the cloth with fresh cheese..."))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel(loc)
				qdel(I)
				qdel(src)
			return
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	..()

/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel
	name = "unfinished cheese wheel"
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "cheesewheel_1"
	w_class = WEIGHT_CLASS_BULKY
	process_step = 1
	var/mature_proc = .proc/maturing_done

/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc) && found_table)
			if(process_step == 4)
				return
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
			if(do_after(user, short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				process_step++
				qdel(I)
				switch(process_step)
					if(2)
						icon_state = "cheesewheel_2"
					if(3)
						icon_state = "cheesewheel_3"
					if(4)
						name = "maturing cheese wheel"
						icon_state = "cheesewheel_end"
						desc = "Slowly solidifying, best left alone a bit longer."
						addtimer(CALLBACK(src, mature_proc), 5 MINUTES)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel/proc/maturing_done()
	playsound(src.loc, 'modular/Neu_Food/sound/rustle2.ogg', 100, TRUE, -1)
	new /obj/item/reagent_containers/food/snacks/rogue/cheddar(loc)
	new /obj/item/natural/cloth(loc)
	qdel(src)


// -------------- CHEESE -----------------
/obj/item/reagent_containers/food/snacks/rogue/cheese
	name = "fresh cheese"
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "freshcheese"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = FRESHCHEESE_NUTRITION)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	faretype = FARE_POOR
	foodtype = GRAIN
	eat_effect = null
	rotprocess = SHELFLIFE_DECENT
	become_rot_type = null
	slice_path = null

/obj/item/reagent_containers/food/snacks/rogue/cheddar
	name = "wheel of cheese"
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "cheesewheel"
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = FRESHCHEESE_NUTRITION*4)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cheese" = 1)
	faretype = FARE_POOR
	eat_effect = null
	rotprocess = SHELFLIFE_LONG
	slices_num = 6
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/cheddar/aged
	slice_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/cheddar/aged
	name = "wheel of aged cheese"
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "blue_cheese"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	faretype = FARE_FINE
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge
	name = "wedge of cheese"
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "cheese_wedge"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_TINY
	faretype = FARE_FINE
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = SHELFLIFE_LONG
	slices_num = 3
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarslice
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	//baitpenalty = 0
	//isbait = TRUE
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 10,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5,
					/obj/item/reagent_containers/food/snacks/fish/angler = 1)

/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	name = "wedge of aged cheese"
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "blue_cheese_wedge"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarslice/aged
	faretype = FARE_FINE
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/cheddarslice
	name = "slice of cheese"
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "cheese_slice"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	eat_effect = null
	faretype = FARE_FINE
	rotprocess = 20 MINUTES
	slices_num = null
	slice_path = null
	become_rot_type = null
	//baitpenalty = 0
	//isbait = TRUE
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 10,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5)

/obj/item/reagent_containers/food/snacks/rogue/cheddarslice/aged
	name = "slice of aged cheese"
	icon = 'modular/Neu_Food/icons/others/dairy.dmi'
	icon_state = "blue_cheese_slice"
	faretype = FARE_FINE
	become_rot_type = null
	rotprocess = null



