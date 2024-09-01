/datum/crafting_recipe/roguetown/cooking/sweetdough
	name = "sweet dough"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/food/snacks/egg = 1,
		/obj/item/reagent_containers/powder/flour/salt = 1,
		/obj/item/reagent_containers/powder/flour = 1,
		/obj/item/reagent_containers/powder/sugar = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/sweetdough
	craftdiff = 2
	subtype_reqs = FALSE


/obj/item/reagent_containers/food/snacks/rogue/sweetdough
	name = "sweet dough"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "sweetdough"
	slices_num = 4
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/uncookedfinecake
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/plaincake
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweetened dough" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood
	rotprocess = 30 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/uncookedfinecake
	name = "uncooked fine cake"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "finecake"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/finecake
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("dough" = 1,"sugar" = 1)
	foodtype = GRAIN
	slice_batch = FALSE
	rotprocess = 30 MINUTES
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/rogue/finecake
	name = "finecake"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "finecake3"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("delicate, melt in your mouth sweetness" = 1)
	foodtype = GRAIN
	bitesize = 3
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/finecake/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "finecake2"
	if(bitecount == 2)
		icon_state = "finecake1"

/obj/item/reagent_containers/food/snacks/rogue/plaincake
	name = "plain cake"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "plaincake"
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/plaincakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 40)
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("crispy sweetened dough with a sugar glaze and hints of rosewater" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 6
	rotprocess = null
	dropshrink = 0.80

/obj/item/reagent_containers/food/snacks/rogue/plaincakeslice
	name = "plain cake slice"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "plaincakeslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 7)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("crispy sweetened dough with a sugar glaze and hints of rosewater" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 3
	rotprocess = null
	dropshrink = 0.60

/datum/crafting_recipe/roguetown/cooking/uncookedapplejam
	name = "uncooked apple jam"
	reqs = list(
		/obj/item/reagent_containers/glass/beaker/jar = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 2,
		/obj/item/reagent_containers/powder/sugar = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/uncookedapplejam
	craftdiff = 2
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/uncookedapplejam
	name = "uncooked apple jam"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "uncookedapplejam"
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood
	bitesize = 3
	rotprocess = null	
	dropshrink = 0.60

/datum/crafting_recipe/roguetown/cooking/applejam
	name = "apple jam"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/food/snacks/rogue/uncookedapplejam = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/applejam
	craftdiff = 2
	subtype_reqs = FALSE
	tools = list(/obj/item/reagent_containers/glass/pot)

/obj/item/reagent_containers/food/snacks/rogue/applejam
	name = "apple jam"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "applejam"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("oversweet apple" = 1)
	foodtype = SUGAR
	bitesize = 3
	rotprocess = null
	dropshrink = 0.60
	trash = /obj/item/reagent_containers/glass/beaker/jar

/datum/crafting_recipe/roguetown/cooking/uncookedappletart
	name = "uncooked apple tart"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/sweetdough= 1,
		/obj/item/reagent_containers/food/snacks/rogue/applejam= 1)
	result = list(	/obj/item/reagent_containers/food/snacks/rogue/uncookedappletart = 1,
					/obj/item/reagent_containers/glass/beaker/jar = 1)
	craftdiff = 2
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/uncookedappletart
	name = "uncooked apple tart"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "uncookedappletart"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/appletart
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("crispy sweetened dough with a sugar glaze and hints of rosewater" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood
	bitesize = 6
	rotprocess = 30 MINUTES
	dropshrink = 0.80

/obj/item/reagent_containers/food/snacks/rogue/appletart
	name = "apple tart"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "appletart"
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/appletartslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 48)
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("A crispy dough with delicate, sweet apple filling" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 6
	dropshrink = 0.80

/obj/item/reagent_containers/food/snacks/rogue/appletartslice
	name = "apple tart slice"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "appletartslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("Soft, sweet filling, with a flaky dough" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 3
	rotprocess = null
	dropshrink = 0.60

/datum/crafting_recipe/roguetown/cooking/appletoast
	name = "apple toast"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/applejam = 1,
		/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast = 6)
	result = list(	/obj/item/reagent_containers/food/snacks/rogue/appletoast,
					/obj/item/reagent_containers/food/snacks/rogue/appletoast,
					/obj/item/reagent_containers/food/snacks/rogue/appletoast,
					/obj/item/reagent_containers/food/snacks/rogue/appletoast,
					/obj/item/reagent_containers/food/snacks/rogue/appletoast,
					/obj/item/reagent_containers/food/snacks/rogue/appletoast,
					/obj/item/reagent_containers/glass/beaker/jar)
	craftdiff = 2
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/appletoast
	name = "apple toast"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "appletoast"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("crispy toast with a sweet apple topping" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 3
	rotprocess = null

/datum/crafting_recipe/roguetown/cooking/uncookedberryjam
	name = "uncooked berry jam"
	reqs = list(
		/obj/item/reagent_containers/glass/beaker/jar = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 3,
		/obj/item/reagent_containers/powder/sugar = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/uncookedberryjam
	craftdiff = 2
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/uncookedberryjam
	name = "uncooked berry jam"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "uncookedberryjam"
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood
	bitesize = 3
	rotprocess = null	
	dropshrink = 0.60

/datum/crafting_recipe/roguetown/cooking/berryjam
	name = "berry jam"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/food/snacks/rogue/uncookedberryjam = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/berryjam
	craftdiff = 2
	subtype_reqs = FALSE
	tools = list(/obj/item/reagent_containers/glass/pot)

/obj/item/reagent_containers/food/snacks/rogue/berryjam
	name = "berry jam"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "berryjam"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweetened berry" = 1)
	foodtype = SUGAR
	bitesize = 3
	rotprocess = null
	dropshrink = 0.60
	trash = /obj/item/reagent_containers/glass/beaker/jar

/datum/crafting_recipe/roguetown/cooking/uncookedberrytart
	name = "uncooked berry tart"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/sweetdough= 1,
		/obj/item/reagent_containers/food/snacks/rogue/berryjam= 1)
	result = list(	/obj/item/reagent_containers/food/snacks/rogue/uncookedberrytart = 1,
					/obj/item/reagent_containers/glass/beaker/jar = 1)
	craftdiff = 2
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/uncookedberrytart
	name = "uncooked berry tart"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "uncookedberrytart"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/berrytart
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("crispy sweetened dough with a sugar glaze and hints of rosewater" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood
	bitesize = 6
	rotprocess = 30 MINUTES
	dropshrink = 0.80

/obj/item/reagent_containers/food/snacks/rogue/berrytart
	name = "berry tart"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "berrytart"
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/berrytartslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 48)
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("A crispy dough with sweet berry filling" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 6
	dropshrink = 0.80

/obj/item/reagent_containers/food/snacks/rogue/berrytartslice
	name = "berry tart slice"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "berrytartslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("Soft, sweet filling, with a flaky dough" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 3
	rotprocess = null
	dropshrink = 0.60

/datum/crafting_recipe/roguetown/cooking/berrytoast
	name = "berry toast"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/berryjam = 1,
		/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast = 6)
	result = list(	/obj/item/reagent_containers/food/snacks/rogue/berrytoast,
					/obj/item/reagent_containers/food/snacks/rogue/berrytoast,
					/obj/item/reagent_containers/food/snacks/rogue/berrytoast,
					/obj/item/reagent_containers/food/snacks/rogue/berrytoast,
					/obj/item/reagent_containers/food/snacks/rogue/berrytoast,
					/obj/item/reagent_containers/food/snacks/rogue/berrytoast,
					/obj/item/reagent_containers/glass/beaker/jar)
	craftdiff = 2
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/berrytoast
	name = "berry toast"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "berrytoast"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("crispy toast with a sweet berry topping" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 3
	rotprocess = null

/datum/crafting_recipe/roguetown/cooking/pumpkindough
	name = "pumpkin dough"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/sweetdough= 1,
		/obj/item/reagent_containers/food/snacks/rogue/pumpkinspice= 1)
	result = list(	/obj/item/reagent_containers/food/snacks/rogue/pumpkindough = 1)
	craftdiff = 1
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/pumpkindough
	name = "pumpkin dough"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "pumpkindough"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pumpkinbread
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("gummy, sweet, herbed dough" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood
	rotprocess = 30 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/pumpkinbread
	name = "pumpkin bread"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "pumpkinbread"
	list_reagents = list(/datum/reagent/consumable/nutriment = 48)
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/pumpkinbreadslice
	dropshrink = 0.80
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced bread" = 1)
	foodtype = SUGAR
	bitesize = 3
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/pumpkinbreadslice
	name = "pumpkin bread slice"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "pumpkinbreadslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced bread" = 1)
	foodtype = SUGAR
	bitesize = 3
	rotprocess = null
	dropshrink = 0.60

/datum/crafting_recipe/roguetown/cooking/rawpumpkinpie
	name = "raw pumpkin pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/sweetdough= 1,
		/obj/item/reagent_containers/food/snacks/grown/pumpkin = 1,
		/obj/item/reagent_containers/food/snacks/rogue/pumpkinspice= 1)
	result = list(	/obj/item/reagent_containers/food/snacks/rogue/rawpumpkinpie = 1)
	craftdiff = 1
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/rawpumpkinpie
	name = "raw pumpkin pie"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "rawpumpkinpie"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pumpkinpie
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced pumpkin filling in a doughy crust" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood
	rotprocess = 30 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/pumpkinpie
	name = "pumpkin pie"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "pumpkinpie"
	list_reagents = list(/datum/reagent/consumable/nutriment = 48)
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/pumpkinpieslice
	dropshrink = 0.80
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced pumpkin filling in a flaky crust" = 1)
	foodtype = SUGAR
	bitesize = 3
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/pumpkinpieslice
	name = "pumpkin pie slice"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "pumpkinpieslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced pumpkin filling in a flaky crust" = 1)
	foodtype = SUGAR
	bitesize = 3
	rotprocess = null
	dropshrink = 0.60

