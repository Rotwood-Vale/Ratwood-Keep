// /datum/crafting_recipe/roguetown/cooking/soup
// 	name = "soup"
// 	subtype_reqs = FALSE
// 	craftdiff = 0
// 	reqs = list(/datum/reagent/water = 10000,
// 	)
// 	req_table = FALSE
// 	tools = list(/obj/item/reagent_containers/glass/pot)

// /datum/crafting_recipe/roguetown/cooking/soup/gruel
// 	name = "gruel"
// 	reqs = list(
// 		/datum/reagent/water = 30,
// 		/obj/item/reagent_containers/food/snacks/grown/wheat= 1,
// 		/obj/item/reagent_containers/glass/bowl = 3)
// 	result = list(	/obj/item/reagent_containers/food/snacks/rogue/soup/gruel,
// 					/obj/item/reagent_containers/food/snacks/rogue/soup/gruel,
// 					/obj/item/reagent_containers/food/snacks/rogue/soup/gruel)
	
// 	craftdiff = 1

// /datum/crafting_recipe/roguetown/cooking/soup/simplestew
// 	name = "simple stew"
// 	reqs = list(
// 		/datum/reagent/water = 30,
// 		/obj/item/reagent_containers/food/snacks/rogue/meat/steak= 1,
// 		/obj/item/reagent_containers/food/snacks/grown/rogue/potato= 1,
// 		/obj/item/reagent_containers/glass/bowl = 3)
// 	result = list(	/obj/item/reagent_containers/food/snacks/rogue/soup/simplestew,
// 					/obj/item/reagent_containers/food/snacks/rogue/soup/simplestew,
// 					/obj/item/reagent_containers/food/snacks/rogue/soup/simplestew)
// 	craftdiff = 1

// /datum/crafting_recipe/roguetown/cooking/soup/fishchowder
// 	name = "fish chowder"
// 	reqs = list(
// 		/datum/reagent/water = 30,
// 		/obj/item/reagent_containers/food/snacks/fish/carp = 1,
// 		/obj/item/reagent_containers/food/snacks/grown/rogue/potato= 1,
// 		/obj/item/reagent_containers/glass/bowl = 3)
// 	result = list(/obj/item/reagent_containers/food/snacks/rogue/soup/fishchowder,
// 					/obj/item/reagent_containers/food/snacks/rogue/soup/fishchowder,
// 					/obj/item/reagent_containers/food/snacks/rogue/soup/fishchowder)
// 	craftdiff = 1

// /datum/crafting_recipe/roguetown/cooking/soup/chickensoup
// 	name = "chicken soup"
// 	reqs = list(
// 		/datum/reagent/water = 30,
// 		/obj/item/reagent_containers/food/snacks/rogue/meat/poultry= 1,
// 		/obj/item/reagent_containers/food/snacks/grown/carrot= 1,
// 		/obj/item/reagent_containers/food/snacks/grown/garlic= 1,
// 		/obj/item/reagent_containers/glass/bowl = 3)
// 	result = list(	/obj/item/reagent_containers/food/snacks/rogue/soup/chickensoup,
// 					/obj/item/reagent_containers/food/snacks/rogue/soup/chickensoup,
// 					/obj/item/reagent_containers/food/snacks/rogue/soup/chickensoup)
// 	craftdiff = 1

// /obj/item/reagent_containers/food/snacks/rogue/soup/gruel
// 	name = "gruel"
// 	desc = ""
// 	icon = 'icons/roguetown/items/food.dmi'
// 	icon_state = "gruel"
// 	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
// 	w_class = WEIGHT_CLASS_NORMAL
// 	tastes = list("creamy, grainy soup" = 1)
// 	foodtype = GRAIN
// 	trash = /obj/item/reagent_containers/glass/bowl

// /obj/item/reagent_containers/food/snacks/rogue/soup/simplestew
// 	name = "simple stew"
// 	desc = ""
// 	icon = 'icons/roguetown/items/food.dmi'
// 	icon_state = "simplestew"
// 	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
// 	w_class = WEIGHT_CLASS_NORMAL
// 	tastes = list("hearty, beefy soup" = 1)
// 	foodtype = MEAT
// 	trash = /obj/item/reagent_containers/glass/bowl
	
// /obj/item/reagent_containers/food/snacks/rogue/soup/fishchowder
// 	name = "fish chowder"
// 	desc = ""
// 	icon = 'icons/roguetown/items/food.dmi'
// 	icon_state = "fishchowder"
// 	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
// 	w_class = WEIGHT_CLASS_NORMAL
// 	tastes = list("creamy, fishy soup" = 1)
// 	foodtype = MEAT
// 	trash = /obj/item/reagent_containers/glass/bowl

// /obj/item/reagent_containers/food/snacks/rogue/soup/chickensoup
// 	name = "chicken soup"
// 	desc = ""
// 	icon = 'icons/roguetown/items/food.dmi'
// 	icon_state = "chickensoup"
// 	list_reagents = list(	/datum/reagent/consumable/nutriment = 15,
// 							/datum/reagent/medicine/healthpot = 15)
// 	w_class = WEIGHT_CLASS_NORMAL
// 	tastes = list("savory, chickeny soup" = 1)
// 	foodtype = MEAT
// 	trash = /obj/item/reagent_containers/glass/bowl
