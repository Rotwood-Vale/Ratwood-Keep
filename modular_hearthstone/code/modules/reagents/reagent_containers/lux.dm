/obj/item/reagent_containers/lux
	name = "lux"
	desc = "The stuff of life and souls, retrieved from within a hopefully-willing donor. It's a bit clammy and squishy, like a half-fried egg."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "lux"
	item_state = "lux"
	possible_transfer_amounts = list()
	volume = 15
	list_reagents = list(/datum/reagent/vitae = 5)
	grind_results = list(/datum/reagent/vitae = 5)
	sellprice = 50
	light_system = MOVABLE_LIGHT
	light_power = 1
	light_range = 1

/datum/reagent/vitae
	name = "Vitae"
	description = "The extracted and processed essence of life."
	color = "#7d8e98" // rgb: 96, 165, 132
	overdose_threshold = 10
	metabolization_rate = 0.1

/datum/reagent/vitae/overdose_process(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, 0.25*REM)
	M.adjustFireLoss(0.25*REM, 0)
	..()
	. = 1

/datum/reagent/vitae/on_mob_life(mob/living/carbon/M)
	if(M.has_flaw(/datum/charflaw/addiction/junkie))
		M.sate_addiction()
	M.apply_status_effect(/datum/status_effect/buff/vitae)
	..()

/obj/item/soul_fragment
	force = 1
	name = "soul fragment"
	desc = "A fragment of a soul that never made it to the carriage, it is weightless and cold to the touch, you can hear the voice of the restless dead if you were to listen closely to it."
	icon = 'modular_hearthstone/icons/obj/items/souls.dmi'
	icon_state = "soul_floor"
	light_system = MOVABLE_LIGHT
	light_power = 1
	light_range = 1

/obj/item/soul_fragment/pickup(mob/user)
	icon_state = "soul"

/obj/item/soul_fragment/dropped(mob/user)
	icon_state = "soul_floor"

/datum/crafting_recipe/roguetown/soul_fragment_lux
	name = "lux"
	result = /obj/item/reagent_containers/lux
	reqs = list(/obj/item/soul_fragment = 6)
	verbage_simple = "bind souls into"
	verbage = "bind souls into"
	craftsound = 'sound/misc/carriage2.ogg'
	time = 200