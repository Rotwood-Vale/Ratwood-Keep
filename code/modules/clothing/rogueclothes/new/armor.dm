/obj/item/clothing/suit/roguetown/armor/leathercoat
	slot_flags = ITEM_SLOT_ARMOR
	name = "leather coat"
	desc = "A long leather coat made with quality materials for experienced hunters or noble explorers. The leather still offers some protection."
	icon = 'icons/roguetown/clothing/newclothes/dripobj.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/newclothes/onmob/onmobdrip.dmi'
	sleeved = 'icons/roguetown/clothing/newclothes/onmob/sleeves_armor.dmi'
	icon_state = "leathercoat"
	blocksound = SOFTHIT
	body_parts_covered = CHEST|GROIN|VITALS|ARMS|LEGS
	armor = list("blunt" = 50, "slash" = 25, "stab" = 40, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	max_integrity = 250
	armor_class = ARMOR_CLASS_LIGHT
	blade_dulling = DULLING_BASHCHOP
	nodismemsleeves = TRUE
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	armor_class = ARMOR_CLASS_LIGHT
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/suit/roguetown/armor/leathercoat/heavy
	name = "heavy leather coat"
	desc = "A long leather coat made with the best furs around. Thicker than the common coat, offers exceptional protection."
	icon_state = "bleathercoat"
	armor = list("blunt" = 70, "slash" = 40, "stab" = 50, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 350
