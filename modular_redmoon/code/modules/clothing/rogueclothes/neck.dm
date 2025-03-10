/obj/item/clothing/neck/roguetown/psicross/xylix
	name = "amulet of Xylix"
	desc = "Be not fooled, and be not afraid to."
	icon_state = "xylix"
	resistance_flags = FIRE_PROOF
	icon = 'modular_redmoon/icons/neck.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/onmob_neck.dmi'

/obj/item/clothing/neck/roguetown/psicross/abyssor
	name = "amulet of Tides"
	desc = "Those who call to the tides wear this symbol."
	icon_state = "abyssor"
	resistance_flags = FIRE_PROOF
	icon = 'modular_redmoon/icons/neck.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/onmob_neck.dmi'

/obj/item/clothing/neck/roguetown/cloth
	name = "padded gorget"
	desc = "Sturdy, durable, flexible. Will protect your neck from some good lumbering."
	icon_state = "cgorget"
	icon = 'modular_redmoon/icons/neck.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/onmob_neck.dmi'
	armor = list("blunt" = 70, "slash" = 60, "stab" = 30, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	max_integrity = 150
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST) //This one will help against chopping
	blocksound = SOFTHIT
	sewrepair = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/cloth

/obj/item/clothing/neck/roguetown/bervor
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/neck/roguetown/bervor/blacksteel
	name = "Blacksteel Bevor"
	desc = "A blacksteel bevor that protects the lower part of the head, that being the neck, mouth and nose."
	icon_state = "bl_bevor"
	icon = 'modular_redmoon/icons/neck.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/onmob_neck.dmi'
	armor = list("blunt" = 95, "slash" = 100, "stab" = 95, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	smeltresult = /obj/item/ingot/blacksteel
	max_integrity = 600
	resistance_flags = FIRE_PROOF | LAVA_PROOF
