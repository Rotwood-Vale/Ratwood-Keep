/obj/item/ms13/lockpick
	name = "lockpick"
	desc = "Hitmen are enroute to your location, delete this."
	icon = 'mojave/icons/objects/tools/tools_world.dmi'
	icon_state = "bobby"
	lefthand_file = 'mojave/icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'mojave/icons/mob/inhands/items_righthand.dmi'
	worn_icon = 'mojave/icons/mob/worn_melee.dmi'
	worn_icon_state = "empty_placeholder"
	w_class = WEIGHT_CLASS_TINY
	grid_width = 32
	grid_height = 32

/obj/item/ms13/lockpick/Initialize()
	. = ..()
	AddElement(/datum/element/world_icon, null, icon, 'mojave/icons/objects/tools/tools_inventory.dmi')

/obj/item/ms13/lockpick/basic
	name = "lockpick"
	desc = "A crudely fashioned flexible piece of metal, perfect for jamming in locks and pin pushing."
