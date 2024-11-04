/obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata
	name = "astratan helmet"
	desc = "Headwear commonly worn by Templars in service to Astrata. The firstborn child's light will forever shine on within its crest."
	icon_state = "astratahelm"
	item_state = "astratahelm"
	emote_environment = 3
	adjustable = CAN_CADJUST
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	block2add = FOV_RIGHT|FOV_LEFT|FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata/alt
	desc = "Gilded gold and silvered metal, the bright, vibrant colors of an Astratan crusader radiate from this blessed helmet."
	icon_state = "astratahelm_alt"
	item_state = "astratahelm_alt"
	adjustable = CANT_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/templar/necra
	name = "necran helmet"
	desc = "Headwear commonly worn by Templars in service to Necra. Let its skeletal features remind you of the only thing which is guaranteed in life. You will die."
	icon_state = "necrahelm"
	item_state = "necrahelm"
	emote_environment = 3
	adjustable = CAN_CADJUST
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	block2add = FOV_RIGHT|FOV_LEFT|FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/templar/necra/alt
	desc = "The darkest of blacks, this hooded helm is reminiscent of an executioner's head, striking fear into those who look upon it that they too may soon face the undermaiden."
	icon_state = "necrahelm_alt"
	item_state = "necrahelm_alt"
	adjustable = CANT_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/templar/malum
	name = "malummite helmet"
	desc = "Forged in a coal-black, this helmet carries a sigiled blade upon it's visor, ever reminding it's wearer of Malum's powerful gaze."
	icon_state = "malumhelm"
	item_state = "malumhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	block2add = FOV_RIGHT|FOV_LEFT|FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/templar/noc
	name = "noctian helmet"
	desc = "Hearwear commonly worn by Templars in service to Noc. Without the night there can be no day, without Noc there can be no light in the dark hours."
	icon_state = "nochelm"
	item_state = "nochelm"
	emote_environment = 3
	adjustable = CAN_CADJUST
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	block2add = FOV_RIGHT|FOV_LEFT|FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/templar/dendor
	name = "dendorite helmet"
	desc = "Headwear commonly worn by Templars in service to Dendor. Its protrusions almost resemble branches. Take root in the earth, and you will never be moved."
	icon_state = "dendorhelm"
	item_state = "dendorhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	block2add = FOV_RIGHT|FOV_LEFT|FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/templar/ravox
	name = "ravoxian helmet"
	desc = "Headwear commonly worn by Templars in service to Ravox. It resembles an heavily adorned visored sallet."
	icon_state = "ravoxhelm"
	item_state = "ravoxhelm"
	emote_environment = 3
	adjustable = CAN_CADJUST
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	block2add = FOV_RIGHT|FOV_LEFT|FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/templar/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "[initial(icon_state)]_raised"
			flags_cover = null
			flags_inv = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = FOV_BEHIND
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEFACE
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()
