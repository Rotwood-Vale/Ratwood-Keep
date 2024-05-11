/datum/sprite_accessory/eyes
	abstract_type = /datum/sprite_accessory/eyes
	color_keys = 2
	color_key_names = list("First Eye", "Second Eye")
	icon = 'icons/mob/sprite_accessory/eyes/eyes.dmi'

/datum/sprite_accessory/eyes/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
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

/datum/sprite_accessory/eyes/humanoid
	name = "Humanoid Eyes"
	icon_state = "human"

/datum/sprite_accessory/eyes/humanoid_glow
	name = "Humanoid Glowing"
	icon_state = "human_glow"

/datum/sprite_accessory/eyes/humanoid_cyber
	name = "Humanoid Cyber"
	icon_state = "human_cyber"
