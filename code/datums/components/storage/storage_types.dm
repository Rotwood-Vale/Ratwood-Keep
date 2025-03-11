/datum/component/storage/concrete/roguetown
	grid = TRUE

/datum/component/storage/concrete/roguetown/satchel
	screen_max_rows = 4
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/roguetown/backpack
	screen_max_rows = 7
	screen_max_columns = 4
	max_w_class = WEIGHT_CLASS_NORMAL
	not_while_equipped = TRUE

/datum/component/storage/concrete/roguetown/backpack/rucksack
	screen_max_rows = 9
	screen_max_columns = 6
	max_w_class = WEIGHT_CLASS_NORMAL
	not_while_equipped = TRUE

/datum/component/storage/concrete/roguetown/belt
	screen_max_rows = 3
	screen_max_columns = 2
	max_w_class = WEIGHT_CLASS_SMALL

/datum/component/storage/concrete/roguetown/belt/knife_belt
	screen_max_rows = 6
	screen_max_columns = 4

/datum/component/storage/concrete/roguetown/belt/knife_belt/New(datum/P, ...)
	. = ..()
	can_hold = typecacheof(list(/obj/item/storage/belt/rogue/leather/knifebelt/black))

/datum/component/storage/concrete/roguetown/coin_pouch
	screen_max_rows = 4
	screen_max_columns = 1
	max_w_class = WEIGHT_CLASS_NORMAL
	not_while_equipped = FALSE

/datum/component/storage/concrete/roguetown/keyring
	screen_max_rows = 4
	screen_max_columns = 5
	max_w_class = WEIGHT_CLASS_SMALL
	allow_dump_out = TRUE
	click_gather = TRUE
	attack_hand_interact = FALSE
	collection_mode = COLLECT_ONE
	insert_verb = "slide"
	insert_preposition = "on"
	rustle_sound = 'sound/items/gems (1).ogg'

/datum/component/storage/concrete/roguetown/keyring/New(datum/P, ...)
	. = ..()
	can_hold = typecacheof(list(/obj/item/key))

// /datum/component/storage/concrete/roguetown/belt/knife_belt
// 	screen_max_rows = 6
// 	screen_max_columns = 4

// /datum/component/storage/concrete/roguetown/belt/knife_belt/New(datum/P, ...)
// 	. = ..()
// 	can_hold = typecacheof(list(/obj/item/rogueweapon/knife/throwingknife))


/datum/component/storage/concrete/roguetown/belt/cloth
	screen_max_columns = 1

/datum/component/storage/concrete/roguetown/belt/assassin
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/roguetown/cloak
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 2
	screen_max_columns = 2

/datum/component/storage/concrete/roguetown/cloak/lord
	max_w_class = WEIGHT_CLASS_BULKY

/datum/component/storage/concrete/roguetown/mailmaster
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 10
	screen_max_columns = 10

/datum/component/storage/concrete/roguetown/bin
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 8
	screen_max_columns = 4

/datum/component/storage/concrete/roguetown/sack
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 5
	screen_max_columns = 4
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	allow_dump_out = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/roguetown/egg_basket
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 5
	screen_max_columns = 2
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = FALSE
	allow_quick_empty = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/roguetown/egg_basket/New(datum/P, ...)
	. = ..()
	set_holdable(
		typecacheof(list(/obj/item/reagent_containers/food/snacks/egg)
	))

/datum/component/storage/concrete/roguetown/cigarettepack
	screen_max_rows = 2
	screen_max_columns = 3
	max_w_class = WEIGHT_CLASS_TINY
	allow_dump_out = TRUE
	collection_mode = COLLECT_ONE
	insert_verb = "slide"
	insert_preposition = "in"

/datum/component/storage/concrete/roguetown/cigarettepack/New(datum/P, ...)
	. = ..()
	can_hold = typecacheof(list(/obj/item/clothing/mask/cigarette/rollie/snek))

/datum/component/storage/concrete/roguetown/surgery_bag
	screen_max_rows = 5
	screen_max_columns = 4
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/roguetown/pilltin
	screen_max_rows = 2
	screen_max_columns = 3
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/roguetown/pilltin/New(datum/P, ...)
	. = ..()
	set_holdable(
		typecacheof(list(/obj/item/reagent_containers/pill)
	))

/datum/component/storage/concrete/roguetown/ifak
	screen_max_rows = 3
	screen_max_columns = 4
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/roguetown/ifak/New(datum/P, ...)
	. = ..()
	set_holdable(
		typecacheof(list(/obj/item/reagent_containers/hypospray/medipen/sealbottle/reju,
						/obj/item/reagent_containers/hypospray/medipen/sty/detox,
						/obj/item/natural/cloth/bandage,
						/obj/item/natural/bundle/cloth/bandage,
						/obj/item/natural/bundle/cloth/bandage/full,
						/obj/item/reagent_containers/pill/pnkpill,
						/obj/item/candle,
						/obj/item/needle,
						/obj/item/needle/thorn,
						/obj/item/needle/pestra)
					))

/datum/component/storage/concrete/grid/bin
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 8
	screen_max_columns = 4
