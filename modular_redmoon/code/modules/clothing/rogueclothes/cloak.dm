/obj/item/clothing/cloak/captain
	name = "Royal Guard Cloak-Hood"
	desc = "Royal Guard Cloak-Hood."
	icon = 'modular_redmoon/icons/captain.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/captain_onmob.dmi'
	sleeved = 'modular_redmoon/icons/captain_onmob.dmi'
	sleevetype = "shirt"
	icon_state = "capcloak"
	detail_tag = "_detail"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	detail_color = CLOTHING_BLUE

/obj/item/clothing/cloak/captain/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/captain/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/cloak/captain/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/captain/Destroy()
	GLOB.lordcolor -= src
	return ..()
