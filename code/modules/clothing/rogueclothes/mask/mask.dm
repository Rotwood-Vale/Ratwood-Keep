/obj/item/clothing/mask/rogue
	name = ""
	icon = 'icons/roguetown/clothing/masks.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/masks.dmi'
	body_parts_covered = FACE
	slot_flags = ITEM_SLOT_MASK
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/rogue/spectacles
	name = "spectacles"
	desc = "A finely made set of spectacles for those with trouble seeing."
	icon_state = "glasses"
	break_sound = "glassbreak"
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	max_integrity = 20
	integrity_failure = 0.5
	resistance_flags = FIRE_PROOF
	body_parts_covered = EYES
	anvilrepair = /datum/skill/craft/blacksmithing
//	block2add = FOV_BEHIND

/obj/item/clothing/mask/rogue/spectacles/golden
	name = "golden spectacles"
	desc = "A finely made set of spectacles, these ones seem to have been commissioned by a noble."
	icon_state = "goggles"
	break_sound = "glassbreak"
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	max_integrity = 35
	integrity_failure = 0.5
	resistance_flags = FIRE_PROOF
	body_parts_covered = EYES
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/mask/rogue/spectacles/Initialize()
	. = ..()
	AddComponent(/datum/component/spill, null, 'sound/blank.ogg')

/obj/item/clothing/mask/rogue/spectacles/Crossed(mob/crosser)
	if(isliving(crosser) && !obj_broken)
		take_damage(11, BRUTE, "blunt", 1)
	..()

/obj/item/clothing/mask/rogue/equipped(mob/user, slot)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/mask/rogue/dropped(mob/user)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/mask/rogue/eyepatch
	name = "eyepatch"
	desc = "An eyepatch, fitted for the right eye."
	icon_state = "eyepatch"
	max_integrity = 20
	integrity_failure = 0.5
	block2add = FOV_RIGHT
	body_parts_covered = EYES
	sewrepair = TRUE
	salvage_amount = 1

/obj/item/clothing/mask/rogue/eyepatch/left
	desc = "An eyepatch, fitted for the left eye."
	icon_state = "eyepatch_l"
	block2add = FOV_LEFT

/obj/item/clothing/mask/rogue/lordmask
	name = "golden halfmask"
	desc = "Half of your face turned gold."
	icon_state = "lmask"
	sellprice = 50
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/clothing/mask/rogue/lordmask/l
	icon_state = "lmask_l"

/obj/item/clothing/mask/rogue/facemask
	name = "iron mask"
	desc = "An iron mask which protects the eyes, nose and mouth while also obscuring the face it."
	icon_state = "imask"
	max_integrity = 100
	blocksound = PLATEHIT
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	resistance_flags = FIRE_PROOF
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	flags_inv = HIDEFACE
	body_parts_covered = FACE
	block2add = FOV_BEHIND
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
	experimental_onhip = TRUE
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/mask/rogue/facemask/hound
	name = "iron hound mask"
	desc = "An iron mask, made for those who have snouts, protecting the eyes, nose and muzzle while obscuring the face."
	icon_state = "imask_hound"

/obj/item/clothing/mask/rogue/facemask/prisoner/Initialize()
	. = ..()
	name = "cursed mask"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)
	clothing_flags = null

/obj/item/clothing/mask/rogue/facemask/prisoner/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/mask/rogue/facemask/steel
	name = "steel mask"
	desc = "A mask of steel which protects the eyes, nose and mouth while also obscuring the face."
	icon_state = "smask"
	max_integrity = 200
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/mask/rogue/facemask/steel/hound
	name = "steel hound mask"
	desc = "A steel mask, made for those who have snouts, protecting the eyes, nose and muzzle while obscuring the face."
	icon_state = "smask_hound"

/obj/item/clothing/mask/rogue/shepherd
	name = "halfmask"
	icon_state = "shepherd"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	body_parts_covered = NECK|MOUTH
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	experimental_onhip = TRUE
	sewrepair = TRUE
	salvage_amount = 1

/obj/item/clothing/mask/rogue/shepherd/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_wear_mask()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEFACE|HIDEFACIALHAIR
			body_parts_covered = NECK|MOUTH
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_wear_mask()

/obj/item/clothing/mask/rogue/physician
	name = "plague mask"
	desc = "What better laboratory than the blood-soaked battlefield?"
	icon_state = "physmask"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEEARS
	body_parts_covered = FACE|EARS|EYES|MOUTH|NECK
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
	sewrepair = TRUE

