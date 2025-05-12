/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*
 *	    (Preserves)		*
 *						*
 * * * * * * * * * * * **/

// -------------- FAT -----------------
/obj/item/reagent_containers/food/snacks/fat
	icon = 'modular/Neu_Food/icons/food.dmi'
	name = "fat"
	desc = "The raw fat from a butchered animal, tastes great most of the time (Add mince to make a wiener, use with salt and dryingrack to make salo)"
	icon_state = "fat"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/fat/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/mince))
		if(isturf(loc)&& (found_table))
			to_chat(user, "<span class='notice'>Stuffing a wiener...</span>")
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,long_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/meat/sausage(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	else
		return ..()

// -------------- RAISINS -----------------
/obj/item/reagent_containers/food/snacks/rogue/raisins
	name = "raisins"
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "raisins5"
	bitesize = 5
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("dried fruit" = 1)
	foodtype = GRAIN
	eat_effect = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/raisins/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "raisins4"
	if(bitecount == 2)
		icon_state = "raisins3"
	if(bitecount == 3)
		icon_state = "raisins2"
	if(bitecount == 4)
		icon_state = "raisins1"

/obj/item/reagent_containers/food/snacks/rogue/raisins/CheckParts(list/parts_list, datum/crafting_recipe/R)
	..()
	for(var/obj/item/reagent_containers/food/snacks/M in parts_list)
		color = M.filling_color
		if(M.reagents)
			M.reagents.remove_reagent(/datum/reagent/consumable/nutriment, M.reagents.total_volume)
			M.reagents.trans_to(src, M.reagents.total_volume)
		qdel(M)

// -------------- CANDY -----------------
/obj/item/reagent_containers/powder/sugar
	name = "sugar"
	desc = "Sweet embrace, goes great with pastries."
	gender = PLURAL
	icon_state = "sugar"
	list_reagents = list(/datum/reagent/consumable/sugar = 1)
	grind_results = list(/datum/reagent/consumable/sugar = 10)
	volume = 1
	sellprice = 0
	var/water_added

/obj/item/reagent_containers/powder/sugar/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	var/obj/item/reagent_containers/R = I
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(!istype(R) || (water_added))
		return ..()
	if(isturf(loc)&& (!found_table))
		to_chat(user, "<span class='notice'>Need a table...</span>")
		return ..()
	if(!R.reagents.has_reagent(/datum/reagent/water, 10))
		to_chat(user, "<span class='notice'>Needs more water to work it.</span>")
		return TRUE
	to_chat(user, "<span class='notice'>Adding water, now its time to knead it...</span>")
	playsound(get_turf(user), 'modular/Neu_Food/sound/splishy.ogg', 100, TRUE, -1)
	if(do_after(user,2 SECONDS, target = src))
		user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
		name = "sticky sugar"
		desc = "Destined for greatness, at your hands."
		R.reagents.remove_reagent(/datum/reagent/water, 10)
		water_added = TRUE
		color = "#d9d0cb"
	return TRUE

/obj/item/reagent_containers/powder/sugar/attack_hand(mob/living/user)
	if(water_added)
		playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
		if(do_after(user,3 SECONDS, target = src))
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
			new /obj/item/reagent_containers/food/snacks/rogue/candybase(loc)
			qdel(src)
	else ..()

/obj/item/reagent_containers/food/snacks/rogue/candybase
	name = "candy base"
	desc = "About to become something great. (Add apple or berries)"
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "candybase"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, sticky, and malleable" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/rogue/candybase/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/grown/apple))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading.ogg', 90, TRUE, -1)
			to_chat(user, "<span class='notice'>Breaking the apple down into the base...</span>")
			if(do_after(user,short_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/applecandy(loc)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/grown/berries/rogue))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading.ogg', 100, TRUE, -1)
			to_chat(user, "<span class='notice'>Breaking the berries down into the base...</span>")
			if(do_after(user,short_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/berrycandy(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/applecandy
	name = "apple candy"
	desc = "Sweet sweet candy, "
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "applecandy6"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("sweet, tart apple candy" = 1)
	foodtype = SUGAR
	bitesize = 6
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = /datum/status_effect/buff/sweet


/obj/item/reagent_containers/food/snacks/rogue/applecandy/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "applecandy5"
	if(bitecount == 2)
		icon_state = "applecandy4"
	if(bitecount == 3)
		icon_state = "applecandy3"
	if(bitecount == 4)
		icon_state = "applecandy2"
	if(bitecount == 5)
		icon_state = "applecandy1"

/obj/item/reagent_containers/food/snacks/rogue/berrycandy
	name = "berry candy"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "berrycandy6"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("sweet, tart berry candy" = 1)
	foodtype = SUGAR
	bitesize = 6
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = /datum/status_effect/buff/sweet

/obj/item/reagent_containers/food/snacks/rogue/berrycandy/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "berrycandy5"
	if(bitecount == 2)
		icon_state = "berrycandy4"
	if(bitecount == 3)
		icon_state = "berrycandy3"
	if(bitecount == 4)
		icon_state = "berrycandy2"
	if(bitecount == 5)
		icon_state = "berrycandy1"

// -------------- SPIDER HONEY -----------------
/obj/item/reagent_containers/food/snacks/rogue/honey
	name = "spider honey"
	icon = 'modular/Neu_Food/icons/food.dmi'
	icon_state = "spiderhoney"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	mill_result = /obj/item/reagent_containers/powder/alch/honey
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("sweetness and spiderwebs" = 1)
	eat_effect = /datum/status_effect/buff/sweet
	rotprocess = null


/*	........   Drying Rack recipes   ................ */
/datum/crafting_recipe/roguetown/cooking/salami
	name = "salumoi - (sausage, salt; DRYING RACK; NONE)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage = 1,
		/obj/item/reagent_containers/powder/salt = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/salami
	req_table = FALSE
	structurecraft = /obj/machinery/tanningrack
	skill_level = 0

/datum/crafting_recipe/roguetown/cooking/coppiette
	name = "coppiette - (steak, salt; DRYING RACK; NONE)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
		/obj/item/reagent_containers/powder/salt = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/coppiette
	req_table = FALSE
	skill_level = 0
	structurecraft = /obj/machinery/tanningrack

/datum/crafting_recipe/roguetown/cooking/salo
	name = "salo - (fat, salt; DRYING RACK; NONE)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fat = 1,
		/obj/item/reagent_containers/powder/salt = 1)
	result = /obj/item/reagent_containers/food/snacks/fat/salo
	skill_level = 0
	structurecraft = /obj/machinery/tanningrack
	req_table = FALSE

/datum/crafting_recipe/roguetown/cooking/saltfish
	name = "saltfish - (fish, salt; DRYING RACK; NONE)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fish = 1,
		/obj/item/reagent_containers/powder/salt = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/fish = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/saltfish
	req_table = FALSE
	skill_level = 0
	subtype_reqs = TRUE
	structurecraft = /obj/machinery/tanningrack

/datum/crafting_recipe/roguetown/cooking/raisins
	name = "raisins - (berries; DRYING RACK; NONE)"
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/raisins
	structurecraft = /obj/machinery/tanningrack
	req_table = FALSE
	skill_level = 0
	subtype_reqs = TRUE


// -------------- SALUMOI (dwarven smoked sausage) -----------------
/obj/item/reagent_containers/food/snacks/rogue/meat/salami
	name = "salumoi"
	desc = "Traveling food invented by dwarves. Said to last for ten yils before spoiling"
	icon_state = "salumoi5"
	eat_effect = null
	fried_type = null
	slices_num = 4
	bitesize = 5
	slice_batch = FALSE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice
	tastes = list("salted meat" = 1)
	rotprocess = null
	slice_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/meat/salami/update_icon()
	if(slices_num)
		icon_state = "salumoi[slices_num]"
	else
		icon_state = "salumoi_slice"

/obj/item/reagent_containers/food/snacks/rogue/meat/salami/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 4
		if(bitecount == 2)
			slices_num = 3
		if(bitecount == 3)
			slices_num = 2
		if(bitecount == 4)
			changefood(slice_path, eater)

/obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice
	eat_effect = null
	slices_num = 0
	name = "salumoi"
	icon_state = "salumoi_slice"
	fried_type = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 1
	tastes = list("salted meat" = 1)

// -------------- COPPIETTE (dried meat) -----------------
/obj/item/reagent_containers/food/snacks/rogue/meat/coppiette
	eat_effect = null
	name = "coppiette"
	icon_state = "jerk5"
	desc = "Dried meat sticks."
	fried_type = null
	bitesize = 5
	slice_path = null
	tastes = list("salted meat" = 1)
	rotprocess = null
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)

/obj/item/reagent_containers/food/snacks/rogue/meat/coppiette/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "jerk4"
	if(bitecount == 2)
		icon_state = "jerk3"
	if(bitecount == 3)
		icon_state = "jerk2"
	if(bitecount == 4)
		icon_state = "jerk1"

// -------------- SALTFISH -----------------
/obj/item/reagent_containers/food/snacks/rogue/saltfish
	eat_effect = null
	icon = 'icons/roguetown/misc/fish.dmi'
	name = "saltfish"
	icon_state = ""
	desc = "Dried fish."
	fried_type = null
	bitesize = 4
	slice_path = null
	tastes = list("salted meat" = 1)
	rotprocess = null
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)
	dropshrink = 0.6

/obj/item/reagent_containers/food/snacks/rogue/saltfish/CheckParts(list/parts_list, datum/crafting_recipe/R)
	for(var/obj/item/reagent_containers/food/snacks/M in parts_list)
		icon_state = "[initial(M.icon_state)]dried"
		qdel(M)

// -------------- SALO (salted fat) -----------------
/obj/item/reagent_containers/food/snacks/fat/salo
	name = "salo"
	icon_state = "salo4"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	bitesize = 4
	slice_path = /obj/item/reagent_containers/food/snacks/fat/salo/slice
	slices_num = 4
	slice_batch = FALSE
	slice_sound = TRUE
	eat_effect = null

/obj/item/reagent_containers/food/snacks/fat/salo/update_icon()
	if(slices_num)
		icon_state = "salo[slices_num]"
	else
		icon_state = "saloslice"

/obj/item/reagent_containers/food/snacks/fat/salo/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 3
		if(bitecount == 2)
			slices_num = 2
		if(bitecount == 3)
			changefood(slice_path, eater)

/obj/item/reagent_containers/food/snacks/fat/salo/slice
	name = "salo"
	icon_state = "saloslice"
	bitesize = 2
	slices_num = FALSE
	slice_path = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)



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
	if(user.mind)
		short_cooktime = (70 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (120 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/powder/salt))
		if(!reagents.has_reagent(/datum/reagent/consumable/milk, 12))
			to_chat(user, "<span class='warning'>Not enough milk.</span>")
			return
		to_chat(user, "<span class='warning'>Adding salt to the milk.</span>")
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
		if(do_after(user,2 SECONDS, target = src))
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
			reagents.remove_reagent(/datum/reagent/consumable/milk, 12)
			reagents.add_reagent(/datum/reagent/consumable/milk/salted, 12)
			qdel(I)

