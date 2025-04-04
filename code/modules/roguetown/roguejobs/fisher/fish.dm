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
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	eat_effect = /datum/status_effect/debuff/uncookedfood
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/fish/dead
	dead = TRUE

/obj/item/reagent_containers/food/snacks/fish/Initialize()
	. = ..()
	var/rarity = pickweight(list("gold" = 1, "ultra" =40, "rare"=50, "com"=900))
	icon_state = "[initial(icon_state)][rarity]"
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
	desc = "A majestic scaled fish bearing untold tales."
	icon_state = "carp"
	sellprice = 2
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp
	cooked_smell = /datum/pollutant/food/baked_carp

/obj/item/reagent_containers/food/snacks/fish/clownfish
	name = "clownfish"
	desc = "This fish brings vibrant hues to the dark world of Rockhill."
	icon_state = "clownfish"
	sellprice = 15
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish
	cooked_smell = /datum/pollutant/food/baked_clownfish

/obj/item/reagent_containers/food/snacks/fish/angler
	name = "anglerfish"
	desc = "A menacing abyssal predator."
	icon_state = "angler"
	sellprice = 10
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler
	cooked_smell = /datum/pollutant/food/baked_angler

/obj/item/reagent_containers/food/snacks/fish/eel
	name = "eel"
	desc = "A sinuous eel that slithers through the dark waters."
	icon_state = "eel"
	sellprice = 5
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel
	cooked_smell = /datum/pollutant/food/baked_eel

/obj/item/reagent_containers/food/snacks/fish/shrimp
	name = "shrimp"
	desc = "A tiny shellfish, little bigger than your thumb. Often nicknamed butterflies of the sea, they taste great in gumbo when mixed with some cabbage and onion."
	icon_state = "shrimp"
	sellprice = 5
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/shrimp
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/shrimp

/obj/item/reagent_containers/food/snacks/fish/oyster
	name = "oyster"
	desc = "A stubborn shellfish that MIGHT hide a prize within, they taste great in chowder, mixed with some onion and powder on a bowl."
	icon_state = "oyster"
	sellprice = 5
	var/closed
	var/obj/item/pearl
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/shellfish
	trash = /obj/item/oystershell

/obj/item/reagent_containers/food/snacks/fish/oyster/Initialize()
	. = ..()
	var/pearl_weight
	switch(name) //checks the rarity of the oyster via the name
		if("legendary oyster")
			pearl_weight = pickweight(list("bpearl" = 200, "pearl" =15, "nopearl"=15)) //specific weights should be modified due to balance later
		if("ultra-rare oyster")
			pearl_weight = pickweight(list("bpearl" = 60, "pearl" =120, "nopearl"=35))
		if("rare oyster")
			pearl_weight = pickweight(list("bpearl" = 40, "pearl" =80, "nopearl"=150))
		if("common oyster")
			pearl_weight = pickweight(list("bpearl" = 10, "pearl" =40, "nopearl"=200))
	switch(pearl_weight)
		if("nopearl")
			pearl = null
		if("pearl")
			pearl = new /obj/item/pearl(src)
		if("bpearl")
			pearl = new /obj/item/pearl/black(src)
	closed = TRUE

/obj/item/reagent_containers/food/snacks/fish/oyster/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/rogueweapon/huntingknife))
		if(closed)
			user.visible_message("<span class='notice'>[user] opens the oyster with the knife.</span>")
			closed = FALSE
			icon_state = "[icon_state]_open"
			update_icon()
		else
			if(slice(src, user))
				new /obj/item/oystershell(user.loc)
				new /obj/item/oystershell(user.loc)
	else
		. = ..()
	
/obj/item/reagent_containers/food/snacks/fish/oyster/attack_right(mob/user)
	if(user.get_active_held_item())
		return
	else
		if(pearl)
			user.put_in_hands(pearl)
			pearl = null
			update_icon()
	. = ..()

/obj/item/reagent_containers/food/snacks/fish/oyster/update_icon()
	cut_overlays()
	if(!closed && pearl)
		var/mutable_appearance/pearl = mutable_appearance(icon, "pearl")
		add_overlay(pearl)

/obj/item/oystershell
	name = "oyster shell"
	icon = 'icons/roguetown/misc/fish.dmi'
	icon_state = "oyster_shell"
	desc = ""
	dropshrink = 0.5
	sellprice = 3

/obj/item/reagent_containers/food/snacks/fish/crab
	name = "crab"
	desc = "A defensive shellfish that's a real hassle to crack open, they taste great when made into cakes with dough."
	icon_state = "crab"
	sellprice = 10
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/crab
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/crab
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/shellfish

/obj/item/reagent_containers/food/snacks/fish/lobster
	name = "lobster"
	desc = "An exotic-looking shellfish with entirely too many legs, the best meat is at it's tail."
	icon_state = "lobster"
	sellprice = 15
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/shellfish

/obj/item/reagent_containers/food/snacks/rogue/fryfish
	icon = 'icons/roguetown/misc/fish.dmi'
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("fish" = 1)
	name = "cooked fish"
	desc = "A charred fish, crisped to perfection."
	icon_state = "carpcooked"
	foodtype = MEAT
	warming = 5 MINUTES
	dropshrink = 0.6

/obj/item/reagent_containers/food/snacks/rogue/fryfish/carp
	icon_state = "carpcooked"

/obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish
	icon_state = "clownfishcooked"

/obj/item/reagent_containers/food/snacks/rogue/fryfish/angler
	icon_state = "anglercooked"

/obj/item/reagent_containers/food/snacks/rogue/fryfish/eel
	icon_state = "eelcooked"

/obj/item/reagent_containers/food/snacks/rogue/fryfish/carp/rare
	eat_effect = /datum/status_effect/buff/greatsnackbuff
	extra_eat_effect = /datum/status_effect/buff/blessed

/obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish/rare
	eat_effect = /datum/status_effect/buff/greatsnackbuff
	extra_eat_effect = /datum/status_effect/buff/blessed

/obj/item/reagent_containers/food/snacks/rogue/fryfish/angler/rare
	eat_effect = /datum/status_effect/buff/greatsnackbuff
	extra_eat_effect = /datum/status_effect/buff/blessed
/obj/item/reagent_containers/food/snacks/rogue/fryfish/eel/rare
	eat_effect = /datum/status_effect/buff/greatsnackbuff
	extra_eat_effect = /datum/status_effect/buff/blessed

/obj/item/reagent_containers/food/snacks/rogue/fryfish/shrimp
	icon_state = "shrimpcooked"
	name = "cooked shrimp"
	tastes = list("shrimp" = 1)

/obj/item/reagent_containers/food/snacks/rogue/fryfish/crab
	icon_state = "crabcooked"
	name = "cooked crab"
	tastes = list("shellfish" = 1)
	
/obj/item/reagent_containers/food/snacks/rogue/fryfish/lobster
	icon_state = "lobstercooked"
	name = "cooked lobster"
	tastes = list("shellfish" = 1)

