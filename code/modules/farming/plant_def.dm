/datum/plant_def
	abstract_type = /datum/plant_def
	/// Name of the plant
	var/name = "Some plant"
	/// Description of the plant
	var/desc = "Sure is a plant."
	var/icon
	var/icon_state
	/// Loot the plant will yield for uprooting it
	var/list/uproot_loot
	/// Time in ticks the plant will require to mature, before starting to make produce
	var/maturation_time = 6 MINUTES
	/// Time in ticks the plant will require to make produce
	var/produce_time = 3 MINUTES
	/// Typepath of produce to make on harvest
	var/produce_type
	/// Amount of produce to make on harvest
	var/produce_amount = 3
	/// How much nutrition will the plant require to mature fully
	var/maturation_nutrition = 30
	/// How much nutrition will the plant require to make produce
	var/produce_nutrition = 20
	/// If not perennial, the plant will uproot itself upon harvesting first produce
	var/perennial = FALSE
	/// Whether the plant is immune to weeds and will naturally deal with them
	var/weed_immune = FALSE
	/// The rate at which the plant drains water, if zero then it'll be able to live without water
	var/water_drain_rate = 2 / (1 MINUTES)

/datum/plant_def/shroom
	name = "shroom spores"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "shroom"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/shroom
	produce_amount = 3
	uproot_loot = list(/obj/item/natural/fibers, /obj/item/natural/fibers)
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 5 MINUTES
	produce_time = 2 MINUTES


/datum/plant_def/wheat
	name = "wheat stalks"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "wheat"
	produce_type = /obj/item/natural/chaff/wheat
	produce_amount = 4
	uproot_loot = list(/obj/item/natural/fibers, /obj/item/natural/fibers)
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 5 MINUTES
	produce_time = 2 MINUTES

/datum/plant_def/oat
	name = "oat stalks"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "oat"
	produce_type = /obj/item/natural/chaff/oat
	produce_amount = 4
	uproot_loot = list(/obj/item/natural/fibers, /obj/item/natural/fibers)
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 5 MINUTES
	produce_time = 2 MINUTES

/datum/plant_def/apple
	name = "apple tree"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "apple"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/apple
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount = 3
	maturation_nutrition = 60
	produce_nutrition =  30
	maturation_time = 6 MINUTES
	produce_time = 3 MINUTES

/datum/plant_def/pipeweed
	name = "westleach leaf"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "tobacco"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed

/datum/plant_def/sweetleaf
	name = "swampweed"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "weed"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf

/datum/plant_def/berry
	name = "berry bush"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/berries/rogue
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount = 3
	maturation_nutrition = 60
	produce_nutrition =  30
	maturation_time = 6 MINUTES
	produce_time = 3 MINUTES

/datum/plant_def/berry_poison
	name = "berry bush"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE

/datum/plant_def/potato
	name = "potato plant"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "potato"
	produce_amount = 3
	maturation_nutrition = 60
	produce_nutrition =  30
	maturation_time = 6 MINUTES
	produce_time = 3 MINUTES
	produce_type = /obj/item/reagent_containers/food/snacks/grown/rogue/potato
	
/datum/plant_def/sugarcane
	name = "sugarcane"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "sugarcane"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/sugarcane
	produce_amount = 4
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 5 MINUTES
	produce_time = 2 MINUTES

/datum/plant_def/pumpkin
	name = "pumpkin"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "pumpkin"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/pumpkin
	produce_amount = 3
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 6 MINUTES
	produce_time = 2 MINUTES
	weed_immune = FALSE

/datum/plant_def/carrot
	name = "carrot"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "carrot"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/carrot
	produce_amount = 4
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 4 MINUTES
	produce_time = 2 MINUTES
	weed_immune = FALSE

/datum/plant_def/garlic
	name = "garlic"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "garlic"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/garlic
	produce_amount = 4
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 5 MINUTES
	produce_time = 2 MINUTES
	weed_immune = FALSE

/datum/plant_def/onion
	name = "onion"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "onion"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/onion/rogue
	produce_amount = 4
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 5 MINUTES
	produce_time = 2 MINUTES
	weed_immune = FALSE

/datum/plant_def/cabbage
	name = "cabbage"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "cabbage"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/cabbage/rogue
	produce_amount = 4
	maturation_nutrition = 30
	produce_nutrition = 20
	maturation_time = 5 MINUTES
	produce_time = 2 MINUTES
	weed_immune = FALSE