/datum/crafting_recipe/roguetown/cooking/candybase
	name = "candy base"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/powder/sugar = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/candybase
	craftdiff = 1
	subtype_reqs = FALSE
	tools = list(/obj/item/reagent_containers/glass/pot)

/obj/item/reagent_containers/food/snacks/rogue/candybase
	name = "candy base"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "candybase"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, sticky, and malleable" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/pumpkincandy
	name = "pumpkin candy"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/candybase = 1,
		/obj/item/reagent_containers/food/snacks/rogue/pumpkinspice = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/pumpkincandy
	craftdiff = 1
	subtype_reqs = FALSE
	tools = list(/obj/item/reagent_containers/glass/pot)

/obj/item/reagent_containers/food/snacks/rogue/pumpkincandy
	name = "pumpkin candy"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "pumpkincandy6"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced pumpkin candy" = 1)
	foodtype = SUGAR
	bitesize = 6
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/pumpkincandy/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "pumpkincandy5"
	if(bitecount == 2)
		icon_state = "pumpkincandy4"
	if(bitecount == 3)
		icon_state = "pumpkincandy3"
	if(bitecount == 4)
		icon_state = "pumpkincandy2"
	if(bitecount == 5)
		icon_state = "pumpkincandy1"

/datum/crafting_recipe/roguetown/cooking/applecandy
	name = "apple candy"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/candybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/applecandy
	craftdiff = 1
	subtype_reqs = FALSE
	tools = list(/obj/item/reagent_containers/glass/pot)

