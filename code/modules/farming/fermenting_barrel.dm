/obj/structure/fermenting_barrel
	name = "barrel"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "barrel1"
	density = TRUE
	opacity = FALSE
	anchored = FALSE
	pressure_resistance = 2 * ONE_ATMOSPHERE
	max_integrity = 300
	drag_slowdown = 2
	var/open = FALSE
	var/speed_multiplier = 1 //How fast it distills. Defaults to 100% (1.0). Lower is better.
	metalizer_result = /obj/item/reagent_containers/glass/bucket/pot

/obj/structure/fermenting_barrel/Initialize()
	// Bluespace beakers, but without the portability or efficiency in circuits.
	create_reagents(900, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	icon_state = "barrel[rand(1,3)]"
	. = ..()

/obj/structure/fermenting_barrel/Destroy()
	chem_splash(loc, 2, list(reagents))
	return ..()

/obj/structure/fermenting_barrel/examine(mob/user)
	. = ..()
//	. += span_notice("It is currently [open?"open, letting you pour liquids in.":"closed, letting you draw liquids."]")

/obj/structure/fermenting_barrel/proc/makeWine(obj/item/reagent_containers/food/snacks/I)
	if(I.reagents)
		I.reagents.remove_reagent(/datum/reagent/consumable/nutriment, I.reagents.total_volume)
		I.reagents.trans_to(src, I.reagents.total_volume)
	if(I.distill_reagent)
		reagents.add_reagent(I.distill_reagent, I.distill_amt)
	qdel(I)
	playsound(src, "bubbles", 100, TRUE)

/obj/structure/fermenting_barrel/attackby(obj/item/reagent_containers/food/snacks/I, mob/user, params)
	if(istype(I))
		if(!I.can_distill)
			to_chat(user, span_warning("I can't ferment this into anything."))
			return TRUE
		else if(!user.transferItemToLoc(I,src))
			to_chat(user, span_warning("[I] is stuck to my hand!"))
			return TRUE
		to_chat(user, span_info("I place [I] into [src]."))
		addtimer(CALLBACK(src, PROC_REF(makeWine), I), rand(1 MINUTES, 3 MINUTES))
		return TRUE
	..()

//obj/structure/fermenting_barrel/attack_hand(mob/user)
//	open = !open
//	if(open)
//		ENABLE_BITFIELD(reagents.flags, DRAINABLE)
//		ENABLE_BITFIELD(reagents.flags, REFILLABLE)
//		to_chat(user, span_notice("I open [src]."))
//	else
//		DISABLE_BITFIELD(reagents.flags, DRAINABLE)
//		DISABLE_BITFIELD(reagents.flags, REFILLABLE)
//		to_chat(user, span_notice("I close [src]."))
//	update_icon()

/datum/crafting_recipe/fermenting_barrel
	name = "Wooden Barrel"
	result = /obj/structure/fermenting_barrel
	reqs = list(/obj/item/stack/sheet/mineral/wood = 30)
	time = 50
	category = CAT_NONE

/obj/structure/fermenting_barrel/update_icon()
	if(open)
		icon_state = "barrel_open"
	else
		icon_state = "barrel"
	if(broken)
		icon_state = "barrel_destroyed"

/obj/structure/fermenting_barrel/random/water/Initialize()
	. = ..()
	icon_state = "barrel3"
	reagents.add_reagent(/datum/reagent/water, rand(0,900))

/obj/structure/fermenting_barrel/random/beer/Initialize()
	. = ..()
	icon_state = "barrel2"
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, rand(0,900))

/obj/structure/fermenting_barrel/random/wine/Initialize()
	. = ..()
	icon_state = "barrel1"
	reagents.add_reagent(/datum/reagent/consumable/ethanol/wine, rand(0,900))

/obj/structure/fermenting_barrel/water/Initialize()
	. = ..()
	icon_state = "barrel3"
	reagents.add_reagent(/datum/reagent/water,900)

/obj/structure/fermenting_barrel/beer/Initialize()
	. = ..()
	icon_state = "barrel2"
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer,900)

/obj/structure/fermenting_barrel/wine/Initialize()
	. = ..()
	icon_state = "barrel1"
	reagents.add_reagent(/datum/reagent/consumable/ethanol/wine,900)	

/obj/item/roguebin/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,500)
	update_icon()

/obj/item/roguebin/water/gross/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water/gross,500)
	update_icon()
