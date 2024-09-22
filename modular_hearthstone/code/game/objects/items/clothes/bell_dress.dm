/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	icon = 'modular_hearthstone/icons/obj/items/clothes/dress.dmi'
	mob_overlay_icon = 'modular_hearthstone/icons/obj/items/clothes/on_mob/belldress.dmi'
	name = "bell dress"
	desc = "A fancy dress for the ladies."
	body_parts_covered = CHEST|GROIN|VITALS
	icon_state = "belldress"
	sleeved = 'modular_hearthstone/icons/obj/items/clothes/on_mob/belldress.dmi'
	sleevetype = "belldress"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL


//COLORS

/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/black
	color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/blue
	color = CLOTHING_BLUE

/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/purple
	color = "#664357"

/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/red
	color = "#6F0000"

/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/random/Initialize()
	color = pick(CLOTHING_BLACK, CLOTHING_BLUE, "#664357", "#6F0000")
	..()

//CRAFTING

/datum/crafting_recipe/roguetown/weaving/bell_dress
	name = "bell dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell)
	reqs = list(/obj/item/natural/silk = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/weaving/bell_dress_black
	name = "black bell dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/black)
	reqs = list(/obj/item/natural/silk = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/weaving/bell_dress_blue
	name = "blue bell dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/blue)
	reqs = list(/obj/item/natural/silk = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/weaving/bell_dress_red
	name = "red bell dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/red)
	reqs = list(/obj/item/natural/silk = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/weaving/bell_dress_purple
	name = "purple bell dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/purple)
	reqs = list(/obj/item/natural/silk = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

//SUPPLY

/datum/supply_pack/rogue/wardrobe/suits/bell_dress_black
	name = "Black bell Dresses"
	cost = 10
	contains = list(
					/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/black,
					/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/black,
				)

/datum/supply_pack/rogue/wardrobe/suits/bell_dress_blue
	name = "Blue bell Dresses"
	cost = 10
	contains = list(
					/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/blue,
					/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/blue,
				)

/datum/supply_pack/rogue/wardrobe/suits/bell_dress_red
	name = "Red bell Dresses"
	cost = 10
	contains = list(
					/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/red,
					/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/red,
				)

/datum/supply_pack/rogue/wardrobe/suits/bell_dress_purple
	name = "Purple bell Dresses"
	cost = 10
	contains = list(
					/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/purple,
					/obj/item/clothing/suit/roguetown/shirt/dress/gen/bell/purple,
				)
