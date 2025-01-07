/obj/item/clothing/suit/roguetown/armor/leather/bikini
	name = "leather bikini"
	desc = "Flexible cowhide armor. Lightweight, better than nothing. Now in tasteful bikini shape."
	icon = 'icons/roguetown/clothing/donator.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/donator.dmi'
	body_parts_covered = CHEST|GROIN
	icon_state = "leatherkini"
	item_state = "leatherkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
	name = "studded leather bikini"
	desc = "Studded leather is the most durable of all hides and leathers and about as light. This one is in bikini form."
	icon = 'icons/roguetown/clothing/donator.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/donator.dmi'
	body_parts_covered = CHEST|GROIN
	icon_state = "studleatherkini"
	item_state = "studleatherkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/neck/roguetown/fencerguard
	name = "fencer neckguard"
	icon = 'icons/roguetown/clothing/donator.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/donator.dmi'
	icon_state = "fencercollar"
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/mask/rogue/lordmask/naledi
	name = "war scholar's mask"
	icon = 'icons/roguetown/clothing/donator.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/donator.dmi'
	item_state = "naledimask"
	icon_state = "naledimask"
	desc = "Runes and wards, meant for daemons; the gold has somehow rusted in unnatural, impossible agony. The most prominent of these etchings is in the shape of the Naledian psycross."
	sellprice = 0

/obj/item/clothing/head/roguetown/archercap
	name = "archer's cap"
	icon = 'icons/roguetown/clothing/donator.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/donator.dmi'
	desc = "For the merry men."
	icon_state = "archercap"

/obj/item/clothing/suit/roguetown/shirt/otavan
	slot_flags = ITEM_SLOT_SHIRT
	icon = 'icons/roguetown/clothing/donator.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/donator.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/donator.dmi'
	name = "fencer gambeson"
	icon_state = "fancygamb"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	flags_inv = HIDEBOOB|HIDECROTCH
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	allowed_race = NON_DWARVEN_RACE_TYPES

/datum/crafting_recipe/roguetown/leather/bikini
	name = "leather bikini armor"
	result = /obj/item/clothing/suit/roguetown/armor/leather/bikini
	reqs = list(/obj/item/natural/hide = 2)
	sellprice = 26

/datum/anvil_recipe/armor/studdedbikini
	name = "Клёпанное кожаное бикини (+кожаное бикини)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
