/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*
 *		 (Meats)		*
 *						*
 * * * * * * * * * * * **/


/*	.............   Raw meat   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat
	eat_effect = /datum/status_effect/debuff/uncookedfood
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	name = "meat"
	desc = "Chop to create mince, bake or fry to make frysteak"
	icon_state = "meatslab"
	slice_batch = TRUE // so it takes more time, changed from FALSE
	filling_color = "#8f433a"
	rotprocess = SHELFLIFE_SHORT
	chopping_sound = TRUE
	foodtype = MEAT
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	mill_result = /obj/item/reagent_containers/powder/alch/mincem

/obj/item/reagent_containers/food/snacks/rogue/meat/steak
	ingredient_size = 2
	name = "raw meat"
	icon_state = "meatcutlet"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried
	cooked_smell = /datum/pollutant/food/fried_meat
	slices_num = 2
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef
	slice_bclass = BCLASS_CHOP

/* Meatballs */
/obj/item/reagent_containers/food/snacks/rogue/meat/meatballs_raw
	name = "raw meatballs"
	desc = "A delicacy first originating from Sienna that consists balls of cooked meat."
	icon_state = "meatballs_raw"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/meatballs
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/meatballs
	cooked_smell = /datum/pollutant/food/fried_meat

/obj/item/reagent_containers/food/snacks/rogue/meat/meatballs
	eat_effect = null
	name = "meatballs"
	desc = "A delicacy first originating from Sienna that consists balls of cooked meat."
	icon_state = "meatballs"
	cooked_smell = /datum/pollutant/food/fried_meat
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_CHUNKY)


/*	.............   Minced meat & stuffing sausages   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/mince
	name = "mince"
	icon_state = "meatmince"
	desc = "Use in stew, pie or alchemy or use with fat or more mince to make a Sausage."
	ingredient_size = 2
	slice_path = null
	filling_color = "#8a0000"
	rotprocess = SHELFLIFE_TINY
	cooked_type = null
/obj/item/reagent_containers/food/snacks/rogue/meat/mince/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/mess(get_turf(src))
	playsound(get_turf(src), 'modular/Neu_Food/sound/meatslap.ogg', 100, TRUE, -1)
	..()
	qdel(src)

/obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef
	name = "minced meat"

/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	name = "minced fish"
	icon_state = "fishmince"

/obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry
	name = "mince"
	icon_state = "meatmince"


/*	.............   Pork, spidermeat, birdmeat   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/fatty //pork
	slices_num = 4
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/bacon
	chopping_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/meat/bacon
	name = "raw bacon"
	icon_state = "bacon"
	slice_path = null
	slices_num = 0
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried
	filling_color = "#8a0000"


/obj/item/reagent_containers/food/snacks/rogue/meat/spider // Low-nutrient, kind of gross. Survival food.
	name = "spidermeat"
	icon_state = "spidermeat"
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/spider/fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/spider/fried
	slice_path = null
	slices_num = 0


/obj/item/reagent_containers/food/snacks/rogue/meat/poultry
	name = "plucked bird"
	icon_state = "halfchicken"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked
	fried_type = null
	slices_num = 2
	slice_sound = TRUE
	ingredient_size = 4

/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet
	name = "bird meat"
	icon_state = "chickencutlet"
	ingredient_size = 2
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried
	slices_num = 1
	slice_bclass = BCLASS_CHOP
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried


/*	..................   Sausage & Wiener   ................... */
/obj/item/reagent_containers/food/snacks/rogue/meat/sausage
	name = "raw sausage"
	icon_state = "raw_wiener"
	ingredient_size = 1
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
	cooked_smell = /datum/pollutant/food/sausage

/obj/item/reagent_containers/food/snacks/rogue/meat/wiener
	name = "raw wiener"
	icon_state = "raw_wiener"
	ingredient_size = 1
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked/wiener
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked/wiener
	cooked_smell = /datum/pollutant/food/sausage

/*	........   Fish sounds   ................ */
/obj/item/reagent_containers/food/snacks/fish
	mill_result = /obj/item/reagent_containers/powder/alch/mincef
	chopping_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/meat/fish_fillet_raw
	name = "raw fish filet meat"
	desc = "A fine cut of boneless fish meat. (Slice again for mince)"
	icon_state = "fishfilet_uncook"
	rotprocess = SHELFLIFE_LONG
	slices_num = 1
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	eat_effect = /datum/status_effect/debuff/uncookedfood
	mill_result = /obj/item/reagent_containers/powder/alch/mincef
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/fish_fillet
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/fish_fillet

/obj/item/reagent_containers/food/snacks/rogue/meat/fish_fillet
	eat_effect = null
	slices_num = 0
	name = "fish filet"
	desc = "A fine cut of boneless fish meat, cooked to perfection."
	icon_state = "fishfilet"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = MEATSLAB_NUTRITION)

/* .........   Shellfish    ................. */
/obj/item/reagent_containers/food/snacks/rogue/meat/shellfish
	name = "shellfish meat"
	desc = "Chop to create mince, bake or fry to make fried shellfish meat"
	icon_state = "shellfish_meat"
	rotprocess = SHELFLIFE_LONG //Fish don't rot
	mill_result = /obj/item/reagent_containers/powder/alch/mincef
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	slices_num = 1
	slice_bclass = BCLASS_CHOP
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/meat/shellfish/fried
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/meat/shellfish/fried

/obj/item/reagent_containers/food/snacks/rogue/meat/shellfish/fried
	eat_effect = null
	slices_num = 0
	name = "fried shellfish"
	desc = "Description goes here"
	icon_state = "shellfish_meat_cooked"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = MEATSLAB_NUTRITION)
