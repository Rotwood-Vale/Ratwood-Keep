/*                      feel free to delete if you want it cleaner. decpreciated old food not Neu food here.

/obj/item/reagent_containers/food/snacks/rogue/raisins
	name = "raisins"
	desc = "A handful of sweet, dried grape raisins."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "raisins5"
	bitesize = 5
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("dried fruit" = 1)
	foodtype = GRAIN
	eat_effect = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/raisins/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "raisins4"
	if(bitecount == 2)
		icon_state = "raisins3"
	if(bitecount == 3)
		icon_state = "raisins2"
	if(bitecount == 4)
		icon_state = "raisins1"

/obj/item/reagent_containers/food/snacks/rogue/raisins/CheckParts(list/parts_list, datum/crafting_recipe/R)
	..()
	for(var/obj/item/reagent_containers/food/snacks/M in parts_list)
		color = M.filling_color
		if(M.reagents)
			M.reagents.remove_reagent(/datum/reagent/consumable/nutriment, M.reagents.total_volume)
			M.reagents.trans_to(src, M.reagents.total_volume)
		qdel(M)


/obj/item/reagent_containers/food/snacks/rogue/cheese
	name = "cheese"
	desc = "A wheel of mozzarella cheese, adorned with a little bit of mold."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "freshcheese"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	foodtype = GRAIN
	eat_effect = null
	rotprocess = 20 MINUTES
	become_rot_type = null
	slice_path = null

/obj/item/reagent_containers/food/snacks/rogue/cheddar
	name = "wheel of cheddar"
	desc = "A golden wheel of cheddar cheese."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "cheesewheel"
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = 6
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/cheddar/aged

/obj/item/reagent_containers/food/snacks/rogue/cheddar/aged
	name = "wheel of aged cheese"
	desc = "A wheel with intricate patterns of several types of mold with a pungent aroma."
	icon_state = "blue_cheese"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge
	name = "wedge of cheese"
	desc = "An invigorating wedge of cheddar cheese."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "cheese_wedge"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = 3
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarslice
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	baitchance = 100
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 10,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5,
					/obj/item/reagent_containers/food/snacks/fish/angler = 1)

/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	name = "wedge of aged cheese"
	desc = "A dangerous piece of cheese for the brave."
	icon_state = "blue_cheese_wedge"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarslice/aged
	become_rot_type = null
	rotprocess = null
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/cheddarslice
	name = "slice of cheese"
	desc = "A soft, creamy slice of cheddar cheese."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "cheese_slice"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = null
	slice_path = null
	become_rot_type = null
	baitchance = 100
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 10,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5)

/obj/item/reagent_containers/food/snacks/rogue/cheddarslice/aged
	name = "slice of aged cheese"
	desc = "A dangerous slice of cheese."
	icon_state = "blue_cheese_slice"
	become_rot_type = null
	rotprocess = null
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/honey
	name = "honeycomb"
	desc = "Golden honey rich with the aroma of floral nectar."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "honey"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/honey = 5)
	grind_results = list(/datum/reagent/consumable/honey = 10)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("sweetness and light" = 1)
	eat_effect = null
	rotprocess = null
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/mead
	distill_amt = 20

/obj/item/reagent_containers/food/snacks/rogue/onionslice
	name = "slice of onion"
	desc = "It makes you cry thinking about it."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "onionslice"
	bitesize = 3
	rotprocess = 20 MINUTES
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tearjuice = 1)
	grind_results = list(/datum/reagent/consumable/tearjuice = 1)

/obj/item/reagent_containers/food/snacks/rogue/tomatoslice
	name = "slice of tomato"
	desc = "It makes you cry thinking about it."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "tomatoslice"
	bitesize = 3
	rotprocess = 20 MINUTES
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 1)
	grind_results = list(/datum/reagent/consumable/tomatojuice = 1)

/obj/item/reagent_containers/food/snacks/grown/sauerkraut
	name = "grenzelkraut"
	desc = "Known simply as 'sauerkraut' to the Grenzelhoftians, this smelly fermented cabbage goes good on dogrolls."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "sauerkraut"
	bitesize = 3
	rotprocess = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/sodiumchloride = 3)

/obj/item/reagent_containers/food/snacks/grown/westspice
	name = "western herbs"
	desc = "Herbs that can be found in the western hemisphere - a little less exotic, a lot more affordable, but still tasty."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "westernspice"
	bitesize = 3
	rotprocess = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)

/obj/item/reagent_containers/food/snacks/grown/eastspice
	name = "eastern spices"
	desc = "Herbs that have to be imported from the other side of the globe - expensive and flavorful."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "easternspice"
	bitesize = 3
	rotprocess = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)

/obj/item/reagent_containers/food/snacks/grown/cucumberjar
	name = "jar of pickling cucumbers"
	desc = "A jar of cucumbers that is currently pickling. Don't eat them until they're ready!"
	bitesize = 0 
	icon_state = "cucumberjar"
	rotprocess = 20 MINUTES
	become_rot_type = /obj/item/storage/belt/rogue/pickles

/obj/item/reagent_containers/food/snacks/grown/pickle
	name = "pickle"
	desc = "It has a nice crunch to it."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "pickle"
	bitesize = 3
	rotprocess = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_SMALL
*/
