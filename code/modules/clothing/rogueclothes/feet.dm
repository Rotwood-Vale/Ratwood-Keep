/obj/item/clothing/shoes/roguetown
	name = "shoes"
	icon = 'icons/roguetown/clothing/feet.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/feet.dmi'
	desc = ""
	gender = PLURAL
	slot_flags = ITEM_SLOT_SHOES
	body_parts_covered = FEET
	sleeved = 'icons/roguetown/clothing/onmob/feet.dmi'
	sleevetype = "leg"
	bloody_icon_state = "shoeblood"
	equip_delay_self = 30
	w_class = WEIGHT_CLASS_SMALL
	sewrepair = TRUE

/obj/item/clothing/shoes/roguetown/shortboots
	name = "shortboots"
	color = "#d5c2aa"
	desc = "Boots which are a bit shorter at the ankles."
	icon_state = "shortboots"
	item_state = "shortboots"

/obj/item/clothing/shoes/roguetown/ridingboots
	name = "riding boots"
	color = "#d5c2aa"
	desc = "Boots worn by those who ride Saigas often."
	icon_state = "ridingboots"
	item_state = "ridingboots"


/obj/item/clothing/shoes/roguetown/gladiator
	name = "leather sandals"
	desc = ""
	icon_state = "gladiator"
	item_state = "gladiator"

/obj/item/clothing/shoes/roguetown/sandals
	name = "sandals"
	desc = ""
	icon_state = "sandals"
	item_state = "sandals"

/obj/item/clothing/shoes/roguetown/jester
	name = "funny shoes"
	desc = "Perfect for performing a jig or running for your life after a bad joke."
	icon_state = "jestershoes"
	resistance_flags = null

/obj/item/clothing/shoes/roguetown/simpleshoes
	name = "shoes"
	desc = "Better than going barefoot."
	icon_state = "simpleshoe"
	item_state = "simpleshoe"
	resistance_flags = null
	color = "#473a30"
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide

/obj/item/clothing/shoes/roguetown/simpleshoes/white
	color = null

/obj/item/clothing/shoes/roguetown/simpleshoes/buckle
	name = "shoes"
	icon_state = "buckleshoes"
	color = null

/obj/item/clothing/shoes/roguetown/simpleshoes/lord
	name = "shoes"
	desc = ""
	icon_state = "simpleshoe"
	item_state = "simpleshoe"
	resistance_flags = null
	color = "#cbcac9"


// **ARMOURED** //


/obj/item/clothing/shoes/roguetown/armor //This subtype is for armoured shoes
	name = "dark boots"
	color = "#d5c2aa"
	desc = "A fine set of dark boots."
	icon_state = "blackboots"
	item_state = "blackboots"
	blocksound = SOFTHIT //This hit sound is for leather
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST) //These match leather helmets
	armor = list("blunt" = 30, "slash" = 10, "stab" = 20, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/shoes/roguetown/armor/leather
	name = "leather boots"
	desc = "Boots made of leather."
	icon_state = "leatherboots"
	item_state = "leatherboots"
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide

/obj/item/clothing/shoes/roguetown/armor/steel
	name = "steel plated boots"
	desc = "A heavy pair of steel plated boots."
	icon_state = "armorboots"
	item_state = "armorboots"
	color = null
	blocksound = PLATEHIT
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	sewrepair = FALSE
	clothing_flags = CANT_SLEEP_IN
	resistance_flags = FIRE_PROOF
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/shoes/roguetown/armor/nobleboot
	name = "noble boots"
	desc = "Fine dark leather boots."
	icon_state = "nobleboots"
	item_state = "nobleboots"
	armor = list("blunt" = 35, "slash" = 15, "stab" = 25, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/shoes/roguetown/armor/shalal
	name = "babouche"
	desc = "Simple cheap shoes."
	icon_state = "shalal"
	item_state = "shalal"
	armor = list("blunt" = 25, "slash" = 20, "stab" = 25, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/shoes/roguetown/armor/grenzelhoft
	name = "grenzelhoft boots"
	desc = "A pair of fine boots worn by mercenaries."
	icon_state = "grenzelboots"
	item_state = "grenzelboots"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	armor = list("blunt" = 15, "slash" = 15, "stab" = 15, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
