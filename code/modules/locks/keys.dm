//MOJAVE SUN KEY OBJECTS AND FUNCTION FILE//
/obj/item/ms13/key
	name = "base ms13 key"
	desc = "Lock this guy up and throw this away."
	icon = 'mojave/icons/objects/tools/keys_world.dmi'
	icon_state = "brass"
	lefthand_file = 'mojave/icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'mojave/icons/mob/inhands/items_righthand.dmi'
	worn_icon = 'mojave/icons/mob/worn_melee.dmi'
	worn_icon_state = "empty_placeholder"
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 32
	grid_height = 32

/obj/item/ms13/key/Initialize()
	. = ..()
	AddElement(/datum/element/world_icon, null, icon, 'mojave/icons/objects/tools/keys_inventory.dmi')
