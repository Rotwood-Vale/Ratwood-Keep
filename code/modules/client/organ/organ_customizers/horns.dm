/datum/organ_customizer/horns
	abstract_type = /datum/organ_customizer/horns
	name = "Horns"

/datum/organ_choice/horns
	abstract_type = /datum/organ_choice/horns
	name = "Horns"
	organ_type = /obj/item/organ/horns
	organ_slot = ORGAN_SLOT_HORNS

/datum/organ_customizer/horns/humanoid
	organ_choices = list(/datum/organ_choice/horns/humanoid)

/datum/organ_choice/horns/humanoid
	name = "Horns"
	organ_type = /obj/item/organ/horns/humanoid
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/horns/simple,
		/datum/sprite_accessory/horns/short,
		/datum/sprite_accessory/horns/curled,
		/datum/sprite_accessory/horns/ram,
		/datum/sprite_accessory/horns/angler,
		/datum/sprite_accessory/horns/guilmon,
		/datum/sprite_accessory/horns/drake,
		/datum/sprite_accessory/horns/knight,
		)
