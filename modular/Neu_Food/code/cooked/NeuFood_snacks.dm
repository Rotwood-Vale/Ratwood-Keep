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
	desc = "A slab of beastflesh, fried to a perfect medium-rare (Serve as is or add Pepper, Onion or use with salt to make a Coppiette)"
	icon_state = "frysteak"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = MEATSLAB_NUTRITION)
	rotprocess = SHELFLIFE_DECENT
	tastes = list("warm steak" = 1)

/*	.............   Grenzelbun   ................ */
/obj/item/reagent_containers/food/snacks/rogue/bun_grenz
	list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+SMALLDOUGH_NUTRITION)
	tastes = list("savory sausage" = 1, "bread" = 1)
	name = "grenzelbun"
	desc = "Originally an elven cuisine composed of mortal races flesh and bread, the classic wiener in a bun, now modified and staple food of Grenzelhoft cuisine."
	icon_state = "grenzbun"
	foodtype = GRAIN | MEAT
	warming = 5 MINUTES
	bitesize = 4
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/mealbuff

/obj/item/reagent_containers/food/snacks/rogue/bun_grenz/plated
	icon_state = "grenzbun_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
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
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = SHELFLIFE_DECENT


/*	.............   Twin fried cackleberries   ................ */
/obj/item/reagent_containers/food/snacks/rogue/friedegg/two
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_CHUNKY)
	tastes = list("fried cackleberries" = 1)
	name = "fried cackleberries"
	desc = "Double the yolks, double the fun."
	icon_state = "seggs"
	eat_effect = /datum/status_effect/buff/snackbuff


/*	.............   Frybird   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried
	eat_effect = null
	slices_num = 0
	name = "frybird"
	desc = "Poultry scorched to a perfect delicious crisp."
	icon_state = "frybird"
	fried_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_DECENT


/*	.............   Crispy bacon   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried
	eat_effect = null
	name = "fried bacon"
	desc = "A trufflepig's retirement plan."
	icon_state = "friedbacon"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_DECENT


/*	.............   Fryspider   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/spider/fried
	name = "fried spidermeat"
	desc = "A spider leg, shaved and roasted."
	icon_state = "friedspider"
	eat_effect = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	rotprocess = SHELFLIFE_DECENT


/*	.............   Sausage & Wiener   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
	eat_effect = null
	name = "sausage"
	desc = "Delicious flesh stuffed in a intestine casing."
	icon_state = "wiener"
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
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("warm cabbage" = 1)
	rotprocess = SHELFLIFE_LONG


/*	.............   Baked potato   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked
	name = "baked potatos"
	desc = "A dwarven favorite, as a meal or a game of hot potato."
	icon_state = "potato_baked"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_LONG


/*	.............   Fried onions   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried
	name = "fried onion"
	desc = "Seared onions roasted to a delicious set of rings."
	icon_state = "onion_fried"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("savoury morsel" = 1)
	rotprocess = SHELFLIFE_DECENT

/*	.............   Fried potato   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried
	name = "fried potato"
	desc = "Potato bits, well roasted."
	icon_state = "potato_fried"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("warm potato" = 1)
	rotprocess = SHELFLIFE_LONG

/* ............ Shellfish ................... */

/obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster/meal
	list_reagents = list(/datum/reagent/consumable/nutriment = MEATSLAB_NUTRITION+BUTTERSLICE_NUTRITION + 1)
	tastes = list("lobster" = 1, "butter" = 1)
	name = "lobster meal"
	desc = "Lobster is somewhat bland on it's own and doesn't pair well with many seasonings, so people have taken to smothering it in butter for extra taste instead. Lobster prepared in this way is popular among high-society types for it's exotic appearance."
	icon_state = "lobster_meal"
	icon = 'modular/Neu_Food/icons/food.dmi'
	foodtype = MEAT
	warming = 5 MINUTES
	bitesize = 5
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/mealbuff

/obj/item/reagent_containers/food/snacks/rogue/fryfish/chowder
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_GOOD)
	tastes = list("oyster chowder" = 1)
	name = "oyster chowder"
	icon_state = "chowder"
	icon = 'modular/Neu_Food/icons/food.dmi'
	foodtype = MEAT
	warming = 5 MINUTES
	bitesize = 5
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/greatmealbuff
	trash = /obj/item/reagent_containers/glass/bowl

/obj/item/reagent_containers/food/snacks/rogue/fryfish/gumbo
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_GOOD)
	tastes = list("shrimp" = 1, "cabbage and onion" = 1)
	name = "shrimp gumbo"
	icon_state = "gumbo"
	icon = 'modular/Neu_Food/icons/food.dmi'
	foodtype = MEAT
	warming = 5 MINUTES
	bitesize = 5
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/greatmealbuff
	trash = /obj/item/reagent_containers/glass/bowl

/datum/crafting_recipe/roguetown/cooking/gumbo
	name = "shrimp gumbo - (2 cooked shrimps; onion slice, caggabe slice, bowl; BEGINNER)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/fryfish/shrimp = 2,
		/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced = 1,
		/obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced = 1,
		/obj/item/reagent_containers/glass/bowl = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/fryfish/gumbo

/datum/crafting_recipe/roguetown/cooking/chowder
	name = "oyster chowder - (oyster, flour, onion slice, bowl; BEGINNER)"
	reqs = list(/obj/item/reagent_containers/food/snacks/fish/oyster = 1,
			/obj/item/reagent_containers/powder/flour = 1,
			/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced = 1,
			/obj/item/reagent_containers/glass/bowl = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/fryfish/chowder
