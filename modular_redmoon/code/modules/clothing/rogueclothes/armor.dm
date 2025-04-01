//STEEL
/obj/item/clothing/suit/roguetown/armor/plate/bikini
	name = "half-plate bikini"
	desc = "Half plate in bikini form, still just as protective somehow."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
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
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
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
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
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
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
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
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
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
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
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
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
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

/obj/item/clothing/suit/roguetown/armor/captain
	name = "Royal Halfplate"
	desc = "A basic cuirass of steel, decorated with gold."
	icon_state = "capplate"
	icon = 'modular_redmoon/icons/captain.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/captain_onmob.dmi'
	sleeved = 'modular_redmoon/icons/captain_onmob.dmi'
	detail_tag = "_detail"
	detail_color = CLOTHING_BLUE
	blocksound = SOFTHIT
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	clothing_flags = CANT_SLEEP_IN
	armor_class = ARMOR_CLASS_HEAVY
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	do_sound_plate = TRUE
	w_class = WEIGHT_CLASS_BULKY
	max_integrity = 520
	equip_delay_self = 160
	unequip_delay_self = 160
	equip_delay_other = 60
	strip_delay = 60

/obj/item/clothing/suit/roguetown/armor/captain/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/captain/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/captain/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/captain/Destroy()
	GLOB.lordcolor -= src
	return ..()

//ROBES
/obj/item/clothing/suit/roguetown/shirt/robe/abyssor //thanks to cre for abyssor clothing sprites
	name = "Abyssor Robe"
	desc = ""
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "abyssorrobe"
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/armor/plate
	body_parts_covered = CHEST|GROIN|VITALS|ARMS

/obj/item/clothing/suit/roguetown/armor/plate/skirt
	name = "Skirt Steel Half-Plate"
	body_parts_covered = CHEST|GROIN|VITALS|LEGS
	icon_state = "skirt_plate"
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'

//GAMBESON

/obj/item/clothing/suit/roguetown/armor/gambeson/doublet
	name = "doublet"
	desc = "A quilted doublet will fit into the image of a wealthy person"
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	icon_state = "doublet"
	item_state = "doublet"
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/armor_onmob.dmi'
	l_sleeve_status = SLEEVE_NORMAL
	r_sleeve_status = SLEEVE_NORMAL
	armor = list("blunt" = 25, "slash" = 15, "stab" = 20, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	sellprice = 37
	prevent_crits = null
	boobed = TRUE
	allowed_race = list(
			/datum/species/human/northern,
			/datum/species/human/halfelf,
			/datum/species/elf/dark,
			/datum/species/elf/wood,
			/datum/species/tieberian,
			/datum/species/aasimar,
			/datum/species/lizardfolk,
			/datum/species/lupian,
			/datum/species/tabaxi,
			/datum/species/vulpkanin,
			/datum/species/axian,
			/datum/species/moth,
			/datum/species/dracon,
			/datum/species/anthromorph,
			/datum/species/demihuman,
			/datum/species/halforc,
			/datum/species/anthromorphsmall,
			/datum/species/kobold
	)

/obj/item/clothing/suit/roguetown/armor/gambeson/doublet/random/Initialize()
	color = pick(CLOTHING_BLACK, CLOTHING_DARK_GREEN, CLOTHING_MAJENTA, CLOTHING_RED)
	return ..()

/obj/item/clothing/suit/roguetown/armor/brigandine
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	armor_class = ARMOR_CLASS_MEDIUM
	armor = list("blunt" = 90, "slash" = 100, "stab" = 90, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/brigandine/light
	max_integrity = 200
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/under/roguetown/splintlegs
	armor_class = ARMOR_CLASS_LIGHT
	max_integrity = 200

/obj/item/clothing/wrists/roguetown/splintarms
	max_integrity = 200
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket
	name = "Royal Handcoat"
	icon_state = "handcoat"
	icon = 'modular_redmoon/icons/noble.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/noble_onmob.dmi'
	sleeved = 'modular_redmoon/icons/noble_onmob.dmi'
	detail_tag = "_detail"
	detail_color = CLOTHING_BLACK
	flags_inv = HIDEBOOB|HIDECROTCH

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/suit/roguetown/armor/gambeson/steward
	name = "Steward Black Suit"
	desc = "A tight, impeccably clean leather steward tailcoat adorned with polished bronze buttons."
	icon_state = "stewardtailcoat"
	item_state = "stewardtailcoat"
	icon = 'modular_redmoon/icons/noble.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/noble_onmob.dmi'
	sleeved = 'modular_redmoon/icons/noble_onmob.dmi'

/obj/item/clothing/suit/roguetown/shirt/dress/stewarddress
	name = "Black Steward Gown"
	desc = "Victorian style black steward dress with shiny bronze buttons."
	icon = 'modular_redmoon/icons/noble.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/noble_onmob.dmi'
	icon_state = "stewarddress"
	sleeved = FALSE
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT

/obj/item/clothing/suit/roguetown/armor/plate/scale/zybantian
	slot_flags = ITEM_SLOT_ARMOR
	name = "Lamellar armor"
	desc = "Steel lamellar armor with bronze coating. Protects the body and legs without reducing mobility."
	body_parts_covered = CHEST|VITALS|GROIN|LEGS
	allowed_sex = list(MALE, FEMALE)
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "brsclarm"
	max_integrity = 275
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 40
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/zybantian
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "Hauberk with a mirror"
	desc = "A long chain mail made of small rings, in order to successfully protect the wearer from arrows and pricks, is also convenient for sleeping in it. It has a special mirror on the chest for additional protection."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "zrch"
	item_state = "zrch"
	max_integrity = 255
	armor = list("blunt" = 60, "slash" = 100, "stab" = 80, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	do_sound_chain = TRUE
	armor_class = ARMOR_CLASS_MEDIUM
	w_class = WEIGHT_CLASS_BULKY

/obj/item/clothing/suit/roguetown/armor/brigandine/light/zybantian
	slot_flags = ITEM_SLOT_ARMOR
	name = "Mirror armor"
	desc = "Mirror armor, light enough, but provides good chest protection."
	icon = 'modular_redmoon/icons/armor.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/armor_onmob.dmi'
	sleeved = 'modular_redmoon/icons/sleeves_armor.dmi'
	icon_state = "zr"
	max_integrity = 400
	blocksound = SOFTHIT
	body_parts_covered = CHEST|VITALS
	armor = list("blunt" = 60, "slash" = 70, "stab" = 70, "bullet" = 60, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	smeltresult = /obj/item/ingot/iron
	equip_delay_self = 40
	armor_class = ARMOR_CLASS_LIGHT
	w_class = WEIGHT_CLASS_BULKY
	clothing_flags = CANT_SLEEP_IN
	resistance_flags = FIRE_PROOF
