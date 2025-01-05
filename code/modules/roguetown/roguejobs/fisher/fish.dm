/obj/item/reagent_containers/food/snacks/fish
	name = "рыба"
	desc = "Ещё видны остатки крови на е чешуе. Мягкий блеск серебристых чешуек мерцает на свету."
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
			name = "легендарная [initial(name)]"
		if("ultra")
			sellprice = sellprice * 4
			name = "крайне редкая [initial(name)]"
		if("rare")
			sellprice = sellprice * 2
			name = "редкая [initial(name)]"
		if("com")
			name = "обычная [initial(name)]"
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
		to_chat(user, span_warning("Слишком скользкая!"))
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
	name = "карп"
	desc = "Величественная рыба с чешуей, что таит в себе несказанные истории."
	icon_state = "carp"
	sellprice = 2
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp
	cooked_smell = /datum/pollutant/food/baked_carp

/obj/item/reagent_containers/food/snacks/fish/clownfish
	name = "рыба-клоун"
	desc = "Эта рыба приносит яркие краски в тёмный мир Рокхилла."
	icon_state = "clownfish"
	sellprice = 15
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish
	cooked_smell = /datum/pollutant/food/baked_clownfish

/obj/item/reagent_containers/food/snacks/fish/angler
	name = "удильщик"
	desc = "Грозный глубинный хищник."
	icon_state = "angler"
	sellprice = 10
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler
	cooked_smell = /datum/pollutant/food/baked_angler

/obj/item/reagent_containers/food/snacks/fish/eel
	name = "угорь"
	desc = "Извивающийся угорь, скользящий сквозь тёмные воды."
	icon_state = "eel"
	sellprice = 5
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel
	cooked_smell = /datum/pollutant/food/baked_eel

/obj/item/reagent_containers/food/snacks/fish/shrimp
	name = "креветка"
	desc = "Простая, как все креветки."
	icon_state = "shrimp"
	sellprice = 5
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/shrimp
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/fryfish/shrimp

/obj/item/reagent_containers/food/snacks/rogue/fryfish
	icon = 'icons/roguetown/misc/fish.dmi'
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("fish" = 1)
	name = "жареная рыба"
	desc = "Обжаренная рыба с идеально хрустящей корочкой."
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
	eat_effect = list(/datum/status_effect/buff/foodbuff, /datum/status_effect/buff/blessed)

/obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish/rare
	eat_effect = list(/datum/status_effect/buff/foodbuff, /datum/status_effect/buff/blessed)

/obj/item/reagent_containers/food/snacks/rogue/fryfish/angler/rare
	eat_effect = list(/datum/status_effect/buff/foodbuff, /datum/status_effect/buff/blessed)

/obj/item/reagent_containers/food/snacks/rogue/fryfish/eel/rare
	eat_effect = list(/datum/status_effect/buff/foodbuff, /datum/status_effect/buff/blessed)

/obj/item/reagent_containers/food/snacks/rogue/fryfish/shrimp
	icon_state = "shrimpcooked"
	name = "жареная креветка"
