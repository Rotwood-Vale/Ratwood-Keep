/datum/organ_customizer/tail_feature
	abstract_type = /datum/organ_customizer/tail_feature
	name = "Tail Feature"

/datum/organ_choice/tail_feature
	abstract_type = /datum/organ_choice/tail_feature
	name = "Tail Feature"
	organ_type = /obj/item/organ/tail_feature
	organ_slot = ORGAN_SLOT_TAIL_FEATURE

/datum/organ_customizer/tail_feature/lizard_spines
	organ_choices = list(/datum/organ_choice/tail_feature/lizard_spines)

/datum/organ_choice/tail_feature/lizard_spines
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

/datum/organ_customizer/tail_feature/vox_markings
	organ_choices = list(/datum/organ_choice/tail_feature/vox_markings)

/datum/organ_choice/tail_feature/vox_markings
	name = "Tail Markings"
	organ_type = /obj/item/organ/tail_feature/vox_marking
	sprite_accessories = list(
	/datum/sprite_accessory/tail_feature/vox_marking/bands,
	/datum/sprite_accessory/tail_feature/vox_marking/tip,
	/datum/sprite_accessory/tail_feature/vox_marking/stripe,
	)
