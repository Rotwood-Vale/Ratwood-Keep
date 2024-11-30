/*
/obj/item/reagent_containers/food/snacks/rogue/pie
	name = "pie"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "pieuncooked"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("pie" = 1)
	filling_color = "#FFFFFF"
	foodtype = GRAIN | DAIRY | SUGAR
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked
	slices_num = 0
	bitesize = 5
	var/stunning = FALSE
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked
	icon_state = "pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/pieslice
	slices_num = 6
	slice_batch = TRUE
	warming = 10 MINUTES
	eat_effect = null

/obj/item/reagent_containers/food/snacks/rogue/pie/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if we're not being caught
		splat(hit_atom)

/obj/item/reagent_containers/food/snacks/rogue/pie/proc/splat(atom/movable/hit_atom)
	if(isliving(loc)) //someone caught us!
		return
	var/turf/T = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/food/pie_smudge(T)
	if(reagents && reagents.total_volume)
		reagents.reaction(hit_atom, TOUCH)
	if(isliving(hit_atom))
		var/mob/living/L = hit_atom
		if(stunning)
			L.Paralyze(20) //splat!
		L.adjust_blurriness(1)
		L.visible_message(span_warning("[L] is hit by [src]!"), span_danger("I'm hit by [src]!"))
	if(is_type_in_typecache(hit_atom, GLOB.creamable))
		hit_atom.AddComponent(/datum/component/creamed, src)
	qdel(src)



/obj/item/reagent_containers/food/snacks/rogue/pie/CheckParts(list/parts_list)
	..()
	for(var/obj/item/reagent_containers/food/snacks/M in parts_list)
		filling_color = M.filling_color
		update_snack_overlays(M)
		color = M.filling_color
		if(M.reagents)
			M.reagents.remove_reagent(/datum/reagent/consumable/nutriment, M.reagents.total_volume)
			M.reagents.trans_to(src, M.reagents.total_volume)
		qdel(M)

/obj/item/reagent_containers/food/snacks/rogue/pieslice
	icon = 'icons/roguetown/items/food.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("pie" = 1)
	name = "pie slice"
	desc = ""
	icon_state = "slice"
	filling_color = "#FFFFFF"
	foodtype = GRAIN | DAIRY | SUGAR
	warming = 10 MINUTES
	bitesize = 3
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/piedough
	name = "pie dough"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "piedough"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("dough" = 1)
	foodtype = GRAIN
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/piedough
	name = "pie dough"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/powder/flour= 2,
		/obj/item/reagent_containers/food/snacks/butterslice = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/piedough



/datum/crafting_recipe/roguetown/cooking/berrypie
	name = "berry pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/berry


/datum/crafting_recipe/roguetown/cooking/applepie
	name = "apple pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/apple = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/apple = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/apple

/obj/item/reagent_containers/food/snacks/rogue/pie/berry
	name = "berry pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/berry
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/berry
	name = "berry pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("berries" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/apple
	name = "apple pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/apple
	eat_effect = /datum/status_effect/debuff/uncookedfood


/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/apple
	name = "apple pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("apples" = 1)

/datum/crafting_recipe/roguetown/cooking/meatpie
	name = "meat pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/meat

	subtype_reqs = FALSE

/obj/item/reagent_containers/food/snacks/rogue/pie/meat
	name = "meat pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat
	eat_effect = /datum/status_effect/debuff/uncookedfood
	filling_color = "#8f433a"

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat
	name = "meat pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("meat" = 1)

/datum/crafting_recipe/roguetown/cooking/meatpie/fish
	name = "fish pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1
	)
	parts = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 3
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/meat/fish


/obj/item/reagent_containers/food/snacks/rogue/pie/meat/fish
	name = "fish pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat/fish
	tastes = list("fish" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat/fish
	name = "fish pie"
	tastes = list("fish" = 1)

/datum/crafting_recipe/roguetown/cooking/meatpie/poultry
	name = "pot pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1
	)
	parts = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry = 3
	)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/meat/poultry


/obj/item/reagent_containers/food/snacks/rogue/pie/meat/poultry
	name = "pot pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat/poultry

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat/poultry
	name = "pot pie"
	tastes = list("chicken" = 1)

/datum/crafting_recipe/roguetown/cooking/eggpie
	name = "egg pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/egg = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/egg = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/egg


/obj/item/reagent_containers/food/snacks/rogue/pie/egg
	name = "egg pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/egg
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/egg
	name = "egg pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("eggs" = 1)

/datum/crafting_recipe/roguetown/cooking/pearpie
	name = "pear pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/pear = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/pear = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/pear

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/pear
	name = "pear pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("pears" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/pear
	name = "pear pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/pear
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/cherrypie
	name = "cherry pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/cherry = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/cherry = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/cherry

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/cherry
	name = "cherry pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("cherries" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/cherry
	name = "cherry pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/cherry
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/cabbagepie
	name = "cabbage pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/cabbage

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/cabbage
	name = "cabbage pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("cabbages" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/cabbage
	name = "cabbage pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/cabbage
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/onionpie
	name = "onion pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/onion = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/onion = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/onion

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/onion
	name = "onion pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("onions" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/onion
	name = "onion pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/onion
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/carrotpie
	name = "carrot pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/carrot = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/carrot = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/carrot

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/carrot
	name = "carrot pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("carrots" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/carrot
	name = "carrot pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/carrot
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/radishpie
	name = "radish pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/radish = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/radish = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/radish

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/radish
	name = "radish pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("radishes" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/radish
	name = "radish pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/radish
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/rocknutpie
	name = "rocknut pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/nut = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/nut = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/rocknut

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/rocknut
	name = "rocknut pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("nutty" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/rocknut
	name = "rocknut pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/rocknut
	eat_effect = /datum/status_effect/debuff/uncookedfood

/datum/crafting_recipe/roguetown/cooking/plumphelmetpie
	name = "plump helmet pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/plumphelmet = 3,
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/grown/plumphelmet = 3)
	result = /obj/item/reagent_containers/food/snacks/rogue/pie/plumphelmet

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/plumphelmet
	name = "plump helmet pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	eat_effect = /datum/status_effect/buff/foodbuff
	tastes = list("the mountainhome" = 1)

/obj/item/reagent_containers/food/snacks/rogue/pie/plumphelmet
	name = "plump helmet pie"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/plumphelmet
	eat_effect = /datum/status_effect/debuff/uncookedfood

*/
