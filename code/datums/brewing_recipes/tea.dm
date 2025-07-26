/datum/brewing_recipe/golden_calendula_tea
	name = "Golden Calendula Tea"
	category = "Tea"
	bottle_name = "golden calendula tea"
	bottle_desc = "A bottle of locally-brewed golden calendula tea. Has a herbal flavor."
	reagent_to_brew = /datum/reagent/consumable/golden_calendula_tea
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/alch/calendula = 1, /obj/item/alch/mentha = 1, /obj/item/reagent_containers/food/snacks/rogue/honey/spider = 1)
	brewed_amount = 6
	brew_time = 4 MINUTES
	sell_value = 60
	heat_required = 320

/datum/brewing_recipe/soothing_valerian_tea
	name = "Soothing Valerian Tea"
	category = "Tea"
	bottle_name = "soothing valerian tea"
	bottle_desc = "A bottle of locally-brewed soothing valerian tea. Has a herbal flavor."
	reagent_to_brew = /datum/reagent/consumable/soothing_valerian_tea
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/alch/valeriana = 1, /obj/item/alch/hypericum = 1, /obj/item/reagent_containers/food/snacks/rogue/honey/spider = 1)
	brewed_amount = 6
	brew_time = 4 MINUTES
	sell_value = 60
	heat_required = 310
