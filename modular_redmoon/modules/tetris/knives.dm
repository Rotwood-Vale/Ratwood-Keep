/obj/item/rogueweapon/knife
	grid_height = 64
	grid_width = 32

/obj/item/rogueweapon/knife/Initialize()
	. = ..()
	AddElement(/datum/element/tipped_item)
