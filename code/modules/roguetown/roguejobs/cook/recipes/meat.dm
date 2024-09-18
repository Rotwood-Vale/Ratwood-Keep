/datum/crafting_recipe/roguetown/cooking/sausage
	name = "sausage (mm)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince = 2)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage
	req_table = TRUE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/cooking/sausage/mf
	name = "sausage (mf)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince = 1,
		/obj/item/reagent_containers/food/snacks/fat = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage


/datum/crafting_recipe/roguetown/cooking/sausage/bb
	name = "sausage (bb)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/bacon = 2)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage


/datum/crafting_recipe/roguetown/cooking/sausage/fb
	name = "sausage (fb)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/bacon = 1,
		/obj/item/reagent_containers/food/snacks/fat = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage


/datum/crafting_recipe/roguetown/cooking/salami
	name = "salumoi"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/sausage = 1,
		/obj/item/reagent_containers/powder/salt = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/salami
	req_table = FALSE
	structurecraft = /obj/structure/fluff/dryingrack
	craftdiff = 0

/datum/crafting_recipe/roguetown/cooking/coppiette
	name = "coppiette"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
		/obj/item/reagent_containers/powder/salt = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/coppiette
	req_table = FALSE
	craftdiff = 0
	structurecraft = /obj/structure/fluff/dryingrack


/datum/crafting_recipe/roguetown/cooking/salo
	name = "salo"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fat = 1,
		/obj/item/reagent_containers/powder/salt = 1)
	result = /obj/item/reagent_containers/food/snacks/salo
	craftdiff = 0
	structurecraft = /obj/structure/fluff/dryingrack
	req_table = FALSE

/datum/crafting_recipe/roguetown/cooking/saltfish
	name = "saltfish"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fish = 1,
		/obj/item/reagent_containers/powder/salt = 1)
	parts = list(
		/obj/item/reagent_containers/food/snacks/fish = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/saltfish
	req_table = FALSE
	craftdiff = 0
	subtype_reqs = TRUE
	structurecraft = /obj/structure/fluff/dryingrack

/datum/crafting_recipe/roguetown/cooking/meatloaf
	name = "meatloaf"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince = 3,
		/obj/item/reagent_containers/food/snacks/rogue/onionslice = 3,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/meatloaf
	craftdiff = 3
	subtype_reqs = TRUE
	req_table = TRUE

/datum/crafting_recipe/roguetown/cooking/wellington
	name = "beef à la Kron"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 3,
		/obj/item/reagent_containers/food/snacks/grown/plumphelmet = 2,
		/obj/item/reagent_containers/food/snacks/rogue/onionslice = 5, 
		/obj/item/reagent_containers/food/snacks/rogue/piedough = 1)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/wellington
	craftdiff = 5
	subtype_reqs = TRUE
	req_table = TRUE

/datum/crafting_recipe/roguetown/cooking/descaledrakian
	name = "descale drakian wing"
	reqs = list(/obj/item/organ/wings/dracon = 1)
	tools = list(/obj/item/rogueweapon/huntingknife)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/drakianwing
	craftdiff = 2
	subtype_reqs = TRUE
	req_table = TRUE

/datum/crafting_recipe/roguetown/cooking/descalesissean
	name = "descale sissean tail"
	reqs = list(/obj/item/organ/tail/lizard = 1)
	tools = list(/obj/item/rogueweapon/huntingknife)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/sisseantail
	craftdiff = 2
	subtype_reqs = TRUE
	req_table = TRUE

/datum/crafting_recipe/roguetown/cooking/descalekobold
	name = "descale kobold tail"
	reqs = list(/obj/item/organ/tail/kobold = 1)
	tools = list(/obj/item/rogueweapon/huntingknife)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/koboldtail
	craftdiff = 2
	subtype_reqs = TRUE
	req_table = TRUE

/datum/crafting_recipe/roguetown/cooking/pate
	name = "pate"
	reqs = list(
		/obj/item/organ/liver = 1,
		/obj/item/reagent_containers/food/snacks/rogue/onionslice = 2,
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince = 1
		)
	result = /obj/item/reagent_containers/food/snacks/rogue/meat/pate
	craftdiff = 2
	subtype_reqs = TRUE
	req_table = TRUE
