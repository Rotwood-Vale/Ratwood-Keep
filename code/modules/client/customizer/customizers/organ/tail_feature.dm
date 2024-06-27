/datum/customizer/organ/tail_feature
	abstract_type = /datum/customizer/organ/tail_feature
	name = "Tail Feature"

/datum/customizer_choice/organ/tail_feature
	abstract_type = /datum/customizer_choice/organ/tail_feature
	name = "Tail Feature"
	organ_type = /obj/item/organ/tail_feature
	organ_slot = ORGAN_SLOT_TAIL_FEATURE

/datum/customizer/organ/tail_feature/lizard_spines
	customizer_choices = list(/datum/customizer_choice/organ/tail_feature/lizard_spines)
	allows_disabling = TRUE

/datum/customizer_choice/organ/tail_feature/lizard_spines
	name = "Tail Spines"
	organ_type = /obj/item/organ/tail_feature/lizard_spines
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/tail_feature/spines/short,
		/datum/sprite_accessory/tail_feature/spines/shortmeme,
		/datum/sprite_accessory/tail_feature/spines/long,
		/datum/sprite_accessory/tail_feature/spines/longmeme,
		/datum/sprite_accessory/tail_feature/spines/aquatic,
		)

/datum/customizer/organ/tail_feature/vox_markings
	customizer_choices = list(/datum/customizer_choice/organ/tail_feature/vox_markings)

/datum/customizer_choice/organ/tail_feature/vox_markings
	name = "Tail Markings"
	organ_type = /obj/item/organ/tail_feature/vox_marking
	sprite_accessories = list(
	/datum/sprite_accessory/tail_feature/vox_marking/bands,
	/datum/sprite_accessory/tail_feature/vox_marking/tip,
	/datum/sprite_accessory/tail_feature/vox_marking/stripe,
	)

/datum/customizer/organ/tail_feature/anthro
	allows_disabling = TRUE
	default_disabled = TRUE
	customizer_choices = list(/datum/customizer_choice/organ/tail_feature/lizard_spines)
