/obj/item/clothing/suit/roguetown/armor/gambeson/overseer
    name = "overseer jacket"
    desc = "Padded jacket that provides adequate protection against unarmed innocents."
    icon_state = "overseerjacket"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    sleeved = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    slot_flags = ITEM_SLOT_ARMOR
    body_parts_covered = CHEST|GROIN|ARMS|VITALS
    prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_SMASH)
    armor = list("blunt" = 55, "slash" = 50, "stab" = 45, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
    max_integrity = 150
    sellprice = 30
    boobed = TRUE

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer
    name = "vice overseer coat"
    desc = "Heavy, reinforced coat with a tasteful burgundy covering will not leave anyone indifferent."
    icon_state = "viceseercoat"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    sleeved = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    boobed = TRUE
    ignore_sleeves_code = FALSE

/obj/item/clothing/under/roguetown/trou/overseer
    name = "heavy trousers"
    desc = "A pair of washed-out heavy trousers in grey colors."
    icon_state = "overseerpants"
    item_state = "overseerpants"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    sleeved = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    max_integrity = 110
    armor = list("blunt" = 35, "slash" = 25, "stab" = 20, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
    prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)

/obj/item/clothing/gloves/roguetown/leather/overseer
    name = "leather gloves"
    desc = "Black leather gloves, adorned with bright strips."
    icon_state = "overseergloves"
    item_state = "overseergloves"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'

/obj/item/clothing/gloves/roguetown/leather/overseer/vice
    icon_state = "viceseergloves"
    item_state = "viceseergloves"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'

/obj/item/clothing/suit/roguetown/shirt/undershirt/overseer
    icon_state = "overseershirt"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    sleeved = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    color = null

/obj/item/storage/belt/rogue/leather/overseer
    name = "belt with pouches"
    desc = "Leather belt with some pouches attached."
    icon_state = "overseerbelt"
    item_state = "overseerbelt"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    sellprice = 15
    w_class = WEIGHT_CLASS_BULKY
    component_type = /datum/component/storage/concrete/roguetown/belt/overseer

/datum/component/storage/concrete/roguetown/belt/overseer
	screen_max_rows = 3
	screen_max_columns = 3
	max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/mask/rogue/overseer
    name = "cloth hood"
    desc = "You wouldn't hide your face if there were no reasons for."
    icon_state = "overseerhood"
    item_state = "overseerhood"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEEARS
    body_parts_covered = FACE|EARS|MOUTH|NECK
    slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_HIP
    experimental_onhip = TRUE
    sewrepair = TRUE

/obj/item/clothing/head/roguetown/helmet/overseer
    name = "overseer mask"
    desc = "An iconic brass-colored metallic mask depicting visage of the Crying God. Too bulky to be worn with helmets."
    icon_state = "overseermask"
    item_state = "overseermask"
    icon = 'modular_redmoon/modules/inquisition_overseers/icons/overseer.dmi'
    mob_overlay_icon = 'modular_redmoon/modules/inquisition_overseers/icons/onmob/overseer_onmob.dmi'
    max_integrity = 250
    flags_inv = HIDEFACE
    body_parts_covered = FACE|HEAD|HAIR|EARS|NOSE
    flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
    block2add = FOV_BEHIND
    slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
    sellprice = 25

/obj/item/clothing/head/roguetown/helmet/overseer/vice
    name = "vice overseer mask"
    desc = "Silver mask covered in protective runes, depicting visage of the Crying God. Too bulky to be worn with helmets."
    icon_state = "viceseermask"
    item_state = "viceseermask"
    sellprice = 40
    smeltresult = /obj/item/ingot/silver

/obj/item/clothing/head/roguetown/helmet/overseer/vice/pickup(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)

/obj/item/clothing/head/roguetown/helmet/overseer/vice/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)