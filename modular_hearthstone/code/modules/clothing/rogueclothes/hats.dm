/obj/item/clothing/head/roguetown/helmet/sallet

	name = "sallet"
	desc = "A steel helmet which protects the ears."
	icon = 'modular_hearthstone/icons/obj/items/clothes/head/sallet.dmi'	// modularized for Hearthstone
	mob_overlay_icon = 'modular_hearthstone/icons/obj/items/clothes/on_mob/head/sallet.dmi'
	icon_state = "sallet"
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/helmet/sallet/visored

	name = "visored sallet"
	desc = "A steel helmet which protects the ears, nose, and eyes."
	icon = 'modular_hearthstone/icons/obj/items/clothes/head/sallet_visor.dmi'	// modularized for Hearthstone
	mob_overlay_icon = 'modular_hearthstone/icons/obj/items/clothes/on_mob/head/sallet_visor.dmi'
	icon_state = "sallet_visor"
	adjustable = CAN_CADJUST
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	body_parts_covered = FULL_HEAD
	block2add = FOV_BEHIND
	max_integrity = 400

/obj/item/clothing/head/roguetown/helmet/sallet/visored/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "[initial(icon_state)]_raised"
			body_parts_covered = HEAD|EARS|HAIR
			flags_inv = HIDEEARS
			flags_cover = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()