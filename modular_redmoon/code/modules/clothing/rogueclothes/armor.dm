//STEEL
/obj/item/clothing/suit/roguetown/armor/plate/bikini
	name = "half-plate bikini"
	desc = "Half plate in bikini form, still just as protective somehow."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "halfplatekini"
	item_state = "halfplatekini"
	allowed_sex = list(FEMALE)
	max_integrity = 550
	flags_inv = HIDECROTCH|HIDEBOOB
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/suit/roguetown/armor/plate/bikini/bra
	name = "half-plate bra"
	icon_state = "halfplatebra"
	item_state = "halfplatebra"
	desc = "Half plate that's even half-er, still just as protective somehow."
	flags_inv = HIDEBOOB

/obj/item/clothing/suit/roguetown/armor/plate/full/bikini
	name = "fullplate bikini"
	desc = "Full plate in bikini form, full package and full exposure."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "platekini"
	allowed_sex = list(FEMALE)
	flags_inv = HIDECROTCH|HIDEBOOB
	armor_class = ARMOR_CLASS_HEAVY

/obj/item/clothing/suit/roguetown/armor/plate/full/bikini/bra
	name = "fullplate bra"
	icon_state = "platebra"
	item_state = "platebra"
	desc = "The black and white line between absolute protection and none."
	flags_inv = HIDEBOOB

//CHAIN
/obj/item/clothing/suit/roguetown/armor/chainmail/bikini
	name = "chainmail bikini"
	desc = "Try not to get your nipples caught between the chains, and other bits."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	icon_state = "chainkini"
	item_state = "chainkini"
	max_integrity = 225
	allowed_sex = list(FEMALE)
	anvilrepair = /datum/skill/craft/blacksmithing
	flags_inv = HIDEBOOB|HIDECROTCH

/obj/item/clothing/suit/roguetown/armor/chainmail/bikini/bra
	name = "chainmail bra"
	icon_state = "chainbra"
	item_state = "chainbra"
	desc = "Try not to get your nipples caught between the chains."
	flags_inv = HIDEBOOB

/obj/item/clothing/suit/roguetown/armor/chainmail/iron/bikini
	name = "iron chainmail bikini"
	desc = "Try not to get your nipples caught between the chains, and other bits."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	icon_state = "chainkini"
	item_state = "chainkini"
	color = "#9EA48E"
	allowed_sex = list(FEMALE)
	flags_inv = HIDEBOOB|HIDECROTCH

/obj/item/clothing/suit/roguetown/armor/chainmail/iron/bikini/bra
	name = "iron chainmail bra"
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	icon_state = "chainbra"
	item_state = "chainbra"
	color = "#9EA48E"
	desc = "Try not to get your nipples caught between the chains."
	flags_inv = HIDEBOOB

//LEATHER AND HIDE
/obj/item/clothing/suit/roguetown/armor/leather/bikini
	name = "leather bikini"
	desc = "Flexible cowhide armor. Lightweight, better than nothing. Now in tasteful bikini shape."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "leatherkini"
	item_state = "leatherkini"
	allowed_sex = list(FEMALE)
	flags_inv = HIDECROTCH|HIDEBOOB
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/bikini/bra
	name = "Leather armor bra"
	icon_state = "leatherbra"
	item_state = "leatherbra"
	desc = "Flexible cowhide armor. Lightweight, better than nothing, Although the bottom half is literally covered by nothing, it somehow still protects the full torso!"
	flags_inv = HIDEBOOB

/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
	name = "studded leather bikini"
	desc = "Studded leather is the most durable of all hides and leathers and about as light. This one is in bikini form."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "studleatherkini"
	item_state = "studleatherkini"
	allowed_sex = list(FEMALE)
	flags_inv = HIDECROTCH|HIDEBOOB
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini/bra
	name = "studded Leather bra"
	icon_state = "studleatherbra"
	item_state = "studleatherbra"
	desc = "Studded leather is the most durable of all hides and leathers and about as light. Although the bottom half is literally covered by nothing, it somehow still protects the full torso!"
	flags_inv = HIDEBOOB

/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini
	name = "hide bikini"
	desc = "A light armor of wildbeast hide. Far more durable than leather. This will not keep a person warm though..."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "hidearmorkini"
	item_state = "hidearmorkini"
	allowed_sex = list(FEMALE)
	flags_inv = HIDECROTCH|HIDEBOOB
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini/bra
	name = "hide bra"
	icon_state = "hidearmorbra"
	item_state = "hidearmorbra"
	desc = "A light armor of wildbeast hide. Far more durable than leather. This will not keep a person warm though... The bottom half is literally covered by nothing, it somehow still protects the full torso!"
	flags_inv = HIDEBOOB

/obj/item/clothing/suit/roguetown/armor/leather/advanced/bikini
	name = "hardened leather bikini"
	desc = "Sturdy, durable, flexible. Will keep you alive in style, and now even less than before!"
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "advkini"
	item_state = "advkini"
	allowed_sex = list(FEMALE)
	flags_inv = HIDECROTCH|HIDEBOOB
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/advanced/bikini/bra
	name = "hardened leather bra"
	icon_state = "advbra"
	item_state = "advbra"
	desc = "Sturdy, durable, flexible. Will keep you alive in style, and now even... EVEN less than before!"
	flags_inv = HIDEBOOB

/obj/item/clothing/suit/roguetown/armor/leather/masterwork/bikini
	name = "enhanced leather bikini"
	desc = "This bikini is a craftsmanship marvel. Made with the finest leather. Strong, VERY nimible, reliable."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "mastkini"
	item_state = "mastkini"
	allowed_sex = list(FEMALE)
	flags_inv = HIDECROTCH|HIDEBOOB
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/masterwork/bikini/bra
	name = "enhanced leather bra"
	icon_state = "mastbra"
	item_state = "mastbra"
	desc = "This... bra is a craftsmanship marvel. Made with the finest leather. Strong, VERY-VERY nimible, reliable."
	flags_inv = HIDEBOOB

//CAPTAIN
/obj/item/clothing/suit/roguetown/armor/plate/halfplateroyalguard
	slot_flags = ITEM_SLOT_ARMOR
	name = "royal halfplate"
	desc = "A basic cuirass of steel, decorated with gold."
	body_parts_covered = CHEST|VITALS
	icon_state = "royal"
	item_state = "royal"
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	do_sound = FALSE
	blocking_behavior = null
	max_integrity = 675	//3 steel, 3 difficulty, and uncraftable
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM
