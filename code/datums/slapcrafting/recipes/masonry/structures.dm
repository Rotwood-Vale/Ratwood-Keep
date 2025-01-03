/datum/slapcraft_recipe/masonry/structure/smelter
	name = "ore furnace"
	steps = list(
		/datum/slapcraft_step/item/coal,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/item/stone/fourth,
		)
	result_type = /obj/machinery/light/rogue/smelter
	craftsound = null

/datum/slapcraft_recipe/masonry/structure/great_smelter
	name = "great furnace"
	steps = list(
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/item/iron/second,
		/datum/slapcraft_step/item/riddleofsteel,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/coal,
		)
	result_type = /obj/machinery/light/rogue/smelter/great
	craftsound = null

/datum/slapcraft_recipe/masonry/structure/forge
	name = "forge"
	steps = list(
		/datum/slapcraft_step/item/coal,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/item/stone/fourth,
		/datum/slapcraft_step/item/small_log,
		)
	result_type = /obj/machinery/light/rogue/forge
	craftsound = null

/datum/slapcraft_recipe/masonry/structure/sharp_wheel
	name = "sharpening wheel"
	steps = list(
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/iron,
		)
	result_type = /obj/structure/fluff/grindwheel
	craftsound = null

/datum/slapcraft_recipe/masonry/structure/oven
	name = "oven"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		)
	result_type = /obj/machinery/light/rogue/oven
	craftsound = 'sound/foley/Building-01.ogg'


/datum/slapcraft_recipe/masonry/structure/cauldron
	name = "cauldron"
	steps = list(
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/item/iron/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/item/stone/fourth,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/small_log,
		)
	result_type = /obj/item/reagent_containers/glass/bucket/pot
	craftsound = 'sound/foley/Building-01.ogg'


/datum/slapcraft_recipe/masonry/structure/stained_window
	name = "stained glass window (silver)"
	steps = list(
		/datum/slapcraft_step/item/silver,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/glass,
		/datum/slapcraft_step/item/glass/second,
		)
	result_type = /obj/structure/roguewindow/stained
	craftsound = 'sound/foley/Building-01.ogg'
	craftdiff = 2


/datum/slapcraft_recipe/masonry/structure/windowopen
	name = "openable window"
	steps = list(
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/glass,
		)
	result_type = /obj/structure/roguewindow/openclose
	craftsound = 'sound/foley/Building-01.ogg'
	craftdiff = 1

/datum/slapcraft_recipe/masonry/structure/window
	name = "solid window"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/glass,
		)
	result_type = /obj/structure/roguewindow/openclose/reinforced
	craftsound = 'sound/foley/Building-01.ogg'
