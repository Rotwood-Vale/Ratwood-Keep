/obj/item/reagent_containers/food/snacks/fish
	name = "fish"
	desc = "Fresh blood stains its silvery skin. Silver-coloured scales shimmering softly.."
	icon_state = "carp"
	icon = 'icons/roguetown/misc/fish.dmi'
	verb_say = "glubs"
	verb_yell = "glubs"
	obj_flags = CAN_BE_HIT
	var/dead = TRUE
	max_integrity = 50
	sellprice = 10
	dropshrink = 0.6
	slices_num = 1
	slice_bclass = BCLASS_CHOP
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/fish
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/fish/dead
	dead = TRUE

/obj/item/reagent_containers/food/snacks/fish/Initialize()
	. = ..()
	var/rarity = pickweight(list("gold" = 1, "ultra" =40, "rare"=50, "com"=900))
	switch(rarity)
		if("gold")
			sellprice = sellprice * 10
			name = "legendary [initial(name)]"
		if("ultra")
			sellprice = sellprice * 4
			name = "ultra-rare [initial(name)]"
		if("rare")
			sellprice = sellprice * 2
			name = "rare [initial(name)]"
		if("com")
			name = "common [initial(name)]"
	if(!dead)
		START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/fish/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(!(L.mobility_flags & MOBILITY_PICKUP))
			return
	user.changeNext_move(CLICK_CD_MELEE)
	if(dead)
		..()
	else
		if(isturf(user.loc))
			src.forceMove(user.loc)
		to_chat(user, span_warning("Too slippery!"))
		return

/obj/item/reagent_containers/food/snacks/fish/process()
	if(!isturf(loc)) //no floating out of bags
		return
	if(prob(50) && !dead)
		dir = pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
		step(src, dir)

/obj/item/reagent_containers/food/snacks/fish/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/reagent_containers/food/snacks/fish/deconstruct()
	if(!dead)
		dead = TRUE
//		icon_state = "[icon_state]"
		STOP_PROCESSING(SSobj, src)
		return 1



/obj/item/reagent_containers/food/snacks/fish/carp
	name = "carp"
	desc = "A mudraking creacher of the river-depths, barely fit for food."
	faretype = FARE_IMPOVERISHED
	icon_state = "carp"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp

/obj/item/reagent_containers/food/snacks/fish/clownfish
	name = "clownfish"
	desc = "This fish brings vibrant hues to the dark world of Azure Peak."
	icon_state = "clownfish"
	faretype = FARE_NEUTRAL
	sellprice = 40
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish

/obj/item/reagent_containers/food/snacks/fish/angler
	name = "anglerfish"
	desc = "A menacing abyssal predator."
	faretype = FARE_NEUTRAL
	icon_state = "angler"
	sellprice = 15
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler

/obj/item/reagent_containers/food/snacks/fish/eel
	name = "eel"
	desc = "A sinuous eel that slithers through the dark waters."
	icon_state = "eel"
	faretype = FARE_NEUTRAL
	sellprice = 5
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel

/obj/item/reagent_containers/food/snacks/fish/sole
	name = "sole"
	desc = "An ugly flatfish, slimy and with both eyes on one side of its head. Nothing to do with feet."
	icon_state = "sole"
	faretype = FARE_NEUTRAL
	sellprice = 5
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/sole
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/sole

/obj/item/reagent_containers/food/snacks/fish/cod
	name = "cod"
	desc = "A cod, wow! Cod you hand me another piece of bait?"
	icon_state = "cod"
	faretype = FARE_NEUTRAL
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/cod
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/cod

/obj/item/reagent_containers/food/snacks/fish/lobster
	name = "lobster"
	desc = "A hard-shelled cretin, barely fit for eating."
	icon_state = "lobster"
	faretype = FARE_NEUTRAL
	sellprice = 5
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster

/obj/item/reagent_containers/food/snacks/fish/salmon
	name = "salmon"
	desc = "A lonesome, horrific creacher of the freshwaters, searching for a mate. It makes for good eating."
	icon_state = "salmon"
	faretype = FARE_NEUTRAL
	sellprice = 15
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/salmon
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/salmon

