/obj/item/reagent_containers/food/snacks/rogue/meat
	icon = 'icons/roguetown/items/food.dmi'
	eat_effect = /datum/status_effect/debuff/uncookedfood
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	name = "meat"
	icon_state = "meatslab"
	slice_batch = FALSE
	filling_color = "#8f433a"
	rotprocess = 20 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/meat/steak
	ingredient_size = 2
	name = "steak"
	desc = "A raw meat cutlet of muscle. Delicious!"
	icon_state = "meatcutlet"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried
	slices_num = 1
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef

/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried
	eat_effect = null
	slices_num = 0
	name = "fried steak"
	desc = "A fried piece of steak, yum."
	icon_state = "friedsteak"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 15)
	desc = ""

/obj/item/reagent_containers/food/snacks/rogue/meat/mince
	name = "minced meat"
	desc = "With an irregular and coarse texture, makes you hungrier just by looking at it."
	icon_state = "meatmince"
	ingredient_size = 2
	slice_path = null
	slices_num = 0
	filling_color = "#8a0000"

/obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef
	name = "mince"
	desc = "A beef of minced meat."
/obj/item/reagent_containers/food/snacks/rogue/meat/fatty //pork
	slices_num = 4
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/bacon


/obj/item/reagent_containers/food/snacks/rogue/meat/bacon
	name = "bacon"
	desc = "A delicious piece of raw bacon. Makes for a good breakfast."
	icon_state = "bacon"
	slice_path = null
	slices_num = 0
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried
	filling_color = "#8a0000"

/obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried
	eat_effect = null
	slices_num = 0
	name = "fried bacon"
	icon_state = "friedbacon"
	desc = "This bacon smells good. Must taste good, too."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5)

/obj/item/reagent_containers/food/snacks/rogue/meat/spider
	icon_state = "spidermeat"
	desc = "For the desperate. Or the brave."
	slices_num = 0

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry
	name = "chicken meat"
	desc = "A piece of raw chicken, absolutely wonderful."
	icon_state = "halfchicken"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked
	fried_type = null
	slices_num = 2
	ingredient_size = 4

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked
	eat_effect = null
	slices_num = 0
	name = "roast chicken"
	desc = "A delicious meal, of course!"
	icon_state = "roastchicken"
	cooked_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 20)

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet
	name = "chicken steak"
	desc = "A delicious slice of chicken."
	icon_state = "chickencutlet"
	ingredient_size = 2
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried
	slices_num = 1
	slice_bclass = BCLASS_CHOP
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried
	eat_effect = null
	slices_num = 0
	name = "fried chicken steak"
	icon_state = "friedchicken"
	desc = "Smells so wonderfully good!"
	fried_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5)

/obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry
	name = "minced chicken meat"
	desc = "Not common but.. Should be good."
	slices_num = 0
	icon_state = "meatmince"
	cooked_type = null

/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	name = "ground fish meat"
	desc = "Does not smell great. Should taste great though."
	slices_num = 0
	icon_state = "meatmince"
	cooked_type = null

/obj/item/reagent_containers/food/snacks/rogue/meat/sausage
	name = "wiener"
	desc = "A tub of raw sausage."
	icon_state = "rawsausage"
	ingredient_size = 1
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
	slices_num = 0
	cooked_type = null

/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
	eat_effect = null
	slices_num = 0
	name = "fried sausage"
	icon_state = "sausage"
	desc = "A tub of sausage fried to perfection, should make a good breakfast!"
	fried_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5)

/obj/item/reagent_containers/food/snacks/rogue/meat/salami
	eat_effect = null
	name = "salami stick"
	icon_state = "salamistick5"
	desc = "A refined kind of meal."
	fried_type = null
	slices_num = 5
	bitesize = 5
	slice_batch = FALSE
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice
	tastes = list("salted meat" = 1)
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/meat/salami/update_icon()
	if(slices_num)
		icon_state = "salamistick[slices_num]"
	else
		icon_state = "salami_slice"

/obj/item/reagent_containers/food/snacks/rogue/meat/salami/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 4
		if(bitecount == 2)
			slices_num = 3
		if(bitecount == 3)
			slices_num = 2
		if(bitecount == 4)
			changefood(slice_path, eater)


/obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice
	eat_effect = null
	slices_num = 0
	name = "salami slice"
	icon_state = "salami_slice"
	desc = "A slice of salami. Tastes great!"
	fried_type = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 1
	tastes = list("salted meat" = 1)

/obj/item/reagent_containers/food/snacks/rogue/meat/coppiette
	eat_effect = null
	name = "coppiette"
	icon_state = "jerk5"
	desc = "Dried meat sticks."
	fried_type = null
	slices_num = 0
	bitesize = 5
	slice_path = null
	tastes = list("salted meat" = 1)
	rotprocess = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)

/obj/item/reagent_containers/food/snacks/rogue/meat/coppiette/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "jerk4"
	if(bitecount == 2)
		icon_state = "jerk3"
	if(bitecount == 3)
		icon_state = "jerk2"
	if(bitecount == 4)
		icon_state = "jerk1"

/obj/item/reagent_containers/food/snacks/rogue/saltfish
	eat_effect = null
	icon = 'icons/roguetown/misc/fish.dmi'
	name = "saltfish"
	icon_state = ""
	desc = "Dried, salty fish. Lasts much longer."
	fried_type = null
	slices_num = 0
	bitesize = 4
	slice_path = null
	tastes = list("salted meat" = 1)
	rotprocess = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	dropshrink = 0.6

/obj/item/reagent_containers/food/snacks/rogue/saltfish/CheckParts(list/parts_list, datum/crafting_recipe/R)
	for(var/obj/item/reagent_containers/food/snacks/M in parts_list)
		icon_state = "[initial(M.icon_state)]dried"
		qdel(M)

/obj/item/reagent_containers/food/snacks/rogue/meat/crabmeat
	name = "crab meat"
	desc = "A chunk of raw crab meat, absolutely wonderful."
	icon_state = "crabmeatraw"
	slice_path = null
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/crabmeat/fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/crabmeat/fried
	slices_num = null
	ingredient_size = 1

/obj/item/reagent_containers/food/snacks/rogue/meat/crabmeat/fried
	eat_effect = null
	slices_num = 0
	name = "fried crabmeat"
	desc = "A fried piece of crabmeat, yum."
	icon_state = "crabmeat"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5)
	desc = ""