/obj/item/reagent_containers/food/snacks/rogue/applecandy
	name = "apple candy"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "applecandy6"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, tart apple candy" = 1)
	foodtype = SUGAR
	bitesize = 6
	rotprocess = null

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

/datum/crafting_recipe/roguetown/cooking/berrycandy
	name = "berry candy"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/candybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/berrycandy
	craftdiff = 1
	subtype_reqs = FALSE
	tools = list(/obj/item/reagent_containers/glass/pot)

/obj/item/reagent_containers/food/snacks/rogue/berrycandy
	name = "berry candy"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "berrycandy6"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, tart berry candy" = 1)
	foodtype = SUGAR
	bitesize = 6
	rotprocess = null

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

/datum/crafting_recipe/roguetown/cooking/rawcarrotcake
	name = "raw carrot cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/sweetdough= 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 3)
	result = list(	/obj/item/reagent_containers/food/snacks/rogue/rawcarrotcake = 1)
	craftdiff = 1
	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/rawcarrotcake
	name = "raw carrot cake"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "rawcarrotcake"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/carrotcake
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced carrot cake" = 1)
	foodtype = SUGAR
	eat_effect = /datum/status_effect/debuff/uncookedfood
	rotprocess = 30 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/carrotcake
	name = "carrot cake"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "carrotcake"
	list_reagents = list(/datum/reagent/consumable/nutriment = 48)
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/carrotcakeslice
	dropshrink = 0.80
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced carrot cake" = 1)
	foodtype = SUGAR
	bitesize = 3
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/carrotcakeslice
	name = "carrot cake slice"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "carrotcakeslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("sweet, spiced carrot cake" = 1)
	foodtype = SUGAR
	bitesize = 3
	rotprocess = null
	dropshrink = 0.60
