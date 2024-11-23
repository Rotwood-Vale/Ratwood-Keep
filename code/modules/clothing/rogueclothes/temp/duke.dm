/obj/item/clothing/suit/roguetown/armor/leather/duke
	name = "ducal uniform"
	desc = ""
	icon = 'icons/roguetown/clothing/licensed-infraredbaron/duke.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/licensed-infraredbaron/onmob/duke.dmi'
	icon_state = "duke"
	item_state = "duke"
	armor = list("blunt" = 30, "slash" = 35, "stab" = 10, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	armor_class = ARMOR_CLASS_LIGHT
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	blocksound = SOFTHIT
	// This doesnt let you wear a belt because the sprite has a cloak and it would appear over the cloak. I cant bother to fix it.
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_BELT
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = CHEST|VITALS|ARMS
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	sleevetype = null
	sleeved = null
	salvage_result = /obj/item/natural/hide/cured
