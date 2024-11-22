/*

/obj/item/reagent_containers/food/snacks/rogue/peppersteak
	icon = 'icons/roguetown/items/food.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 25)
	tastes = list("steak" = 1, "pepper" = 1)
	name = "peppersteak"
	desc = ""
	icon_state = "peppersteak"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = 30 MINUTES
	eat_effect = /datum/status_effect/buff/foodbuff
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'

/datum/crafting_recipe/roguetown/cooking/peppersteak
	name = "peppersteak"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried = 1,
		/datum/reagent/consumable/blackpepper = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/peppersteak
	skillcraft = null

/obj/item/reagent_containers/food/snacks/rogue/spicedeggs
	icon = 'icons/roguetown/items/food.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	tastes = list("steak" = 1, "pepper" = 1)
	name = "spiced eggs"
	desc = ""
	icon_state = "spicedeggs"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = 30 MINUTES
	eat_effect = /datum/status_effect/buff/foodbuff
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'

/datum/crafting_recipe/roguetown/cooking/spicedeggs
	name = "spiced eggs"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/friedegg = 2,
		/datum/reagent/consumable/blackpepper = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/spicedeggs
	skillcraft = 0
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/eggtoast
	icon = 'icons/roguetown/items/food.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("toast" = 1, "eggs" = 1)
	name = "eggtoast"
	desc = ""
	icon_state = "eggtoast"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = 30 MINUTES
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'

/datum/crafting_recipe/roguetown/cooking/eggtoast
	name = "eggtoast"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/friedegg = 1,
		/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/eggtoast
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/eggcheese
	icon = 'icons/roguetown/items/food.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	tastes = list("steak" = 1, "pepper" = 1)
	name = "eggcheese"
	desc = ""
	icon_state = "eggcheese"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = 30 MINUTES
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/eggcheese
	name = "eggcheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/friedegg = 2,
		/obj/item/reagent_containers/food/snacks/rogue/cheddarslice = 2
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/eggcheese

	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/dogroll
	icon = 'icons/roguetown/items/food.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	tastes = list("sausage" = 1, "bun" = 1)
	name = "dogroll"
	desc = ""
	icon_state = "hotdog"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = 30 MINUTES
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/dogroll
	name = "dogroll"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked = 1,
		/obj/item/reagent_containers/food/snacks/rogue/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/dogroll
	skillcraft = null
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/grenzeldog
	icon = 'icons/roguetown/items/food.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("sausage" = 1, "bun" = 1, "sauerkraut" = 1)
	name = "grenzel dogroll"
	desc = ""
	icon_state = "kraut_dog"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = 30 MINUTES
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/grenzeldog
	name = "grenzeldog"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/dogroll = 1,
		/obj/item/reagent_containers/food/snacks/grown/sauerkraut = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/grenzeldog
	skillcraft = null
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/sandwich
	icon = 'icons/roguetown/items/food.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	tastes = list("salami" = 1,"cheese" = 1, "bread" = 1)
	name = "sandwich"
	desc = ""
	icon_state = "sandwich"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = 30 MINUTES
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/sandwich
	name = "sandwich"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice = 2,
		/obj/item/reagent_containers/food/snacks/rogue/cheddarslice = 1,
		/obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice = 2
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/sandwich
	craftdiff = 0
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/fullroast
	name = "full roast"
	desc = "A whole roasted chicken accompanied by flavorfully seasoned mashed potatoes, mushy peas, cabbage, and radishes."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "fullroast"
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 120)
	w_class = WEIGHT_CLASS_GIGANTIC
	tastes = list("chicken" = 1, "potatoes" = 1, "peas" = 1, "cabbage" = 1, "pepper" = 1, "radish" = 1, "oregano" = 1)
	warming = 5 MINUTES
	rotprocess = 25 MINUTES
	slices_num = 6
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/roastportion
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/roastportion
	name = "portion of roast dinner"
	desc = "A portion of roasted chicken accompanied by flavorfully seasoned mashed potatoes, mushy peas, cabbage, and radishes."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "roast_slice"
	tastes = list("chicken" = 1, "potatoes" = 1, "peas" = 1, "cabbage" = 1, "pepper" = 1, "radish" = 1, "oregano" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	warming = 5 MINUTES
	rotprocess = 25 MINUTES
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/roastdinner
	name = "full roast chicken dinner"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/poultry = 1,
		/obj/item/reagent_containers/food/snacks/grown/radish = 2,
		/obj/item/reagent_containers/food/snacks/grown/peas = 2,
		/obj/item/reagent_containers/food/snacks/grown/potato = 2,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
		/obj/item/reagent_containers/food/snacks/grown/westspice = 1,
		/datum/reagent/consumable/blackpepper = 5,
		/obj/item/reagent_containers/powder/salt = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/fullroast
	craftdiff = 4
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/eggplantparm
	name = "eggplant parmigiana"
	desc = "Breaded eggplant smothered in aged cheese."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "eggplantparm"
	tastes = list("eggplant" = 1, "cheese" = 1, "breadcrumbs" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	warming = 5 MINUTES
	rotprocess = 15 MINUTES
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/eggplantparm
	name = "eggplant parmigiana"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged = 1,
		/obj/item/reagent_containers/powder/flour = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/eggplantparm
	craftdiff = 3
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/sauteedeggplant
	name = "sauteed eggplant"
	desc = "Eggplant sauteed with garlic and oil."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "sauteedeggplant"
	tastes = list("eggplant" = 1, "garlic" = 1, "oil" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/garlic = 3)
	warming = 5 MINUTES
	rotprocess = 15 MINUTES
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/sauteedeggplant
	name = "sauteed eggplant"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/datum/reagent/consumable/cooking_oil = 3
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/sauteedeggplant
	craftdiff = 2
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/etruscansalad
	name = "etruscan salad"
	desc = "Fine tomatos and fresh cheese, layered with oil and herbs."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "etruscan_salad"
	tastes = list("cheese" = 1, "tomato" = 1, "olive oil" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	rotprocess = 15 MINUTES
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/etruscansalad
	name = "etruscan salad"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/tomatoslice = 3,
		/obj/item/reagent_containers/food/snacks/rogue/cheese = 1,
		/obj/item/reagent_containers/food/snacks/grown/westspice = 1,
		/datum/reagent/consumable/cooking_oil = 3
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/etruscansalad
	craftdiff = 3
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/moussaka
	name = "moussaka"
	desc = "A layered casserole made of eggplants, veggies, and meat. Native to Shalvestine."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "moussaka"
	tastes = list("eggplant" = 1, "onion" = 1, "garlic" = 1, "meat" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 40, /datum/reagent/consumable/garlic = 8)
	warming = 5 MINUTES
	rotprocess = 25 MINUTES
	w_class = WEIGHT_CLASS_BULKY
	slices_num = 4
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/moussakaportion
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/moussakaportion
	name = "portion of moussaka"
	desc = "A slice of layered casserole made of eggplants, veggies, and meat. Native to Shalvestine."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "moussaka_slice"
	tastes = list("eggplant" = 1, "onion" = 1, "garlic" = 1, "meat" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/garlic = 2)
	warming = 5 MINUTES
	rotprocess = 25 MINUTES
	w_class = WEIGHT_CLASS_SMALL
	eat_effect = /datum/status_effect/buff/foodbuff

/datum/crafting_recipe/roguetown/cooking/moussaka
	name = "moussaka"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 2,
		/obj/item/reagent_containers/food/snacks/rogue/onionslice = 5,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/butterslice = 3
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/moussaka
	craftdiff = 3
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/stuffedtiefling
	eat_effect = /datum/status_effect/debuff/uncookedfood
	name = "hatched tiefling egg"
	desc = "A tiefling egg fruit with the top cut off and stuffing sticking out! It's raw."
	icon_state = "rawstuffedpepper"
	fried_type = null
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/stuffedtiefling/cooked
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/capsaicin = 10)

/obj/item/reagent_containers/food/snacks/rogue/stuffedtiefling/cooked
	eat_effect = /datum/status_effect/buff/foodbuff
	slices_num = 0
	name = "hatched tiefling egg"
	desc = "A tiefling egg fruit with the top cut off and stuffing sticking out! It burns your nostrils."
	icon_state = "stuffedpepper"
	warming = 10 MINUTES
	rotprocess = 25 MINUTES
	w_class = WEIGHT_CLASS_SMALL
	list_reagents = list(/datum/reagent/consumable/nutriment = 15, /datum/reagent/consumable/capsaicin = 10)

/datum/crafting_recipe/roguetown/cooking/stuffedtiefling
	name = "hatched tiefling egg"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/bellpepper = 1,
		/obj/item/reagent_containers/food/snacks/rogue/cheese = 1,
		/obj/item/reagent_containers/food/snacks/grown/westspice = 1,
		/obj/item/reagent_containers/food/snacks/rogue/onionslice = 1,
		/datum/reagent/consumable/blackpepper = 3
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/stuffedtiefling
	craftdiff = 4
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/jadepheasant
	eat_effect = /datum/status_effect/buff/foodbuff
	slices_num = 0
	name = "Glorious Jade Emperor's Golden Heaven Pheasant"
	desc = "A truly exotic and wondrous dish consisting of whole-roasted bird, pancakes from the mother country and a golden spiced sauce."
	icon_state = "ducknpancakes"
	bitesize = 5
	warming = 10 MINUTES
	rotprocess = 25 MINUTES
	w_class = WEIGHT_CLASS_BULKY
	list_reagents = list(/datum/reagent/consumable/nutriment = 40, /datum/reagent/drug/happiness = 3)

/datum/crafting_recipe/roguetown/cooking/jadeduck
	name = "golden pheasant"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/friedcrow = 1,
		/obj/item/reagent_containers/food/snacks/grown/eastspice = 1,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1,
		/obj/item/reagent_containers/food/snacks/grown/cucumber = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/jadepheasant
	craftdiff = 5
	subtype_reqs = TRUE

/obj/item/reagent_containers/food/snacks/rogue/cornedbeef
	eat_effect = /datum/status_effect/buff/foodbuff
	slices_num = 0
	name = "corned beef and grenzelkraut"
	desc = "A slice of salt-cured brisket served with grenzelkraut."
	icon_state = "cornedbeef"
	bitesize = 3
	warming = 5 MINUTES
	rotprocess = 20 MINUTES
	w_class = WEIGHT_CLASS_SMALL
	list_reagents = list(/datum/reagent/consumable/nutriment = 18)

/datum/crafting_recipe/roguetown/cooking/cornedbeef
	name = "corned beef and grenzelkraut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried = 1,
		/obj/item/reagent_containers/powder/salt = 1,
		/obj/item/reagent_containers/food/snacks/grown/sauerkraut = 1
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/cornedbeef
	craftdiff = 2
	subtype_reqs = TRUE

*/
