/obj/item/clothing/suit/roguetown/shirt/robe
	slot_flags = ITEM_SLOT_ARMOR
	name = "robe"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "white_robe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	boobed = TRUE
	flags_inv = HIDEBOOB|HIDECROTCH
	color = "#7c6d5c"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/astrata
	slot_flags = ITEM_SLOT_ARMOR
	name = "sun robe"
	desc = "Robes worn by those in service to Astrata."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "astratarobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/noc
	slot_flags = ITEM_SLOT_ARMOR
	name = "moon robe"
	desc = "Robes worn by those in service to Noc."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "nocrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/necromancer
	slot_flags = ITEM_SLOT_ARMOR
	name = "necromancer robes"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "necromrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/dendor
	slot_flags = ITEM_SLOT_ARMOR
	name = "briar robe"
	desc = "Robes worn by Druid's in service to Dendor."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "dendorrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/necra
	slot_flags = ITEM_SLOT_ARMOR
	name = "mourning robe"
	desc = "Black robes which cover the body not unlike those in depictions of the Carriageman himself."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "necrarobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/psydonrobe
	slot_flags = ITEM_SLOT_ARMOR
	name = "psydon robe"
	desc = "Blood of Psydon cleanse me."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "psydonrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = FALSE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/black
	color = null

/obj/item/clothing/suit/roguetown/shirt/robe/white
	color = null

/obj/item/clothing/suit/roguetown/shirt/robe/priest
	name = "solar vestments"
	desc = "Holy vestments sanctified by divine hands. Caution is advised if not a faithful."
	icon_state = "priestrobe"
	color = null

/obj/item/clothing/suit/roguetown/shirt/robe/priest/pickup(mob/living/user)
	if((user.job != "Priest") && (user.job != "Priestess"))
		to_chat(user, "<font color='yellow'>UNWORTHY HANDS TOUCH THE VESTMENTS, CEASE OR BE PUNISHED</font>")
		spawn(30)
			if(loc == user)
				user.adjust_fire_stacks(5)
				user.IgniteMob()
	..()

/obj/item/clothing/suit/roguetown/shirt/robe/courtmage
	color = "#6c6c6c"

/obj/item/clothing/suit/roguetown/shirt/robe/mage/Initialize()
	color = pick("#4756d8", "#759259", "#bf6f39", "#c1b144", "#b8252c")
	. = ..()

/obj/item/clothing/suit/roguetown/shirt/robe/mageblue
	color = "#4756d8"

/obj/item/clothing/suit/roguetown/shirt/robe/magegreen
	color = "#759259"

/obj/item/clothing/suit/roguetown/shirt/robe/mageorange
	color = "#bf6f39"

/obj/item/clothing/suit/roguetown/shirt/robe/magered
	color = "#b8252c"

/obj/item/clothing/suit/roguetown/shirt/robe/mageyellow
	color = "#c1b144"

/obj/item/clothing/suit/roguetown/shirt/robe/merchant
	name = "guilder jacket"
	desc = "A fancy jacket common with merchants."
	icon_state = "merrobe"
	sellprice = 30
	color = null

/obj/item/clothing/suit/roguetown/shirt/robe/nun
	color = null
	icon_state = "nun"
	item_state = "nun"
	allowed_sex = list(MALE, FEMALE)

/obj/item/clothing/suit/roguetown/shirt/robe/wizard
	name = "wizard's robe"
	desc = "What wizard's ensemble would be complete without robes?"
	icon_state = "wizardrobes"
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/shirts.dmi'
	boobed = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	color = null
	sellprice = 100

/obj/item/clothing/suit/roguetown/shirt/robe/physician
	name = "plague coat"
	desc = "Medicum morbo adhibere."
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "physcoat"
	slot_flags = ITEM_SLOT_ARMOR
	sleeved = null
	boobed = TRUE
	color = null
	flags_inv = HIDEBOOB|HIDETAIL
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

//Eora content from Stonekeep

/obj/item/clothing/suit/roguetown/shirt/robe/eora
	slot_flags = ITEM_SLOT_ARMOR
	name = "eoran robe"
	desc = "Holy robes, intended for use by followers of Eora"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "eorarobes"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	boobed = TRUE
	color = null
	flags_inv = HIDEBOOB
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	var/fanatic_wear = FALSE

/obj/item/clothing/suit/roguetown/shirt/robe/eora/alt
	name = "open eoran robe"
	desc = "Used by more radical followers of the Eoran Church"
	body_parts_covered = null
	icon_state = "eorastraps"
	fanatic_wear = TRUE

/obj/item/clothing/suit/roguetown/shirt/robe/eora/attack_right(mob/user)
	switch(fanatic_wear)
		if(FALSE)
			name = "open eoran robe"
			desc = "Used by more radical followers of the Eoran Church"
			body_parts_covered = null
			icon_state = "eorastraps"
			fanatic_wear = TRUE
			to_chat(usr, span_warning("Now wearing radically!"))
		if(TRUE)
			name = "eoran robe"
			desc = "Holy robes, intended for use by followers of Eora"
			body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
			icon_state = "eorarobes"
			fanatic_wear = FALSE
			to_chat(usr, span_warning("Now wearing normally!"))
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()
