/obj/item/reagent_containers/food/snacks/grown
	icon = 'icons/roguetown/items/produce.dmi'
	dried_type = null
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	var/can_distill = FALSE //If FALSE, this object cannot be distilled into an alcohol.
	var/distill_reagent //If NULL and this object can be distilled, it uses a generic fruit_wine reagent and adjusts its variables.
	var/distill_amt = 12
	var/list/pipe_reagents = list()
	var/seed
	var/bitesize_mod = 0


/obj/item/reagent_containers/food/snacks/grown/Initialize(mapload)
	. = ..()
	if(!tastes)
		tastes = list("[name]" = 1)
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

/obj/item/reagent_containers/food/snacks/grown/attackby(obj/item/weapon, mob/user, params)
	if(weapon && isturf(loc))
		var/turf/location = get_turf(src)
		if(seed && (user.used_intent.blade_class == BCLASS_BLUNT) && (!user.used_intent.noaa))
			playsound(src,'sound/items/seedextract.ogg', 100, FALSE)
			if(prob(5))
				user.visible_message(span_warning("[user] fails to extract the seeds."))
				qdel(src)
				return
			user.visible_message(span_info("[user] extracts the seeds."))
			new seed(location)
			if(prob(90))
				new seed(location)
			if(prob(23))
				new seed(location)
			if(prob(6))
				new seed(location)
			qdel(src)
			return
	return ..()


/obj/item/reagent_containers/food/snacks/grown/wheat
	seed = /obj/item/seeds/wheat
	name = "wheat grain"
	desc = ""
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "wheat"
	gender = PLURAL
	filling_color = "#F0E68C"
	bitesize_mod = 2
	foodtype = GRAIN
	tastes = list("wheat" = 1)
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer
	distill_amt = 24
	grind_results = list(/datum/reagent/floure = 10)

/obj/item/reagent_containers/food/snacks/grown/oat
	seed = /obj/item/seeds/wheat/oat
	name = "oat grain"
	desc = ""
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "oat"
	gender = PLURAL
	filling_color = "#556B2F"
	bitesize_mod = 2
	foodtype = GRAIN
	tastes = list("oat" = 1)
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/ale
	distill_amt = 12
	grind_results = list(/datum/reagent/floure = 10)

/obj/item/reagent_containers/food/snacks/grown/apple
	seed = /obj/item/seeds/apple
	name = "apple"
	desc = ""
	icon_state = "apple"
	filling_color = "#FF4500"
	bitesize = 3
	foodtype = FRUIT
	tastes = list("apple" = 1)
	trash = /obj/item/trash/applecore
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	slot_flags = ITEM_SLOT_HEAD
	worn_x_dimension = 64
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	worn_y_dimension = 64
	rotprocess = 20 MINUTES
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer/cider
	var/equippedloc = null
	var/list/bitten_names = list()

/obj/item/reagent_containers/food/snacks/grown/apple/On_Consume(mob/living/eater)
	..()
	if(ishuman(eater))
		var/mob/living/carbon/human/H = eater
		if(!(H.real_name in bitten_names))
			bitten_names += H.real_name

/obj/item/reagent_containers/food/snacks/grown/apple/blockproj(mob/living/carbon/human/H)
	testing("APPLEHITBEGIN")
	if(prob(98))
		H.visible_message(span_notice("[H] is saved by the apple!"))
		H.dropItemToGround(H.head)
		return 1
	else
		H.dropItemToGround(H.head)
		return 0

/obj/item/reagent_containers/food/snacks/grown/apple/equipped(mob/M)
	..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.head == src)
			testing("equipped applz")
			equippedloc = H.loc
			START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/grown/apple/process()
	. = ..()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.head == src)
			if(equippedloc != H.loc)
				H.dropItemToGround(H.head)

/obj/item/reagent_containers/food/snacks/grown/berries/rogue
	seed = /obj/item/seeds/berryrogue
	name = "jacksberries"
	desc = ""
	icon_state = "berries"
	tastes = list("berry" = 1)
	bitesize = 5
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	dropshrink = 0.75
	var/color_index = "good"
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer/wine
	rotprocess = 15 MINUTES

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/Initialize()
	if(GLOB.berrycolors[color_index])
		filling_color = GLOB.berrycolors[color_index]
	else
		var/newcolor = pick(BERRYCOLORS)
		if(newcolor in GLOB.berrycolors)
			GLOB.berrycolors[color_index] = pick(BERRYCOLORS)
		else
			GLOB.berrycolors[color_index] = newcolor
		filling_color = GLOB.berrycolors[color_index]
	update_icon()
	..()

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/On_Consume(mob/living/eater)
	..()
	update_icon()

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/update_icon()
	cut_overlays()
	var/used_state = "berriesc5"
	if(bitecount == 1)
		used_state = "berriesc4"
	if(bitecount == 2)
		used_state = "berriesc3"
	if(bitecount == 3)
		used_state = "berriesc2"
	if(bitecount == 4)
		used_state = "berriesc1"
	var/image/item_overlay = image(used_state)
	item_overlay.color = filling_color
	add_overlay(item_overlay)

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison
	seed = /obj/item/seeds/berryrogue/poison
	icon_state = "berries"
	tastes = list("berry" = 1)
	list_reagents = list(/datum/reagent/berrypoison = 5, /datum/reagent/consumable/nutriment = 3)
	grind_results = list(/datum/reagent/berrypoison = 5)
	color_index = "bad"

/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf
	seed = /obj/item/seeds/sweetleaf
	name = "swampweed"
	desc = "A 'foggy' pipe weed."
	icon_state = "sweetleaf"
	filling_color = "#008000"
	bitesize_mod = 1
	foodtype = VEGETABLES
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 5)
	tastes = list("sweet" = 1,"bitterness" = 1)
	eat_effect = /datum/status_effect/debuff/badmeal
	rotprocess = 15 MINUTES

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed
	seed = /obj/item/seeds/pipeweed
	name = "westleach leaf"
	desc = "A generic kind of pipe weed."
	icon_state = "pipeweed"
	filling_color = "#008000"
	bitesize_mod = 1
	foodtype = VEGETABLES
	tastes = list("sweet" = 1,"bitterness" = 1)
	list_reagents = list(/datum/reagent/drug/nicotine = 2, /datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 5)
	grind_results = list(/datum/reagent/drug/nicotine = 5)
	eat_effect = /datum/status_effect/debuff/badmeal
	rotprocess = 15 MINUTES

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry
	seed = null
	name = "westleach leaf"
	desc = "A dried leaf."
	icon_state = "pipeweedd"
	dry = TRUE
	pipe_reagents = list(/datum/reagent/drug/nicotine = 30)
	eat_effect = /datum/status_effect/debuff/badmeal
	list_reagents = list(/datum/reagent/drug/nicotine = 5, /datum/reagent/consumable/nutriment = 1)
	grind_results = list(/datum/reagent/drug/nicotine = 10)

/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry
	seed = null
	name = "swampweed"
	desc = ""
	icon_state = "sweetleafd"
	dry = TRUE
	pipe_reagents = list(/datum/reagent/drug/space_drugs = 30)
	list_reagents = list(/datum/reagent/drug/space_drugs = 2,/datum/reagent/consumable/nutriment = 1)
	grind_results = list(/datum/reagent/drug/space_drugs = 5)
	eat_effect = /datum/status_effect/debuff/badmeal

/obj/item/reagent_containers/food/snacks/grown/carrot
	seed = /obj/item/seeds/carrot
	name = "carrot"
	desc = "A carrot is a root vegetable known for its vibrant orange color, although it can also be found in purple, red, yellow, and white varieties. It has a crisp texture and a sweet, slightly earthy flavor. The dirtier the better"
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "carrot"
	gender = PLURAL
	filling_color = "#f55b0f"
	bitesize_mod = 5
	fried_type = /obj/item/reagent_containers/food/snacks/carrotfried
	cooked_type = /obj/item/reagent_containers/food/snacks/carrotfried
	foodtype = VEGETABLES
	tastes = list("carrot" = 1)
