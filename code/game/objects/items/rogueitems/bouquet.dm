// BOUQUETS & FLOWER CROWNS

/obj/item/bouquet
	name = ""
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi' 
	icon_state = ""
	item_state = ""

	grid_width = 32
	grid_height = 64

/obj/item/bouquet/rosa
	name = "rosa bouquet"
	desc = "Affections bundled together in string."
	item_state = "bouquet_rosa"
	icon_state = "bouquet_rosa"

/obj/item/bouquet/salvia
	name = "salvia bouquet"
	desc = ""
	item_state = "bouquet_salvia"
	icon_state = "bouquet_salvia"

/obj/item/bouquet/matricaria
	name = "matricaria bouquet"
	desc = ""
	item_state = "bouquet_matricaria"
	icon_state = "bouquet_matricaria"

/obj/item/bouquet/calendula
	name = "calendula bouquet"
	desc = ""
	item_state = "bouquet_calendula"
	icon_state = "bouquet_calendula"

/obj/item/flowercrown
	name = ""
	desc = ""
	icon = 'icons/roguetown/clothing/head.dmi' 
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	alternate_worn_layer  = 8.9 //On top of helmet
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	body_parts_covered = null
	icon_state = ""
	item_state = ""

	grid_width = 64
	grid_height = 32

/obj/item/flowercrown/rosa
	name = "crown of rosa"
	desc = ""
	item_state = "rosa_crown"
	icon_state = "rosa_crown"

/obj/item/flowercrown/salvia
	name = "crown of salvia"
	item_state = "salvia_crown"
	icon_state = "salvia_crown"
