/*	..................   Fyritius Flower   ................... */ // some sort of funni fire flowers. Dunno just moving them here for consistency.
/obj/item/reagent_containers/food/snacks/grown/fyritius
	name = "fyritius flower"
	seed = /obj/item/seeds/fyritius // if mass producing these breaks shit just comment it out
	desc = ""
	icon = 'modular_redmoon/icons/items/fyritius.dmi'
	icon_state = "fyritius"
	tastes = list("tastes like a burning coal and fire" = 1)
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin/fyritiusnectar = 5)
	dropshrink = 0.8
	rotprocess = null
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3

/obj/item/seeds/fyritius
	seed_identity = "fyritius seeds"
	plant_def_type = /datum/plant_def/fyritiusflower

/datum/plant_def/fyritiusflower
	name = "fyritius flowers"
	icon_state = "fyritius"
	icon = 'modular_redmoon/icons/items/fyritius_48.dmi'
	produce_type = /obj/item/reagent_containers/food/snacks/grown/fyritius
	produce_amount_min = 1
	produce_amount_max = 3
	maturation_time = 5 MINUTES
	water_drain_rate = 1 / (2 MINUTES)

/datum/reagent/toxin/fyritiusnectar
	name = "fyritius nectar"
	description = "oh no"
	reagent_state = LIQUID
	color = "#ffc400"
	metabolization_rate = 0.5

/datum/reagent/toxin/fyritiusnectar/on_mob_life(mob/living/carbon/M)
	if(volume > 0.49 && prob(33))
		M.add_nausea(9)
		M.adjustFireLoss(2, 0)
		M.adjust_fire_stacks(1)
		M.IgniteMob()
	return ..()
