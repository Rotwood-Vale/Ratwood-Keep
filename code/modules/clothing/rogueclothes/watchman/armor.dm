/obj/item/clothing/suit/roguetown/armor/citywatch
	slot_flags = ITEM_SLOT_ARMOR
	name = "citywatch armor"
	desc = "Made of an alloy of blacksteel and some unknown material. Incredibly resilient to all forms of damage. Issued to the Citywatch."
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/citywatch/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/citywatch/onmob/armor.dmi'
	icon_state = "citywatch"
	item_state = "citywatch"
	blocksound = PLATEHIT
	do_sound_chain = TRUE
	body_parts_covered = CHEST|NECK|GROIN|VITALS|ARMS
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_SMASH, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 250
	armor_class = ARMOR_CLASS_HEAVY
	clothing_flags = CANT_SLEEP_IN
	anvilrepair = /datum/skill/craft/blacksmithing
	sewrepair = FALSE

