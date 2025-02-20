/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*	- Defined as edible food that can't be plated and ideally can be made in rough conditions, generally less nutritious
 *		 (Snacks)		*
 *						*
 * * * * * * * * * * * **/


/*	.............   Frysteak   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried
	eat_effect = null
	slices_num = 0
	name = "frysteak"
	desc = "A slab of beastflesh, fried to a perfect medium-rare"
	icon_state = "frysteak"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = MEATSLAB_NUTRITION)
	faretype = FARE_NEUTRAL
	rotprocess = SHELFLIFE_DECENT
	tastes = list("warm steak" = 1)

/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried/attackby(obj/item/I, mob/living/user, params)
	var/obj/item/reagent_containers/peppermill/mill = I
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(mill))
		if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			to_chat(user, "There's not enough black pepper to make anything with.")
			return TRUE
		mill.icon_state = "peppermill_grind"
		to_chat(user, "You start rubbing the steak with black pepper.")
		playsound(get_turf(user), 'modular/Neu_Food/sound/peppermill.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
				to_chat(user, "There's not enough black pepper to make anything with.")
				return TRUE
			mill.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)
			new /obj/item/reagent_containers/food/snacks/rogue/peppersteak(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(src)

	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		to_chat(user, span_notice("Adding onions..."))
		if(do_after(user,short_cooktime, target = src))
			new /obj/item/reagent_containers/food/snacks/rogue/onionsteak(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(I)
			qdel(src)

	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))


/*	.............   Grenzelbun   ................ */
/obj/item/reagent_containers/food/snacks/rogue/bun_grenz
	list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+SMALLDOUGH_NUTRITION)
	tastes = list("savory sausage" = 1, "bread" = 1)
	name = "grenzelbun"
	desc = "Originally an elven cuisine composed of mortal races flesh and bread, the classic wiener in a bun, now modified and staple food of Grenzelhoft cuisine."
	icon_state = "grenzbun"
	foodtype = GRAIN | MEAT
	faretype = FARE_NEUTRAL
	warming = 5 MINUTES
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/bun_grenz/plated
	icon_state = "grenzbun_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	faretype = FARE_FINE
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_EXTREME


/*	.............   Fried Cackleberry   ................ */
/obj/item/reagent_containers/food/snacks/rogue/friedegg
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("fried cackleberry" = 1)
	name = "fried cackleberry"
	desc = "A favorite dish among Astratans."
	icon_state = "friedegg"
	portable = FALSE
	faretype = FARE_POOR
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/friedegg/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/friedegg))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/friedegg/two(loc)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Twin fried cackleberries   ................ */
/obj/item/reagent_containers/food/snacks/rogue/friedegg/two
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)
	tastes = list("fried cackleberries" = 1)
	name = "fried cackleberries"
	faretype = FARE_NEUTRAL
	desc = "Double the yolks, double the fun."
	portable = FALSE
	icon_state = "seggs"

/obj/item/reagent_containers/food/snacks/rogue/friedegg/two/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,long_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian(loc)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Frybird   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried
	eat_effect = null
	slices_num = 0
	name = "frybird"
	desc = "Poultry scorched to a perfect delicious crisp."
	icon_state = "frybird"
	faretype = FARE_FINE
	portable = FALSE
	fried_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato(loc)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato(loc)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Crispy bacon   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried
	eat_effect = null
	name = "fried bacon"
	desc = "A trufflepig's retirement plan."
	faretype = FARE_FINE
	icon_state = "friedbacon"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_DECENT


/*	.............   Fryspider   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/spider/fried
	name = "fried spidermeat"
	desc = "A spider leg, shaved and roasted."
	faretype = FARE_POOR
	icon_state = "friedspider"
	eat_effect = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/meat/crab/fried
	eat_effect = null
	slices_num = 0
	name = "fried crabmeat"
	faretype = FARE_NEUTRAL
	portable = FALSE
	desc = "A fried piece of crabmeat, yum."
	icon_state = "crabmeat"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	desc = ""


/*	.............   Sausage & Wiener   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
	eat_effect = null
	name = "sausage"
	desc = "Delicious flesh stuffed in a intestine casing."
	icon_state = "wiener"
	faretype = FARE_NEUTRAL
	fried_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked/wiener // wiener meant to be made from beef or maybe mince + bacon, luxury sausage, not implemented yet
	name = "wiener"


/*	.............   Cooked cabbage   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried
	name = "cooked cabbage"
	icon_state = "cabbage_fried"
	desc = "A peasant's delight."
	faretype = FARE_POOR
	portable = FALSE
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("warm cabbage" = 1)
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/wienercabbage(loc)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Baked potato   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked
	name = "baked potatoes"
	desc = "A dwarven favorite, as a meal or a game of hot potato."
	faretype = FARE_POOR
	icon_state = "potato_baked"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of wiener and tatos...")
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotato(loc)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of frybird and tatos...")
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato(loc)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Fried onions   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried
	name = "fried onion"
	desc = "Seared onions roasted to a delicious set of rings."
	icon_state = "onion_fried"
	faretype = FARE_POOR
	portable = FALSE
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("savoury morsel" = 1)
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of wiener and onions...")
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/wieneronions(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/*	.............   Fried potato   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried
	name = "fried potato"
	desc = "Potato bits, well roasted."
	icon_state = "potato_fried"
	faretype = FARE_NEUTRAL
	portable = FALSE
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("warm potato" = 1)
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of wiener and tatos...")
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotato(loc)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of frybird and tatos...")
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/* Fry Fish... i hate neufood */
/obj/item/reagent_containers/food/snacks/rogue/meat/fish/fried
	eat_effect = null
	slices_num = 0
	name = "fryfilet"
	desc = "A slab of flaky fish, fried until falling apart."
	icon_state = "cooked_filet"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = MEATSLAB_NUTRITION)
	faretype = FARE_NEUTRAL
	rotprocess = SHELFLIFE_DECENT
	tastes = list("warm fish" = 1)