/*	............   Churning butter   ................ */
/obj/item/reagent_containers/glass/bucket/wooden/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		long_cooktime = (200 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*20))
	if(istype(I, /obj/item/kitchen/spoon))
		if(!reagents.has_reagent(/datum/reagent/consumable/milk/salted, 12))
			to_chat(user, "<span class='warning'>Not enough salted milk.</span>")
			return
		user.visible_message("<span class='info'>[user] churns butter...</span>")
		playsound(get_turf(user), 'modular/Neu_Food/sound/churn.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
			reagents.remove_reagent(/datum/reagent/consumable/milk/salted, 12)
			new /obj/item/reagent_containers/food/snacks/butter(drop_location())
		return
	..()

// -------------- BUTTER -----------------
/obj/item/reagent_containers/food/snacks/butter
	icon = 'modular/Neu_Food/icons/food.dmi'
	name = "stick of butter"
	desc = "The material that was used to make some of the best foods around, and the reason we have butterdough. Tastes good with toast."
	icon_state = "butter6"
	list_reagents = list(/datum/reagent/consumable/nutriment = BUTTER_NUTRITION)
	foodtype = DAIRY
	slice_path = /obj/item/reagent_containers/food/snacks/butterslice
	slices_num = 6
	slice_batch = FALSE
	bitesize = 6
	slice_sound = TRUE

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
	icon = 'modular/Neu_Food/icons/food.dmi'
	icon_state = "butter_slice"
	name = "butter"
	desc = ""
	foodtype = DAIRY
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)


