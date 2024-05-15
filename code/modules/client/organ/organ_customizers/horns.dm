/datum/customizer/organ/horns
	abstract_type = /datum/customizer/organ/horns
	name = "Horns"

/datum/customizer_choice/organ/horns
	abstract_type = /datum/customizer_choice/organ/horns
	name = "Horns"
	organ_type = /obj/item/organ/horns
	organ_slot = ORGAN_SLOT_HORNS

/datum/customizer/organ/horns/humanoid
	customizer_choices = list(/datum/customizer_choice/organ/horns/humanoid)

/datum/customizer_choice/organ/horns/humanoid
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

/datum/customizer/organ/horns/demihuman
	customizer_choices = list(/datum/customizer_choice/organ/horns/demihuman)
	allows_disabling = TRUE
	default_disabled =  TRUE

/datum/customizer_choice/organ/horns/demihuman
	name = "Horns"
	organ_type = /obj/item/organ/horns
	sprite_accessories = list(
		/datum/sprite_accessory/horns/simple,
		/datum/sprite_accessory/horns/short,
		/datum/sprite_accessory/horns/curled,
		/datum/sprite_accessory/horns/ram,
		/datum/sprite_accessory/horns/guilmon,
		/datum/sprite_accessory/horns/drake,
		/datum/sprite_accessory/horns/knight,
		)
