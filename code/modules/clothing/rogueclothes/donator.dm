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
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "piercing" = 100, "fire" = 0, "acid" = 0)
	max_integrity = 150
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT
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

/obj/item/clothing/suit/roguetown/armor/gambeson/otavan
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "fencer gambeson"
	desc = "A large shirt with heavy padding meant to be used below armor."
	icon = 'icons/roguetown/clothing/donator.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/donator.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/donator.dmi'
	icon_state = "fancygamb"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|VITALS
	armor = list("blunt" = 60, "slash" = 40, "stab" = 50, "piercing" = 25, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT,BCLASS_BLUNT)
	blocksound = SOFTUNDERHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	armor_class = ARMOR_CLASS_LIGHT
	allowed_race = NON_DWARVEN_RACE_TYPES

/datum/crafting_recipe/roguetown/hunting/bikini
	name = "leather bikini armor"
	result = /obj/item/clothing/suit/roguetown/armor/leather/bikini
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/anvil_recipe/armor/studdedbikini
	name = "Клёпанное кожаное бикини (+кожаное бикини)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
