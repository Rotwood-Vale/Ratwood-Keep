/*


/obj/item/reagent_containers/food/snacks/rogue/beanstew
	name = "bean stew"
	desc = "A hearty stew, with beans at the forefront."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "bean_stew"
	tastes = list("bean" = 1, "carrot" = 1, "potato" = 1, "radish" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	eat_effect = null
	warming = 5 MINUTES
	rotprocess = 15 MINUTES
	w_class = WEIGHT_CLASS_SMALL
	trash = /obj/item/reagent_containers/glass/bowl

/datum/crafting_recipe/roguetown/cooking/beanstew
	name = "bean stew"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/bean = 1,
		/obj/item/reagent_containers/food/snacks/grown/radish = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/glass/bowl = 1,
		/datum/reagent/water = 15
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/beanstew
	craftdiff = 1
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/oatstew
	name = "oat stew"
	desc = "A hearty stew, with oats at the forefront."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "oat_stew"
	tastes = list("oat" = 1, "carrot" = 1, "potato" = 1, "radish" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	eat_effect = null
	warming = 5 MINUTES
	rotprocess = 15 MINUTES
	w_class = WEIGHT_CLASS_SMALL
	trash = /obj/item/reagent_containers/glass/bowl

/datum/crafting_recipe/roguetown/cooking/oatstew
	name = "oat stew"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/oat = 1,
		/obj/item/reagent_containers/food/snacks/grown/radish = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/glass/bowl = 1,
		/datum/reagent/water = 15
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/oatstew
	craftdiff = 1
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/riceporridge
	name = "rice porridge"
	desc = "A bland white mush."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "rice_porridge"
	tastes = list("mush" = 1, "bland" = 1, "rice" = 1, "salt" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	eat_effect = null
	warming = 5 MINUTES
	rotprocess = 15 MINUTES
	w_class = WEIGHT_CLASS_SMALL
	trash = /obj/item/reagent_containers/glass/bowl

/datum/crafting_recipe/roguetown/cooking/riceporridge
	name = "rice porridge"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/rice = 1,
		/obj/item/reagent_containers/powder/salt = 1,
		/obj/item/reagent_containers/glass/bowl = 1,
		/datum/reagent/water = 15
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/riceporridge
	craftdiff = 0
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/cheesyporridge
	name = "cheesy rice porridge"
	desc = "Adding cheese saved this dish."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "rice_porridge"
	tastes = list("cheese" = 1, "rice" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	eat_effect = /datum/status_effect/buff/foodbuff
	warming = 5 MINUTES
	rotprocess = 15 MINUTES
	w_class = WEIGHT_CLASS_SMALL
	trash = /obj/item/reagent_containers/glass/bowl

/datum/crafting_recipe/roguetown/cooking/cheesyporridge
	name = "cheesy rice porridge"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/rice = 1,
		/obj/item/reagent_containers/powder/salt = 1,
		/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge = 1,
		/obj/item/reagent_containers/glass/bowl = 1,
		/datum/reagent/water = 15
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/cheesyporridge
	craftdiff = 0
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/tieflingrice
	name = "tiefling rice"
	desc = "A spicy dish hailing from tiefling lineages!"
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "tieflingrice"
	tastes = list("heat" = 1, "rice" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 15, /datum/reagent/consumable/capsaicin = 5)
	eat_effect = /datum/status_effect/buff/foodbuff
	warming = 10 MINUTES
	rotprocess = 15 MINUTES
	w_class = WEIGHT_CLASS_SMALL
	trash = /obj/item/reagent_containers/glass/bowl

/datum/crafting_recipe/roguetown/cooking/tieflingrice
	name = "tiefling rice"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/bellpepper = 1,
		/obj/item/reagent_containers/powder/salt = 1,
		/obj/item/reagent_containers/food/snacks/rogue/tomatoslice = 1,
		/obj/item/reagent_containers/food/snacks/grown/rice = 1,
		/obj/item/reagent_containers/glass/bowl = 1,
		/datum/reagent/water = 15
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/tieflingrice
	craftdiff = 2
	subtype_reqs = TRUE

*/
