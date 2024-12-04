/obj/item/clothing/cloak/shadow
	name = "shadow cloak"
	desc = "."
	icon = 'icons/roguetown/clothing/newclothes/objshadowcloak.dmi'
	icon_state = "shadowcloak"
	item_state = "shadowcloak"
	mob_overlay_icon = 'icons/roguetown/clothing/newclothes/onmob/shadowcloak.dmi'
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	sleeved = 'icons/roguetown/clothing/newclothes/onmob/shadowcloak.dmi'
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	toggle_icon_state = FALSE
	salvage_result = /obj/item/natural/silk

/obj/item/clothing/cloak/fauld
	name = "fauld"
	desc = "."
	color = null
	icon_state = "tabard"
	item_state = "tabard"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/detailed/tabards.dmi'
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK
	flags_inv = HIDECROTCH|HIDEBOOB

/obj/item/clothing/cloak/fauld/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)