/obj/item/reagent_containers/food/snacks/fish/plaice
	name = "plaice"
	desc = "A popular flatfish for eating. Found on tables of noblefolk and peasantry alike."
	icon_state = "plaice"
	faretype = FARE_NEUTRAL
	sellprice = 15
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/plaice
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/plaice

/obj/item/reagent_containers/food/snacks/fish/mudskipper
	name = "mudskipper"
	desc = "A furtive creacher, it hides in murky waters to keep its grotesque visage secreted away."
	icon_state = "mudskipper"
	faretype = FARE_NEUTRAL
	sellprice = 5
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/mudskipper
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/mudskipper

/obj/item/reagent_containers/food/snacks/fish/bass
	name = "seabass"
	desc = "I didn't see a bass."
	icon_state = "seabass"
	faretype = FARE_NEUTRAL
	sellprice = 10
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/bass
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/bass

/obj/item/reagent_containers/food/snacks/fish/sunny
	name = "sunny"
	desc = "A pitiful beast, clinging to Astrata's light as if it would make it stronger. Little does it know that it needs faith for such miracles."
	icon_state = "sunny"
	faretype = FARE_NEUTRAL
	sellprice = 3
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/sunny
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/sunny

/obj/item/reagent_containers/food/snacks/fish/clam
	name = "clam"
	desc = "A beastye built by Abyssor in the image of a knight. Hard shell, squishy interior."
	icon_state = "clam"
	faretype = FARE_NEUTRAL
	sellprice = 15
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/clam
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/clam

/obj/item/reagent_containers/food/snacks/rogue/fryfish
	icon = 'icons/roguetown/misc/fish.dmi'
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("fish" = 1)
	name = "cooked fish"
	faretype = FARE_POOR
	desc = "A charred fish, crisped to perfection."
	icon_state = "carpcooked"
	foodtype = MEAT
	warming = 5 MINUTES
	dropshrink = 0.6

/obj/item/reagent_containers/food/snacks/rogue/fryfish/carp
	icon_state = "carpcooked"
	faretype = FARE_IMPOVERISHED
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish
	icon_state = "clownfishcooked"
	faretype = FARE_POOR
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/fryfish/angler
	icon_state = "anglercooked"
	faretype = FARE_NEUTRAL
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/fryfish/eel
	icon_state = "eelcooked"
	faretype = FARE_NEUTRAL
	plateable = TRUE
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/jelliedeel

/obj/item/reagent_containers/food/snacks/rogue/fryfish/sole
	icon_state = "solecooked"
	faretype = FARE_POOR
	plateable = TRUE
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/cod
	icon_state = "codcooked"
	faretype = FARE_NEUTRAL
	plateable = TRUE
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster
	icon_state = "lobstercooked"
	faretype = FARE_POOR
	plateable = TRUE
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/salmon
	icon_state = "salmoncooked"
	faretype = FARE_NEUTRAL
	plateable = TRUE
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/plaice
	icon_state = "plaicecooked"
	faretype = FARE_NEUTRAL
	plateable = TRUE
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/mudskipper
	icon_state = "mudskippercooked"
	faretype = FARE_POOR
	plateable = FALSE
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/bass
	icon_state = "seabasscooked"
	faretype = FARE_NEUTRAL
	plateable = TRUE
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/sunny
	icon_state = "sunnycooked"
	faretype = FARE_POOR
	plateable = TRUE
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/clam
	icon_state = "clamcooked"
	faretype = FARE_NEUTRAL
	plateable = TRUE
	
/obj/item/reagent_containers/food/snacks/rogue/dryfishfilet
	icon = 'modular/Neu_Food/icons/food.dmi'
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("bland fish" = 1)
	name = "dried fish"
	faretype = FARE_POOR
	desc = "A dried fish filet, boring and flavourless."
	icon_state = "dried_fish"
	foodtype = MEAT
	warming = 5 MINUTES
	dropshrink = 0.6
	rotprocess = null