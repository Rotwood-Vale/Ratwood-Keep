/obj/item/clothing/suit/roguetown/armor/citywatch
	slot_flags = ITEM_SLOT_ARMOR
	name = "citywatch armor"
	desc = "Heavy, well worn armour. Incredibly resilient to all forms of damage. Issued to the Citywatch."
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/citywatch.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/onmob/citywatch.dmi'
	icon_state = "citywatch"
	item_state = "citywatch"
	blocksound = PLATEHIT
	do_sound_chain = TRUE
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 250
	armor_class = ARMOR_CLASS_HEAVY
	clothing_flags = CANT_SLEEP_IN
	anvilrepair = /datum/skill/craft/blacksmithing
	sewrepair = FALSE

/obj/item/clothing/head/roguetown/helmet/citywatch
	name = "city watch helmet"
	desc = "A heavy helmet. Incredibly resilient to all forms of damage. Issued to the Citywatch."
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/citywatch.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/onmob/citywatch.dmi'
	icon_state = "citywatch_helmet"
	item_state = "citywatch_helmet"
	max_integrity = 225
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_SMASH, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	armor_class = ARMOR_CLASS_MEDIUM
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|HAIR|EARS|NECK
	flags_inv = HIDEHAIR
	anvilrepair = /datum/skill/craft/blacksmithing
	sewrepair = FALSE

/obj/item/clothing/cloak/citywatch
	name = "citywatch cape"
	desc = ""
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/citywatch.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/onmob/citywatch.dmi'
	icon_state = "citywatch_cape"
	item_state = "citywatch_cape"
