/obj/item/clothing/head/roguetown/helmet/citywatch
	name = "city watch helmet"
	desc = "A heavy helmet. Incredibly resilient to all forms of damage. Issued to the Citywatch."
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/citywatch/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/citywatch/onmob/head.dmi'
	icon_state = "citywatch_helmet"
	item_state = "citywatch_helmet"
	max_integrity = 225
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_SMASH, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	armor_class = ARMOR_CLASS_MEDIUM
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR
	anvilrepair = /datum/skill/craft/blacksmithing
	sewrepair = FALSE
