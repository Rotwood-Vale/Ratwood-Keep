/obj/item/reagent_containers/food/snacks/potatofried
	name = "roasted potato"
	desc = "A couple of fried potato slices cut in wedges."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "potatoc"
	bitesize = 3
	tastes = list("fried potato" = 1)
	filling_color = "##bdbc55"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 8)
	desc = ""

/obj/item/reagent_containers/food/snacks/carrotfried
	name = "roasted carrot"
	desc = "A piece of roasted carrot, the edges have been cut off."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "carrotc"
	bitesize = 3
	tastes = list("fried carrot" = 1)
	filling_color = "#db7516"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 8)
	desc = ""

/obj/item/reagent_containers/food/snacks/leekfried
	eat_effect = null
	slices_num = 0
	name = "grilled leek"
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "leekc"
	desc = "A piece of leek, cut in half and grilled to a medium rare."
	bitesize = 3
	fried_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 8)