/*	............   Making fresh cheese   ................ */
/obj/item/reagent_containers/glass/bucket/wooden/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/natural/cloth))
		if(reagents.has_reagent(/datum/reagent/consumable/milk/salted, 3))
			user.visible_message("<span class='info'>[user] strains fresh cheese...</span>")
			playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
			if(do_after(user,long_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				reagents.remove_reagent(/datum/reagent/consumable/milk/salted, 3)
				new /obj/item/reagent_containers/food/snacks/rogue/cheese(drop_location())

		var/obj/item/natural/cloth/T = I
		if(T.wet && !T.return_blood_DNA())
			return
		else
			var/removereg = /datum/reagent/water
			if(!reagents.has_reagent(/datum/reagent/water, 5))
				removereg = /datum/reagent/water/gross
				if(!reagents.has_reagent(/datum/reagent/water/gross, 5))
					to_chat(user, "<span class='warning'>No water to soak in.</span>")
					return
			wash_atom(T)
			playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
			reagents.remove_reagent(removereg, 5)
			user.visible_message("<span class='info'>[user] soaks [T] in [src].</span>")
			return
	..()




/*	............   Making cheese wheel   ................ */
/obj/item/natural/cloth/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			user.visible_message("<span class='info'>[user] starts packing the cloth with fresh cheese...</span>")
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_start(loc)
				qdel(I)
				qdel(src)
			return
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	..()

/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_start
	name = "unfinished cheese wheel"
	icon_state = "cheesewheel_1"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_start/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
			if(do_after(user,short_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_two(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_two
	name = "unfinished cheese wheel"
	icon_state = "cheesewheel_2"
	w_class = WEIGHT_CLASS_BULKY
/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_two/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
			if(do_after(user,short_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_three(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_three
	name = "unfinished cheese wheel"
	icon_state = "cheesewheel_3"
	w_class = WEIGHT_CLASS_BULKY
	var/mature_proc = .proc/maturing_done
/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_three/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
			if(do_after(user,short_cooktime, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				qdel(I)
				name = "maturing cheese wheel"
				icon_state = "cheesewheel_end"
				desc = "Slowly solidifying, best left alone a bit longer."
				addtimer(CALLBACK(src, mature_proc), 5 MINUTES)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesewheel_three/proc/maturing_done()
	playsound(src.loc, 'modular/Neu_Food/sound/rustle2.ogg', 100, TRUE, -1)
	new /obj/item/reagent_containers/food/snacks/rogue/cheddar(loc)
	new /obj/item/natural/cloth(loc)
	qdel(src)




// -------------- CHEESE -----------------
/obj/item/reagent_containers/food/snacks/rogue/cheese
	name = "fresh cheese"
	desc = "A fresh batch of glorious cheese, goes great on buns or as a cake ingredient! (Use with cloth and 3 other cheeses to make a cheese wheel)"
	icon_state = "freshcheese"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = FRESHCHEESE_NUTRITION)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	foodtype = DAIRY
	eat_effect = null
	rotprocess = SHELFLIFE_DECENT
	become_rot_type = null
	slice_path = null

/obj/item/reagent_containers/food/snacks/rogue/cheddar
	name = "wheel of cheese"
	icon_state = "cheesewheel"
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = FRESHCHEESE_NUTRITION*4)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cheese" = 1)
	foodtype = DAIRY
	eat_effect = null
	rotprocess = SHELFLIFE_DECENT //Need it to be reasonably low to be able to make aged cheese
	slices_num = 6
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/cheddar/aged
	slice_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/cheddar/aged
	name = "wheel of aged cheese"
	icon_state = "blue_cheese"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	become_rot_type = null
	rotprocess = null
	sellprice = 60
	eat_effect = /datum/status_effect/buff/snackbuff

/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge
	name = "wedge of cheese"
	icon_state = "cheese_wedge"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	foodtype = DAIRY
	eat_effect = null
	rotprocess = SHELFLIFE_DECENT
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
	icon_state = "blue_cheese_wedge"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarslice/aged
	become_rot_type = null
	rotprocess = null
	sellprice = 10
	eat_effect = /datum/status_effect/buff/snackbuff

/obj/item/reagent_containers/food/snacks/rogue/cheddarslice
	name = "slice of cheese"
	icon_state = "cheese_slice"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	foodtype = DAIRY
	eat_effect = null
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
	icon_state = "blue_cheese_slice"
	become_rot_type = null
	rotprocess = null


