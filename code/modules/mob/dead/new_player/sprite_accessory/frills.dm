/datum/sprite_accessory/frills
	abstract_type = /datum/sprite_accessory/frills
	icon = 'icons/mob/sprite_accessory/frills/frills.dmi'
	color_key_name = "Frills"
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/frills/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_face_feature_adjust(appearance_list, organ, bodypart, owner)

/datum/sprite_accessory/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/frills/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/frills/divinity
	name = "Divinity"
	icon_state = "divinity"

/datum/sprite_accessory/frills/horns
	name = "Horns"
	icon_state = "horns"

/datum/sprite_accessory/frills/horns_double
	name = "Horns Double"
	icon_state = "hornsdouble"

/datum/sprite_accessory/frills/big
	name = "Big"
	icon_state = "big"

/datum/sprite_accessory/frills/cobrahood
	name = "Cobra Hood"
	icon_state = "cobrahood"
	color_keys = 2
	color_key_names = list("Hood", "Inner")

/datum/sprite_accessory/frills/cobrahood_ears
	name = "Cobra Hood (Ears)"
	icon_state = "cobraears"
	color_keys = 2
	color_key_names = list("Hood", "Inner")
