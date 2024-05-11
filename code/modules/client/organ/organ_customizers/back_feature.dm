/datum/organ_customizer/back_feature
	abstract_type = /datum/organ_customizer/back_feature
	name = "Back"

/datum/organ_choice/back_feature
	abstract_type = /datum/organ_choice/back_feature
	name = "Back"
	organ_type = /obj/item/organ/back_feature
	organ_slot = ORGAN_SLOT_BACK_FEATURE

/datum/organ_customizer/back_feature/xeno_dorsal
	organ_choices = list(/datum/organ_choice/back_feature/xeno_dorsal)

/datum/organ_choice/back_feature/xeno_dorsal
	name = "Dorsal Tubes"
	organ_type = /obj/item/organ/back_feature/xeno_dorsal
	sprite_accessories = list(
		/datum/sprite_accessory/back_feature/xeno_dorsal/standard,
		/datum/sprite_accessory/back_feature/xeno_dorsal/royal,
		/datum/sprite_accessory/back_feature/xeno_dorsal/down,
		)
