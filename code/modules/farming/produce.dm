/obj/item/reagent_containers/food/snacks/grown
	icon = 'icons/roguetown/items/produce.dmi'
	dried_type = null
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	var/can_distill = FALSE //If FALSE, this object cannot be distilled into an alcohol.
	var/distill_reagent //If NULL and this object can be distilled, it uses a generic fruit_wine reagent and adjusts its variables.
	var/distill_amt = 12
	var/list/pipe_reagents = list()

/obj/item/reagent_containers/food/snacks/grown/wheat

/obj/item/reagent_containers/food/snacks/grown/oat

/obj/item/reagent_containers/food/snacks/grown/apple

/obj/item/reagent_containers/food/snacks/grown/berries/rogue

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison

/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry
