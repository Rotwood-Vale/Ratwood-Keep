/obj/item/clothing/under/roguetown/platelegs/vampire
	name = "ancient plate greaves"
	desc = ""
	gender = PLURAL
	icon_state = "zizocloth"
	item_state = "zizocloth"
	icon = 'modular_redmoon/modules/vampire_update/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/vampire_update/icons/onmob/armor.dmi'
	sewrepair = FALSE
	armor = list("blunt" = 100, "slash" = 100, "stab" = 90, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT
	do_sound_plate = TRUE
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/roguetown/shirt/vampire
	slot_flags = ITEM_SLOT_SHIRT
	name = "regal silks"
	desc = ""
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon_state = "vrobe"
	item_state = "vrobe"
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/roguetown/vampire
	name = "crown of darkness"
	icon_state = "vcrown"
	body_parts_covered = null
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = null
	sellprice = 1000
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/roguetown/armor/chainmail/iron/vampire
	icon_state = "vunder"
	icon = 'modular_redmoon/modules/vampire_update/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/vampire_update/icons/onmob/armor.dmi'
	name = "ancient chain shirt"
	desc = ""
	body_parts_covered = CHEST|GROIN|VITALS
	armor_class = 2
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/roguetown/armor/plate/vampire
	slot_flags = ITEM_SLOT_ARMOR
	name = "ancient ceremonial plate"
	desc = ""
	body_parts_covered = CHEST|GROIN|VITALS
	icon_state = "zizoplate"
	item_state = "zizoplate"
	icon = 'modular_redmoon/modules/vampire_update/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/vampire_update/icons/onmob/armor.dmi'
	armor = list("blunt" = 100, "slash" = 100, "stab" = 90, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	nodismemsleeves = TRUE
	max_integrity = 500
	allowed_sex = list(MALE, FEMALE)
	do_sound_plate = TRUE
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 40
	armor_class = 3
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/shoes/roguetown/armor/steel/vampire
	name = "ancient ceremonial plated boots"
	desc = ""
	body_parts_covered = FEET
	icon = 'modular_redmoon/modules/vampire_update/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/vampire_update/icons/onmob/armor.dmi'
	icon_state = "zizoboots"
	item_state = "zizoboots"
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	color = null
	blocksound = PLATEHIT
	armor = list("blunt" = 100, "slash" = 100, "stab" = 90, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/roguetown/helmet/heavy/captain/vampire
	name = "ancient ceremonial helm"
	icon_state = "zizobarbute"
	icon = 'modular_redmoon/modules/vampire_update/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/vampire_update/icons/onmob/armor.dmi'

/obj/item/clothing/gloves/roguetown/plate/blk/vampire
	name = "ancient ceremonial gloves"
	icon = 'modular_redmoon/modules/vampire_update/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/vampire_update/icons/onmob/armor.dmi'
	icon_state = "zizogauntlets"
	resistance_flags = FIRE_PROOF | ACID_PROOF