//	can_distill = TRUE//
//	distill_reagent = /datum/reagent/consumable/ethanol/spirit//
//	distill_amt = 24//
//	grind_results = list(/datum/reagent/grated_carrot = 10)//

/obj/item/reagent_containers/food/snacks/grown/beet
	seed = /obj/item/seeds/beetroot
	name = "beet"
	desc = "A versatile root vegetable known for its vibrant, deep red or golden roots and green, leafy tops. The root has a sweet, earthy flavor and can be roasted, boiled, or eaten raw"
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "beet"
	gender = PLURAL
	filling_color = "#8a1151"
	bitesize_mod = 4
	foodtype = VEGETABLES
	tastes = list("beet" = 1)

/obj/item/reagent_containers/food/snacks/grown/cabbage
	seed = /obj/item/seeds/carrot
	name = "carrot"
	desc = "A leafy vegetable known for its dense, round head of crisp, green or purple leaves. It grows in a compact, rosette shape and is a staple in many cuisines around the world."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "cabbage"
	gender = PLURAL
	filling_color = "#8ae346"
	bitesize_mod = 6
	foodtype = VEGETABLES

	tastes = list("cabbage" = 1)

/obj/item/reagent_containers/food/snacks/grown/leek
	seed = /obj/item/seeds/leek
	name = "leek"
	desc = "A leafy vegetable known for its dense, round head of crisp, green or purple leaves. It grows in a compact, rosette shape and is a staple in many cuisines around the world."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "leek"
	gender = PLURAL
	filling_color = "#97de73"
	bitesize_mod = 4
	fried_type = /obj/item/reagent_containers/food/snacks/leekfried
	cooked_type = /obj/item/reagent_containers/food/snacks/leekfried
	foodtype = VEGETABLES
	tastes = list("leek" = 1)

/obj/item/reagent_containers/food/snacks/grown/potato
	seed = /obj/item/seeds/potato
	name = "potato"
	desc = "A hearty tuber-producing plant known for its starchy, edible underground bulbs. It features broad, green leaves and small white or purple flowers. Potatoes are a staple food, prized for their versatility and nutritional value, and can be prepared in numerous ways, including baking, boiling, and frying."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "potato"
	gender = PLURAL
	filling_color = "#f2f18f"
	bitesize_mod = 4
	cooked_type = /obj/item/reagent_containers/food/snacks/potatofried
	fried_type = /obj/item/reagent_containers/food/snacks/potatofried
	foodtype = VEGETABLES
	tastes = list("potato" = 1)
//	can_distill = TRUE//
//	distill_reagent = /datum/reagent/consumable/ethanol/vodka//
//	distill_amt = 24//
//	grind_results = list(/datum/reagent/grated_potato = 10)//

/obj/item/reagent_containers/food/snacks/grown/rice
	seed = /obj/item/seeds/rice
	name = "rice"
	desc = "Rice is a staple grain cultivated in flooded fields known as paddies. It comes in various types, including white, brown, and jasmine, each with distinct flavors and textures."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "rice"
	gender = PLURAL
	filling_color = "#e6e5da"
	bitesize_mod = 2
	foodtype = GRAIN
	tastes = list("rice" = 1)
//	can_distill = TRUE//
//	distill_reagent = /datum/reagent/consumable/ethanol/sake//
//	distill_amt = 24//
//	grind_results = list(/datum/reagent/rice_flour = 10)//

///obj/item/reagent_containers/food/snacks/grown/potato
//	icon = 'icons/roguetown/items/produce.dmi'
//	eat_effect = /datum/status_effect/debuff/uncookedfood
//	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
//	name = "potato"
//	icon_state = "potato"
//	slice_batch = FALSE
//	filling_color = "#8f433a"
//	rotprocess = 60 MINUTES