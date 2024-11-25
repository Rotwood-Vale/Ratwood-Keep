/* * * * * * * * * * * **
 *						*	-Cooking based on slapcrafting
 *		 NeuFood		*	-Uses defines to track nutrition
 *						*	-Meant to replace menu crafting completely for foods
 *						*
 * * * * * * * * * * * **/
j/item/reagent_containers/glass/cup
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE
	
/obj/item/cooking/pan
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE

/obj/item/reagent_containers/peppermill // new with some animated art
	name = "pepper mill"
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "peppermill"
	layer = CLOSED_BLASTDOOR_LAYER // obj layer + a little, small obj layering above convenient
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	list_reagents = list(/datum/reagent/consumable/blackpepper = 5)
	reagent_flags = TRANSPARENT

/obj/item/cooking/platter
	name = "platter"
	desc = "Made from fired clay."
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	icon_state = "platter"
	resistance_flags = NONE
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	experimental_inhand = FALSE

/obj/item/book/rogue/yeoldecookingmanual // new book with some tips to learn
	name = "Ye olde ways of cookinge"
	desc = "Penned by Svend Fatbeard, butler in the fourth generation"
	icon_state ="book8_0"
	base_icon_state = "book8"
	bookfile = "Neu_cooking.json"

/obj/item/storage/foodbag
	name = "food pouch"
	desc = "A small pouch for carrying handfuls of food items."
	icon_state = "sack_rope"
	item_state = "sack_rope"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	resistance_flags = NONE
	max_integrity = 300

/obj/item/storage/foodbag/examine(mob/user)
	. = ..()
	if(contents.len)
		. += span_notice("[contents.len] thing[contents.len > 1 ? "s" : ""] in the sack.")

/obj/item/storage/foodbag/attack_right(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	testing("yea144")
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/list/things = STR.contents()
	if(things.len)
		testing("yea64")
		var/obj/item/I = pick(things)
		STR.remove_from_storage(I, get_turf(user))
		user.put_in_hands(I)

/obj/item/storage/foodbag/update_icon()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/list/things = STR.contents()
	if(things.len)
		icon_state = "sack_rope"
		w_class = WEIGHT_CLASS_NORMAL
	else
		icon_state = "sack_rope"
		w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/foodbag/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 20
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 5
	STR.set_holdable(list(
		/obj/item/reagent_containers/food/snacks/rogue/berrycandy,
		/obj/item/reagent_containers/food/snacks/rogue/applecandy,
		/obj/item/reagent_containers/food/snacks/rogue/raisins,
		/obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw/cooked
		))
	STR.click_gather = TRUE
	STR.attack_hand_interact = FALSE
	STR.collection_mode = COLLECT_EVERYTHING
	STR.dump_time = 0
	STR.allow_quick_gather = TRUE
	STR.allow_quick_empty = TRUE
	STR.allow_look_inside = FALSE
	STR.allow_dump_out = TRUE
	STR.display_numerical_stacking = TRUE


/* * * * * * * * * * * * * * *	*
 *								*
 *		Reagents     			*
 *					 			*
 *								*
 * * * * * * * * * * * * * * * 	*/

/// These are for the pot, if more vegetables are added and need to be integrated into the pot brewing you need to add them here
/datum/reagent/consumable/soup // so you get hydrated without the flavor system messing it up. Works like water with less hydration
	var/hydration = 6
/datum/reagent/consumable/soup/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			H.adjust_hydration(hydration)
		if(M.blood_volume < BLOOD_VOLUME_NORMAL)
			M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_NORMAL)
	..()

/datum/reagent/consumable/soup/oatmeal
	name = "oatmeal"
	description = "Fitting for a peasant."
	reagent_state = LIQUID
	color = "#c38553"
	nutriment_factor = 15
	metabolization_rate = 0.5 // half as fast as normal, last twice as long
	taste_description = "oatmeal"
	taste_mult = 3
	hydration = 2

/datum/reagent/consumable/soup/veggie
	name = "vegetable soup"
	description = ""
	reagent_state = LIQUID
	nutriment_factor = 10
	taste_mult = 4
	hydration = 8