/obj/item/reagent_containers/food/snacks/rogue/meat/fish/fried/attackby(obj/item/I, mob/living/user, params)
	var/obj/item/reagent_containers/peppermill/mill = I
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(mill))
		if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			to_chat(user, "There's not enough black pepper to make anything with.")
			return TRUE
		mill.icon_state = "peppermill_grind"
		to_chat(user, "You start rubbing the fish with black pepper.")
		playsound(get_turf(user), 'modular/Neu_Food/sound/peppermill.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
				to_chat(user, "There's not enough black pepper to make anything with.")
				return TRUE
			mill.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)
			new /obj/item/reagent_containers/food/snacks/rogue/pepperfish(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(src)

	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))

/* salmon and salmon accessories */
/obj/item/reagent_containers/food/snacks/rogue/fryfish/salmon/attackby(obj/item/M, mob/living/user, params)
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))	
	if(istype(M, /obj/item/alch/mentha))
		to_chat(user, "You start crushing mentha upon the salmon.")
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			new /obj/item/reagent_containers/food/snacks/rogue/dendorsalmon(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(M)
			qdel(src)
	if(istype(M, /obj/item/reagent_containers/food/snacks/grown/berries/rogue))
		to_chat(user, "You start crushing berries upon the salmon.")
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			new /obj/item/reagent_containers/food/snacks/rogue/berrysalmon(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(M)
			qdel(src)
		
	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))	
/*lobsta*/
/obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster/attackby(obj/item/I, mob/living/user, params)
	var/obj/item/reagent_containers/peppermill/mill = I
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(mill))
		if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			to_chat(user, "There's not enough black pepper to make anything with.")
			return TRUE
		mill.icon_state = "peppermill_grind"
		to_chat(user, "You start rubbing the lobster with black pepper.")
		playsound(get_turf(user), 'modular/Neu_Food/sound/peppermill.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
				to_chat(user, "There's not enough black pepper to make anything with.")
				return TRUE
			mill.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)
			new /obj/item/reagent_containers/food/snacks/rogue/pepperlobsta(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(src)
	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))

/*seabass*/
/obj/item/reagent_containers/food/snacks/rogue/fryfish/bass/attackby(obj/item/M, mob/living/user, params)
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))	
	if(istype(M, /obj/item/reagent_containers/food/snacks/rogue/veg/garlick_clove))
		to_chat(user, "You start crushing garlick upon the bass.")
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			new /obj/item/reagent_containers/food/snacks/rogue/garlickbass(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(M)
			qdel(src)
	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))	

/*milky mollusks*/
/obj/item/reagent_containers/food/snacks/rogue/fryfish/clam/attackby(obj/item/I, mob/living/user, params)
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers))
		if(!I.reagents.has_reagent(/datum/reagent/consumable/milk, 1))
			to_chat(user, "There's not enough milk to pour over these clams.")
			return TRUE
		to_chat(user, "You start pouring the milk over the hot clams.")
		playsound(get_turf(user), 'modular/Creechers/sound/milking1.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			if(!I.reagents.has_reagent(/datum/reagent/consumable/milk, 1))
				to_chat(user, "There's not enough milk to pour over these clams.")
				return TRUE
			I.reagents.remove_reagent(/datum/reagent/consumable/milk, 1)
			new /obj/item/reagent_containers/food/snacks/rogue/milkclam(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(src)
	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))
/*ale cod*/
/obj/item/reagent_containers/food/snacks/rogue/fryfish/cod/attackby(obj/item/I, mob/living/user, params)
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers))
		if(!I.reagents.has_reagent(/datum/reagent/consumable/ethanol/beer, 1))
			to_chat(user, "There's not enough ale to pour over this cod.")
			return TRUE
		to_chat(user, "You start pouring the ale over the hot cod.")
		playsound(get_turf(user), 'modular/Creechers/sound/milking1.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			if(!I.reagents.has_reagent(/datum/reagent/consumable/ethanol/beer, 1))
				to_chat(user, "There's not enough ale to pour over this cod.")
				return TRUE
			I.reagents.remove_reagent(/datum/reagent/consumable/ethanol/beer, 1)
			new /obj/item/reagent_containers/food/snacks/rogue/alecod(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(src)
	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))

/* onion plaice */
/obj/item/reagent_containers/food/snacks/rogue/fryfish/plaice/attackby(obj/item/M, mob/living/user, params)
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))	
	if(istype(M, /obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced))
		to_chat(user, "You start placing onions under the plaice.")
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			new /obj/item/reagent_containers/food/snacks/rogue/onionplaice(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(M)
			qdel(src)
	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))	

/*buttered feet i mean sole*/
/obj/item/reagent_containers/food/snacks/rogue/fryfish/sole/attackby(obj/item/M, mob/living/user, params)
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, span_warning("I need to use a table."))
		return FALSE
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))	
	if(istype(M, /obj/item/reagent_containers/food/snacks/butterslice))
		to_chat(user, "You start buttering the sole.")
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 100, TRUE, -1)
		if(do_after(user,long_cooktime, target = src))
			new /obj/item/reagent_containers/food/snacks/rogue/buttersole(loc)
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			qdel(M)
			qdel(src)
	else
		to_chat(user, span_warning("You need to put [src] on a table to knead in the spice."))	
