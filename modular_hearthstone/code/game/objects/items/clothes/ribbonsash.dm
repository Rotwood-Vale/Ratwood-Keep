/obj/item/storage/belt/rogue/leather/velvet
	name = "velvet sash"
	desc = "A brightly colored ribbon sash made of soft silk"
	icon = 'modular_hearthstone/icons/obj/items/clothes/ribbons.dmi'
	mob_overlay_icon = 'modular_hearthstone/icons/obj/items/clothes/on_mob/ribbons.dmi'
	item_state = "velvetsash"
	icon_state = "velvetsash"
	heldz_items = 1

/obj/item/storage/belt/rogue/leather/velvet/ribbon
	name = "velvet ribbon sash"
	desc = "A brightly colored ribbon sash made of soft silk and tied into a cute ribbon"
	icon = 'modular_hearthstone/icons/obj/items/clothes/ribbons.dmi'
	mob_overlay_icon = 'modular_hearthstone/icons/obj/items/clothes/on_mob/ribbons.dmi'
	item_state = "ribbonsash"
	icon_state = "ribbonsash"
	heldz_items = 1

//COLORS VELVET

/obj/item/storage/belt/rogue/leather/velvet/red
	color = "#ff5b4f"

/obj/item/storage/belt/rogue/leather/velvet/blue
	color = "#30baff"

/obj/item/storage/belt/rogue/leather/velvet/purple
	color = "#ba35fc"

/obj/item/storage/belt/rogue/leather/velvet/black
	color = CLOTHING_BLACK

/obj/item/storage/belt/rogue/leather/velvet/gold
	color = "#ffde5c"


//COLORS RIBBON

/obj/item/storage/belt/rogue/leather/velvet/ribbon/red
	color = "#ff5b4f"

/obj/item/storage/belt/rogue/leather/velvet/ribbon/blue
	color = "#30baff"

/obj/item/storage/belt/rogue/leather/velvet/ribbon/purple
	color = "#ba35fc"

/obj/item/storage/belt/rogue/leather/velvet/ribbon/black
	color = CLOTHING_BLACK

/obj/item/storage/belt/rogue/leather/velvet/ribbon/gold
	color = "#ffde5c"

//CRAFTING - VELVET


/datum/crafting_recipe/roguetown/weaving/velvet
	name = "velvet sash"
	result = list(/obj/item/storage/belt/rogue/leather/velvet)
	reqs = list(/obj/item/natural/silk = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/velvet/red
	name = "velvet sash"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/red)
	reqs = list(/obj/item/natural/silk = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/velvet/blue
	name = "velvet sash"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/blue)
	reqs = list(/obj/item/natural/silk = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/velvet/purple
	name = "velvet sash"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/purple)
	reqs = list(/obj/item/natural/silk = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/velvet/black
	name = "velvet sash"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/black)
	reqs = list(/obj/item/natural/silk = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/velvet/gold
	name = "velvet sash"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/gold)
	reqs = list(/obj/item/natural/silk = 1)
	craftdiff = 1
	sellprice = 30


/// CRAFTING - VELVET RIBBONS

/datum/crafting_recipe/roguetown/weaving/ribbon
	name = "velvet ribbon"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/ribbon)
	reqs = list(/obj/item/storage/belt/rogue/leather/velvet = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/ribbon/red
	name = "red velvet ribbon"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/ribbon/red)
	reqs = list(/obj/item/storage/belt/rogue/leather/velvet/red = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/ribbon/blue
	name = "blue velvet ribbon"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/ribbon/blue)
	reqs = list(/obj/item/storage/belt/rogue/leather/velvet/blue = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/ribbon/purple
	name = "purple velvet ribbon"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/ribbon/purple)
	reqs = list(/obj/item/storage/belt/rogue/leather/velvet/purple = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/ribbon/black
	name = "black velvet ribbon"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/ribbon/black)
	reqs = list(/obj/item/storage/belt/rogue/leather/velvet/black = 1)
	craftdiff = 1
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/ribbon/gold
	name = "gold velvet ribbon"
	result = list(/obj/item/storage/belt/rogue/leather/velvet/ribbon/gold)
	reqs = list(/obj/item/storage/belt/rogue/leather/velvet/gold = 1)
	craftdiff = 1
	sellprice = 30
