/datum/organ_customizer/taur_body
	abstract_type = /datum/organ_customizer/taur_body
	name = "Taur Body"

/datum/organ_choice/taur_body
	abstract_type = /datum/organ_choice/taur_body
	name = "Taur Body"
	organ_type = /obj/item/organ/taur_body
	organ_slot = ORGAN_SLOT_TAUR_BODY

/datum/organ_customizer/taur_body/humanoid
	organ_choices = list(/datum/organ_choice/taur_body/humanoid)

/datum/organ_choice/taur_body/humanoid
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

/datum/organ_customizer/taur_body/synth
	organ_choices = list(/datum/organ_choice/taur_body/synth)

/datum/organ_choice/taur_body/synth
	name = "Taur Body"
	organ_type = /obj/item/organ/taur_body/synth
	sprite_accessories = list(
		/datum/sprite_accessory/taur/synth_feline,
		/datum/sprite_accessory/taur/synth_horse,
		/datum/sprite_accessory/taur/synth_lizard,
		/datum/sprite_accessory/taur/synth_wolf,
		/datum/sprite_accessory/taur/synth_naga,
		)