/datum/reagent/consumable/soup/veggie/potato
	color = "#869256"
	taste_description = "potato broth"

/datum/reagent/consumable/soup/veggie/onion
	color = "#a6b457"
	taste_description = "boiled onions"

/datum/reagent/consumable/soup/veggie/cabbage
	color = "#859e56"
	taste_description = "watery cabbage"

/datum/reagent/consumable/soup/veggie/beet
	color = "#8E3A59"
	taste_description = "watery beets"

/datum/reagent/consumable/soup/stew
	name = "thick stew"
	description = "All manners of edible bits went into this."
	reagent_state = LIQUID
	nutriment_factor = 20
	taste_mult = 4

/datum/reagent/consumable/soup/stew/chicken
	color = "#baa21c"
	taste_description = "chicken"

/datum/reagent/consumable/soup/stew/meat
	color = "#80432a"
	taste_description = "meat stew"

/datum/reagent/consumable/soup/stew/fish
	color = "#c7816e"
	taste_description = "fish"

/datum/reagent/consumable/soup/stew/yucky
	color = "#9e559c"
	taste_description = "something rancid"


/* * * * * * * * * * * * * * *	*
 *								*
 *		Powder & Salt			*
 *					 			*
 *								*
 * * * * * * * * * * * * * * * 	*/

// -------------- POWDER (flour) -----------------
/obj/item/reagent_containers/powder/flour
	name = "powder"
	desc = "With this ambition, we build an empire."
	gender = PLURAL
	icon_state = "flour"
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 0
	var/water_added
/obj/item/reagent_containers/powder/flour/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/flour(get_turf(src))
	..()
	qdel(src)

/obj/item/reagent_containers/powder/flour/attackby(obj/item/I, mob/living/user, params)
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
		name = "wet powder"
		desc = "Destined for greatness, at your hands."
		R.reagents.remove_reagent(/datum/reagent/water, 10)
		water_added = TRUE
		color = "#d9d0cb"	
	return TRUE

/obj/item/reagent_containers/powder/flour/attack_hand(mob/living/user)
	if(water_added)
		playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
		if(do_after(user,3 SECONDS, target = src))
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
			new /obj/item/reagent_containers/food/snacks/rogue/dough_base(loc)
			qdel(src)
	else ..()

// -------------- SALT -----------------
/obj/item/reagent_containers/powder/salt
	name = "salt"
	desc = ""
	gender = PLURAL
	icon_state = "salt"
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 0

/obj/item/reagent_containers/powder/salt/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/flour(get_turf(src))
	..()
	qdel(src)

/*	..................   Food platter   ................... */
/obj/item/cooking/platter/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/peppersteak))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/peppersteak/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/onionsteak))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/onionsteak/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/friedrat))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/friedrat/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/hcakeslice))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/hcakeslice/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/ccakeslice))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/ccakeslice/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/bun_grenz))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/bun_grenz/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/wienercabbage))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/wienercabbage/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/wienerpotato))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotato/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/wieneronions))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/wieneronions/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/frybirdtato))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	else
		return ..()	

/* * * * * * * * * * * **
 *						*
 *	 Food Rotting		*	- Just lists as it stands on 2024-07-16
 *						*
 * * * * * * * * * * * **/

/*	.................   Never spoils   ................... *//*

* Hardtack
* Toast
* Salted fish
* Frybread
* Unbitten handpies
* Biscuit
* Prezzel
* Cheese wheel/wedges
* Salo
* Copiette
* Salumoi
* Uncut pie
* Raw potato, onion, cabbage

/*	.................   Long shelflife   ................... */

* Uncut bread loaf
* Uncut raisin bread
* Uncut cake
* Pastry
* Bun
* Most plated dishes
* Most cooked veggies
* Cooked sausage
* Pie slice
* Bread slice

/*	.................   Decent shelflife   ................... */

* Fresh cheese
* Mixed dishes with meats 
* Fried meats & eggs

/*	.................   Short shelflife   ................... */

* Raw meat
* Berries

/*	.................   Tiny shelflife   ................... */

* Minced meat

*/
