/datum/customizer/organ/taur_body
	abstract_type = /datum/customizer/organ/taur_body
	name = "Taur Body"

/datum/customizer_choice/organ/taur_body
	abstract_type = /datum/customizer_choice/organ/taur_body
	name = "Taur Body"
	organ_type = /obj/item/organ/taur_body
	organ_slot = ORGAN_SLOT_TAUR_BODY

/datum/customizer/organ/taur_body/humanoid
	customizer_choices = list(/datum/customizer_choice/organ/taur_body/humanoid)

/datum/customizer_choice/organ/taur_body/humanoid
	name = "Taur Body"
	organ_type = /obj/item/organ/taur_body/humanoid
	sprite_accessories = list(
		/datum/sprite_accessory/taur/cow,
		/datum/sprite_accessory/taur/cow_spotted,
		/datum/sprite_accessory/taur/deer,
		/datum/sprite_accessory/taur/drake,
		/datum/sprite_accessory/taur/drake_old,
		/datum/sprite_accessory/taur/drider,
		/datum/sprite_accessory/taur/eevee,
		/datum/sprite_accessory/taur/horse,
		/datum/sprite_accessory/taur/naga,
		/datum/sprite_accessory/taur/otie,
		/datum/sprite_accessory/taur/pede,
		/datum/sprite_accessory/taur/tentacle,
		/datum/sprite_accessory/taur/canine,
		/datum/sprite_accessory/taur/feline,
		)

/datum/customizer/organ/taur_body/synth
	customizer_choices = list(/datum/customizer_choice/organ/taur_body/synth)

/datum/customizer_choice/organ/taur_body/synth
	name = "Taur Body"
	organ_type = /obj/item/organ/taur_body/synth
	sprite_accessories = list(
		/datum/sprite_accessory/taur/synth_feline,
		/datum/sprite_accessory/taur/synth_horse,
		/datum/sprite_accessory/taur/synth_lizard,
		/datum/sprite_accessory/taur/synth_wolf,
		/datum/sprite_accessory/taur/synth_naga,
		)
