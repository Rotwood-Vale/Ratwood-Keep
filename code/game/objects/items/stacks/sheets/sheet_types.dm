/* Diffrent misc types of sheets
 * Contains:
 * Metal
 * Plasteel
 * Wood
 * Cloth
 * Plastic
 * Cardboard
 * Paper Frames
 * Runed Metal (cult)
 * Bronze (bake brass)
 */

/*
 * Metal
 */
GLOBAL_LIST_INIT(metal_recipes, list ( \
	new/datum/stack_recipe("stool", /obj/structure/chair/stool, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("bar stool", /obj/structure/chair/stool/bar, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("bed", /obj/structure/bed, 2, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe_list("office chairs", list( \
		new/datum/stack_recipe("dark office chair", /obj/structure/chair/office, 5, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("light office chair", /obj/structure/chair/office/light, 5, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("comfy chairs", list( \
		new/datum/stack_recipe("beige comfy chair", /obj/structure/chair/comfy/beige, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("black comfy chair", /obj/structure/chair/comfy/black, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("brown comfy chair", /obj/structure/chair/comfy/brown, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("lime comfy chair", /obj/structure/chair/comfy/lime, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("teal comfy chair", /obj/structure/chair/comfy/teal, 2, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("sofas", list(
		new /datum/stack_recipe("sofa (middle)", /obj/structure/chair/sofa, 1, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("sofa (left)", /obj/structure/chair/sofa/left, 1, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("sofa (right)", /obj/structure/chair/sofa/right, 1, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("sofa (corner)", /obj/structure/chair/sofa/corner, 1, one_per_turf = TRUE, on_floor = TRUE)
		)),
	null, \
	new/datum/stack_recipe("rack parts", /obj/item/rack_parts), \
	new/datum/stack_recipe("closet", /obj/structure/closet, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("canister", /obj/machinery/portable_atmospherics/canister, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("floor tile", /obj/item/stack/tile/plasteel, 1, 4, 20), \
	new/datum/stack_recipe("metal rod", /obj/item/stack/rods, 1, 2, 60), \
	null, \
	new/datum/stack_recipe("wall girders", /obj/structure/girder, 2, time = 40, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	null, \
	null, \
	new/datum/stack_recipe("meatspike frame", /obj/structure/kitchenspike_frame, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("iron door", /obj/structure/mineral_door/iron, 20, one_per_turf = TRUE, on_floor = TRUE), \
))

/obj/item/stack/sheet/metal
	name = "metal"
	desc = ""
	singular_name = "metal sheet"
	icon_state = "sheet-metal"
	item_state = "sheet-metal"
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
	throwforce = 10
	flags_1 = CONDUCT_1
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/metal
	grind_results = list(/datum/reagent/iron = 20)
	point_value = 2
	tableVariant = /obj/structure/table
	material_type = /datum/material/iron

/obj/item/stack/sheet/metal/New()
	qdel()

/obj/item/stack/sheet/metal/narsie_act()
	new /obj/item/stack/sheet/runed_metal(loc, amount)
	qdel(src)

/obj/item/stack/sheet/metal/fifty
	amount = 50

/obj/item/stack/sheet/metal/twenty
	amount = 20

/obj/item/stack/sheet/metal/ten
	amount = 10

/obj/item/stack/sheet/metal/five
	amount = 5

/obj/item/stack/sheet/metal/get_main_recipes()
	. = ..()
	. += GLOB.metal_recipes

/obj/item/stack/sheet/metal/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins whacking [user.p_them()]self over the head with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS

/*
 * Plasteel
 */
GLOBAL_LIST_INIT(plasteel_recipes, list ( \
))

/obj/item/stack/sheet/plasteel
	name = "plasteel"
	singular_name = "plasteel sheet"
	desc = ""
	icon_state = "sheet-plasteel"
	item_state = "sheet-metal"
	custom_materials = list(/datum/material/iron=2000, /datum/material/plasma=2000)
	throwforce = 10
	flags_1 = CONDUCT_1
	armor = list("blunt" = 0, "slash" = 0, "stab" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 80)
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/plasteel
	grind_results = list(/datum/reagent/iron = 20, /datum/reagent/toxin/plasma = 20)
	point_value = 23
	tableVariant = /obj/structure/table/reinforced
	material_flags = MATERIAL_NO_EFFECTS

/obj/item/stack/sheet/plasteel/get_main_recipes()
	. = ..()
	. += GLOB.plasteel_recipes

/obj/item/stack/sheet/plasteel/twenty
	amount = 20

/obj/item/stack/sheet/plasteel/fifty
	amount = 50

/*
 * Wood
 */
GLOBAL_LIST_INIT(wood_recipes, list ( \
	new/datum/stack_recipe("wooden sandals", /obj/item/clothing/shoes/sandal, 1), \
	new/datum/stack_recipe("wood floor tile", /obj/item/stack/tile/wood, 1, 4, 20), \
	new/datum/stack_recipe("wood table frame", /obj/structure/table_frame/wood, 2, time = 10), \
	new/datum/stack_recipe("rifle stock", /obj/item/weaponcrafting/stock, 10, time = 40), \
	new/datum/stack_recipe("rolling pin", /obj/item/kitchen/rollingpin, 2, time = 30), \
	new/datum/stack_recipe("wooden chair", /obj/structure/chair/wood/, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("winged wooden chair", /obj/structure/chair/wood/wings, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("wooden barricade", /obj/structure/barricade/wooden, 5, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("wooden door", /obj/structure/mineral_door/wood, 10, time = 20, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("coffin", /obj/structure/closet/crate/coffin, 5, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("book case", /obj/structure/bookcase, 4, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("dog bed", /obj/structure/bed/dogbed, 10, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("dresser", /obj/structure/dresser, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("picture frame", /obj/item/wallframe/picture, 1, time = 10),\
	new/datum/stack_recipe("display case chassis", /obj/structure/displaycase_chassis, 5, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("tiki mask", /obj/item/clothing/mask/gas/tiki_mask, 2), \
	new/datum/stack_recipe("wooden bucket", /obj/item/reagent_containers/glass/bucket/wooden, 3, time = 10),\
	new/datum/stack_recipe("wooden crate", /obj/structure/closet/crate/wooden, 6, time = 50, one_per_turf = TRUE, on_floor = TRUE),\
	new/datum/stack_recipe("baseball bat", /obj/item/melee/baseball_bat, 5, time = 15),\
	new/datum/stack_recipe("loom", /obj/structure/loom, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("mortar", /obj/item/reagent_containers/glass/mortar, 3), \
	new/datum/stack_recipe("firebrand", /obj/item/match/firebrand, 2, time = 100), \
	null, \
	new/datum/stack_recipe_list("pews", list(
		new /datum/stack_recipe("pew (middle)", /obj/structure/chair/pew, 3, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("pew (left)", /obj/structure/chair/pew/left, 3, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("pew (right)", /obj/structure/chair/pew/right, 3, one_per_turf = TRUE, on_floor = TRUE)
		)),
	null, \
	))

/obj/item/stack/sheet/mineral/wood
	name = "wooden plank"
	desc = ""
	singular_name = "wood plank"
	icon_state = "sheet-wood"
	item_state = "sheet-wood"
	icon = 'icons/obj/stack_objects.dmi'
	sheettype = "wood"
	armor = list("blunt" = 0, "slash" = 0, "stab" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/sheet/mineral/wood
	novariants = TRUE
	grind_results = list(/datum/reagent/cellulose = 20) //no lignocellulose or lignin reagents yet,

/obj/item/stack/sheet/mineral/wood/New()
	qdel()

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.wood_recipes

/obj/item/stack/sheet/mineral/wood/fifty
	amount = 50

/*
 * Cloth
 */
GLOBAL_LIST_INIT(cloth_recipes, list ( \
	new/datum/stack_recipe("white jumpskirt", /obj/item/clothing/under/color/jumpskirt/white, 3), /*Ladies first*/ \
	new/datum/stack_recipe("white jumpsuit", /obj/item/clothing/under/color/white, 3), \
	new/datum/stack_recipe("white shoes", /obj/item/clothing/shoes/sneakers/white, 2), \
	new/datum/stack_recipe("white scarf", /obj/item/clothing/neck/scarf, 1), \
	null, \
	new/datum/stack_recipe("backpack", /obj/item/storage/backpack, 4), \
	new/datum/stack_recipe("duffel bag", /obj/item/storage/backpack/duffelbag, 6), \
	null, \
	new/datum/stack_recipe("book bag", /obj/item/storage/bag/books, 4), \
	new/datum/stack_recipe("mining satchel", /obj/item/storage/bag/ore, 4), \
	new/datum/stack_recipe("chemistry bag", /obj/item/storage/bag/chemistry, 4), \
	new/datum/stack_recipe("bio bag", /obj/item/storage/bag/bio, 4), \
	null, \
	new/datum/stack_recipe("improvised gauze", /obj/item/stack/medical/gauze/improvised, 1, 2, 6), \
	new/datum/stack_recipe("rag", /obj/item/reagent_containers/glass/rag, 1), \
	new/datum/stack_recipe("bedsheet", /obj/item/bedsheet, 3), \
	null, \
	new/datum/stack_recipe("fingerless gloves", /obj/item/clothing/gloves/fingerless, 1), \
	new/datum/stack_recipe("white gloves", /obj/item/clothing/gloves/color/white, 3), \
	new/datum/stack_recipe("white softcap", /obj/item/clothing/head/soft/mime, 2), \
	new/datum/stack_recipe("white beanie", /obj/item/clothing/head/beanie, 2), \
	null, \
	new/datum/stack_recipe("blindfold", /obj/item/clothing/glasses/blindfold, 2), \
	))

/obj/item/stack/sheet/cloth
	name = "cloth"
	desc = ""
	singular_name = "cloth roll"
	icon_state = "sheet-cloth"
	item_state = "sheet-cloth"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cloth
	drop_sound = 'sound/blank.ogg'
	pickup_sound =  'sound/blank.ogg'
	grind_results = list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.cloth_recipes

/obj/item/stack/sheet/cloth/ten
	amount = 10

/obj/item/stack/sheet/cloth/five
	amount = 5

GLOBAL_LIST_INIT(durathread_recipes, list ( \
	new/datum/stack_recipe("durathread jumpsuit", /obj/item/clothing/under/misc/durathread, 4, time = 40),
	new/datum/stack_recipe("durathread beret", /obj/item/clothing/head/beret/durathread, 2, time = 40), \
	new/datum/stack_recipe("durathread beanie", /obj/item/clothing/head/beanie/durathread, 2, time = 40), \
	new/datum/stack_recipe("durathread bandana", /obj/item/clothing/mask/bandana/durathread, 1, time = 25), \
	))

/obj/item/stack/sheet/durathread
	name = "durathread"
	desc = ""
	singular_name = "durathread roll"
	icon_state = "sheet-durathread"
	item_state = "sheet-cloth"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/durathread
	drop_sound = 'sound/blank.ogg'
	pickup_sound =  'sound/blank.ogg'

/obj/item/stack/sheet/durathread/get_main_recipes()
	. = ..()
	. += GLOB.durathread_recipes

/obj/item/stack/sheet/cotton
	name = "raw cotton bundle"
	desc = ""
	singular_name = "raw cotton ball"
	icon_state = "sheet-cotton"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cotton
	var/pull_effort = 30
	var/loom_result = /obj/item/stack/sheet/cloth
	grind_results = list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/cotton/durathread
	name = "raw durathread bundle"
	desc = ""
	singular_name = "raw durathread ball"
	icon_state = "sheet-durathreadraw"
	merge_type = /obj/item/stack/sheet/cotton/durathread
	pull_effort = 70
	loom_result = /obj/item/stack/sheet/durathread
	grind_results = list()

/*
 * Cardboard
 */
GLOBAL_LIST_INIT(cardboard_recipes, list (														\
	new/datum/stack_recipe("box", /obj/item/storage/box),										\
	new/datum/stack_recipe("cardborg suit", /obj/item/clothing/suit/cardborg, 3),				\
	new/datum/stack_recipe("cardborg helmet", /obj/item/clothing/head/cardborg),				\
	new/datum/stack_recipe("large box", /obj/structure/closet/cardboard, 4, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("cardboard cutout", /obj/item/cardboard_cutout, 5),					\
	null,																						\
	new/datum/stack_recipe("folder", /obj/item/folder),											\
	null,																						\
	//TO-DO: Find a proper way to just change the illustration on the box. Code isn't the issue, input is.
	new/datum/stack_recipe_list("fancy boxes", list(
		new /datum/stack_recipe("donut box", /obj/item/storage/fancy/donut_box),				\
		new /datum/stack_recipe("egg box", /obj/item/storage/fancy/egg_box),					\
		new /datum/stack_recipe("donk-pockets box", /obj/item/storage/box/donkpockets),			\
		new /datum/stack_recipe("monkey cube box", /obj/item/storage/box/monkeycubes),
		new /datum/stack_recipe("nugget box", /obj/item/storage/fancy/nugget_box),			\
		null,																					\

		new /datum/stack_recipe("lethal ammo box", /obj/item/storage/box/lethalshot),			\
		new /datum/stack_recipe("rubber shot ammo box", /obj/item/storage/box/rubbershot),		\
		new /datum/stack_recipe("bean bag ammo box", /obj/item/storage/box/beanbag),			\
		new /datum/stack_recipe("flashbang box", /obj/item/storage/box/flashbangs),				\
		new /datum/stack_recipe("handcuffs box", /obj/item/storage/box/handcuffs),				\
		null,																					\

		new /datum/stack_recipe("pillbottle box", /obj/item/storage/box/pillbottles),			\
		new /datum/stack_recipe("beaker box", /obj/item/storage/box/beakers),					\
		new /datum/stack_recipe("syringe box", /obj/item/storage/box/syringes),					\
		new /datum/stack_recipe("latex gloves box", /obj/item/storage/box/gloves),				\
		new /datum/stack_recipe("sterile masks box", /obj/item/storage/box/masks),				\
		new /datum/stack_recipe("body bag box", /obj/item/storage/box/bodybags),					\
		new /datum/stack_recipe("perscription glasses box", /obj/item/storage/box/rxglasses),	\
		null,																					\
		new /datum/stack_recipe("light tubes box", /obj/item/storage/box/lights/tubes),			\
		new /datum/stack_recipe("light bulbs box", /obj/item/storage/box/lights/bulbs),			\
		new /datum/stack_recipe("mixed lights box", /obj/item/storage/box/lights/mixed),		\
		new /datum/stack_recipe("mouse traps box", /obj/item/storage/box/mousetraps),			\
		new /datum/stack_recipe("candle box", /obj/item/storage/fancy/candle_box)
		)),

	null,																						\
))

/obj/item/stack/sheet/cardboard	//BubbleWrap //it's cardboard you fuck
	name = "cardboard"
	desc = ""
	singular_name = "cardboard sheet"
	icon_state = "sheet-card"
	item_state = "sheet-card"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cardboard
	novariants = TRUE
	grind_results = list(/datum/reagent/cellulose = 10)

/obj/item/stack/sheet/cardboard/get_main_recipes()
	. = ..()
	. += GLOB.cardboard_recipes

/obj/item/stack/sheet/cardboard/fifty
	amount = 50


/*
 * Runed Metal
 */

/obj/item/stack/sheet/runed_metal
	name = "runed metal"
	desc = ""
	singular_name = "runed metal sheet"
	icon_state = "sheet-runed"
	item_state = "sheet-runed"
	icon = 'icons/obj/stack_objects.dmi'
	sheettype = "runed"
	merge_type = /obj/item/stack/sheet/runed_metal
	novariants = TRUE
	grind_results = list(/datum/reagent/iron = 5, /datum/reagent/blood = 15)

/obj/item/stack/sheet/runed_metal/attack_self(mob/living/user)
	var/turf/T = get_turf(user) //we may have moved. adjust as needed...
	var/area/A = get_area(user)
	if((!is_station_level(T.z) && !is_mining_level(T.z)) || (A && !(A.flags_1 & CULT_PERMITTED_1)))
		to_chat(user, span_warning("The veil is not weak enough here."))
		return FALSE
	return ..()

/*
 * Bronze
 */

GLOBAL_LIST_INIT(bronze_recipes, list ( \
	new/datum/stack_recipe("wall gear", /obj/structure/girder/bronze, 2, time = 20, one_per_turf = TRUE, on_floor = TRUE), \
	null,
	new/datum/stack_recipe("directional bronze window", /obj/structure/window/bronze/unanchored, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("fulltile bronze window", /obj/structure/window/bronze/fulltile/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("bronze hat", /obj/item/clothing/head/bronze), \
	new/datum/stack_recipe("bronze suit", /obj/item/clothing/suit/bronze), \
	new/datum/stack_recipe("bronze boots", /obj/item/clothing/shoes/bronze), \
	null,
	new/datum/stack_recipe("bronze chair", /obj/structure/chair/bronze, 1, time = 0, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("Marx Bust", /obj/structure/statue/bronze/marx, 15, one_per_turf = 1, on_floor = 1), \
))

/obj/item/stack/tile/bronze
	name = "brass"
	desc = ""
	singular_name = "bronze sheet"
	icon_state = "sheet-brass"
	item_state = "sheet-brass"
	icon = 'icons/obj/stack_objects.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	throwforce = 10
	max_amount = 50
	throw_speed = 1
	throw_range = 3
	turf_type = /turf/open/floor/bronze
	novariants = FALSE
	grind_results = list(/datum/reagent/iron = 5, /datum/reagent/copper = 3) //we have no "tin" reagent so this is the closest thing
	merge_type = /obj/item/stack/tile/bronze
	tableVariant = /obj/structure/table/bronze

/obj/item/stack/tile/bronze/get_main_recipes()
	. = ..()
	. += GLOB.bronze_recipes

/obj/item/stack/sheet/paperframes/Initialize()
	. = ..()
	pixel_x = 0
	pixel_y = 0

/obj/item/stack/tile/bronze/thirty
	amount = 30

/*
 * Lesser and Greater gems - unused
 */
/obj/item/stack/sheet/lessergem
	name = "lesser gems"
	desc = ""
	singular_name = "lesser gem"
	icon_state = "sheet-lessergem"
	item_state = "sheet-lessergem"
	novariants = TRUE


/obj/item/stack/sheet/greatergem
	name = "greater gems"
	desc = ""
	singular_name = "greater gem"
	icon_state = "sheet-greatergem"
	item_state = "sheet-greatergem"
	novariants = TRUE

	/*
 * Bones
 */
/obj/item/stack/sheet/bone
	name = "bones"
	icon = 'icons/obj/mining.dmi'
	icon_state = "bone"
	item_state = "sheet-bone"
	singular_name = "bone"
	desc = ""
	force = 7
	throwforce = 5
	max_amount = 12
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 3
	grind_results = list(/datum/reagent/carbon = 10)
	merge_type = /obj/item/stack/sheet/bone

GLOBAL_LIST_INIT(plastic_recipes, list(
	new /datum/stack_recipe("plastic floor tile", /obj/item/stack/tile/plastic, 1, 4, 20), \
	new /datum/stack_recipe("folding plastic chair", /obj/structure/chair/plastic, 2), \
	new /datum/stack_recipe("water bottle", /obj/item/reagent_containers/glass/waterbottle/empty), \
	new /datum/stack_recipe("large water bottle", /obj/item/reagent_containers/glass/waterbottle/large/empty, 3), \
	new /datum/stack_recipe("colo cups", /obj/item/reagent_containers/glass/colocup, 1), \
	new /datum/stack_recipe("wet floor sign", /obj/item/clothing/suit/caution, 2), \
	new /datum/stack_recipe("blank sign", /obj/item/sign_backing, 1)))

/obj/item/stack/sheet/plastic
	name = "plastic"
	desc = ""
	singular_name = "plastic sheet"
	icon_state = "sheet-plastic"
	item_state = "sheet-plastic"
	custom_materials = list(/datum/material/plastic=MINERAL_MATERIAL_AMOUNT)
	throwforce = 7
	merge_type = /obj/item/stack/sheet/plastic

/obj/item/stack/sheet/plastic/fifty
	amount = 50

/obj/item/stack/sheet/plastic/five
	amount = 5

/obj/item/stack/sheet/plastic/get_main_recipes()
	. = ..()
	. += GLOB.plastic_recipes

GLOBAL_LIST_INIT(paperframe_recipes, list(
new /datum/stack_recipe("paper frame separator", /obj/structure/window/paperframe, 2, one_per_turf = TRUE, on_floor = TRUE, time = 10), \
new /datum/stack_recipe("paper frame door", /obj/structure/mineral_door/paperframe, 3, one_per_turf = TRUE, on_floor = TRUE, time = 10 )))

/obj/item/stack/sheet/paperframes
	name = "paper frames"
	desc = ""
	singular_name = "paper frame"
	icon_state = "sheet-paper"
	item_state = "sheet-paper"
	merge_type = /obj/item/stack/sheet/paperframes
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/paperframes/get_main_recipes()
	. = ..()
	. += GLOB.paperframe_recipes
/obj/item/stack/sheet/paperframes/five
	amount = 5
/obj/item/stack/sheet/paperframes/twenty
	amount = 20
/obj/item/stack/sheet/paperframes/fifty
	amount = 50

/obj/item/stack/sheet/capitalisium
	name = "capitalisium sheet"
	desc = ""
	icon_state = "sheet-capitalisium"
	merge_type = /obj/item/stack/sheet/capitalisium

/obj/item/stack/sheet/stalinium
	name = "stalinium sheet"
	desc = ""
	icon_state = "sheet-stalinium"
	merge_type = /obj/item/stack/sheet/stalinium
