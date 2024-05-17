/datum/sprite_accessory/face_detail
	icon = 'icons/mob/sprite_accessory/face_detail.dmi'
	layer = BODY_LAYER
	default_colors = list("FFFFFF")

/datum/sprite_accessory/face_detail/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDEFACE)

/datum/sprite_accessory/face_detail/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE, OFFSET_FACE_F)

/datum/sprite_accessory/face_detail/brows
	name = "Thick Eyebrows"
	icon_state = "brows"
	layer = BODY_LAYER
	default_colors =  null
	color_key_defaults = list(KEY_HAIR_COLOR)

/datum/sprite_accessory/face_detail/brows/dark
	name = "Dark Eyebrows"
	icon_state = "darkbrows"
	layer = BODY_LAYER

/datum/sprite_accessory/face_detail/scar
	name = "Scar"
	icon_state = "scar"
	layer = BODY_LAYER

/datum/sprite_accessory/face_detail/scart
	name = "Scar2"
	layer = BODY_LAYER
	icon_state = "scar2"

/datum/sprite_accessory/face_detail/burnface_r
	name = "Burns (r)"
	icon_state = "burnface_r"
	layer = BODY_LAYER

/datum/sprite_accessory/face_detail/burnface_l
	name = "Burns (l)"
	icon_state = "burnface_l"
	layer = BODY_LAYER

/datum/sprite_accessory/face_detail/deadeye_r
	name = "Dead Eye (r)"
	icon_state = "deadeye_r"
	layer = BODY_LAYER

/datum/sprite_accessory/face_detail/deadeye_l
	name = "Dead Eye (l)"
	icon_state = "deadeye_l"
	layer = BODY_LAYER

/datum/sprite_accessory/accessory
	icon = 'icons/mob/sprite_accessory/accessory.dmi'
	default_colors = list("FFFFFF")

/datum/sprite_accessory/accessory/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDEFACE)

/datum/sprite_accessory/accessory/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE, OFFSET_FACE_F)

/datum/sprite_accessory/accessory/earrings
	name = "Earrings (G)"
	icon_state = "earrings"
	layer = BODY_FRONT_LAYER

/datum/sprite_accessory/accessory/earrings/sil
	name = "Earrings"
	icon_state = "earrings_sil"
	layer = BODY_FRONT_LAYER

/datum/sprite_accessory/accessory/earrings/em
	name = "Earrings (E)"
	icon_state = "earrings_em"
	layer = BODY_FRONT_LAYER

/datum/sprite_accessory/accessory/eyepierce
	name = "Pierced Brow (L)"
	icon_state = "eyepierce"
	layer = BODY_FRONT_LAYER

/datum/sprite_accessory/accessory/eyepierce/alt
	name = "Pierced Brow (R)"
	icon_state = "eyepiercealt"
	layer = BODY_LAYER

/datum/sprite_accessory/accessory/choker
	name = "Neckband"
	icon_state = "choker"
	layer = BODY_LAYER

/datum/sprite_accessory/accessory/chokere
	name = "Neckband (E)"
	icon_state = "chokere"
	layer = BODY_LAYER
