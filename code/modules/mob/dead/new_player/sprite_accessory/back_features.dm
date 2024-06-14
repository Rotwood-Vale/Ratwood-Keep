/datum/sprite_accessory/back_feature
	abstract_type = /datum/sprite_accessory/back_feature

/datum/sprite_accessory/back_feature/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_BACK, OFFSET_BACK_F)