/obj/item/clothing/mask/rogue/facemask/goldmask
	name = "Gold Mask"
	icon_state = "goldmask"
	max_integrity = 150
	sellprice = 100
	smeltresult = /obj/item/ingot/gold

/obj/item/clothing/mask/rogue/exoticsilkmask
	name = "Exotic Silk Mask"
	icon_state = "exoticsilkmask"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	body_parts_covered = NECK|MOUTH
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
	sewrepair = TRUE

//---------------- NEW/MASK.DM ---------------------

/obj/item/clothing/mask/rogue/pestra
	name = "pestran mask"
	desc = "A mask made in such a way to keep the rot away as much as possible from you. Some of the smell still goes through."
	icon = 'icons/roguetown/clothing/masks.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/masks.dmi'
	icon_state = "feldmask"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEEARS
	body_parts_covered = FACE|EARS|EYES|MOUTH|NECK
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
	sewrepair = TRUE

/obj/item/clothing/mask/rogue/pestra/court
	name = "court physician mask"
	desc = "A mask specially made for the court physician, one of the most experienced pestrans around."
	icon_state = "pestramask"

/obj/item/clothing/mask/rogue/rag
	name = "rag mask"
	desc = "A piece of cloth folded in a way to make it easy to protect your identity or your nose from the rot."
	icon = 'icons/roguetown/clothing/masks.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/masks.dmi'
	icon_state = "ragmask"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	body_parts_covered = NECK|MOUTH
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	experimental_onhip = TRUE
	sewrepair = TRUE
	salvage_amount = 1

/obj/item/clothing/mask/rogue/rag/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_wear_mask()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEFACE|HIDEFACIALHAIR
			body_parts_covered = NECK|MOUTH
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_wear_mask()

//----------------- MORE AZURE SPRITEWORK ---------------------

/obj/item/clothing/mask/rogue/skullmask
	name = "skull mask"
	desc = "A mask in the shape of a skull, designed to terrify."
	icon_state = "skullmask"
	max_integrity = 100
	blocksound = PLATEHIT
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	resistance_flags = FIRE_PROOF
	armor = list("blunt" = 10, "slash" = 40, "stab" = 40, "fire" = 0, "acid" = 0)
	prevent_crits = null
	flags_inv = HIDEFACE
	body_parts_covered = FACE
	block2add = FOV_BEHIND
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
	experimental_onhip = TRUE

/obj/item/clothing/mask/rogue/wildguard
	name = "wild guard"
	desc = "A mask shaped after the beasts of dendor."
	icon_state = "wildguard"
	blocksound = PLATEHIT
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	max_integrity = 100
	resistance_flags = FIRE_PROOF
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	flags_inv = HIDEFACE
	body_parts_covered = FACE
	block2add = FOV_BEHIND
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/mask/rogue/shepherd/shadowmask
	name = "purple halfmask"
	icon_state = "shadowmask"
	desc = "For when one wants to conceal their face while performing dastardly deeds in the name of the crown."

/obj/item/clothing/mask/rogue/lordmask/naledi
	name = "war scholar's mask"
	item_state = "naledimask"
	icon_state = "naledimask"
	desc = "Runes and wards, meant for daemons; the gold has somehow rusted in unnatural, impossible agony. The most prominent of these etchings is in the shape of the Naledian psycross."
	sellprice = 0

/obj/item/clothing/mask/rogue/facemask/psydonmask
	name = "psydonian mask"
	desc = "A silver mask, forever locked in a rigor of uncontestable joy. The Order of Saint Xylix can't decide on whether it's meant to represent Psydon's 'mirthfulness', 'theatricality', or the unpredictable melding of both."
	icon_state = "psydonmask"
	item_state = "psydonmask"

/obj/item/clothing/mask/rogue/overseer
    name = "cloth hood"
    desc = "You wouldn't hide your face if there was no reason for."
    icon_state = "overseerhood"
    item_state = "overseerhood"
    icon = 'icons/roguetown/clothing/inquisition_overseers/overseer.dmi'
    mob_overlay_icon = 'icons/roguetown/clothing/inquisition_overseers/onmob/overseer_onmob.dmi'
    flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEEARS
    body_parts_covered = FACE|EARS|MOUTH|NECK
    slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
    experimental_onhip = TRUE
    sewrepair = TRUE
