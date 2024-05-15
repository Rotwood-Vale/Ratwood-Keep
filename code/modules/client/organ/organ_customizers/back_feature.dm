/datum/customizer/organ/back_feature
	abstract_type = /datum/customizer/organ/back_feature
	name = "Back"

/datum/customizer_choice/organ/back_feature
	abstract_type = /datum/customizer_choice/organ/back_feature
	name = "Back"
	organ_type = /obj/item/organ/back_feature
	organ_slot = ORGAN_SLOT_BACK_FEATURE

/datum/customizer/organ/back_feature/xeno_dorsal
	customizer_choices = list(/datum/customizer_choice/organ/back_feature/xeno_dorsal)

/datum/customizer_choice/organ/back_feature/xeno_dorsal
	name = "Dorsal Tubes"
	organ_type = /obj/item/organ/back_feature/xeno_dorsal
	sprite_accessories = list(
		/datum/sprite_accessory/back_feature/xeno_dorsal/standard,
		/datum/sprite_accessory/back_feature/xeno_dorsal/royal,
		/datum/sprite_accessory/back_feature/xeno_dorsal/down,
		)
