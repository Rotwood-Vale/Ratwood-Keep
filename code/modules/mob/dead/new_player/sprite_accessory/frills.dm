/datum/sprite_accessory/frills
	abstract_type = /datum/sprite_accessory/frills
	icon = 'icons/mob/sprite_accessory/frills/frills.dmi'
	color_key_name = "Frills"
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/frills/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/humie = owner
	var/datum/species/species = owner.dna.species
	for(var/mutable_appearance/appearance as anything in appearance_list)
		if(humie.gender == FEMALE)
			if(OFFSET_FACE_F in species.offset_features)
				appearance.pixel_x += species.offset_features[OFFSET_FACE_F][1]
				appearance.pixel_y += species.offset_features[OFFSET_FACE_F][2]
		else
			if(OFFSET_FACE in species.offset_features)
				appearance.pixel_x += species.offset_features[OFFSET_FACE][1]
				appearance.pixel_y += species.offset_features[OFFSET_FACE][2]

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
